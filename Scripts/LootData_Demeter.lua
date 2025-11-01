LootSetData.Demeter =
{
	-- Demeter
	DemeterUpgrade = 
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
		BoonInfoIcon = "BoonInfoSymbolDemeterIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_DemeterUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_DemeterUpgrade",
		LootRejectedText = "Player_GodDispleased_DemeterUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_DemeterUpgrade",
		Icon = "BoonSymbolDemeter",
		DoorIcon = "BoonDropDemeterPreview",
		DoorUpgradedIcon = "BoonDropDemeterUpgradedPreview",
		SpawnSound = "/SFX/DemeterBoonFrost",
		PortraitEnterSound = "/SFX/DemeterBoonFrost",
		UpgradeSelectedSound = "/SFX/Player Sounds/DemeterColdBoonSelect",

		LootRejectionAnimation = "BoonDissipateA_Demeter",

		Color = { 255, 192, 203, 255 },
		LightingColor = {0.592, 0.631, 1.000, 1.0},
		LootColor = {128, 96, 255, 255},
		SubtitleColor = Color.DemeterVoice,

		SpeakerName = "Demeter",
		Speaker = "NPC_Demeter_01",
		LoadPackages = { "Demeter", },
		Portrait = "Portrait_Demeter_Default_01",
		WrathPortrait = "Portrait_Demeter_Default_01_Wrath",
		OverlayAnim = "DemeterOverlay",
		Gender = "Female",
		FlavorTextIds =
		{
			"DemeterUpgrade_FlavorText01",
			"DemeterUpgrade_FlavorText02",
			"DemeterUpgrade_FlavorText03",
		},

		PriorityUpgrades = { "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", "DemeterSprintBoon", "DemeterManaBoon" },
		WeaponUpgrades =
		{
			"DemeterWeaponBoon",
			"DemeterSpecialBoon",
			"DemeterCastBoon",
			"DemeterSprintBoon",
			"DemeterManaBoon",
		},
		Traits =
		{
			"CastNovaBoon",
			"PlantHealthBoon",
			"BoonGrowthBoon",
			"ReserveManaHitShieldBoon",
			"SlowExAttackBoon",
			"CastAttachBoon",
			"RootDurationBoon",

			-- Elemental
			"ElementalDamageCapBoon",

			-- Legendary
			"InstantRootKill",

			-- Duos
			"RootStrikeBoon",
			"KeepsakeLevelBoon",
			"GoodStuffBoon",
			"StormSpawnBoon",
			"MaxHealthDamageBoon",
			"BurnConsumeBoon",
			"ClearRootBoon",
			"SelfCastBoon",
		},
		Consumables = { },

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
			{ Cue = "/VO/Melinoe_0647", Text = "The sigil of frost..." },
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

			{ Cue = "/VO/Melinoe_1480", Text = "{#Emph}Brr..." },
			{ Cue = "/VO/Melinoe_1481", Text = "Grandmother...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0647", Text = "The sigil of frost..." },
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "DemeterFirstMeeting",
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Always",
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "DemeterFirstPickUp" },
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
				
				{ Cue = "/VO/Melinoe_0649", Text = "Grandmother..." }
			},
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		DuoPickupTextLines =
		{
			DemeterWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "RootStrikeBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0099",
					Text = "When my sisters and my foster-brothers and I overthrew Chronos long ago, we were much closer to {#Emph}your {#Prev}age, flower. Now we are older, and one should think wiser... although our frequent bickering and inaction suggest otherwise." },
				{ Cue = "/VO/Zeus_0158",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "We are a strong-willed family, as you know perfectly well, Lady Demeter. We must move forward in unison! Building that sort of consensus is not always quick; though we each could do our part to hasten it along." },
			},

			DemeterWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "KeepsakeLevelBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0101",
					Text = "Of late, even my radiant young sister must sully her delicate hands in all the field work that must be done. She is even beginning to take to it... aren't you, Hera our Queen?" },
				{ Cue = "/VO/Hera_0108",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "{#Emph}Oh{#Prev}, Demeter. These hands have seen more than you know! I simply do not flaunt the hardships I've endured. One {#Emph}can {#Prev}be as strong as a rock, without taking on its texture." },
			},

			DemeterWithPoseidon01 =
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
				{ Cue = "/VO/Demeter_0071",
					Text = "Granddaughter, Poseidon here has been regaling me about the time his seas drank half the land! {#Emph}Ahh{#Prev}, such a flood that was! Perhaps our strengths can be combined again..." },
				{ Cue = "/VO/Poseidon_0185",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, there's no {#Emph}perhaps {#Prev}about it, Demeter! We'll weather this storm yet! I'd just as soon whip up another great big flood for old {#Emph}Time{#Prev}'s sake, it's just... too many mortals these days!" },
			},

			DemeterWithApollo01 =
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
				{ Cue = "/VO/Demeter_0103",
					Text = "You know, flower, how mortals seek to be like us? Yet in so doing, they take on our ignoble qualities. Perhaps it's Lord Apollo's fault, as the standard to which they aspire!" },
				{ Cue = "/VO/Apollo_0098",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Emote = "PortraitEmoteSurprise",
					Text = "Did I offend somehow, good Lady Demeter? I know the times have been quite cruel, though why don't we direct that cruelty at our enemies, instead of heaping it upon each other here?" },
			},

			DemeterWithAphrodite01 =
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
				{ Cue = "/VO/Demeter_0105",
					Text = "Aid from Olympus can take many different forms... as not all of us are suitably prepared or even {#Emph}built {#Prev}to face significant ordeals. Take, for instance, fairest Aphrodite over here..." },
				{ Cue = "/VO/Aphrodite_0149",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Text = "Oh, Lady Demeter, you know that's {#Emph}patently {#Prev}untrue! I may be more a lover than a fighter, but that doesn't mean I won't mangle the faces of our foes, if that is what it takes to get them to {#Emph}back off! {#Prev}Now why don't we show your granddaughter how well we get along?" },
			},

			DemeterWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ClearRootBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0107",
					Text = "Even {#Emph}I {#Prev}could use a bit of heat on some occasions, flower, which the forge of Hephaestus here provides. Perhaps as compensation for the utter lack of {#Emph}warmth {#Prev}between most members of our family." },
				{ Cue = "/VO/Hephaestus_0128",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Text = "{#Emph}Ah{#Prev}, just {#Emph}listen {#Prev}to the Lady Demeter! Everybody on our mountaintop thinks they're {#Emph}so sharp{#Prev}, but {#Emph}this {#Prev}one? She is blunt like my hammer. And some jobs call for a blunt instrument, don't they?" },
			},

			DemeterWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BurnConsumeBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0109",
					Text = "Your Great-Aunt Hestia is not exactly as she {#Emph}seems. {#Prev}In olden times, she was content merely to let her flames keep sputtering within the hearths of mortal homes. Admit to it, Sister: You've changed." },
				{ Cue = "/VO/Hestia_0154",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "And you, Demeter, you've not changed at {#Emph}all! None {#Prev}of you have! It's why you're in a heap of {#Emph}trouble {#Prev}now, or {#Emph}we {#Prev}I ought to say. Good thing your grandkid's coming to our rescue!" },
			},

			DemeterWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SelfCastBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0190",
					Text = "{#Emph}Oh{#Prev}, Ares. Not even our most-eager god of war can put an immediate stop to the troubles that our family is having to weather. Have you so little control of your domain?" },
				{ Cue = "/VO/Ares_0163",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "We all but do our best, O Demeter. For my part, I ensure that wars are instigated when required, and that necessary outcomes are achieved. But I cannot precisely guarantee their duration or intensity, for violence is a force unto itself." },
			},
		},

		InteractTextLineSets =
		{
			DemeterFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/Melinoe_0648", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 4.0, PowerWordPresentation = true, PowerWordWaitTime = 5.5 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "Headmistress told me so much about you, and now at last we meet. {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Demeter_0002",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					PreLineWait = 0.35,
					Text = "...You look just like your mother. I'll not lose her again. I shall freeze hell in its entirety if that is what it takes to get her back. You'll help me, won't you, Granddaughter?" },
			},

			-- low health
			DemeterLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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

				{ Cue = "/VO/Demeter_0066",
					Emote = "PortraitEmoteSurprise",
					
					Text = "{#Emph}Ah{#Prev}, you're hurt! Your partly-mortal blood's to blame. And so am I, for having fallen into love with a mere farm-boy once..." },
			},
			DemeterLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterLowHealth01", },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0065",
					Emote = "PortraitEmoteSurprise",
					
					Text = "What happened, Granddaughter? May those wretches that hurt you thus suffer a thousandfold for what they have done." },
			},
			DemeterLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterLowHealth01", },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0158",
					Emote = "PortraitEmoteSurprise",
					
					Text = "Injured already...! Know that the pains we suffer are the means by which we grow. And our enemies are about to grow a {#Emph}great deal." },
			},
			DemeterLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterLowHealth01", },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0159",

					Text = "You spill your blood each night for our mistakes. I cannot cure your ailments from here, but I {#Emph}can {#Prev}make your enemies shatter to {#Emph}pieces{#Prev}, if that is of any comfort." },
			},

			-- run starts
			DemeterRunStart01 =
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
				{ Cue = "/VO/Demeter_0073",
					
					Text = "As you begin your next attempt at the seemingly impossible, know that I shall be with you to the bitter end. In blessing form, at least." },
			},
			DemeterRunStart02 =
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
				{ Cue = "/VO/Demeter_0074",
					
					Text = "Go forth on this next ordeal with my blessing, Granddaughter. I've a feeling it shall be a very cold night for our enemies..." },
			},
			DemeterRunStart03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0161",
					
					Text = "Should this night take you all the way to hell and back, I still would gladly come along. But, this is the best that I can do from here." },
			},
			DemeterRunStart04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0162",
					
					Text = "The forecast for this evening calls for a sharp decline in temperature. Though you are well-accustomed to the cold by now, aren't you?" },
			},

			-- story events
			DemeterAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0033",
					
					Text = "I miss your mother terribly, and your brother as well. He was my little sprout. Chronos must have ensnared him with the others in your father's House, the unforgivable wretch..." },
			},
			DemeterAboutZagreus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						SumPrevRuns = 6,
						Path = { "RoomsEntered", "C_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift07" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0280",
					Portrait = "Portrait_Demeter_Pleased_01",			
					Text = "Your brother Zagreus, why I suppose he's no longer my little sprout by now, grown as he has into a noble Underworld Prince. That you two finally know each other gladdens my old heart." },
			},

			DemeterAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0034",
					
					Text = "Melinoë... I was certain you were gone. Scarce born, only to be taken by Chronos, along with my daughter and those nearest her. But the Witch of the Crossroads got you out of there, did she? How could she not send word...?" },
			},
			DemeterAboutMelinoe02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutApollo01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ApolloAboutMelinoe01", "ArtemisAboutApollo01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0035",
					
					Text = "When bright Apollo gathered us and announced that his twin sister, whilst out hunting for our enemies, stumbled upon a long-lost relative with the Witch of the Crossroads, why... I was overjoyed and furious at once..." },
			},
			DemeterAboutMelinoe03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0036",
					
					Text = "You could have informed us; informed {#Emph}me{#Prev}, whilst you grew supple and strong in the Witch's care. Yet knowing Hecate... she must have deemed the risk too great. I understand. I'll try to understand..." },
			},

			DemeterAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0086",
					Text = "The first time your mother was lost to me... the Witch of the Crossroads emerged from the shadows to light my way, as I searched to the ends of the Earth. We found not a thing; but at least I was not alone..." },
			},
			DemeterAboutHecate02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0039",
					
					Text = "You know I always felt a kinship with Hecate, seldom though we saw each other. She never seemed to want for children of her own. But the Fates delivered you to her anyhow." },
			},
			DemeterAboutHecate03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DemeterGift06", "HecateGift06" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0269",
					Portrait = "Portrait_Demeter_Pleased_01",			
				
					Text = "I reached out to the Witch of the Crossroads recently... to give thanks to her, for making such a difficult decision to keep you hidden for as long as she did. I know she did it for your safety... and to raise the likelihood we would prevail." },
			},

			DemeterAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0040",
					
					Text = "I {#Emph}detested {#Prev}Chronos even in my youth. Almost as much as my own Titan father. We took our vengeance, though; on Chronos, Hyperion, and the rest. But I was a fool to think we'd never see any of them again..." },
			},
			DemeterAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0041",
					
					Text = "We've been locked in conflict with Chronos for so long that we've begun to doubt that anything can meaningfully change. I wonder, flower... can you truly rid us of this blight?" },
			},
			DemeterAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0097",
					
					Text = "I take it Chronos still goes everywhere with that old gaudy-looking golden scythe of his? He fancies himself a reaper, speaks of harvest and decay; but he merely speaks in riddles, whilst {#Emph}I {#Prev}work directly in the trade." },
			},

			DemeterAboutChronosBossW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0213",
					
					Text = "If it is true you reached the Underworld's depths and slew that wretched Titan there, then {#Emph}good. {#Prev}It likely shall take more than that, I know, but you must have inflicted some amount of pain, and perhaps fear. Which is a start." },
			},
			DemeterAboutChronosBossW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "DemeterAboutChronosBossW01" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0214",
					
					Text = "You bested Chronos again didn't you, flower? We always knew he could be beaten; I once saw to it myself. But can he be destroyed? The Witch of the Crossroads {#Emph}must {#Prev}know..." },
			},

			DemeterAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0167",
					Text = "Prometheus stole fire from us not for mortalkind, but because he desired it for his own gain. What good is that power to him now, upon a mountain cold as ice?" },
			},
			DemeterAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0212",
					Text = "I could snuff out the flames of that Prometheus... but in so doing, all of mortalkind would likely freeze. I am not yet prepared to go {#Emph}that {#Prev}far, though likely can be pushed." },
			},
			DemeterAboutPrometheus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0226",
					Text = "This scheme that Chronos has devised to keep all of us occupied... even Prometheus remains a nuisance as before! Inform us right away if you suspect any deceit." },
			},

			DemeterAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0216",
					Emote = "PortraitEmoteAnger",
					Text = "The incursion by that abhorrent monster Typhon... it is more than a threat, it is an {#Emph}insult! I {#Prev}control the seasons, yet he {#Emph}dares {#Prev}smother our mountain in his foul storm?" },
			},
			DemeterAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterAboutTyphon01" },
					},
					{
						SumPrevRuns = 4,
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
				{ Cue = "/VO/Demeter_0217",
					Text = "If Chronos truly is behind the reawakening of Typhon, then he is not merely arrogant, but mad. He promises another Golden Age yet visits such a creature on this world?" },
			},
			DemeterAboutTyphon03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},					
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0227",
					Text = "Snow falls gently on Olympus as before, but no trace of Typhon's foul storm remains... or of the {#Emph}rest {#Prev}of him. But you are able to confront him still somewhere beyond...?" },
			},
			DemeterAboutTyphonW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "TyponHead" },
					},
					{
						Path = { "PrevRun", "TextLinesRecord" },
						HasAny = { "DemeterPalaceFirstMeeting", "DemeterPalaceAboutTyphonDeath01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0218",
					Text = "Zeus says you substantially contributed to Typhon's defeat at our summit. Thank you for that, flower, but I regret I could not have been there to say so at our Palace grounds. Our enemies are numerous, and not letting up." },
			},
			DemeterAboutTyphonW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyponHead" },
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0219",
					Text = "That monster Typhon apparently has not yet understood that neither he nor Chronos shall stop us. But we shall {#Emph}make {#Prev}him, and your presence here may be the difference we need." },
			},
			DemeterAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0220",
					Text = "Now the Titan Chronos is our solitary goal. Show him no more mercy than the monster he unleashed would have shown us. But be careful; I demand your safe return." },
			},
			DemeterAboutTyphonDeath02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterPalaceAboutTyphonDeath01" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyponHead" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0221",
					Portrait = "Portrait_Demeter_Pleased_01",
					Text = "As much as I relished our victory over Typhon, to have finally met you meant the world to me, flower. Forgive that I am not known for my cheer, especially as of late. And may we see each other again." },
			},

			DemeterAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Circe_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Circe_01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0155",
					
					Text = "The witch Circe, whom you know. She's distant daughter to my Titan-brother Helios the Sun, who dares not show his face. Her enthusiasm for soil and grain is almost cloying... though I appreciate the underlying sentiment." },
			},

			DemeterAboutBlessings01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0037",
					
					Text = "I've so much I would speak with you about, Melinoë... but this is not the hour or the means. At least you can hear {#Emph}me{#Prev}, can't you? And I can sense your presence, faint and distant though it may be." },
			},

			DemeterAboutSisters01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "HestiaFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0042",
					
					Text = "Hera, Hestia, and I were far enough afield in disposition that we were not particularly close as sisters go. Although warring against Chronos has brought us {#Emph}somewhat {#Prev}closer, I suppose..." },
			},

			DemeterAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0044",
					
					Text = "My understanding was your line could scarce survive beyond the reaches of the Underworld. Yet there you are, traipsing about as though not bound by your father's fate. How can this be...?" },
			},
			DemeterAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0043",
					
					Text = "You sprang forth from underneath that gloom unto our world's surface, have you, flower? If you mean to visit our mountain, merely follow the path of desolation leading straight to us..." },
			},

			DemeterAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HeraAboutSurfaceThreat01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0168",
					Text = "The very ground beneath our feet has started to shift, and it bodes ill, I think. What does blasted Chronos now intend to do, topple our entire mountain to the Earth?" },
			},

			DemeterAboutEarth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0098",
					
					Text = "Fear not for this mountaintop, nor for the Earth; for she is far more resilient than us all. Our foes could scour {#Emph}every trace {#Prev}of our existence, yet Mother Gaia would remain, and recover." },
			},

			DemeterAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0225",
					Text = "A proper garden must be carefully maintained. So it shall be with your Underworld as I see it, flower. If there exists some lingering influence from Chronos, let us root it out." },
			},

			DemeterAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0092",
					
					Text = "What are you doing in those brackish depths, flower? Even Poseidon has turned his back on what lurks in that corner of the sea. Does such a path truly lead deeper into hell?" },
			},

			DemeterAboutFields01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "H_Intro" },
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "BiomesReached", "H" },
							},
						},
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0093",
					
					Text = "Your journey sends you through the Mourning Fields. I've seen that place... just {#Emph}dreadful{#Prev}, utterly! All of the wheat there, it... I thought perhaps it would provide a bit of cheer..." },
			},
			DemeterAboutTartarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Intro" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0215",
					
					Text = "Your recent descent took you deeper than my deepest roots, close to where the Titan Chronos now resides... and holds your mother captive with the rest. Is there no way to inform us of what happened?" },
			},

			DemeterAboutEphyra01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0094",

					Text = "Nothing lives in the city of Ephyra. And I shall keep it that way until its infestation of shambling wretches is brought to heel! Though, you need not concern yourself with the details; we have someone already on the case." },
			},
			DemeterAboutEphyra02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0163",
					
					Text = "Are you on your way here to us, flower? A journey that your mother made many a spring... but at a different time, whilst not beset by thuggish followers of a despicable Titan." },
			},

			DemeterAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0052",
					
					Text = "Your uncle Poseidon created that watery chasm you see before you. I've half a mind to freeze it shut, though I fear our enemies shall cross it anyhow, and your voyage would only be more fraught." },
			},
			DemeterAboutThessaly02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O", },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterAboutThessaly01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0095",
					
					Text = "That Rift of Thessaly could easily be turned to ice, you know. I'd like to see the enemy's fleet sail across it {#Emph}then! {#Prev}But I am told we have to cool it with the cataclysms for a while... mortals and their {#Emph}begging." },
			},

			DemeterAboutMoon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 5,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "N", "O", "P" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0045",
					
					Text = "Even in the dark of a new moon, when Selene herself dares not ride across the cold night sky, I found you there... and I shall give you all the power that I have to spare." },
			},
			DemeterAboutRain01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", },
						HasAny = { "WetState" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0046",
					
					Text = "That rainfall there may be of benefit to you; washing all the filth away, revealing new growth. Think you that Zeus himself brings the rain, or Poseidon? Take one more guess..." },
			},
			DemeterAboutResources01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0047",
					
					Text = "The bounties of the Earth... life flourishes even there where you reside, amid all that death. Flowers, roots, herbs, and seeds; you know their hidden strength. I let them grow for you." },
			},
			DemeterAboutResources02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
						Comparison = ">=",
						Value = 50,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0048",
					
					Text = "You've picked an abundance of Moly flowers... unassuming little things, aren't they? Not unlike {#Emph}you{#Prev}, for they too hold power far beyond that suggested by their form." },
			},
			DemeterAboutResources03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "GameState", "Resources", "PlantOMandrake" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0048",
					
					Text = "You have in your possession Mandrake Root? Its poison if not its scream can end a mortal's life, though you and your Witch of the Crossroads must have learned to tame those properties..." },
			},

			-- legendary
			DemeterLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0050",
					
					Text = "As the sapling struggles to grow, so too must we push ourselves to discover our truest potential. Behold my power over life and death; may you find yours." },
			},
			DemeterLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0051",
					
					Text = "The seasons are a never-ending cycle of decay and renewal... though there are such times when the seasons assert themselves much more fiercely than usual; times such as {#Emph}now." },
			},

			-- about other gods
			DemeterAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0053",
					Text = "There's a touch of moonlight about you, flower, as though Selene lights your way. Would that the Moon concerned herself with more than her path across the sky..." },
			},
			DemeterAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0054",
					
					Text = "Your fair cousin Apollo wields the light that mortals so cherish, for it brings them warmth, melting away my snow. With my permission, of course! His power shall only help you so much." },
			},
			DemeterAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
				{ Cue = "/VO/Demeter_0055",
					
					Text = "The great and crafty Zeus is aiding you directly, now? Then you truly must be one of our best remaining chances to thwart the Titan's plans... for Zeus is loath to ask for help, or offer it." },
			},
			DemeterAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0056",
					
					Text = "{#Emph}Ahh{#Prev}, you bear the blessing of Poseidon! Surely such a loud and blustering god must have more than sufficient might to back it up?" },
			},
			DemeterAboutPoseidon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterAboutPoseidon01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0057",
					
					Text = "So Poseidon has again availed himself to you! Well, good, and may he prove of use. I'll hold my threat to freeze his oceans then, for now." },
			},
			DemeterAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0058",
					
					Text = "Why, you even got the elusive god of the forge to crawl out of his cave. To think that all it took was this terrible in-fighting with our forebear to bring our family closer together." },
			},
			DemeterAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0059",
					
					Text = "Well it seems you've earned the good graces of my sister Hera! And you didn't even have to commit yourself to a mate or bear any children, I suppose. She must be growing soft!" },
			},
			DemeterAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0060",
					
					Text = "So Hestia gave you her gift of flame? Normally the old miser wants nothing to do with any of us, not even her sisters. But extraordinary times do call for extraordinary measures." },
			},
			DemeterAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0061",
					
					Text = "Normally, sweet Aphrodite's power over beauty provides no shortage of entertainment I'm sure, though I fail to see how her blessing can be of much benefit in such a predicament as ours." },
			},
			DemeterAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0241",
					Text = "I knew warlike Ares would be unable to resist giving our present conflict his personal attention. Although I doubt he shall help put it to an end, for he is thoroughly enjoying this." },
			},
			DemeterAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0062",
					
					Text = "You're making haste, flower! I'd swear that you were graced by swift Hermes himself, except he must be too busy keeping watch over our enemies to be of much benefit to you." },
			},
			DemeterAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},	
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0063",
					
					Text = "Perhaps I misjudged your woodsy cousin Artemis. To think that she found you! I was certain she was merely gallivanting with her Nymph-friends rather than being of use." },
			},
			DemeterAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Athena_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0243",
					
					Text = "Did the famous wisdom of Athena live up to her reputation, flower? I would think our master strategist should not have to defend the front lines herself. But what do I know?" },
			},

			DemeterAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0089",
					
					Text = "Your father was sullen and difficult even whilst young, quite honestly. What my daughter saw in him, I could not. Yet my Kore as I called her... she would brighten around him..." },
			},
			DemeterAboutHades02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutHades01" }
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "HermesAboutHades01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0090",
					
					Text = "Word reaches us that you located Hades, flower! How he must seethe, incarcerated in that pit of despair, although at least he's whole. What of your mother, nothing still...?" },
			},
			DemeterAboutHades03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					OrRequirements =
					{
						{
							{
								SumPrevRuns = 2,
								Path = { "RoomsEntered", "I_Story01" },
								Comparison = ">=",
								Value = 1,
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "HadesAndPersephoneKeepsake" },
							},
						},
					}
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0270",
					
					Text = "Surely he would not admit to this... but your father has been through quite an ordeal. Worse perhaps than any of us. But he and your mother have weathered difficult times before, and each time they have grown from it." },
			},

			DemeterAboutPersephone01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift02" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0088",
					
					Text = "You inherited your mother's flaxen hair, and seemingly her force of will. Greenery would burst to life for her... the dead would too, if but they could. Within the reaches of my heart not yet grown cold, I know she still is safe." },
			},
			DemeterAboutPersephone02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift02" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0224",
					Portrait = "Portrait_Demeter_Pleased_01",
					Text = "Your mother used to visit us for months on end, but now... knowing that she is all right and restored to her Underworld throne, I could not ask for more. Not right away." },
			},

			DemeterAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DemeterAboutFates02" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0229",
					Text = "Now even the weavers of destiny apparently are gone, and shall do nothing to preserve their stake in our futures? That is the talk on the mountain, Granddaughter. So then we truly are alone... but we can fend for ourselves." },
			},
			DemeterAboutFates02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesAboutFates01", "ZeusPalacePostTrueEnding01" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0232",
					Text = "Chronos claims not even he knows where the Three Fates currently reside, despite having cast them away himself? I've seldom heard such foolishness. To think such a bumbling fool could have come so close to overthrowing us!" },
			},

			DemeterAboutFarmBoy01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift04" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0160",
					
					Text = "You have one grandfather in the cruel Titan, Chronos... and another who was nothing but a mortal farm-boy worshiper of mine. Whether I loved or pitied him, I cannot say. At least your mother was born deathless..." },
			},

			-- other reactions
			DemeterUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				{ Cue = "/VO/Demeter_0091",

					Text = "Granddaughter, where have you been? In the deepest reaches of your father's realm, perhaps! Striking at the very heart of our enemy. One can but hope." },
			},
			DemeterSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
				{ Cue = "/VO/Demeter_0166",
					Text = "I thank you, flower, for you've thrown our enemies upon this mountain into turmoil. Even now they attempt to regroup, but with your continued effort, we may drive them back." },
			},

			DemeterAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyDemeter" }
					},
					--[[
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyDemeter", "PackageBountyOneTouch", "PackageBountyStrife" }
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0156",
					
					Text = "Something about this night is troubling... as though some force of will yawned forth from the very depths of Chaos. But {#Emph}you {#Prev}wouldn't know anything of this, would you?" },
			},

			DemeterAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0157",
					
					Text = "Such a foreboding night this is! The air is thick with the death and decay of your father's realm, and the desolation I have wrought. The pale Moon can scarce cut through..." },
			},

			DemeterAboutSnow01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0274",
					
					Text = "Do you see those tiny flecks that drift down from the heavens to the Earth? I call it snow, and it is beautiful but very cold. We gods ought to be like the snow ourselves." },
			},

			DemeterAboutPom01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "StackUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0064",
					
					Text = "I wonder if the vile pomegranate fruit yet grows in your Underworld. It holds a power there that I do not abide; a mere taste of its blood-like seeds can be very dangerous, indeed." },
			},

			DemeterAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceDemeterBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0087",
					Text = "We are connected not unlike that Sheaf of Barley which you have. Each stem is broken easily, and yet the bunch is strong! Each different, and yet all very much alike." },
			},

			DemeterPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0222",
					Emote = "PortraitEmoteAnger",
					Text = "What have you {#Emph}done? {#Prev}The Titan Chronos ought have been destroyed, not taken in. The rot is in his very soul and cannot be removed! But... my daughter, she sent word that she is well, and... {#Emph}oh{#Prev}, what am I to {#Emph}do {#Prev}with all of this..." },
			},

			DemeterPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0192",
					Portrait = "Portrait_Demeter_Pleased_01",

					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					Text = "Oh, Granddaughter... what would I have ever done if not for you. That this mountain yet stands is one thing, but then... you found your mother for the both of us. I cannot repay you... what love I have to give shall have to suffice." },
			},
			DemeterPostTrueEnding03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0223",
					Text = "I shall never forgive Chronos, nor do I wish to see his wretched countenance again. But if whatever spell you cast on him has truly withered his ambitions, then so be it. Perhaps there was no other way..." },
			},

			DemeterPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0233",
					Text = "The weavers of destiny have sprouted up from the Earth once again! And conveniently right after we quelled the Titan's uprising without {#Emph}them {#Prev}having to intervene. We never {#Emph}could {#Prev}depend on the Fates..." },
			},
			DemeterPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0234",
					Text = "When my sisters and I and your father and his brothers first slew Chronos long ago, it was an ugly victory, but ushered in an age in which Olympus ruled. Now it seems another age is nigh... and I have yet to see a perfect one." },
			},

			DemeterAboutPalace01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {
							"DemeterPalaceFirstMeeting",
							"DemeterPalaceAboutTyphonDeath01",
							"DemeterPalacePostTrueEnding01",
							"DemeterPalacePostTrueEnding01_B",
						},
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = {
							"DemeterPalaceFirstMeeting",
							"DemeterPalaceAboutTyphonDeath01",
							"DemeterPalacePostTrueEnding01",
							"DemeterPalacePostTrueEnding01_B",
						}, Max = 8 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0228",
					Portrait = "Portrait_Demeter_Pleased_01",
					Text = "There has been little cause for joy upon Olympus in the recent past, certainly not for me. But seeing {#Emph}you{#Prev}, flower? That made up for much of the hardship. I know it may be some time before we meet again, but also know we {#Emph}shall." },
			},

			DemeterAboutPersephoneAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobImpulseAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0237",
					Text = "Some sort of skull you have... one of the Arms of Night, I know, and yet, that {#Emph}form... {#Prev}something about it, it... reminds me not of Nyx, but... of my {#Emph}daughter? Ah{#Prev}, but do not listen to my ravings. Carry on." },
			},
			DemeterAboutHelAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0238",
					Text = "That artifact you bear... such cold is emanating from it that I sense its power all the way from here. Whatever is the origin of all that deathlike frost, it isn't of this realm..." },
			},

			DemeterPostGift01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift07" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0235",
					Portrait = "Portrait_Demeter_Pleased_01",
					Text = "At times I fear that I've grown cold and bitter, but this matter has been quite rejuvenating in a way... ever since meeting you. I had perhaps been dormant for too long." },
			},

			DemeterAboutFamilyTree01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0230",
					Text = "How revolting to think that Chronos is technically a grandfather to you, as I am a grandmother. We have no connection at all, yet this family tree of ours has grown for many aeons and has twisted limbs by now..." },
			},

			DemeterAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift08" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0236",
					Text = "Of late I feel increasingly at loss for words, flower. After all this toil... I may wilt from social graces for a while. Though you'll have my undying support for as long as you require." },
			},

			-- repeatable lines
			DemeterChat01 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0003",
					
					Text = "Cold vengeance grows deep inside our hearts; let it flourish for a while." },
			},
			DemeterChat02 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0004",
					
					Text = "I have slain Titans once or twice before; you get to do the honors now, it seems." },
			},
			DemeterChat03 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0005",
					
					Text = "I shall not rest until your mother the Queen is restored to her rightful throne." },
			},
			DemeterChat04 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0006",
					
					Text = "May Chronos shiver, knowing well his actions shall not go unpunished." },
			},
			DemeterChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0007",
					
					Text = "My blessings, Granddaughter. You're like a cool winter's breeze." },
			},
			DemeterChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0008",
					
					Text = "You have your mother's strength. Take mine as well." },
			},
			DemeterChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0009",
					
					Text = "Perhaps you feel the bitter cold even from there." },
			},
			DemeterChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0010",
					
					Text = "We are amid a dark season indeed, my granddaughter..." },
			},
			DemeterChat09 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},

				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0011",
					
					Text = "Desolation unto those who side with the Titans against us." },
			},
			DemeterChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0012",
					
					Text = "However I can aid in your pursuits, I shall, flower." },
			},
			DemeterChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0013",
					
					Text = "Can you feel the biting chill in the air, Granddaughter? It shall intensify for you." },
			},
			DemeterChat12 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0014",
					
					Text = "So many traitors stand against us now, but soon they all shall lie in ruin and decay." },
			},
			DemeterChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0015",
					
					Text = "Through the seasons I bring life as well as death; which shall it be this time?" },
			},
			DemeterChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0016",
					
					Text = "Even the ichor flowing through a Titan's veins can be made to run cold." },
			},
			DemeterChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0017",
					
					Text = "The days grow dark, though perhaps they shall take a turn for the better as yet..." },
			},
			DemeterChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0018",
					
					Text = "For mortals, life is precious as it is fleeting. We goddesses can snuff it out so easily..." },
			},
			DemeterChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0019",
					
					Text = "You grow ever-stronger, flower, and it warms my cold heart." },
			},
			DemeterChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0020",
					
					Text = "Let none stand between you and your ambitions, Granddaughter." },
			},
			DemeterChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0021",
					
					Text = "Death and decay to the enemies of Olympus." },
			},
			DemeterChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0022",
					
					Text = "Those who dare stand against Olympus shall be summarily destroyed." },
			},
			DemeterChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0023",
					
					Text = "Pride and wrath run deep within our family, Granddaughter." },
			},
			DemeterChat22 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},

				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0024",
					
					Text = "It matters not that Chronos is our kin; there is no bond that cannot fray." },
			},
			DemeterChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0025",
					
					Text = "May you know times of peace as you grow long in years, but for right now..." },
			},
			DemeterChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0026",
					
					Text = "Be as complete and as relentless as the winter's cold, Melinoë." },
			},
			DemeterChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0027",
					
					Text = "{#Emph}Ahh{#Prev}, the ever-turning cycle of death and rebirth! Isn't it exquisite, in a way?" },
			},
			DemeterChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0028",
					
					Text = "Would that the surface offered fairer climes, flower, but no; not yet." },
			},
			DemeterChat27 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0029",
					
					Text = "Together let us see to it that Chronos reaps all that he has sown." },
			},
			DemeterChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0030",
					
					Text = "Grow strong and flourish like I know you can, Melinoë." },
			},
			DemeterChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0031",
					
					Text = "I think by now our foes are good and ripe for the harvesting." },
			},
			DemeterChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0032",
					
					Text = "Look what I picked just for you this eve, flower." },
			},
			DemeterChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0185",
					Text = "Tonight calls for inclement weather, so our enemies had better bundle up." },
			},
			DemeterChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0186",
					Text = "As you are my granddaughter, you are welcome to reap the benefits." },
			},
			DemeterChat33 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0187",
					Text = "The Earth shall drink deep of the blood of our enemies; those that {#Emph}can {#Prev}bleed, at least." },
			},
			DemeterChat34 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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

				{ Cue = "/VO/Demeter_0188",
					Text = "It remains unseasonably cold up here, flower. But you seem not to mind." },
			},
			DemeterChat35 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0189",
					Text = "I shall not hesitate to purge what warmth remains within the Earth, if that is what it takes." },
			},
			DemeterChat36 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0251",
					Text = "None know better than I of just how cruel the turning of the seasons can be." },
			},
			DemeterChat37 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0252",
					Text = "I shall drain all remaining life from whichever of our enemies have any of it left." },
			},
			DemeterChat38 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0253",
					Text = "Even in the wake of such devastation as we have seen, life can survive, and regrow." },
			},
			DemeterChat39 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0254",
					Text = "From the ashes of this war, may we yet flourish with sufficient time." },
			},
			DemeterChat40 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0255",
					Text = "Time threatened to take everything away from us, but we held fast, and always shall." },
			},

		},

		BoughtTextLines =
		{
			DemeterBlindBox01 =
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
						Path = { "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 0,
					},					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0084",
					Text = "I care very little for surprises, flower. And perhaps in that we are alike. Yet there exists a rare variety that's welcome... like a brisk breeze on an autumn eve." },
			},
			DemeterBlindBox02 =
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
						Path = { "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0085",
					Text = "How humiliating, that even our Boons must be concealed... lest we risk revealing too much about our plans and defenses to our enemies." },
			},

			DemeterLootBought01 =
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
						Path = { "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0075",
					
					Text = "How shameful that we now resort to common subterfuge, having our correspondence smuggled to and fro by the erstwhile Boatman of the Dead." },
			},
			DemeterLootBought02 =
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
						Path = { "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0076",
					
					Text = "The Titan's coin that you exchanged for this message... we shall find all of it, melt it down, and return the Gold whence it came." },
			},
			DemeterLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0082",
					
					Text = "If only you could see my fields in the morning sun... shining brighter than any Gold you shall ever find. Such metals ought remain within the Earth." },
			},
			DemeterLootBought04 =
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
						Path = { "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0083",

					Text = "To be reduced to picking through such meager offerings! You ought have lived here in the glory of Olympus, where everything that you desire is at hand... for the most part." },
			},

		},

		RejectionTextLines =
		{
			DemeterRejection01 =
			{
				{ Cue = "/VO/Demeter_0077",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					
					Text = "You would spurn your own {#Emph}grandmother? {#Prev}Perhaps where you were raised, proper manners were not taught as a priority." },
			},
			DemeterRejection02 =
			{
				{ Cue = "/VO/Demeter_0078",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					
					Text = "Even amid such times, we gods and goddesses yet have our pride; you would be wiser next time not to hurt mine thus." },
			},
			DemeterRejection03 =
			{
				{ Cue = "/VO/Demeter_0111",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You are a direct descendant of mine, and {#Emph}still {#Prev}you would spurn me like this?" },
			},
			DemeterRejection04 =
			{
				{ Cue = "/VO/Demeter_0112",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Such wrath I feel, Melinoë, that I have a great deal to spare, even for {#Emph}you." },
			},
			DemeterRejection05 =
			{
				{ Cue = "/VO/Demeter_0113",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Had you grown up within your father's House, you would have learned {#Emph}respect." },
			},
			DemeterRejection06 =
			{
				{ Cue = "/VO/Demeter_0114",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Understand that lately, I lack the patience for such antics, Granddaughter." },
			},
			DemeterRejection07 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "ApolloUpgrade" },
					},
				},
				{ Cue = "/VO/Demeter_0115",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Do not choose against me even in jest, Granddaughter; Apollo makes light, not I." },
			},
			DemeterRejection08 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HestiaUpgrade" },
					},
				},
				{ Cue = "/VO/Demeter_0116",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "So what if Hestia is {#Emph}technically {#Prev}my elder? She hardly gives Olympus her attention!" },
			},
			DemeterRejection09 =
			{
				PlayFirst = true,
				{ Cue = "/VO/Demeter_0169",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You would forsake my blessing, even knowing it is sought after all the world over?" },
			},
			DemeterRejection10 =
			{
				PlayFirst = true,
				{ Cue = "/VO/Demeter_0170",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I take no pride in what I am about to do, Melinoë. But how else shall you learn?" },
			},
			DemeterRejection11 =
			{
				PlayFirst = true,
				{ Cue = "/VO/Demeter_0171",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "If this was your attempt at humor, know that it was lost on me entirely." },
			},
			DemeterRejection12 =
			{
				PlayFirst = true,
				{ Cue = "/VO/Demeter_0172",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "If you are wondering whether that icy chill you feel in the air is mine, {#Emph}it is." },
			},
		},

		RejectionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "GodRejectedVoiceLines" },
		},

		MakeUpTextLines =
		{
			DemeterMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0079",
					
					Text = "I am not angry with you any longer, Granddaughter; merely a little disappointed at the moment..." },
			},
			DemeterMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0080",
					
					Text = "Oh, I cannot remain upset with you, flower. I would rather you look upon me kindly than with scorn." },
			},
			DemeterMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0121",

					Text = "{#Emph}<Sigh> {#Prev}My mood's as foul as the weather as of late... apologies for the outburst, flower." },
			},
			DemeterMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0122",
					
					Text = "You weathered the storm, though could have avoided it outright, of course..." },
			},
			DemeterMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0123",
					
					Text = "There need not be a strain between us, Granddaughter. Forgive me. I was rash." },
			},
			DemeterMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0124",
					
					Text = "This family, and our blasted {#Emph}pride! {#Prev}These constant fights with our own kin! {#Emph}Feh." },
			},
			DemeterMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0173",
					
					Text = "Your mother used to anger me in just this way, and look where {#Emph}that {#Prev}got her." },
			},
			DemeterMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0174",
					
					Text = "Let us move on. Your provocation needn't have roused my ire to the extent that it did." },
			},
			DemeterMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0175",
					
					Text = "No harm comes of a little fight. We {#Emph}ought {#Prev}to focus on the {#Emph}real {#Prev}fight, instead." },
			},
			DemeterMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0176",
					
					Text = "I am not angry with you, Granddaughter; and I admit I acted out of turn." },
			},
			DemeterMakeUp11 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
					}
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0177",
					
					Text = "Oh, Melinoë, we mustn't fight! Not with each other, only side by side." },
			},
			DemeterMakeUp12 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
					}
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0178",
					
					Text = "{#Emph}Eugh{#Prev}, I ought {#Emph}bury {#Prev}these impulses that drive me to act out of temper, not reason." },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			DemeterGift01 =
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
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0961", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To think the goddess of seasons herself is my grandmother. I am honored to have made your acquaintance!" },
				{ Cue = "/VO/Demeter_0067",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I see the Witch of the Crossroads taught you not just strength but grace! I hereby accept your offering, and have something for you as well." },
			},
			DemeterGift02 =
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
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0962", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lady Demeter! I'm grateful for your strength. This is hardly fitting in exchange, but please accept it." },
				{ Cue = "/VO/Demeter_0068",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "It seems there are such youth today as still can show my generation due respect. I am pleased my own granddaughter is such an example." },
			},
			DemeterGift03 =
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
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1769", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To the goddess whose power truly is the lifeblood of our world! It's by your grace that such an offering of Nectar may exist at all." },
				{ Cue = "/VO/Demeter_0069",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Why, flower, surely there are other matters weighing heavily upon you now, more so than honoring your elders in the customary way? Nevertheless, I'm grateful for this, truly." },
			},
			DemeterGift04 =
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
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1770", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Grandmother, we've so much making up to do for all the time we could have spent getting to know each other. I trust we'll do just that soon enough, though for right now, there's this." },
				{ Cue = "/VO/Demeter_0070",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "It's strange... as much as I loved your mother, she never honored me thus. Perhaps I was too lenient with her, or perhaps your generation is merely more considerate of their predecessors." },
			},
			DemeterGift05 =
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
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3726", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I cannot begin to imagine all that you do for this world, Grandmother. All living creatures count on you and what the seasons bring. That you are able to make time for me amid all that is not something I'll ever take for granted." },
				{ Cue = "/VO/Demeter_0164",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I thank you for the offering, though I am usually left cold. From mortals lately, merely begging, cries for mercy, nothing more. {#Emph}Let my crops grow, Lady Demeter. Save my harvest, Lady Demeter! {#Prev}Insufferable..." },
			},
			DemeterGift06 =
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
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3727", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Where I am from, we lacked for plenty, but we never truly lacked. And I know that's in small part because of you, Grandmother. My headmistress thinks so highly of you, and I could see why from the moment we met like this." },
				{ Cue = "/VO/Demeter_0165",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Perhaps I ought have far more gratitude, myself. I think so often of my pain and lack... how could I not? Yet I have you, this mountain home, and more. Would only that the burden of it all ever lightened." },
			},
			DemeterGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_HeraDemeterGiftHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DemeterPostTrueEnding02", "DemeterGift06" },
					},
				},
				{ Cue = "/VO/MelinoeField_4167", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "A gift of Ambrosia for you, Grandmother! Perhaps this can liven things up, for there ought to be much cause for celebration in the coming times. But mostly I just wanted you to have it, for all the hope you gave me." },
				{ Cue = "/VO/Demeter_0193",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Demeter_Pleased_01",
					Text = "You say {#Emph}I {#Prev}gave {#Emph}you {#Prev}hope? I was intent on fighting the Titan no matter what. But having met you... I started to consider the possibility that we might prevail. Then I could see my daughter's gentle face, and {#Emph}her {#Prev}daughter's. I can think of no worthier cause." },
			},
			DemeterGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				CompletedHintId = "Codex_BondForgedDemeter",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DemeterGift07" },
					},
				},
				{ Cue = "/VO/MelinoeField_4168", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Grandmother, you've stood by me ever since we met, and I felt our bond from the start. May this Ambrosia commemorate not just our past but our future. For I feel I still have so much to learn about you, and learn from you." },
				{ Cue = "/VO/Demeter_0194",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Demeter_Pleased_01",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Demeter_01", Icon = "Keepsake_Demeter" },

					Text = "I shall accept this, but no more. Know that your mother and I always had our struggles, flower. It was only once she lived her own life rather than my idea of it that our withered connection started to heal. May your and my relationship grow quickly past that point." },
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1736", Text = "A gift from Grandmother..." },
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
				Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "DemeterUpgrade" },
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

				{ Cue = "/VO/Demeter_0147", Text = "Back to dust!" },
				{ Cue = "/VO/Demeter_0149", Text = "Ripe for the harvest!" },
				{ Cue = "/VO/Demeter_0150", Text = "Reap what you sow!", PlayFirst = true },
				{ Cue = "/VO/Demeter_0245", Text = "Shiver and rot!" },
				{ Cue = "/VO/Demeter_0247", Text = "The numbing cold!" },
				{ Cue = "/VO/Demeter_0246", Text = "Freeze forever!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = { "/VO/Demeter_0147", "/VO/Demeter_0149", "/VO/Demeter_0150", "/VO/Demeter_0245", "/VO/Demeter_0247" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "DemeterUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Demeter_0248", Text = "Is this truly what you want?!" },
				{ Cue = "/VO/Demeter_0249", Text = "How like your mother you are!", PlayFirst = true },
				{ Cue = "/VO/Demeter_0250", Text = "Whatever you say, Granddaughter!" },
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

				{ Cue = "/VO/Chronos_1259", Text = "Unseasonably cold...!" },
				{ Cue = "/VO/Chronos_1260", Text = "A {#Emph}chill {#Prev}here in these {#Emph}depths?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsAny = { "I_Boss01" }
						},
					},
				},
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

				{ Cue = "/VO/Zagreus_0358", Text = "Grandmother...?", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0359", Text = "She has a favorite then!" },
			},
		},

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
			PreLineWait = 1.25,
			NoTarget = true,

			{ Cue = "/VO/Demeter_0117", Text = "I'm finished tolerating insolence; no exceptions, not even for you.", PlayFirst = true },
			{ Cue = "/VO/Demeter_0118", Text = "Do not anger me again, flower, or I shall make you {#Emph}wilt." },
			{ Cue = "/VO/Demeter_0119", Text = "All you young goddesses are far too much alike..." },
			{ Cue = "/VO/Demeter_0120", Text = "This is not a betrayal, Granddaughter; merely a lesson." },
		},

		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
				},

				{ Cue = "/VO/Demeter_0139", Text = "Very well." },
				{ Cue = "/VO/Demeter_0140", Text = "Yes, of course." },
				{ Cue = "/VO/Demeter_0141", Text = "I shall oblige." },
				{ Cue = "/VO/Demeter_0142", Text = "Your choice." },
				{ Cue = "/VO/Demeter_0143", Text = "Yes, done." },
				{ Cue = "/VO/Demeter_0144", Text = "As you wish." },
				{ Cue = "/VO/Demeter_0145", Text = "Certainly." },
				{ Cue = "/VO/Demeter_0146", Text = "For you." },
			},
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
			TriggerCooldowns = { "DemeterBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Demeter_0133", Text = "Hello, flower!" },
			{ Cue = "/VO/Demeter_0134", Text = "It is I." },
			{ Cue = "/VO/Demeter_0135", Text = "My greetings." },
			{ Cue = "/VO/Demeter_0136", Text = "Granddaughter?" },
			{ Cue = "/VO/Demeter_0137", Text = "What have we here?" },
			{ Cue = "/VO/Demeter_0138", Text = "What a surprise!" },
			{ Cue = "/VO/Demeter_0181", Text = "Behold." },
		},

		Using = { ProjectileName = "DemeterSprintStorm" },
	},	

}

OverwriteTableKeys( LootData, LootSetData.Demeter )