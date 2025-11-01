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
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		Weight = 10,
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
		EmoteOffsetY = -280,
		EmoteOffsetX = 30,
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

			-- Elemental
			"ElementalDamageFloorBoon",

			-- Legendary
			"SpawnKillBoon",

			-- Duos
			"SuperSacrificeBoonZeus",
			"LightningVulnerabilityBoon",
			"RootStrikeBoon",
			"ApolloSecondStageCastBoon",
			"SprintEchoBoon",
			"EchoBurnBoon",
			"ReboundingSparkBoon",
			"AutoRevengeBoon",
		},
		Consumables = { },

		SpeakerName = "Zeus",
		Speaker = "NPC_Zeus_01",
		LoadPackages = { "Zeus", },
		Portrait = "Portrait_Zeus_Default_01",
		WrathPortrait = "Portrait_Zeus_Default_01_Wrath",
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
			{
				PlayOnce = true,
				PlayOnceContext = "ZeusPostTrueEndingResponseSpeech",
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Always",
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ZeusPostTrueEnding01" },
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_5020", Text = "Lord Uncle, I have many questions, too..." },
			},
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},
		
		DuoPickupTextLines =
		{
			ZeusWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SuperSacrificeBoonZeus" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0097",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SuperSacrificeBoonZeus" },
					},
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "LightningVulnerabilityBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "LightningVulnerabilityBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ApolloSecondStageCastBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0099",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "RootStrikeBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0157",
					Text = "Our upstart enemies shall scatter to the Four Winds once we're through with them! Our challenge is to purge them while minimizing unspeakable devastation. And Lady Demeter {#Emph}could {#Prev}always make the Earth re-grow." },
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SprintEchoBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0159",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ReboundingSparkBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "EchoBurnBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0163",
					Text = "We're so accustomed to my sister-in-law Hestia being off on her own, why, we even stopped saving a seat in my palace! But she's here to stay this time, aren't you, Hes?" },
				{ Cue = "/VO/Hestia_0146",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Oh{#Prev}, why, dearest Zeus, perish the thought that I would ever leave again! You've given me such a warm welcome after all, having removed my blasted seat only to put it back. Though, let's not worry hot stuff here with all of that!" },
			},

			ZeusWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "AutoRevengeBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0198",
					Text = "My warlike son Ares is never one to shy from conflict, but you'd never know it from a chat with him, young lady! Go on, Ares, {#Emph}greet {#Prev}her! And do try to seem relatively normal, would you now?" },
				{ Cue = "/VO/Ares_0080",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "Come, Lord Father, what have we to hide? That which we perceive as normalcy may be far from the custom of the Underworld now. Let our kin see us for exactly who we are." },
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
					UseRoomContextArt = true,
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0050",
					
					Emote = "PortraitEmoteSurprise",
					Text = "Oh {#Emph}no{#Prev}, my niece, you're hurt! A hazard of your mission, I suppose, yet even still it breaks my heart to see. Have courage and fight on!" },
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},

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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
			ZeusUnderworldRunStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0196",
					Text = "You're going after Chronos again, aren't you? Probably for the best! Perhaps if you prevail against him there, then Typhon's efforts shall somehow be disrupted here..." },
			},
			ZeusRunStartPostSurfaceW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0336",
					Text = "Turned your attention to the Underworld, have you now? Well I suppose all your successes here ought carry you to further victory below. My dear Hera shall be very pleased!" },
			},
			ZeusRunStartPostUnderworldW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0337",
					Text = "As of last night, I understand there is one fewer possibility that the Titan of Time could have ever deposed us. And now you're turning to the possibility of {#Emph}Typhon{#Prev}, so it seems?" },
			},

			ZeusAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0040",
					
					Text = "Your father and I had our differences. But the brotherly bond we shared was very strong, indeed... stronger than either one of us! Let us prevail in this war to honor him." },
			},
			ZeusAboutHades02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0323",
					Text = "How it gladdens me knowing good Hades and Persephone now rest upon their rightful thrones once more! Your brother Zagreus, the goddess Nyx, and all the rest, they're also doing well? Such an ordeal you helped them to withstand..." },
			},
			ZeusAboutHades03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0324",
					Text = "The Titan Chronos caught us unawares because we'd grown accustomed to not hearing from your father for long stretches at a time. Well we shall have to remedy that now! Hades and I have much catching up to do, besides." },
			},
			ZeusAboutHades04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0325",
					Emote = "PortraitEmoteFiredUp",
					Text = "How seriously Hades takes his renovation projects, {#Emph}hah! {#Prev}Your father never was the jesting type but always made me laugh. For he is quite methodical, so I expect the restoration of the Underworld shall take him quite a bit of time!" },
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
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0038",
					
					Text = "You're fortunate that you inherited your mother's features, rather than your father's, young lady! {#Emph}Hah{#Prev}, poor old Hades, how the world weighed heavily on him. He was a good brother to me, and shall be suitably avenged!" },
			},
			ZeusAboutMelinoe02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift05" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0335",
					Text = "Just as committed as your father, aren't you, Niece? It seems this matter with the Titan Chronos is {#Emph}interminable{#Prev}, but we all shall have to move on at some point! You've done more than enough, and need not toil for the sake of it." },
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
					
					Text = "That reclusive Witch of the Crossroads must have been a most unwilling caretaker of yours, and kept you from your real family till now! At least Hecate taught you some survival skills, and had enough sense to finally acquaint us!" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHecate01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusAboutHecate01" }, Min = 2 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0042",
					
					Text = "Do tell that Witch of the Crossroads that I shall be expecting prompt reports from her as to the situation in the Underworld. Now certainly is not the time for selfishness!" },
			},

			ZeusAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0326",
					Text = "I had not realized that righteous Nemesis was in the Underworld with you! All the more reason those who dared oppose us fell, for Retribution has been on our side. She is as stunning as her mother Nyx." },
			},

			ZeusAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosNightmare01" }, Min = 2 },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
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
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0088",
					
					Text = "Melinoë, {#Emph}erm{#Prev}, something is afoot here on Olympus... rumblings, yet not even Poseidon knows the source. Well, whatever cowardly maneuver Chronos has in store, we're going to repel it! With your aid, perhaps." },
			},
			ZeusAboutSurfaceThreat02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0319",
					
					Text = "We could have scoured all our surface foes by now, but Chronos claims they're needed still; that you must face them as you previously did to draw out remnant possibilities of Typhon to destroy. As long as you are willing, Niece..." },
			},

			ZeusAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = {
							"HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0271",
					
					Text = "Word reached me you encountered strong-armed Heracles! He's the surliest fellow you'll ever meet; I suggest you leave him to his labors. We have not asked him for the {#Emph}world{#Prev}, only for his fair share if he seeks to lead a divine life." },
			},
			ZeusAboutHeracles02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						SumPrevRuns = 2,
						Path = { "TextLinesRecord" },
						TableValuesToCount = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
						Comparison = "<",
						Value = 0,
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = {
							"HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0331",
					Text = "We once attempted to keep my son Heracles on a short leash, but he broke free of it, for breaking {#Emph}is {#Prev}his specialty. Yet he is utterly committed to our family, that I know. He never once has failed to deliver what we asked!" },
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
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0079",
					
					Text = "That worthless Cyclops Polyphemus, turning his broad back against the gods! His kind once aided us against the Titans; yet he's of a newer generation, lacking {#Emph}loyalty{#Prev}, apparently! His actions {#Emph}cannot {#Prev}be excused." },
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
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "N_Boss01", "N_Boss02" },
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
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0170",
					Text = "You Underworld goddesses and gods all know each other, do you not? If you could please notify Nyx's pest of a daughter {#Emph}Eris {#Prev}that she has no permission to fly within our borders, we would be mightily obliged!" },
			},

			ZeusAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01", },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0186",
					Emote = "PortraitEmoteAnger",
					Text = "That traitorous Titan Prometheus leads the vanguard of our enemy's forces on Olympus. Apparently he didn't learn a {#Emph}thing {#Prev}from when we punished him for his past crimes! We shall have to think of {#Emph}new {#Prev}ways to make him come around..." },
			},
			ZeusAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutPrometheus01" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusAboutPrometheus03" }, Min = 3 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0187",
					Text = "You may have heard about the actions of Prometheus that earned him all my wrath. He {#Emph}stole {#Prev}from us! Denied us the glory of bestowing fire unto mortalkind on our own terms! He suffered as a consequence, but not nearly enough." },
			},
			ZeusAboutPrometheus03 =
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
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0333",
					Text = "I have been much inclined to put a stop to the rebellion of Prometheus, yet now I'm to believe he is facilitating your continued efforts to ensure that {#Emph}time flows freely forth? {#Prev}Well should you cease to trust in this, merely send word." },
			},

			ZeusAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0189",
					Text = "In all my rancor, I never thought Chronos {#Emph}completely {#Prev}mad. But what else could have driven him to use the Father of All Monsters as a weapon? Typhon heeds no master; the destruction of Olympus shall not sate his appetites!" },
			},
			ZeusAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
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
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0190",
					Text = "The monster Typhon is {#Emph}far {#Prev}from invincible, no matter how it seems. When first he dared attack Olympus long ago, I {#Emph}personally {#Prev}struck him down! But now, he does seem more resistant to my lightning than before..." },
			},
			ZeusAboutTyphon03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
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
				{ Cue = "/VO/Zeus_0191",
					Text = "Whenever you should bravely face Typhon again, I shall subdue him with my lightning bolt as soon as possible. But I cannot risk leaving my Palace here for long... I'm only able to at all when you distract him first!" },
			},
			ZeusAboutTyphonW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0192",
					Text = "I must admit, young lady, I had my doubts about you coming all this way to lend your aid! We ought be capable enough to drive back Typhon on our own! But our latest battle with him might have gone differently if not for you..." },
			},
			ZeusAboutTyphonW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutTyphon01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0193",
					Text = "Typhon is clambering back up toward our summit once again, in spite of how we dealt with him last night, thanks to your aid. He's {#Emph}clearly {#Prev}not the {#Emph}smartest {#Prev}one, although perhaps we'll teach him a valuable lesson soon enough!" },
			},
			ZeusAboutTyphonW03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0194",
					Text = "You are truly one of {#Emph}us{#Prev}, Melinoë! I saw how mightily you fought with my own eyes! Even in the face of Typhon's savagery. Your father surely would have been as proud as I." },
			},
			ZeusAboutTyphonW04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0320",
					Text = "Your latest victory means there's an even slimmer chance Typhon may haunt us, is that it? Perhaps these are the very possibilities Prometheus has always prattled on about. Well then, keep on eliminating undesirable outcomes one by one!" },
			},

			ZeusAboutTyphonL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusAboutTyphonW03", "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B", "ZagreusPastMeeting05" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 3,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0195",
					Text = "We should be able to contend with Typhon here, but cannot reach the Titan Chronos where he is. So why do you insist on heading {#Emph}this {#Prev}way? Focus on the Underworld and leave my realm to {#Emph}me." },
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
						HasAll = { "PoseidonFirstPickUp", "HestiaFirstPickUp", "DemeterFirstPickUp", "AphroditeFirstPickUp", "HephaestusFirstPickUp" },
					},
					{
						Path = { "GameState", "UseRecord" },
						HasNone = { "NPC_Athena_01", "NPC_Dionysus_01", "AresUpgrade" },
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
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0075",
					Text = "You've seen it now firsthand: Our great mountain is perpetually besieged, and we've not had a moment's peace of late. Yet this trial only makes us stronger as a family!" },
			},
			ZeusAboutOlympus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
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
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0188",
					Text = "It pains me that our mountain home remains in such an utterly unserviceable state, and that your arrival here was not met with a proper welcome! But mark my words, you shall witness Olympus in all its glory once this little matter is resolved!" },
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
						Path = { "GameState", "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0047",
					Text = "Some mortals are such fools to be enticed by the promise of a new Golden Age. {#Emph}When Chronos ruled, it was a time of peace{#Prev}, they claim! {#Emph}No war or strife! {#Prev}And no advancement or society, either. The path of progress isn't paved!" },
			},
			ZeusAboutMortals03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0322",
					Text = "Our mortal worshipers have suffered through difficult times before... but their faith in us shall be rewarded, just as soon as all of this is settled at long last. Loyalty is something we must never take for granted, Niece!" },
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
						SumPrevRuns = 3,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0146",
					Text = "I regret you've been swept up in some of our little disagreements here, young lady. We all wish to bestow our favor, and should not be fighting over who gets to go first! Yet our pride is not so {#Emph}delicate {#Prev}as it may seem, and we always stand together in the end!" },
			},
			ZeusAboutDevotionTests02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0318",
					Text = "Do pardon our continued bickering, Melinoë! I merely wish to offer that your efforts would be better spent dispelling remnants of the Father of All Monsters, rather than the possibility of Chronos in the Underworld, as good Queen Hera thinks. All families must squabble as we do!" },
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
					Text = "{#Emph}Augh{#Prev}, what are you doing on the {#Emph}surface{#Prev}, young lady? How shall you survive? Surely you know your line is bound beneath the earth! Your strength is better spent against our foes down {#Emph}there!" },
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
					
					Text = "Your treks up here seem ill-advised, Melinoë. I trust you have some sort of {#Emph}plan{#Prev}, don't you? You and that Witch of the Crossroads can be quite difficult to read!" },
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
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceFirstMeeting01", "ZeusAboutSurfaceNoCure01" },
					},
					{
						SumPrevRuns = 5,
						Path = { "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
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
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusAboutRouteChoice01" }, Min = 2 },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
					},
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Text = "Now, where exactly {#Emph}are {#Prev}you, young lady? The outskirts of Poseidon's realm, it seems. You mean to circumnavigate your father's domain! Why confront the armies of Chronos head-on when you could go around... a clever move!" },
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
					Text = "The deepest reaches of the Underworld have surely changed a lot; dismal, in all-new ways! To think that Chronos made his stronghold down in Tartarus, where once we buried him..." },
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
					Portrait = "Portrait_Zeus_Pleased_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
			ZeusUnderworldRunCleared03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "Q_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0197",
					Text = "Word has it that you somehow managed to thwart Chronos just last night? Although I remain somewhat skeptical, because his forces still press the attack, and Typhon shows no sign of slowing down. We have to put a stop to this..." },
			},
			ZeusUnderworldRunCleared04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
					{
						SumPrevRuns = 5,
						Path = { "TextLinesRecord", "TrueEnding01" },
						CountPathTrue = true,
						Comparison = "<",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0321",
					Text = "Father Chronos claims you eliminated yet another possibility that his past self could have achieved dominion on Olympus and below. You're to keep battling the Titan of Time as though he were {#Emph}still {#Prev}threatening us as before? Absurd..." },
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
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0090",
					Text = "What happened to you on your journey to our mountaintop, my niece? We lost contact with you somewhere on your way, just when it seemed you were so close. Well, don't despair, and don't relent, either!" },
			},

			ZeusPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0315",
					Text = "I know not what you did to Chronos, Niece, but he is no longer himself... practically groveling for mercy here! And asking for our aid to ensure time flows freely forth, or some such drivel. Is {#Emph}this {#Prev}why you plan to re-trace your steps...?" },
			},
			ZeusPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0316",
					Text = "Long have my brothers, foster sisters, and I warred against the Titan Chronos, and yet {#Emph}now {#Prev}we are to have a {#Emph}truce? {#Prev}I shall not trust in him anytime soon... you need but say the word, and we shall seal him away for good." },
			},
			ZeusPostTrueEnding03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusPalacePostTrueEnding01", "ChronosBossOutroPostTrueEnding01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusPalacePostTrueEnding01" }, Min = 2 },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0317",
					Text = "I noted that your father and I thought of something suitable for Chronos, for I do not want him {#Emph}here. {#Prev}He shall preside over the Isles of the Blessed, near to Elysium in {#Emph}your {#Prev}domain! An honorary post befitting one of his experience." },
			},
			ZeusAboutFuture01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusPalacePostTrueEnding01", "ZeusGift06" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0329",
					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },
					Text = "What shall you do, young lady, now that the momentous task you've undertaken is complete? We certainly have quite a mess left to clean up, but after that. Whatever you decide, may it bring satisfaction and success." },
			},
			ZeusPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0327",
					Emote = "PortraitEmoteFiredUp",
					Text = "The Three Fates, located at last, our messenger excitedly reports! I trust they shall resume safeguarding our dominion from here on... even if it means having to pull the strings a bit from time to time. A small price to be paid!" },
			},
			ZeusPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0328",
					Text = "We the Olympians, appointed by the Fates themselves to rule this world, are prophecized to just... {#Emph}back off {#Prev}a bit? Take more of a {#Emph}light touch! Huh. {#Prev}Then so we shall, no questioning those three. Although I doubt mortals shall like the change." },
			},
			ZeusPostEpilogue03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0330",
					Text = "Your grandfather has not yet given up entirely on his idea for another Golden Age. As he's behaving reasonably well, we have agreed to hear him out. The times are clearly changing, after all... let us ensure it's for the best." },
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
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift03" },
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0056",
					Portrait = "Portrait_Zeus_Pleased_01",
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
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift06" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0057",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
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
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0063",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "{#Emph}Ah{#Prev}, my lovely wife has graced you with her presence, Melinoë? She's very watchful, that one, so you're in good hands! Good, strong, and very {#Emph}watchful {#Prev}hands..." },
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
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0064",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "I've weathered many hardships with my good and loyal Hera by my side! She is so {#Emph}tolerant{#Prev}, and wise, why, she's my rock! I always shall hold fast to her, as the great rock she is!" },
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
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHera02" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0065",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "Now, Melinoë, once you've been married for as long as Hera and myself, you shall have overcome your own innumerable challenges. Our marriage only grows {#Emph}stronger {#Prev}for each small transgression made along the way!" },
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0059",
					Portrait = "Portrait_Zeus_Pleased_01",
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0060",
					Portrait = "Portrait_Zeus_Pleased_01",
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0062",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "Upon my word, young lady! Such is your splendor that I near mistook you for beauteous Aphrodite herself. She has already visited with you, that much is clear. You goddesses, you wield your beauty like a {#Emph}blade!" },
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0066",
					Portrait = "Portrait_Zeus_Pleased_01",
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0067",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "In Lady Demeter, you've a fierce supporter, young lady! Already blessed you, sure enough. She's like the enduring winter, {#Emph}that {#Prev}one! But meeting her granddaughter thus has reminded her of fairer seasons, I think." },
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0069",
					Portrait = "Portrait_Zeus_Pleased_01",
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0058",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						Path = { "GameState", "UseRecord", "NPC_Athena_01" },
						Comparison = "<=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0043",
					Portrait = "Portrait_Zeus_Pleased_01",
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
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Artemis_Field_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
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
						Path = { "GameState", "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "UseRecord", "ZeusAboutAres02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0095",
					Text = "You've yet to meet a certain son of mine, the notorious god of war? I would have expected Ares to be positively overjoyed by all that's been unfolding as of late! Such a time for him to disappear. He and I are overdue for a little {#Emph}chat." },
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
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Dionysus_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0096",
					Text = "My peace-loving son Dionysus, he wants nothing to do with this situation we're in, can you believe the {#Emph}nerve? {#Prev}He genuinely believes {#Emph}wine {#Prev}is the solution to all of life's problems! {#Emph}Heh! {#Prev}He'll soon have naught to drink with such an attitude." },
			},
			ZeusAboutDionysus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutDionysus01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusAboutDionysus01" }, Min = 3 },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Dionysus_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0334",
					Text = "Our newfound peace ought to have drawn wine-loving Dionysus out, yet still I've seen no sign of him at all... save that our stores of Nectar and Ambrosia remain perilously low! Perhaps it's best that all our feasting is on hold." },
			},

			ZeusAboutChaos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurfaceAppearance01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChaosAboutSurfaceAppearance01" }, Min = 3 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0272",
					Text = "Word reached me there are these ancient passageways that have begun appearing on our surface, which purportedly lead to the depths of Chaos. All the way from here? Your sorcery at work, I trust... or old alliances..." },
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
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "You're wise to bear my Cloud Bangle, my niece! How easily I spotted you with it, so that I may bestow my blessings when you need them most! Now {#Emph}choose{#Prev}, and smite our enemies as I would do myself if I were there!" },
			},
			ZeusAboutKeepsake02 =
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
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "ForceZeusBoonKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0274",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "Why, that Cloud Bangle I offered you is all charged up! For who can resist wielding the power of the heavens themselves? Of course most lack the opportunity; I do not freely give it out!" },
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
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0175",
					Text = "Such a dreadful night this is, the likes of which I haven't felt in quite some time! But you and that Witch of the Crossroads, you must revel in the stifling fear and darkness, don't you? Go then and terrify our foes!" },
			},
			ZeusAboutShrine02 =
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
						Value = 16,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0273",
					Text = "I must say, mortals must be positively terrified on such a night as blustering and dark as {#Emph}this! {#Prev}Either we gods are angry and unsettled, or perhaps merely our many foes." },
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
					Text = "I can always sense when something is amiss, and on this night, strange forces are at work. Perhaps it was the Fates themselves ensuring you would find me thus..." },
			},

			ZeusPackageBountyIntro01 =
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
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyZeus" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0173",
					Text = "You Underworld gods and your ancient ways... I know only that you've done {#Emph}something {#Prev}to shape the course of this evening, for I can {#Emph}feel {#Prev}it in the air. May it be to our benefit!" },
			},
			ZeusPackageBountyIntro02 =
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
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyZeus" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPackageBountyIntro01" },
					},
					--[[
					{
						PathFromArgs = true,
						Path = { "ActiveBountyClears" },
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0174",
					Text = "It feels as though we've met before upon a night exactly such as this... but then we've been battling Chronos for so long, our sense of time can be just as deceiving as our foe!" },
			},
			ZeusAboutRandomBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.LateStartPackagedBounties,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Zeus_0332",
					Text = "What is this bizarre path you're taking, Niece? We were barely able to locate you! Something seems to be amiss tonight, strange forces beyond even {#Emph}our {#Prev}control..." },
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
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Text = "Our enemies shall soon be in for quite the shock, I think!" },
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
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0018",
					Text = "Chronos can be outsmarted and outfought. We'll get him, Niece!" },
			},
			ZeusChat17 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0019",
					Text = "Your father would be very proud, I'm sure. All of us are!" },
			},
			ZeusChat18 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0020",
					Text = "We face a wrathful adversary, yes; but we, too, have our ways, Melinoë..." },
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
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift07" }
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
					Text = "This storm of ours shall rage on for as long as we see fit, won't it, my niece?" },
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
			ZeusChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0340",
					Text = "Even the faintest trace of the threat Chronos and Typhon posed shall not remain over our heads." },
			},
			ZeusChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0341",
					Text = "Do know that your continued service to Olympus is appreciated, Niece." },
			},
			ZeusChat33 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0342",
					Text = "If Typhon's remnant is to be your target, then perhaps I'll see you when the time has come to strike!" },
			},
			ZeusChat34 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0343",
					Text = "So long as the threat of Typhon weighs on us, we shall do something about it!" },
			},
			ZeusChat35 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0344",
					Text = "Go forth and see to it your Underworld remains squarely in your family's control!" },
			},
			ZeusChat36 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0345",
					Text = "Your father may be difficult to get a hold of, but I always can reach out to you!" },
			},
			ZeusChat37 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift07" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0346",
					Text = "The might of Olympus stands behind you in whatever you do next, Melinoë." },
			},
			ZeusChat38 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift06" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0347",
					Text = "For all the challenges our family faced, there's yet to be one that we have not overcome." },
			},
			ZeusChat39 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0348",
					Text = "A bit of threat prevention should ensure our family can rest easily wherever we reside." },
			},
			ZeusChat40 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift07" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0347",
					Text = "Would that my children all were as responsible as you." },
			},
			ZeusChat41 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0368",
					
					Text = "{#Emph}Ah{#Prev}, your journey begins anew again, young lady!" },
			},
			ZeusChat42 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0369",
					
					Text = "My command of the heavens is nothing compared to the strength of our family bond." },
			},
			ZeusChat43 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0370",
					
					Text = "I expected I might find you setting forth here on another of your escapades!" },
			},
			ZeusChat44 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0371",
					
					Text = "We have the matter on Olympus well in hand, young lady!" },
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
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
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
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0141",
					Text = "Old Charon must have ample time to spare, now that he isn't busy sending souls to their eternal rest. Although I do suspect that we can keep him plenty busy in service to us here!" },
			},
			ZeusLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZeusPostEpilogue03" }
					},
				},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0143",
					Text = "{#Emph}Ah, haha! {#Prev}To think my blessing could be had for a mere bit of coin. Know that the Boatman brokered this particular exchange only for {#Emph}you! {#Prev}Our services have never been for sale." },
			},
			ZeusLootBought05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ZeusUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0338",
					Emote = "PortraitEmoteFiredUp",
					Text = "How many more such blasted Chronos coins are there, my niece? According to your Grandfather, none shall be made henceforth, yet they are in abundance even still!" },
			},

		},

		RejectionTextLines =
		{
			ZeusRejection01 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "O" },
					},
				},
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
			ZeusRejection07 =
			{
				{ Cue = "/VO/Zeus_0252",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Text = "I am the King of Olympus! Is some obedience truly too much to expect?" },
			},
			ZeusRejection08 =
			{
				{ Cue = "/VO/Zeus_0253",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "You've a defiant streak in you, young lady! One you'd be wise to hold in check." },
			},
			ZeusRejection09 =
			{
				{ Cue = "/VO/Zeus_0254",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "If you undermine my authority, you shall suffer the consequences. Simple." },
			},
			ZeusRejection10 =
			{
				{ Cue = "/VO/Zeus_0255",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "The Witch of the Crossroads may have taught you how to fight, but where are your manners?" },
			},
			ZeusRejection11 =
			{
				{ Cue = "/VO/Zeus_0256",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "We are a family, that is true; but when the need arises, the final say is mine." },
			},
			ZeusRejection12 =
			{
				{ Cue = "/VO/Zeus_0257",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Do not test the limits of my patience; recently I have little to spare." },
			},
			ZeusRejection13 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HeraUpgrade" },
					},
				},
				{ Cue = "/VO/Zeus_0258",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Normally I would suggest you always take Queen Hera's side in everything. But not in this!" },
			},
			ZeusRejection14 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HeraUpgrade" },
					},
				},
				{ Cue = "/VO/Zeus_0259",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "My beloved Hera and I may occasionally disagree, but you stay out of it!" },
			},
			ZeusRejection15 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "PoseidonUpgrade" },
					},
				},
				{ Cue = "/VO/Zeus_0260",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "You'd take my brother's side over my own? Young lady, I thought you were {#Emph}sensible!" },
			},

		},

		RejectionVoiceLines =
		{
			{ GlobalVoiceLines = "GodRejectedVoiceLines" },
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
			ZeusMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0261",
					Text = "Such bickering is getting us nowhere! Let us direct our pent-up wrath toward our {#Emph}foes!" },
			},
			ZeusMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0262",
					Text = "Consider yourself reprimanded, Melinoë. Let us get back to the matter at hand!" },
			},
			ZeusMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0263",
					Text = "We mustn't fight amongst ourselves like this! Although at least we make it brief!" },
			},
			ZeusMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0264",
					Text = "My priority is always family, my niece! Even if it requires hard choices now and again." },
			},
			ZeusMakeUp11 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0265",
					Text = "I'd rather not prolong such an unnecessary feud, when we have real foes to face." },
			},
			ZeusMakeUp12 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Zeus_0266",
					Text = "Your father always had a certain dry sense of humor, as apparently do you." },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0954", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To mighty Uncle Zeus, vanquisher of Titans! Your strength has saved our family before. You are most kind to now share some of it with me." },
				{ Cue = "/VO/Zeus_0081",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "This hardly seems the time to make me offerings. All the more reason I appreciate the gesture, Niece! And per the custom of our family, I've prepared something for you, in turn!" },
			},
			ZeusGift02 =
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
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0955", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Zeus, king of Olympus, I am honored to be in your service! I vow to use your thunderous power for the greater good of our family." },
				{ Cue = "/VO/Zeus_0082",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0956", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Benevolent Lord Uncle Zeus, I have for you another offering, as meager as it is! May you soon have occasion to enjoy it peaceably." },
				{ Cue = "/VO/Zeus_0084",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Zeus_Pleased_01",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1763", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Uncle, a token of my appreciation! Though I knew of your generous spirit well before we finally met, I'd not expected you'd make time for me again and again like this." },
				{ Cue = "/VO/Zeus_0083",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "Your brother once was similarly generous to me! I often wondered who could have taught him such deference. Old {#Emph}Hades {#Prev}didn't, {#Emph}that {#Prev}I knew!" },
			},
			ZeusGift05 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3672", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "For all your steady leadership, I bid you please accept this offering, Lord Uncle Zeus. Once all this is ended, may you and Queen Hera reign in peace and prosperity forevermore." },
				{ Cue = "/VO/Zeus_0176",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "Respect for one's elders does not come automatically, I know only too well. Know that I do not take kind gestures such as yours for granted, and appreciate them a great deal. You have a generous spirit!" },
			},
			ZeusGift06 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3673", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "You have a wondrous family to protect, Lord Uncle Zeus, not to mention the heavens and the earth. Yet you always carry yourself with dignity and courage, despite the weight of your burdens! Thank you for never backing down." },
				{ Cue = "/VO/Zeus_0177",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "I've many sons and daughters; nieces and nephews, many more. And it's a pleasure to know each and every one. I try never to play favorites, but... between us, young lady? You're an exception." },
			},
			-- bond forged
			ZeusGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_ZeusGiftHint01",
				CompletedHintId = "Codex_BondForgedZeus",
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
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusGift06", "ZeusAboutFuture01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3825", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "A gift in honor of our victory, Lord Uncle! We could never have achieved this if not for your leadership and relentless conviction, and your lightning bolts! May this Ambrosia help bring us closer together in times of peace." },
				{ Cue = "/VO/Zeus_0314",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Zeus_01", Icon = "Keepsake_Zeus" },

					Portrait = "Portrait_Zeus_Pleased_01",
					Text = "Ambrosia such as this ought to flow in abundance on Olympus once again, and I trust soon enough it shall. To that eventual result, you have contributed far more than just this bottle, Niece. I and all of us are grateful beyond words." },
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
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "Q_Boss02" },
					},
				},

				{ Cue = "/VO/Chronos_1278", Text = "{#Emph}This {#Prev}shall come as a {#Emph}shock!" },
				{ Cue = "/VO/Chronos_1279", Text = "A {#Emph}storm {#Prev}is coming!" },
				{ Cue = "/VO/Chronos_1280", Text = "{#Emph}Oh look, I am a spoiled brat!" },
				{ Cue = "/VO/Chronos_1281", Text = "{#Emph}Hello I am your Uncle Zeus!", PlayFirst = true },
			},
			{
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_Boss02" },
					},
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "ZeusUpgrade" },
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
				
				{ Cue = "/VO/Zeus_0101", Text = "{#Emph}This {#Prev}shall come as a {#Emph}shock!" },
				{ Cue = "/VO/Zeus_0102", Text = "A {#Emph}storm {#Prev}is coming..." },
				{ Cue = "/VO/Zeus_0103", Text = "Behold my thunderbolts!" },
				{ Cue = "/VO/Zeus_0349", Text = "How about a little extra jolt?" },
				{ Cue = "/VO/Zeus_0350", Text = "Who dares oppose my niece?" },
				{ Cue = "/VO/Zeus_0351", Text = "My lightning bolt is yours!", PlayFirst = true },
				{ Cue = "/VO/Zeus_0246", Text = "Of course!" },
				{ Cue = "/VO/Zeus_0248", Text = "Begone from this mountain!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P", "Q" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0251", Text = "Out with you all!" },

			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "ZeusUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Zeus_0352", Text = "Young lady, I daresay!" },
				{ Cue = "/VO/Zeus_0353", Text = "Who do you take me for?" },
				{ Cue = "/VO/Zeus_0354", Text = "You test my generosity!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				ObjectTypes = { "NPC_Heracles_01", "Heracles" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Heracles_0544", Text = "Father...!" },
				{ Cue = "/VO/Heracles_0546", Text = "Lord Father..." },
				{ Cue = "/VO/Heracles_0545", Text = "Father, why...?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsAny = { "P_Boss01" },
						},
					},
				},
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				ObjectTypes = { "Chronos" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_Boss01" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Chronos_1253", Text = "My son's billowing strength?!" },
				{ Cue = "/VO/Chronos_1254", Text = "The mark of Zeus..." },
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

				{ Cue = "/VO/Zagreus_0352", Text = "Lord Uncle...?" },
				{ Cue = "/VO/Zagreus_0353", Text = "Lord Zeus...!" },
			},
		},

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			PreLineWait = 1.25,
			NoTarget = true,

			{ Cue = "/VO/Zeus_0267", Text = "I am head of this family, and expect a certain level of obedience." },
			{ Cue = "/VO/Zeus_0268", Text = "Whoever stands against {#Emph}me {#Prev}tends to fare far worse than you did here." },
			{ Cue = "/VO/Zeus_0269", Text = "To openly defy me is to force me to make an example out of you." },
			{ Cue = "/VO/Zeus_0270", Text = "When next we meet, I shall forget this slight against me; but {#Emph}you {#Prev}had better not.", PlayFirst = true },
			{ Cue = "/VO/Zeus_0121", Text = "That was entirely unwise." },
			{ Cue = "/VO/Zeus_0123", Text = "You need to be reminded of your place." },
			{ Cue = "/VO/Zeus_0124", Text = "Best not to anger me again." },
		},

		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.66,
				SuccessiveChanceToPlayAll = 0.66,
				Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = {
							"/VO/Zeus_0107",
							"/VO/Zeus_0108",
							"/VO/Zeus_0114",
							"/VO/Zeus_0116",
							"/VO/Zeus_0118",
							"/VO/Zeus_0120",
						},
					},
				},
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
				},

				{ Cue = "/VO/Zeus_0107", Text = "Very well." },
				{ Cue = "/VO/Zeus_0108", Text = "So be it!", PlayFirst = true },
				{ Cue = "/VO/Zeus_0120", Text = "This is yours." },
				{ Cue = "/VO/Zeus_0311", Text = "Indeed." },
				{ Cue = "/VO/Zeus_0313", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Zeus_0306", Text = "Be safe." },
			},
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			TriggerCooldowns = { "ZeusBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Zeus_0104", Text = "Greetings to you!" },
			{ Cue = "/VO/Zeus_0105", Text = "I have arrived." },
			{ Cue = "/VO/Zeus_0106", Text = "We meet again!" },
			{ Cue = "/VO/Zeus_0119", Text = "I have something for you." },
			{ Cue = "/VO/Zeus_0296", Text = "Greetings!" },
			{ Cue = "/VO/Zeus_0297", Text = "Young lady!" },
			{ Cue = "/VO/Zeus_0302", Text = "My niece!" },
		},


		SuperSacrificeVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			TriggerCooldowns = { "ZeusBoonTakenSpeech", "MelinoeBoonTakenSpeech" },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = {
						"/VO/Zeus_0107",
						"/VO/Zeus_0108",
						"/VO/Zeus_0114",
						"/VO/Zeus_0116",
						"/VO/Zeus_0118",
						"/VO/Zeus_0120",
					},
				},
			},

			{ Cue = "/VO/Zeus_0107", Text = "Very well." },
			{ Cue = "/VO/Zeus_0108", Text = "So be it!" },
			{ Cue = "/VO/Zeus_0114", Text = "{#Emph}Ah{#Prev}, splendid!" },
			{ Cue = "/VO/Zeus_0116", Text = "How thoughtful!" },
			{ Cue = "/VO/Zeus_0118", Text = "This pleases me." },
			{ Cue = "/VO/Zeus_0120", Text = "This is yours." },
		},

	},

}

OverwriteTableKeys( LootData, LootSetData.Zeus )