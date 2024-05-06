LootSetData.Demeter =
{
	-- Demeter
	DemeterUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		OffersElementalTrait = {"Water","Earth"},
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
		SurfaceShopText = "DemeterUpgrade_Store",
		SurfaceShopIcon = "BoonInfoSymbolDemeterIcon",
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
		Portrait = "Portrait_Demeter_Default_01",
		WrathPortrait = "Portrait_Demeter_Wrath_01",
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

			-- Legendary
			"InstantRootKill",

			-- Elemental
			"ElementalDamageCapBoon",

			-- Duos
			"EchoAllBoon",
			"KeepsakeLevelBoon",
			"GoodStuffBoon",
			"CastRampBoon",
			"MaxHealthDamageBoon",
			"DoubleBurnBoon",
			"ClearRootBoon",
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
			[2] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines,
			[3] = GlobalVoiceLines.FoundRareBoonVoiceLines,
		},

		DuoPickupTextLines =
		{
			DemeterWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "EchoAllBoon",
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
					HasTraitNameInRoom = "KeepsakeLevelBoon",
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
					HasTraitNameInRoom = "GoodStuffBoon",
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
					HasTraitNameInRoom = "CastRampBoon",
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
					HasTraitNameInRoom = "MaxHealthDamageBoon",
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
					HasTraitNameInRoom = "ClearRootBoon",
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
					HasTraitNameInRoom = "DoubleBurnBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0109",
					Text = "Your Great Aunt Hestia is not exactly as she {#Emph}seems. {#Prev}In olden times, she was content merely to let her flames keep sputtering within the hearths of mortal homes. Admit to it, Sister: You've changed." },
				{ Cue = "/VO/Hestia_0154",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "And you, Demeter, you've not changed at {#Emph}all! None {#Prev}of you have! It's why you're in a heap of {#Emph}trouble {#Prev}now, or {#Emph}we {#Prev}I ought to say. Good thing your grandkid's coming to our rescue!" },
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
					NarrativeContextArt = "DialogueBackground_Erebus",
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
					RequiredMaxHealthFraction = 0.3,
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
						Value = 0,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterLowHealth01", },
					},
					RequiredMaxHealthFraction = 0.3,
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
					RequiredMaxHealthFraction = 0.3,
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
					RequiredMaxHealthFraction = 0.3,
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
					-- @ temp
					--[[
					{
						Path = { "GameState", "UseRecord", "DemeterUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0033",
					
					Text = "I miss your mother terribly, and your brother as well. He was my little sprout. Chronos must have ensnared him with the others in your father's House, the unforgivable wretch..." },
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
					Text = "The first time your mother was lost to me... the Witch of the Crossroads emerged from the shadows to light my way, as I searched to the ends of the earth. We found not a thing; but at least I was not alone..." },
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
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0097",
					
					Text = "I take it Chronos still goes everywhere with that old gaudy-looking golden scythe of his? He fancies himself a reaper, speaks of harvest and decay; but he merely speaks in riddles, whilst {#Emph}I {#Prev}work directly in the trade." },
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
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0043",
					
					Text = "You sprang forth from underneath that gloom unto our world's surface, have you, flower? If you mean to visit our mountain, merely follow the path of desolation leading straight to us..." },
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
						IsAny = { "G", },
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
						PathTrue = { "PrevRun", "RoomsEntered", "H_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0093",
					
					Text = "Your journey sends you through the Mourning Fields. I've seen that place... just {#Emph}dreadful{#Prev}, utterly! All of the wheat there, it... I thought perhaps it would provide a bit of cheer..." },
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
					
					Text = "The bounties of the earth... life flourishes even there where you reside, amid all that death. Flowers, roots, herbs, and seeds; you know their hidden strength. I let them grow for you." },
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
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
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
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
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
						HasNone = GameData.GodAboutGodVoiceLines,
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
					-- @ temp
					{
						Path = { "GameState", "UseRecord", "DemeterUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
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
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					-- @ temp
					{
						Path = { "GameState", "UseRecord", "DemeterUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
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
					-- @ temp
					{
						Path = { "GameState", "UseRecord", "DemeterUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
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
						HasNone = GameData.GodAboutGodVoiceLines,
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
						HasNone = GameData.GodAboutGodVoiceLines,
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
						HasNone = GameData.GodAboutGodVoiceLines,
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
						HasNone = GameData.GodAboutGodVoiceLines,
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
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0061",
					
					Text = "Normally, sweet Aphrodite's power over beauty provides no shortage of entertainment I'm sure, though I fail to see how her blessing can be of much benefit in such a predicament as ours." },
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
						HasNone = GameData.GodAboutGodVoiceLines,
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
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0063",
					
					Text = "Perhaps I misjudged your woodsy cousin Artemis. To think that she found you! I was certain she was merely gallivanting with her Nymph-friends rather than being of use." },
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

			DemeterAboutPersephone01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift02" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0088",
					
					Text = "You inherited your mother's flaxen hair, and seemingly her force of will. Greenery would burst to life for her... the dead would too, if but they could. Within the reaches of my heart not yet grown cold, I know she still is safe." },
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
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0091",

					Text = "Granddaughter, where have you been? In the deepest reaches of your father's realm, perhaps! Striking at the very heart of our enemy. One can but hope." },
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
						IsAny = { "PackageBountyOneTouch" }
					},
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
						Value = 14,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0157",
					
					Text = "Such a foreboding night this is! The air is thick with the death and decay of your father's realm, and the desolation I have wrought. The pale Moon can scarce cut through..." },
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
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0005",
					
					Text = "I shall not rest until your mother the Queen is restored to her rightful throne." },
			},
			DemeterChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Demeter_0028",
					
					Text = "Would that the surface offered fairer climes, flower, but no; not yet." },
			},
			DemeterChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
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
					IsObjectTypeAlive = "NPC_Charon_01",
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
					IsObjectTypeAlive = "NPC_Charon_01",
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
					-- IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Demeter_0082",
					
					Text = "If only you could see my fields in the morning sun... shining brighter than any gold you shall ever find. Such metals ought remain within the earth." },
			},
			DemeterLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					IsObjectTypeAlive = "NPC_Charon_01",
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
					Text = "Had you grown up within your father's house, you would have learned {#Emph}respect." },
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
			[1] = GlobalVoiceLines.GodRejectedVoiceLines,
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
				},
				{ Cue = "/VO/Melinoe_0961", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To think the goddess of seasons herself is my grandmother. I am honored to have made your acquaintance." },
				{ Cue = "/VO/Demeter_0067",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I see the Witch of the Crossroads taught you not just strength but grace! I hereby accept your offering, and have something for you as well." },
			},
			DemeterGift02 =
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
				},
				{ Cue = "/VO/Melinoe_0962", UsePlayerSource = true,
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
				},
				{ Cue = "/VO/MelinoeField_1769", UsePlayerSource = true,
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
				},
				{ Cue = "/VO/MelinoeField_1770", UsePlayerSource = true,
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

			-- placeholder
			DemeterGiftTemp =
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

			{ Cue = "/VO/Melinoe_1736", Text = "A gift from Grandmother..." },
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
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
			Cooldowns =
			{
				{ Name = "BoonRarifiedSpeech", Time = 60 },
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

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
			TriggerCooldowns = { "DemeterBoonTakenSpeech" },

			{ Cue = "/VO/Demeter_0133", Text = "Hello, flower!" },
			{ Cue = "/VO/Demeter_0134", Text = "It is I." },
			{ Cue = "/VO/Demeter_0135", Text = "My greetings." },
			{ Cue = "/VO/Demeter_0136", Text = "Granddaughter?" },
			{ Cue = "/VO/Demeter_0137", Text = "What have we here?" },
			{ Cue = "/VO/Demeter_0138", Text = "What a surprise!" },
			{ Cue = "/VO/Demeter_0181", Text = "Behold." },
		},

	},	

}

OverwriteTableKeys( LootData, LootSetData.Demeter )