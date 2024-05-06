LootSetData.Zeus =
{
	-- Zeus
	ZeusUpgrade =
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "ZeusFirstPickUp" },
			},
			-- first appears in Opening rooms; additional requirements in RoomDataF ForcedRewards table
		},
		OffersElementalTrait = {"Air"},
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		Weight = 10,
		SurfaceShopText = "ZeusUpgrade_Store",
		SurfaceShopIcon = "BoonInfoSymbolZeusIcon",
		BoonInfoIcon = "BoonInfoSymbolZeusIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_ZeusUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_ZeusUpgrade",
		LootRejectedText = "Player_GodDispleased_ZeusUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_ZeusUpgrade",
		Icon = "BoonSymbolZeus",
		DoorIcon = "BoonDropZeusPreview",
		DoorUpgradedIcon = "BoonDropZeusUpgradedPreview",
		Color = { 250, 250, 215, 255 },
		LightingColor = {255, 255, 128, 255},
		LootColor = {255, 255, 64, 255},
		SubtitleColor = Color.ZeusVoice,
		ColorGrade = "ZeusLightning",
		LootRejectionAnimation = "BoonDissipateA_Zeus",
		SpawnSound = "/SFX/ZeusBoonThunder",
		PortraitEnterSound = "/SFX/ZeusBoonThunder",
		UpgradeSelectedSound = "/SFX/ZeusBoonChoice",

		PriorityUpgrades = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoon" },
		WeaponUpgrades =
		{
			"ZeusWeaponBoon",
			"ZeusSpecialBoon",
			"ZeusCastBoon",
			"ZeusSprintBoon",
			"ZeusManaBoon",
		},
		Traits =
		{
			"ZeusManaBoltBoon",
			"BoltRetaliateBoon",
			"CastAnywhereBoon",
			"FocusLightningBoon",
			"DoubleBoltBoon",
			"EchoExpirationBoon",
			"LightningDebuffGeneratorBoon",

			-- Legendary
			"SpawnKillBoon",

			-- Elemental
			"ElementalDamageFloorBoon",

			-- Duos
			"SuperSacrificeBoonZeus",
			"LightningVulnerabilityBoon",
			"EchoAllBoon","ApolloSecondStageCastBoon",
			"SprintEchoBoon",
			"EchoBurnBoon",
			"ReboundingSparkBoon",
		},
		Consumables = { },

		SpeakerName = "Zeus",
		Speaker = "NPC_Zeus_01",
		Portrait = "Portrait_Zeus_Default_01",
		WrathPortrait = "Portrait_Zeus_Wrath_01",
		OverlayAnim = "ZeusOverlay",
		Gender = "Male",
		FlavorTextIds =
		{
			"ZeusUpgrade_FlavorText01",
			"ZeusUpgrade_FlavorText02",
			"ZeusUpgrade_FlavorText03",
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
			{ Cue = "/VO/Melinoe_0638", Text = "The lightning sigil..." },
		},

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.85,
			ChanceToPlay = 0.33,
			GameStateRequirements =
			{
				NamedRequirements = { "OlympianOnSpawnVoiceLinesAllowed" },
			},

			{ Cue = "/VO/Melinoe_1468", Text = "Lord Uncle...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1469", Text = "There he is..." },
			{ Cue = "/VO/Melinoe_0638", Text = "The lightning sigil..." },
		},

		UpgradeMenuOpenVoiceLines =
		{
			[1] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines,
			[2] = GlobalVoiceLines.FoundRareBoonVoiceLines,
		},
		
		DuoPickupTextLines =
		{
			ZeusWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "SuperSacrificeBoonZeus",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0097",
					Text = "Niece, I expect from you only the best behavior, manners, and performance in the presence of my dear beloved wife, without whom I would be the merest shadow of my greatness." },
				{ Cue = "/VO/Hera_0098",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "The truest words you've spoken in quite some time, Husband! And I'm more than just your {#Emph}dear beloved {#Prev}wife, aren't I? Seeing as I am the blasted Queen. Not that {#Emph}your {#Prev}authority or mine has been worth much of anything of late." },
			},
			ZeusWithHera02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "SuperSacrificeBoonZeus",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0153",
					Text = "My command of the heavens is nothing compared to the strength of our family bond! The Queen and I have stood together through worse times than {#Emph}this. {#Prev}Haven't we, Dear?" },
				{ Cue = "/VO/Hera_0100",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "{#Emph}Oh {#Prev}why, we've stood together now through more hard times than I can count! I daresay we're well past due for a break. Perhaps after our present difficulties finally subside?" },
			},

			ZeusWithPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "LightningVulnerabilityBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0085",
					Text = "Melinoë, one tidbit you ought to know about our side of the family is, while we may not agree on each detail, in the end, we always find ourselves on the same side of every challenge that we face. Isn't that right, Brother?" },
				{ Cue = "/VO/Poseidon_0083",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, absolutely, Lord Zeus! When you get down to it, our clan is of a single will! Although I guess, you — {#Emph}w-w-we {#Prev}don't count Chronos in that estimation, do we, now? He's technically family, but very much opposed to everything we stand for!" },
			},
			ZeusWithPoseidon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "LightningVulnerabilityBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0155",
					Text = "We are as one big family upon Olympus, and we pride and celebrate our differences. So many varying perspectives to account for at all times! Although Poseidon here, we always manage to see eye-to-eye, don't we..." },
				{ Cue = "/VO/Poseidon_0266",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh that we {#Emph}do{#Prev}, most certainly, Brother! Not always right away, and there are some occasions when I might decide elsewise if it were solely up to me, but even {#Emph}still! {#Prev}You always have your head up in the clouds, where smart ideas form!" },
			},

			ZeusWithApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ApolloSecondStageCastBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0099",
					Text = "Melinoë, my bright son Apollo, you'd be wise to learn a thing or two from {#Emph}him! {#Prev}Why he is just about the best at everything. Envy of Olympus, here to greet you, and to teach you, {#Emph}here he is!" },
				{ Cue = "/VO/Apollo_0090",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Text = "I'm grateful for the flattery, Father. Though, your fair niece is more than capable of fending for herself. Still, an extra bit of insurance from the heavens couldn't hurt, right?" },
			},

			ZeusWithDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "EchoAllBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0157",
					Text = "Our upstart enemies shall scatter to the Four Winds once we're through with them! Our challenge is to purge them whilst minimizing unspeakable devastation. And Lady Demeter could always make the Earth re-grow." },
				{ Cue = "/VO/Demeter_0100",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "Well, Lord Zeus... it is much harder to re-grow where not a trace of life remains. But that's of little consequence right now. Let all who oppose us {#Emph}wither! {#Prev}And we shall salt the Earth beneath their feet." },
			},

			ZeusWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "SprintEchoBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0159",
					Text = "You witches like to use your feminine wiles to get your way? Well {#Emph}now {#Prev}is the time to use every means at our disposal! Why, even Aphrodite has taken up the cause, not to mention the spear!" },
				{ Cue = "/VO/Aphrodite_0141",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Text = "Oh I'm no novice with the spear, Lord Zeus. For there {#Emph}are {#Prev}those against whom not even my {#Emph}feminine wiles {#Prev}prove as effective as a sharp and pointy bit of metal tends to be. I think our Underworld kin can probably relate!" },
			},

			ZeusWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ReboundingSparkBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0161",
					Text = "If there's one good thing about this war, it's that even our most reserved family members have to rise up and make themselves known! Or just make themselves known in the case of my good son Hephaestus here, {#Emph}haha!" },
				{ Cue = "/VO/Hephaestus_0120",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Text = "{#Emph}Ah! {#Prev}Another one of your fine jests there, Dad, and right in witchie's earshot too! Just when I thought he couldn't possibly stoop to my level, he continues to surprise." },
			},

			ZeusWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "EchoBurnBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0163",
					Text = "We're so accustomed to my sister-in-law Hestia being off on her own, why, we even stopped saving a seat in my palace! But she's here to stay this time, aren't you, Hess?" },
				{ Cue = "/VO/Hestia_0146",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Oh{#Prev}, why, dearest Zeus, perish the thought that I would ever leave again! You've given me such a warm welcome after all, having removed my blasted seat only to put it back. Though, let's not worry hot stuff here with all of that!" },
			},

		},

		InteractTextLineSets =
		{
			ZeusFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/MelinoeField_1598", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.7, PowerWordPresentation = true, PowerWordWaitTime = 4.25 },
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					NarrativeContextArt = "DialogueBackground_Erebus",
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "The king of the gods must have his hands full recently. {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Zeus_0125",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Text = "{#Emph}Ah{#Prev}, young lady, so we meet at last! Emerged from all that gloom to help us settle an old score. If you possess your father's strength, then we have the advantage! Let us strike." },
			},

			-- low health
			ZeusLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0048",
					
					Text = "{#Emph}Augh{#Prev}, Melinoë, what happened to you there? You're barely hanging on, though let me see if I can't help you find your footing." },
			},
			ZeusLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0049",
					
					Text = "{#Emph}Mm{#Prev}, you must have weathered quite a storm on your way there. But don't lose hope; we'll turn that storm into a source of strength!" },
			},
			ZeusLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0050",
					
					Emote = "PortraitEmoteSurprise",
					Text = "Oh no, my niece, you're hurt! A hazard of your mission, I suppose, yet even still it breaks my heart to see. Have courage and fight on!" },
			},
			ZeusLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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

				{ Cue = "/VO/Zeus_0051",
					
					Text = "Such injuries you've already sustained... yet you press on, knowing the task you've undertaken is imperative. You are an inspiration, young lady!" },
			},

			-- run starts
			ZeusRunStart01 =
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
				{ Cue = "/VO/Zeus_0052",
					
					Text = "Greetings, my fair niece! I expected I might find you setting forth here on another of your escapades! And I would have this be a most successful one, for you and all of us!" },
			},
			ZeusRunStart02 =
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
				{ Cue = "/VO/Zeus_0053",
					
					Text = "{#Emph}Ah{#Prev}, your journey begins anew again, young lady! Though, let's see how it goes for you when you have my incomparable blessing from the start!" },
			},
			ZeusRunStart03 =
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
				{ Cue = "/VO/Zeus_0149",
					Text = "As you set forth again this evening, let me guarantee that you start off on the right foot. Know that all of us are behind you, every step of the way!" },
			},
			ZeusRunStart04 =
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
				{ Cue = "/VO/Zeus_0150",
					Text = "You're just getting started for this evening, aren't you, young lady? Well let me usher you along. Harness the thunder, and ensure our victory!" },
			},
			ZeusSurfaceRunStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutSurface03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0151",
					Text = "You must be somewhere near a gateway to your father's realm. So you're headed {#Emph}here {#Prev}again, rather than toward his House? Well be that as it may, my aid is yours." },
			},
			ZeusSurfaceRunStart02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutSurface03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0152",
					Text = "You've a long way to go before you reach Olympus, Niece; and there's been some inclement weather. But you don't mind a little thunder and lightning now, do you?" },
			},

			-- story events
			ZeusAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0033",
					
					Text = "I remember we were overjoyed to learn your mother was expecting; but alas, we never heard from her again. Chronos seized an awful opportunity to strike. Imagine our shock when you sprang from the shadows into our lives!" },
			},
			ZeusAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0034",
					
					Text = "When we realized Chronos struck your father's House, we feared you were lost with all the rest. How fortunate the Witch of the Crossroads was able to whisk you away! Though she ought have reached out sooner with such news..." },
			},
			ZeusAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0035",
					
					Text = "We'd grown so accustomed to having little contact with your father down in the Underworld that Chronos was able to gain a foothold there before we knew it. Been locked in battle with his forces ever since!" },
			},
			ZeusAboutChronos04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0036",
					
					Text = "I once fought the Titan Chronos hand-to-hand! Now perhaps you'll get to do the honors for me, {#Emph}hm? {#Prev}I have the family to look after, and must oversee our plans as they unfold." },
			},
			ZeusAboutChronos05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0037",
					
					Text = "The Fates themselves knew Chronos would be overthrown by his own kin. We've done it before, and we're going to do it again! Your assistance in the matter is appreciated." },
			},

			ZeusAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0040",
					
					Text = "Your father and I had our differences. But the brotherly bond we shared was very strong, indeed... stronger than either one of us! Let us prevail in this war to honor him." },
			},

			ZeusAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0038",
					
					Text = "You're fortunate that you inherited your mother's features, rather than your father's, young lady! {#Emph}Hah{#Prev}, poor old Hades, how the world weighed heavily on him. He was a good brother to me, and shall be suitably avenged!" },
			},

			ZeusAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0041",
					
					Text = "That reclusive Witch of the Crossroads must have been a most unwilling caretaker of yours! And kept you from your real family till now. At least Hecate taught you some survival skills, and had enough sense to finally acquaint us!" },
			},
			ZeusAboutHecate02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHecate01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0042",
					
					Text = "Do tell that Witch of the Crossroads that I shall be expecting prompt reports from her as to the situation in the Underworld. Now certainly is not the time for selfishness!" },
			},

			ZeusAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0045",
					
					Text = "Alas that you never got to know your brother Zagreus, fine lad that he was. Determined lad! Didn't always get on with your father, but who does? I'm certain he fought Chronos just as bravely as he could." },
			},

			ZeusAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ChronosNightmare01" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0078",
					
					Emote = "PortraitEmoteSurprise",
					Text = "Chronos has captured the {#Emph}Three Fates?! {#Prev}Preposterous. A useless provocation! They answer to no god or Titan. All it means is that what comes to pass shall not be their decision anymore. We ought to see it as an {#Emph}opportunity!" },
			},

			ZeusAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					-- @ update with real requirements
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0088",
					
					Text = "Melinoë, {#Emph}erm{#Prev}, something is afoot here on Olympus... rumblings, yet not even Poseidon knows the source. Well, whatever cowardly maneuver Chronos has in store, we're going to repel it! With your aid, perhaps." },
			},

			ZeusAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Boss01", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0079",
					
					Text = "That worthless Cyclops Polyphemus, turning his broad back against the gods! His kind once aided us against the Titans; yet he's of a newer generation, lacking loyalty, apparently! His actions cannot be excused." },
			},
			ZeusAboutPolyphemus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Boss01", },
						Comparison = ">=",
						Value = 2,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0127",
					
					Text = "Would that Poseidon didn't make sport of ridiculing Cyclopes, perhaps old sightless Polyphemus would be standing with us rather than against! {#Emph}Ah{#Prev}, but we all make mistakes, don't we?" },
			},

			ZeusAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01", },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0170",
					Text = "You Underworld goddesses and gods all know each other, do you not? If you could please notify Nyx's pest of a daughter {#Emph}Eris {#Prev}that she has no permission to fly within our borders, we would be mightily obliged!" },
			},

			ZeusAboutOlympians01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PoseidonFirstPickUp", "HestiaFirstPickUp", "DemeterFirstPickUp", "AphroditeFirstPickUp" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0039",
					
					Text = "You've met most members of the clan by now, but unfortunately, several are away. I'm certain they'll have the most fascinating explanations for their absences during such a circumstance." },
			},

			ZeusAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift02" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0074",
					
					Text = "Once all of this is settled, you come join us on Olympus here, won't you? No need to toil on within that witch's glade. Though, I suppose you may be needed in your father's House. At any rate, know that the invitation stands!" },
			},
			ZeusAboutOlympus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "P_Intro" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0075",
					
					Text = "You've seen it now firsthand: Our great mountain is perpetually besieged, and we've not had a moment's peace of late. Yet this trial only makes us stronger as a family!" },
			},

			ZeusAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01", },
						Comparison = ">=",
						Value = 2,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0046",
					
					Text = "The mortals, they don't shower us with offerings at quite the rate at which they used to, young lady. How brazen they've become, seeing Chronos as some sort of savior, I suppose. {#Emph}Pah!" },
			},
			ZeusAboutMortals02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01", },
						Comparison = ">=",
						Value = 5,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0047",
					Text = "Some mortals are such fools to be enticed by the promise of a new Golden Age. {#Emph}When Chronos ruled, it was a time of peace{#Prev}, they claim! {#Emph}No war or strife! {#Prev}And no advancement or society, either. The path of progress isn't paved!" },
			},

			ZeusAboutWeapons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0091",
					
					Text = "That silver sickle that you wield. It seems not only are the Arms of Night awakened, they are in your grasp. I once fought Titans with their counterparts. Now it seems that history repeats." },
			},

			ZeusAboutDevotionTests01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "DevotionTestN"  },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0146",
					Text = "I regret you've been swept up in some of our little disagreements here, young lady. We all wish to bestow our favor, and should not be fighting over who gets to go first! Yet our pride is not so delicate as it may seem, and we always stand together in the end!" },
			},

			ZeusAboutErebus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "WetState" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0145",
					Text = "You must reside somewhere in those terrible woods at the edge of your father's domain. So then you know the sensation of rainfall, the sound of distant thunder. That power now is yours." },
			},

			ZeusAboutSurfaceNoCure01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0070",
					
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Augh{#Prev}, what are you doing on the {#Emph}surface{#Prev}, young lady? How will you survive? Surely you know your line is bound beneath the earth. Your strength is better spent against our foes down {#Emph}there!" },
			},
			ZeusAboutSurfaceNoCure02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutSurfaceNoCure01", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0071",
					
					Text = "Your treks up here seem ill-advised, Melinoë. I trust you have some sort of plan, don't you? You and that Witch of the Crossroads can be quite difficult to read!" },
			},
			ZeusAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutSurfaceNoCure01", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0072",
					
					Text = "Something is different with you, Niece. You seem so very much alive... upon the surface here, no less! You cured your curse somehow? Impossible..." },
			},
			ZeusAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0073",
					
					Text = "I don't know how you circumvented the curse that bound you to the Underworld, young lady; but I {#Emph}do {#Prev}know this changes everything! You can help us defend this mountaintop! Help we could use, even {#Emph}I {#Prev}must admit..." },
			},
			ZeusAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0076",
					
					Text = "Observe the handiwork of Chronos all about you, there! The once-thriving city of Ephyra, laid to ruin; the Underworld's gates, flung open! Unconscionable acts, for which there must be dire consequences!" },
			},
			ZeusAboutSurface04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0092",
					Text = "It's all mixed up here on the surface, young lady. The very ground beneath your feet shifts constantly, due either to Poseidon's quakes, or to whatever Chronos has devised. You know which way to go, if not the precise path." },
			},
			ZeusAboutSurface05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ZeusAboutRouteChoice01" }, Count = 8 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0144",
					Text = "We have the matter on Olympus well in hand, young lady! I'd rather you stay focused on our common foe within your father's realm. Though you shall have my blessing either way!" },
			},

			ZeusAboutRouteChoice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ZeusAboutSurface05" }, Count = 8 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0171",	
					Text = "There is some difference of opinion here regarding where your efforts are of greatest benefit. We shall keep the matter on Olympus well in hand, but we cannot get to Chronos in your father's realm as easily as you!" },
			},

			ZeusAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0169",
					Text = "Chronos has quite the relentless fleet there in the Rift of Thessaly! Ships packed with bodies and supplies. Very clever of you, stowing away to disrupt the enemy lines!" },
			},

			ZeusAboutChronosClockwork01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0093",
					
					Text = "Within your father's realm are these odd ancient golden wheels, ceaselessly shifting the Underworld's chambers to and fro. The work of Chronos, it turns out! And he's managed to extend his foul influence to the surface as well..." },
			},
			ZeusAboutStorms01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0094",
					Text = "Even I can be temperamental; but I refrain from ravaging the surface with my storms, knowing that the mortals who have fallen in with Chronos have merely been deceived. Once all this is over, they shall come back to the light." },
			},

			ZeusAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0077",
					Text = "Now, where exactly are you, young lady? The outskirts of Poseidon's realm, it seems. You mean to circumnavigate your father's domain! Why confront the armies of Chronos head on, when you could go around. A clever move!" },
			},
			ZeusAboutOceanus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutOceanus01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0167",
					Text = "How unseemly that you need to trudge across the border in between my brothers' realms! Though if it's any consolation, those aquatic monstrosities you face are in for a real shock!" },
			},
			ZeusAboutTartarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0168",
					Text = "The deepest reaches of the Underworld have surely changed a lot; dismal in all-new ways! To think that Chronos made his stronghold down in Tartarus, where once we buried him..." },
			},

			ZeusUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0089",
					Text = "It's been a while, young lady! Word reached me that you've made significant advances as of late, and furthered our great cause. So I commend you, and of course, I give my blessing to you, too!" },
			},
			ZeusUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0148",
					Text = "How exactly you shall vanquish Chronos, someone shall have to explain to me at some point! Your witching-ways shall help you to prevail where we could not, {#Emph}hm? {#Prev}At least he hasn't yet imprisoned you along with your kin!" },
			},
			ZeusSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					-- @ update based on last boss chamber
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0090",
					Text = "What happened to you on your journey to our mountaintop, my niece? We lost contact with you somewhere on your way, just when it seemed you were so close. Well, don't despair, and don't relent, either!" },
			},

			ZeusPostGift01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift01", },
					},
					{
						Path = { "GameState", "UseRecord", "ZeusUpgrade" },
						Comparison = ">=",
						Value = 8,
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0056",
					Text = "I must admit, Melinoë... your commitment to this task of yours is greater than I had surmised. My offspring can be easily discouraged. I'm pleased to see my older brother's offspring isn't thus." },
			},
			ZeusPostGift02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift02" },
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0057",
					Text = "A pity that you're unattached, or so I hear. Your ceaseless training, living in a hidden grove... no {#Emph}wonder {#Prev}that there's no one special in your life! Fear not, though, you'll be fending off suitors left and right once word of you gets out!" },
			},

			-- legendary
			ZeusLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0054",
					Text = "Enough with the {#Emph}little {#Prev}jolts, I say, my niece! I'm in a giving mood, so all my thunderous might is yours to do with as you please! Well, not quite {#Emph}all {#Prev}of it, but more than enough, I'm sure!" },
			},
			ZeusLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0055",
					Text = "I grow weary of this interminable stalemate! Take now my strength, young lady, and crash through the enemy ranks like a bolt in the night!" },
			},

			-- about other gods
			ZeusAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0063",
					Text = "{#Emph}Ah{#Prev}, my lovely wife has graced you with her presence, Melinoë? She's very watchful, that one, so you're in good hands! Good, strong, and very watchful hands..." },
			},
			ZeusAboutHera02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHera01" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0064",
					Text = "I've weathered many hardships with my good and loyal Hera by my side! She is so tolerant, and wise, why, she's my rock! I always shall hold fast to her, as the great rock she is!" },
			},
			ZeusAboutHera03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHera02", },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0065",
					Text = "Now, Melinoë, once you've been married for as long as Hera and myself, you will have overcome your own innumerable challenges. Our marriage only grows stronger for each small transgression made along the way!" },
			},
			ZeusAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0059",
					Text = "The brightness of my fair son Apollo has illuminated you in the dark, if but for a moment, there, young lady! Would that all of my kin were equally as talented as he!" },
			},
			ZeusAboutApollo02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutApollo01", },
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
				{ Cue = "/VO/Zeus_0060",
					Text = "Shining Apollo has availed himself to you again, has he? Excels at just about anything he sets his mind and body to, that one! Though even he's been having a bit of trouble what with everything of late!" },
			},
			ZeusAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0061",
					Text = "You bear Brother Poseidon's watery blessing already, yes, young lady? Well, I'll be blunt: You're going to need more help than {#Emph}that{#Prev}, so here." },
			},
			ZeusAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0062",
					Text = "Upon my word, young lady! Such is your splendor that I near mistook you for beauteous Aphrodite herself. She has already visited with you, that much is clear. You goddesses, you wield your beauty like a blade!" },
			},
			ZeusAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0066",
					Text = "You've no idea what a feat it is having old Hestia invested in your task! She can be very disagreeable, and loath to participate in any shared activity of ours. But when it comes to {#Emph}you{#Prev}, she's positively fired up!" },
			},
			ZeusAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0067",
					Text = "In Lady Demeter, you've a fierce supporter, young lady! Already blessed you, sure enough. She's like the enduring winter, that one! But meeting her granddaughter thus has reminded her of fairer seasons, I think." },
			},
			ZeusAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0069",
					Text = "Hard-working Hephaestus offered you his services, has he? We need him clanking away at our armories {#Emph}here{#Prev}, though I suppose assisting you directly does advance our cause. No lack of interest in {#Emph}his {#Prev}handiwork of late!" },
			},
			ZeusAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					--[[ @purposely omitted
					{pur
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0068",
					Text = "You got here rather quickly, quite unlike that rascal Hermes, I should say. Lately he's never about when needed! Should he decide to make himself useful in all this, may he prove more dependable with you." },
			},
			ZeusAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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
				{ Cue = "/VO/Zeus_0058",
					Text = "You gleam as though with moonlight, there, young lady! Almost as if fairest Selene herself anointed you. Alas, that she must ride across the night, while you're left to your own devices on the ground." },
			},

			ZeusAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0043",
					Text = "You know, young lady, you remind me a bit of my ever-watchful daughter, Athena! She's had her hands full as of late, devising strategies to repel these incessant attacks. I look forward to you meeting at some point!" },
			},
			ZeusAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0044",
					Text = "Where is that flighty Artemis in this? My daughter could have been assisting you, but is instead cavorting with some Forest Nymphs, I think! Would that my children all were as responsible as you." },
			},
			ZeusAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutOlympians01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0095",
					Text = "You've yet to meet a certain son of mine, the notorious god of war? I would have expected Ares to be positively overjoyed by all that's been unfolding as of late! Such a time for him to disappear. He and I are overdue for a little chat." },
			},
			ZeusAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutOlympians01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0096",
					Text = "My peace-loving son Dionysus, he wants nothing to do with this situation we're in, can you believe the nerve? He genuinely believes {#Emph}wine {#Prev}is the solution to all of life's problems! {#Emph}Heh! {#Prev}He'll soon have naught to drink with such an attitude." },
			},
			ZeusAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceZeusBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0147",
					Text = "You're wise to bear my Cloud Bangle, my niece! How easily I spotted you with it, so that I may bestow my blessings when you need them most! Now choose, and smite our enemies as I would do myself if I were there!" },
			},

			ZeusAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0175",
					Text = "Such a dreadful night this is, the likes of which I haven't felt in quite some time! But you and that Witch of the Crossroads, you must revel in the stifling fear and darkness, don't you? Go then and terrify our foes!" },
			},
			ZeusAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0172",
					Text = "I can always sense when something is amiss, and on this night, strange forces are at work. Perhaps it was the Fates themselves ensuring you would find me thus!" },
			},

			-- repeatable lines
			ZeusChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0003",
					Text = "Even the sacred bond of family can be broken, young lady." },
			},
			ZeusChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0004",
					Text = "Remember there's no god of mercy on Olympus, Melinoë." },
			},
			ZeusChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0005",
					Text = "When all this is over, I'll make certain you're rewarded handsomely." },
			},
			ZeusChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0006",
					Text = "The time for amicable solutions to our predicament has long since past." },
			},
			ZeusChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0007",
					Text = "You keep your head held high, young lady, for we're {#Emph}gods! {#Prev}The lot of us!" },
			},
			ZeusChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0008",
					Text = "Together, we can rid this world of Chronos and his evil influence." },
			},
			ZeusChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0009",
					Text = "As gods, this world is ours by right. And we'll defend that right, won't we?" },
			},
			ZeusChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0010",
					Text = "Our enemies will soon be in for quite the shock, I think!" },
			},
			ZeusChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0011",
					Text = "We'll put an end to this little uprising sooner or later, {#Emph}hm?" },
			},
			ZeusChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0012",
					Text = "Your dedication to this family doesn't go unnoticed, young lady." },
			},
			ZeusChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0013",
					Text = "Contending with upstarts and fools is just a part of godhood, I'm afraid." },
			},
			ZeusChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0014",
					Text = "Olympus stands strong, and you'll help see to it we'll stay that way, won't you?" },
			},
			ZeusChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0015",
					Text = "We'll turn the tables yet, Melinoë! Go forth now with a token of my strength." },
			},
			ZeusChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0016",
					Text = "You witches have a natural spark in you, I know, but here! I've got another." },
			},
			ZeusChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0017",
					Text = "Do show our enemies a properly electrifying time for me, would you?" },
			},
			ZeusChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0018",
					Text = "Chronos can be outsmarted and outfought. We'll get him, Niece!" },
			},
			ZeusChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0019",
					Text = "Your father would be very proud, I'm sure. All of us are!" },
			},
			ZeusChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0020",
					Text = "We face a crafty adversary, yes; but we, too, have our ways, Melinoë..." },
			},
			ZeusChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0021",
					Text = "You'll help us tilt the balance in our favor, won't you, young lady?" },
			},
			ZeusChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0022",
					Text = "I trust we'll have all this unpleasantness behind us in no time, {#Emph}hm?" },
			},
			ZeusChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0023",
					Text = "We'll soon have Chronos wishing he remained in deepest Tartarus, where he belongs!" },
			},
			ZeusChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0024",
					Text = "Become as lightning, Niece, and strike our enemies before they know what hit them!" },
			},
			ZeusChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0025",
					Text = "We didn't come to rule this world by underestimating enemies, my niece." },
			},
			ZeusChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0026",
					Text = "I've pressing matters to attend to, so take care of things for me down there, would you?" },
			},
			ZeusChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0027",
					Text = "Always wonderful to see you, Melinoë! Even in times such as these..." },
			},
			ZeusChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0028",
					Text = "This storm of ours will rage on for as long as we see fit, won't it, my niece?" },
			},
			ZeusChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0029",
					Text = "Our family's had its downturns through the ages, though we always bounce back!" },
			},
			ZeusChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0030",
					Text = "That tingling sensation in the air, that's a sure sign that victory's at hand!" },
			},
			ZeusChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0031",
					Text = "I and the other members of the clan are behind you in your every step, young lady." },
			},
			ZeusChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0032",
					Text = "All those who stand against Olympus shall be summarily struck down." },
			},

		},

		BoughtTextLines =
		{
			ZeusBlindBox01 =
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
				{ Cue = "/VO/Zeus_0165",
					Text = "You must have sensed it was my blessing you'd receive, young lady! That energy, that {#Emph}electricity... {#Prev}why, I'm afraid there's just no hiding it!" },
			},
			ZeusBlindBox02 =
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
				{ Cue = "/VO/Zeus_0166",
					Text = "I do believe this was a veritable blessing in disguise! It could have just as soon been any other member of the clan... so you are very fortunate indeed!" },
			},

			ZeusLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusLootBought03" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0140",
					Text = "I trust this message finds you well! We must remain in close communication as best we can, even if it means employing the services of your Underworld's Boatman every so often." },
			},
			ZeusLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusLootBought03" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0141",
					Text = "Old Charon must have ample time to spare, now that he isn't busy sending souls to their eternal rest. Although I do suspect that we can keep him plenty busy in service to us here!" },
			},
			ZeusLootBought03 =
			{
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0142",
					Text = "How vain of Chronos to have pressed all of those golden coins in his own image! The promise of a new {#Emph}Golden Age{#Prev}, some mortals say, {#Emph}pah! {#Prev}That age has long since passed. And no amount of shiny metal shall bring it back." },
			},
			ZeusLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusLootBought03" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0143",
					Text = "{#Emph}Ah, haha! {#Prev}To think my blessing could be had for a mere bit of coin. Know that the Boatman brokered this particular exchange only for {#Emph}you! {#Prev}Our services have never been for sale." },
			},

		},

		RejectionTextLines =
		{
			ZeusRejection01 =
			{
				{ Cue = "/VO/Zeus_0128",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I am lord and commander of our efforts here! And the chain of command must be obeyed." },
			},
			ZeusRejection02 =
			{
				{ Cue = "/VO/Zeus_0130",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I do not freely dole my blessings out; when I offer them, I expect you to take them." },
			},
			ZeusRejection03 =
			{
				{ Cue = "/VO/Zeus_0131",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You can't please everybody all the time, but you needn't have displeased {#Emph}me {#Prev}so." },
			},
			ZeusRejection04 =
			{
				{ Cue = "/VO/Zeus_0132",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteAnger",
					Text = "My word! The standard for respect and decency seem far too low where you were raised." },
			},
			ZeusRejection05 =
			{
				{ Cue = "/VO/Zeus_0133",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "If {#Emph}you {#Prev}were openly refused, in {#Emph}my {#Prev}place you would certainly respond as I shall now." },
			},
			ZeusRejection06 =
			{
				{ Cue = "/VO/Zeus_0134",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "While I enjoy a clever jest as much as any god, this was in decidedly poor taste." },
			},
		},

		RejectionVoiceLines =
		{
			[1] = GlobalVoiceLines.GodRejectedVoiceLines,
		},

		MakeUpTextLines =
		{
			ZeusMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0129",
					Text = "My patience lately has its limits, young lady. I would advise you not keep testing them." },
			},
			ZeusMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0135",
					Text = "There is no limit to the wrath of Olympus. Best not invite it on yourself again." },
			},
			ZeusMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0136",
					Text = "Our might is best applied against our common foe. But do be mindful of your place next time." },
			},
			ZeusMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0137",
					Text = "Oh, enough of this! We must maintain decorum, even in such times as these." },
			},
			ZeusMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0138",
					Text = "You have weathered this storm, but do take heed not to get caught in it next time." },
			},
			ZeusMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0139",
					Text = "Such petty squabbling! My temper has decidedly been short as you can see." },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			ZeusGift01 =
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
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0954", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To mighty Uncle Zeus, vanquisher of Titans! Your strength has saved our family before. You are most kind to now share some of it with me." },
				{ Cue = "/VO/Zeus_0081",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "This hardly seems the time to make me offerings. All the more reason I appreciate the gesture, Niece! And per the custom of our family, I've prepared something for you, in turn!" },
			},
			ZeusGift02 =
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
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0955", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Zeus, king of Olympus, I am honored to be in your service! I vow to use your thunderous power for the greater good of our family." },
				{ Cue = "/VO/Zeus_0082",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Even in such a time, you pay proper respects to your lord uncle, my well-mannered niece. Know, in turn, you have my gratitude!" },
			},
			ZeusGift03 =
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
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0956", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Benevolent Lord Uncle Zeus, I have for you another offering, as meager as it is! May you soon have occasion to enjoy it peaceably." },
				{ Cue = "/VO/Zeus_0084",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I'm often showered in such offerings, you know. However, coming from one such as you, it means a lot more to me than the rest. My other children stand to learn from you!" },
			},
			ZeusGift04 =
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
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1763", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Uncle, a token of my appreciation! Though I knew of your generous spirit well before we finally met, I'd not expected you'd make time for me again and again like this." },
				{ Cue = "/VO/Zeus_0083",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Your brother once was similarly generous to me! I often wondered who could have taught him such deference. Old Hades didn't, that I knew!" },
			},

			-- placeholder
			ZeusGiftTemp =
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

			{ Cue = "/VO/Melinoe_1739", Text = "You are most generous, Lord Uncle." },
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
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			PreLineWait = 1.25,
			NoTarget = true,

			{ Cue = "/VO/Zeus_0121", Text = "That was entirely unwise." },
			{ Cue = "/VO/Zeus_0123", Text = "You need to be reminded of your place." },
			{ Cue = "/VO/Zeus_0124", Text = "Best not to anger me again.", PlayFirst = true },
		},

		RarityUpgradeVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			Cooldowns =
			{
				{ Name = "BoonRarifiedSpeech", Time = 60 },
			},

			{ Cue = "/VO/Zeus_0107", Text = "Very well." },
			{ Cue = "/VO/Zeus_0108", Text = "So be it!" },
			{ Cue = "/VO/Zeus_0120", Text = "This is yours." },
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			TriggerCooldowns = { "ZeusBoonTakenSpeech" },

			{ Cue = "/VO/Zeus_0104", Text = "Greetings to you!" },
			{ Cue = "/VO/Zeus_0105", Text = "I have arrived." },
			{ Cue = "/VO/Zeus_0106", Text = "We meet again!" },
			{ Cue = "/VO/Zeus_0119", Text = "I have something for you." },
		},

	},

}

OverwriteTableKeys( LootData, LootSetData.Zeus )