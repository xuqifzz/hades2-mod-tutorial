LootSetData.Hephaestus =
{
	-- Hephaestus
	HephaestusUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord" },
				HasAll = { "ZeusUpgrade" },
			},
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "ZeusFirstPickUp" },
			},
			{
				Path = { "PrevRun", "TextLinesRecord" },
				HasNone = { "ZeusFirstPickUp" },
			}
		},

		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = true,
		Weight = 10,

		BoonInfoIcon = "BoonSymbolHephaestusIcon",
		Icon = "BoonSymbolHephaestus",
		DoorIcon = "BoonDropHephaestusPreview",
		DoorUpgradedIcon = "BoonDropHephaestusUpgradedPreview",
		MenuTitle = "UpgradeChoiceMenu_Title_HephaestusUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_HephaestusUpgrade",
		LootRejectedText = "Player_GodDispleased_HephaestusUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_HephaestusUpgrade",

		SpawnSound = "/SFX/WeaponUpgradeHammerDrop",
		PortraitEnterSound = "/SFX/WeaponUpgradeHammerDrop",
		UpgradeSelectedSound = "/SFX/HammerBoonChoice",

		Color = { 255, 100, 0, 255 },
		LightingColor = {255, 120, 0, 255},
		LootColor = {255, 90, 0, 255},
		SubtitleColor = Color.HephaestusVoice,
		SpeakerName = "Hephaestus",

		Speaker = "NPC_Hephaestus_01",
		Portrait = "Portrait_Hephaestus_Default_01",
		OverlayAnim = "HephaestusOverlay",
		Gender = "Male",
		FlavorTextIds =
		{
			"HephaestusUpgrade_FlavorText01",
			"HephaestusUpgrade_FlavorText02",
			"HephaestusUpgrade_FlavorText03",
		},
	
		PriorityUpgrades = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusCastBoon", "HephaestusSprintBoon", "HephaestusManaBoon" },
		WeaponUpgrades =
		{
			"HephaestusWeaponBoon",
			"HephaestusSpecialBoon",
			"HephaestusCastBoon",
			"HephaestusSprintBoon",
			"HephaestusManaBoon",
		},
		Traits =
		{ 
			"ChargeCounterBoon",
			"AntiArmorBoon",
			"HeavyArmorBoon",
			"ArmorBoon",
			"EncounterStartDefenseBuffBoon",
			"ManaToHealthBoon",
			"MassiveKnockupBoon",

			-- Legendary
			"WeaponUpgradeBoon",

			-- Elemental
			"ElementalDamageBoon",

			-- Duos
			"EmptySlotDamageBoon",
			"ReboundingSparkBoon",
			"MassiveCastBoon",
			"ClearRootBoon",
			"MassiveAoEIncrease",
			"FirstHitHealBoon",
			"DoubleMassiveAttackBoon",
		},
		Consumables = { },

		UpgradeMenuOpenVoiceLines =
		{
			[1] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines,
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
			{ Cue = "/VO/Melinoe_0940", Text = "The blacksmith sigil..." },
		},

		DuoPickupTextLines =
		{
			HephaestusWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ReboundingSparkBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0119",
					Emote = "PortraitEmoteDepressed",
					Text = "Always grand whenever our Lord Zeus decides to drop by unannounced, and watch over my shoulder whilst I work my forge! Even likes to point where my hammer ought to strike. Well, Dad, where to next?" },
				{ Cue = "/VO/Zeus_0162",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Need I remind you, my good son, that this is not, in fact, {#Emph}your {#Prev}forge, but a facility that all of us may use? And I would use it now to benefit your distant cousin over there! {#Emph}Erm{#Prev}, show me how to use this thing again..." },
			},

			HephaestusWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "EmptySlotDamageBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0121",
					Text = "My Mum the Queen could not believe that you and I had been conversing lately, witchie. So I had to prove it to her here, you understand. Though seems she wants to be conversing in my stead..." },
				{ Cue = "/VO/Hera_0112",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "My son Hephaestus need only prove he can exude the {#Emph}confidence {#Prev}befitting a god, rather than whatever it is that he exudes instead. He's made himself useful at least, yes?" },
			},

			HephaestusWithPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MassiveCastBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0123",
					Text = "Proud family, this one! Uncle Poseidon here forgoes full armor on account that he's too quick and too thick-headed, {#Emph}erm... {#Prev}thick-{#Emph}skinned{#Prev}, I mean to say. Ain't that the case, Uncle?" },
				{ Cue = "/VO/Poseidon_0272",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Come, Nephew, you know how much I value your craft! Even if I'd not be caught {#Emph}dead {#Prev}wearing much of it myself! It's just, only a {#Emph}coward {#Prev}goes to battle clad in plating head-to-toe; a coward far more likely to withstand his wounds, but {#Emph}still!" },
			},

			HephaestusWithApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MassiveAoEIncrease",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0125",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Oi{#Prev}, witchie, was just chatting with {#Emph}Apollo {#Prev}how not all of us are gifted with good looks, and silver tongue, and all. Got to {#Emph}work {#Prev}at something to be good at it! Like he couldn't imagine!" },
				{ Cue = "/VO/Apollo_0102",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh, I can more than {#Emph}imagine{#Prev}, Brother. Part of being talented is making things look easy. Take you and blacksmithing! For me it's quite like {#Emph}that{#Prev}, but with a bunch of {#Emph}other {#Prev}things!" },
			},

			HephaestusWithDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ClearRootBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0127",
					Text = "Your grandnan and I, we don't usually get talking very much. But now we got something in common, witchie: {#Emph}you! {#Prev}I say you've got things well under control, but I... can't fool the likes of Lady Demeter!" },
				{ Cue = "/VO/Demeter_0108",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "Not one of us has {#Emph}got things well under control{#Prev}, Granddaughter. So pay what Hephaestus said no heed! Instead use our strength combined... and Fates willing, restore for us some sense of normalcy." },
			},

			HephaestusWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "FirstHitHealBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0129",
					Text = "No point in wallowing, witchie! Whatever's going on out there, you got to love what you do, simple as that. Though don't take it from {#Emph}me! {#Prev}Got the authority right here!" },
				{ Cue = "/VO/Aphrodite_0093",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Emote = "PortraitEmoteAffection",
					Text = "Why, thank you, dear! We each have so much love to give. And the beauty of it is, the more of it we give, the more we {#Emph}have! {#Prev}To think that such a {#Emph}precious {#Prev}thing can have a limitless supply!" },
			},

			HephaestusWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "DoubleMassiveAttackBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0133",
					Text = "The mortals, they like giving thanks to us, but what are {#Emph}we {#Prev}supposed to do, you know? Well, I just do the same. Give thanks to Lady Hestia, at least! For keeping my forge burning hot. She even visits me now and again!" },
				{ Cue = "/VO/Hestia_0158",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Text = "Well, that's because I {#Emph}like {#Prev}it here, my lad! In spite of all the clanging and whatnot, it's {#Emph}peaceful{#Prev}, more or less. And you're not such bad company to keep. Though, why don't we show your cousin what we can cobble up {#Emph}together?" },
			},

		},

		InteractTextLineSets =
		{
			HephaestusFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/Melinoe_0941", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.5, PowerWordPresentation = true, PowerWordWaitTime = 3.8 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					NarrativeContextArt = "DialogueBackground_Erebus",
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "What, is he going to fit me for a suit of armor? {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Hephaestus_0002",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Text = "They told me you needed a weapon or something? {#Emph}Bah! {#Prev}You already got one! Right lousy one, can spot that piss-poor workmanship from here. Though, {#Emph}erm{#Prev}... I could tune it up..." },
			},

			-- low health
			HephaestusLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0062",
					
					Emote = "PortraitEmoteSurprise",
					Text = "You look like you've been beaten like a chunk of ore! Just keep it together long enough to appreciate my handiwork." },
			},
			HephaestusLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0063",
					
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Eugh{#Prev}, you're in shambles there, witchie. Mayhap this'll be too little too late! Could've come in handy earlier." },
			},
			HephaestusLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0064",
					
					Emote = "PortraitEmoteDepressed",
					Text = "Well, you look plain awful right now, and that's coming from {#Emph}me! {#Prev}Though hey, you get a free weapon service with the, {#Emph}erm... {#Prev}unwelcome remark." },
			},
			HephaestusLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0065",
					
					Text = "So you took some hits along the way, so what? You're an extension of your weapon, witchie! And a decent one can take a lot of punishment." },
			},

			-- run starts
			HephaestusRunStart01 =
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

				{ Cue = "/VO/Hephaestus_0066",
					
					Text = "Had an opening come up in my schedule, so I figured why not get your gear back to better-than-new condition right from the start?" },
			},
			HephaestusRunStart02 =
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

				{ Cue = "/VO/Hephaestus_0067",
					
					Text = "Oi, wanted to catch you right on your way out! Got a special this evening: free tune-ups for secret silver weapons, if you got one there?" },
			},
			HephaestusRunStart03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift02" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0153",
					Text = "Fine evening to you, witchie! My work ain't quick, but sometimes {#Emph}I {#Prev}can be. And here I thought, why don't I join her from the get-go, {#Emph}eh? {#Prev}Can't hurt!" },
			},
			HephaestusRunStart04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift02" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0154",
					Emote = "PortraitEmoteFiredUp",
					Text = "Where do you think {#Emph}you're {#Prev}off to, {#Emph}eh? {#Prev}Best not head out against {#Emph}impossible {#Prev}odds whilst {#Emph}unprepared! {#Prev}So, here. Let's get you suited up right quick." },
			},
			HephaestusRunStartSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0155",
					Text = "Off to pay us all a visit then, or try? Reckon you're liable to get into a {#Emph}tussle {#Prev}or two on the way, but... I can offer a {#Emph}complete {#Prev}protection plan against that sort of thing!" },
			},

			-- story events
			HephaestusAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "HephaestusUpgrade" },
						Comparison = "<=",
						Value = 4,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0035",
					
					Text = "So, you're a witch or something, I'm to understand? Then what do you need {#Emph}me {#Prev}for? Mayhap that fancy magick of yours ain't all it's cracked up to be! {#Emph}My {#Prev}work, witchie, is reliable." },
			},

			HephaestusAboutForge01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0036",
					
					Text = "Dark times of late, witchie, but what can you do? Tell you what {#Emph}I {#Prev}can do: I can sit here sweating over my forge, clanging away at armaments and such. So blasted hot and loud in here, nobody dares disturb my work. Ain't bad!" },
			},
			HephaestusAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0037",
					
					Text = "Never knew your family, {#Emph}eh? {#Prev}Better off if you ask me. Though you... didn't ask me. Probably wouldn't even if you could, and I'm also keenly aware you're expecting my services not my opinions, so, {#Emph}erm{#Prev}... here." },
			},
			HephaestusAboutFamily02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0038",
					
					Text = "My mum and dad, they don't get on too good. But once in a long while, there's a spark between 'em, and they're like a proper king and queen again. The envy of all gods! Lately, though, they're mostly panicking." },
			},

			HephaestusAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0040",
					
					Text = "Nothing like a good honest fight to settle a family dispute, {#Emph}eh? {#Prev}Especially productive seeing as we can't even kill each other, as old Chronos hisself can attest. {#Emph}Ah well! {#Prev}Plenty of work for me!" },
			},
			HephaestusAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0041",
					
					Text = "Right clever of old man Chronos to recruit a bunch of bitter dead against us, isn't it? We got them killed in wars and such... reckon the payback's only fair. More chances for my handiwork to shine!" },
			},

			HephaestusAboutOlympians01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp", "DemeterFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0042",
					
					Text = "You've met most of the lot up here by now. So now you know how come I'm cooped up in this forge. The work needs doing, not to mention it's less tiring than being with the family all the time." },
			},

			HephaestusAboutSurfaceIntro01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01" },
						Comparison = "<=",
						Value = 6,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0137",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Oi! {#Prev}What are you doing on {#Emph}this {#Prev}side, you lose your way? Thought you had business in the Underworld, not here. Mayhap I'm just a bit out of the loop is all... you need this stuff or not?" },
			},
			HephaestusAboutSurfaceIntro02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01" },
						Comparison = "<=",
						Value = 10,
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "P_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0138",
					Text = "I heard the latest, witchie, that you're headed for our mountain tippy-top! Just don't expect warm welcomes when you get here, as we are a... a bit preoccupied right now?" },
			},

			HephaestusAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Opening01", "N_PreHub01", "N_PreBoss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0079",
					
					Emote = "PortraitEmoteSparkly",
					Text = "Welcome to the fine city of Ephyra, witchie! Most important thing to know is, whatever happens to you there, {#Emph}I {#Prev}cannot be held liable. I work weapons, not miracles..." },
			},
			HephaestusAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0139",
					Text = "Ain't you not supposed to be able to breathe up here or something? Well, what can you do but push on through, is what I say! Ain't always easy but we manage or we try." },
			},

			HephaestusAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "P_Intro" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0080",
					Text = "Oi, you made it all the way up to the mountain earlier? I'd give you a tour of the old forge next time, it's just... it's sealed up. Damn near impossible to find! Security's sake." },
			},

			HephaestusAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0083",
					
					Text = "Where'd you get off to, witchie? The Underworld's gutter from the looks of it, all cold and wet... piss-poor working conditions, that much is clear." },
			},

			HephaestusAboutFields01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0204",
					Text = "Supposedly you're passing through the Mourning Fields along your way down there? Glad {#Emph}I {#Prev}ain't never seen a place like that. Misery's like smoke, gets in your eyes and such... hard to shake off!" },
			},

			HephaestusAboutTartarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "PrevRun", "BiomesReached" },
						HasAny = { "I" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0203",
					
					Text = "Wonder what Chronos did to Tartarus? Was quite the architectural feat under your mum and dad! But the Titan hasn't got any taste. Probably turned everything to gold..." },
			},
			HephaestusAboutHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0140",
					Text = "While back, made your mum and dad bit of a housewarming gift, guess you could say. Scale model of Dad's palace here, for you Underworld lot to remember us by! That Chronos better not have scrapped the thing..." },
			},

			HephaestusAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0144",
					Text = "See all those Chronos ships trudging this way, witchie? Most of 'em already sunk before, however many times. They and their dead crews keep coming back to haunt us! Now that's some dedicated service, {#Emph}eh?" },
			},

			HephaestusAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					-- @ update with real requirements
					{
						PathTrue = { "GameState", "RoomCountCache", "O_Intro" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0089",
					Text = "Don't know what's been with all the rumbling of late, but it ain't Poseidon, and it ain't my forge. Probably something bad! But, I ain't sweating it till I know what it is." },
			},

			HephaestusAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0084",
					Text = "There's talk up here that Chronos made off with the Fates or something like that? Well... those three have messed with all our lives so much, suppose it's only fair, ain't it?" },
			},

			-- about weapons
			HephaestusAboutWeapons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0050",
					Text = "{#Emph}Oi{#Prev}, I take back {#Emph}everything {#Prev}I said about your weapon first we met. In my defense, ain't often I see workmanship superior to mine! Though, don't go telling anyone I said as much..." },
			},
			HephaestusAboutWeapons02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0051",
					Text = "Wracked my brain about those fancy silver weapons of yours, trying to sort out who exactly could have made such things... or when? They're the Nocturnal Arms, ain't they? Meant only as a last resort! But here we are, I reckon." },
			},

			HephaestusAboutSilver01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift02" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0151",
					Text = "{#Emph}Say{#Prev}, where'd you get that silver armor you've got on? Much finer work than first I thought. Not too much coverage, mind, but you seem more the sort that likes to freely move about. Always a trade-off to be made!" },
			},

			HephaestusAboutStaff01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons02", },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0052",
					
					Text = "So that's the Staff of Dusk, is it? Descura, that's her name! Forged who-only-knows-how-deep within the Earth under the watchful eye of Night... something like that." },
			},
			HephaestusAboutDagger01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons02", },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0053",
					
					Text = "You got the Sister Blades of Lim and Oros, huh? Delicate-looking but damn near indestructible. Light as a feather, too. This is going to be a treat!" },
			},
			HephaestusAboutTorch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons02", },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0057",
					
					Emote = "PortraitEmoteSurprise",
					Text = "Hold on, that's Ygnium you've got! The Flames of the Crossroads Witch! What, has the student become the master or somesuch, or is she just getting you to do all the dirty work?" },
			},
			HephaestusAboutAxe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons02", },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0054",
					
					Text = "Oi, that is Zorephet the Moonstone Axe, all right! Though not expected ever to lay eyes on it. Some mortals worship the labrys, you know? Here! Let's give 'em something to believe in." },
			},
			HephaestusAboutAxe02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutAxe01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0055",
					
					Text = "Never got why some mortals prefer axes with a single blade. Why settle for one? Twice the blades, twice the benefits, I say! No downside. In fact, I've been developing a {#Emph}triple{#Prev}-bladed axe! Still needs a bit of time to bake, but, {#Emph}erm{#Prev}, anyway..." },
			},
			HephaestusAboutLob01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons02", },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0056",
					
					Text = "All right, that's called Revaal, I think, that skull you got? Ain't exactly my mental picture of a weapon, liable to give me night terrors in fact, but... then I'll be the first to say, {#Emph}whatever works!" },
			},
			HephaestusAboutAspects01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutWeapons02" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllWeaponAspects,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0091",
					
					Text = "Now hold on, that another weapon you got...? {#Emph}Ahh, right{#Prev}, the Nocturnal Arms and their shape-shifting tricks. Figures! You witches {#Emph}like {#Prev}changing things about, as I'm to understand." },
			},

			-- legendary
			HephaestusLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0068",
					
					Text = "...You wouldn't know it, witchie, but I'm mad this evening. Nothing you did, mind! Fortunately, when I'm mad, I do good work. My {#Emph}best {#Prev}damn work if I say so myself..." },
			},
			HephaestusLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0069",
					
					Text = "Can't guarantee a weapon worthy of the gods is going to be enough for you to see this through. But I {#Emph}can {#Prev}guarantee you're getting the very best." },
			},

			-- about characters
			HephaestusAboutHeraRelationship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "HephaestusAboutHera01", "HephaestusGift03" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0039",
					
					Text = "Got off on the wrong foot from the first, me and my mum. Can you blame her? Imagine seeing splendorous Apollo and Athena and so on, thinking, {#Emph}oi, I want to make me one of those! {#Prev}But instead, {#Emph}heheheh{#Prev}, you make me." },
			},

			HephaestusAboutAphroditeRelationship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "AphroditeUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift01", },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HephaestusAboutAphroditeRelationship02", "HephaestusAboutAphroditeRelationship03" }, Count = 5 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0044",
					
					Text = "{#Emph}Whew{#Prev}, Aphrodite, she's a real force of nature, isn't she? And just about the only thing gets me to leave the forge! Not that she minds me working all the time. We've always had an understanding, I reckon!" },
			},
			HephaestusAboutAphroditeRelationship02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "AphroditeUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift01", },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HephaestusAboutAphroditeRelationship01", "HephaestusAboutAphroditeRelationship03" }, Count = 5 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0045",
					Emote = "PortraitEmoteSparkly",
					Text = "Oi Aphrodite seems to like {#Emph}you {#Prev}quite a bit! Likes just about everybody, granted, but with you it's different. She'd never fess to it though I reckon she gets a bit lonely here, you know? Lots of acquaintances, not many friends." },
			},
			HephaestusAboutAphroditeRelationship03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll ={ "HephaestusAboutAphroditeRelationship01", "HephaestusGift03", "AphroditeGift03" },
					},
					{
						Path = { "GameState", "UseRecord", "AphroditeUpgrade" },
						Comparison = ">=",
						Value = 12,
					},
					{
						Path = { "GameState", "UseRecord", "HephaestusUpgrade" },
						Comparison = ">=",
						Value = 12,
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HephaestusAboutAphroditeRelationship01", "HephaestusAboutAphroditeRelationship02" }, Count = 5 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0136",
					Text = "{#Emph}Erm{#Prev}, wanted to say cheers for keeping Aphrodite company, being a decent listener and all. Me? I find talk more tiresome sometimes than this here forge... but not with her. Anyway! Small thing, big help." },
			},

			HephaestusAboutParents01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0143",
					Text = "No telling how many cousins I got, but you're another, {#Emph}eh? {#Prev}You're getting special treatment only 'cause my mum and dad, they asked me real nice. Don't mind the extra work!" },
			},

			HephaestusAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0043",
					
					Text = "{#Emph}Erm{#Prev}, not met your dad, but... heard plenty about him. Shame, might've gotten on better with him than the rest. Likes his metals and gemstones and such as I'm to understand, so... we'd have that at least." },
			},

			HephaestusAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0046",
					
					Text = "Been living under the auspices of the old Witch of the Crossroads, {#Emph}huh? {#Prev}Not met her face to face. Keeps to herself, so I scarce believed it when Apollo said that she'd reached out with something important. Turns out, it was {#Emph}you!" },
			},

			HephaestusAboutIcarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Icarus_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0192",
					Text = "You seen that Icarus flying about? At first I took him for some giant ghostly bird, but... it's the kid of Daedalus all right! Reckon he made his latest wings hisself. He's not too bad!" },
			},

			HephaestusAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0047",
					
					Text = "While back, your brother came to us for help, what's his name... {#Emph}Zagreus? {#Prev}I wasn't having it. This family's problems would disappear overnight if we could just stop getting in each other's business! Felt bad sitting it out, though..." },
			},

			HephaestusAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0090",
					
					Text = "Ran into no-eyed Polyphemus, so I hear? Mean bastard, big, all meat and muscle. Could've used {#Emph}that {#Prev}one at the old forge. Ah well! Hope he doesn't try to chew you up or nothing!" },
			},

			HephaestusAboutErisBossW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Eris" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0149",
					Text = "Heard Eris got her poor wings plucked, witchie! Next make her hand over her Rail of Adamant, would you? Shoots faster than any bow I've seen! Demands a closer look...!" },
			},

			HephaestusAboutPandora01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0207",
					Text = "Used to be this lass Pandora who, through right mean circumstances, ended up accidentally cursing mortalkind forever more. Long story, long ago... though I still think about it now and again. Mayhap she cursed us, too..." },
			},

			-- about other gods
			HephaestusAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0072",
					
					Text = "Reckon my dad'll be of help in all this! Lord Zeus, he loves to help! Especially hisself... lot on the line right now, and you don't get to be the king of Olympus being coy." },
			},
			HephaestusAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0073",
					
					Text = "{#Emph}Ahh{#Prev}, Uncle Poseidon's been of some assistance, then? {#Emph}Heh! {#Prev}Reckon it's more welcome than him stomping uninvited in my forge, all sopping wet, filling the place with steam. {#Emph}Psh. {#Prev}What a kidder!" },
			},
			HephaestusAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					--[[ @purposely omitted
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0075",
					Text = "So Mum gave you her blessing, just like {#Emph}that? {#Prev}Hard won's the favor of Queen Hera. Whilst mine... reckon it's a bit easier to come by..." },
			},
			HephaestusAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0071",
					Text = "Fresh-faced Apollo got to you before me, {#Emph}eh? {#Prev}Well ain't that a surprise. He can help boost your spirit, {#Emph}I {#Prev}can boost your weapon. Tough choice om?" },
			},
			HephaestusAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "HephaestusUpgrade" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "UseRecord", "AphroditeUpgrade" },
						Comparison = ">=",
						Value = 5,
					},
					--[[ @purposely omitted
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0074",
					
					Text = "Got to say, when we first met, I was uncertain what to make of you. Don't always trust you witchy types is all. But, if you're worthy of Aphrodite's blessing, you get the package deal." },
			},
			HephaestusAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0076",
					
					Text = "When old Hestia said she liked you, 'twas all I needed to hear. The forge would be no good if not for her! She sparks the flame, I bend the metal, and {#Emph}you {#Prev}get the benefits." },
			},
			HephaestusAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0077",
					
					Text = "I keep forgetting that you're Demeter's grand-kid! Can't stand being around her myself. Nothing personal, mind, I just can't get anything done when it's so blasted cold." },
			},
			HephaestusAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0078",
					
					Text = "Haven't the faintest what Hermes is up to. Where is he? Best make hisself useful, else I'm taking back the sandals {#Emph}and {#Prev}the hat! And then we'll see how blasted quick he is!" },
			},

			HephaestusAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0205",
					Text = "Normally, it'd be ever-wise {#Emph}Athena {#Prev}who'd be first to greet you and make nice, but... she's been busy putting all my arms and armor to the test. {#Emph}Good news {#Prev}is the {#Emph}testing's {#Prev}going well!" },
			},
			HephaestusAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0193",
					Text = "They come to me sometimes and ask, {#Emph}where's Ares? {#Prev}Like I'm supposed to know just 'cause we got a brotherly connection? It's bloody {#Emph}war! {#Prev}Must be he's out there having a great time!" },
			},
			HephaestusAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0194",
					Text = "You've not seen Dionysus, right? Probably just getting sloshed somewhere is all. Don't like when everybody's fighting... can you blame him?" },
			},

			HephaestusAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
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

				{ Cue = "/VO/Hephaestus_0070",
					
					Text = "Don't know if it's your silver gear or what, but for a bit there I thought I was staring at the Moon... don't much get to see the Moon in my line of work." },
			},
			HephaestusAboutDaedalus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "WeaponUpgrade" }
					},
					--[[ @purposely omitted
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0060",
					
					Text = "Like to think I can spot the handiwork of Daedalus, best mortal craftsman ever lived; and I {#Emph}have {#Prev}spotted it! Still keeping busy nowadays, is he? I'm sure even his work leaves bits of room for improvement here and there." },
			},
			HephaestusAboutDaedalus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "WeaponUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutDaedalus01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HephaestusAboutDaedalus02" }, Count = 3 },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0061",
					
					Text = "{#Emph}Ohh{#Prev}, this is going to be a real piece of work, since Daedalus already left his mark! I'd bless that dead old busybody bastard if I could, but I can never pin him down." },
			},

			-- other reactions
			HephaestusAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceHephaestusBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0135",
					Emote = "PortraitEmoteFiredUp",
					Text = "See you still got that Adamant Shard I sent over before! Just a bit of scrap, really, but... it's a shiny one, and has some decent heft. And I can use it to pinpoint you {#Emph}quick!" },
			},

			HephaestusAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Hub" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0048",
					
					Text = "Those mortals, they sure got it rough of late. Sometimes I think there's just so blasted many of them now. More suffering and such! {#Emph}Eh{#Prev}, reckon that's life! Don't get any say in being born, then do what we can." },
			},
			HephaestusAboutMortals02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutMortals01", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0049",
					
					Text = "Oi what I said before, 'bout more mortals begetting more suffering and the like? Aphrodite, she reminded me there's more to it than that. And maybe she's right. It's just, I reckon the bad in things is easier to spot..." },
			},

			HephaestusAboutVolcanoes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0150",
					Text = "Feel any tremors, they are probably Uncle Poseidon shaking up the place. Though there {#Emph}are {#Prev}times it's me! When Earth herself gets angry with the state of things, I give 'er a good outlet to let off a little steam." },
			},

			HephaestusAboutPractice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0145",
					Emote = "PortraitEmoteFiredUp",
					Text = "This lot up here act like they all was born with all the talent in the world! Mayhap Apollo and Athena, sure, and Artemis, and Hermes... Aphrodite definitely, too, but, {#Emph}erm... point is! {#Prev}Most of us, we got to {#Emph}work {#Prev}at things before {#Emph}we're {#Prev}any good." },
			},

			HephaestusAboutLegs01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0146",
					Text = "Must like to run about don't you? Me, at this point I would rather sit. And so I do! Won't find a better set of legs than this anyplace besides on Aphrodite herself! Yet even still." },
			},

			HephaestusAboutBackstory01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0147",
					Text = "Must think I got it all up here, don't you? Well you'd be right! But let's just say you're not the only one who had to learn things the hard way, witchie. I needed to do what I do." },
			},

			HephaestusAboutAutomatons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0081",
					
					Text = "All this warring, bit concerned I'll end up typecast as a weaponsmith! I make a lot of things, you know! Jewelry, fancy chairs, walking automatons even! Though lately, it's all weapons, all the time..." },
			},

			HephaestusUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0092",
					Text = "{#Emph}Ohh, there {#Prev}you are! We'd lost you for a bit! Must have gone so deep, we couldn't spy on you no more. Well, you've still got your arms and legs! Must have turned out all right." },
			},
			HephaestusUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "HephaestusUpgrade" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0148",
					Emote = "PortraitEmoteFiredUp",
					Text = "Am I to understand you gave a certain {#Emph}Titan {#Prev}a right thorough walloping of late? Mayhap I helped in my own way? Not like you took down Chronos with your bare hands, {#Emph}eh? {#Prev}Point is, {#Emph}good job{#Prev}, witchie! " },
			},

			-- repeatable lines
			HephaestusChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0003",
					
					Text = "Don't sweat it, you'll be as good as new here in a bit." },
			},
			HephaestusChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0004",
					
					Text = "Oi witchie, let me see about that hunk of metal you got there." },
			},
			HephaestusChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0005",
					
					Text = "You still alive, witchie? Here, this ought to keep it that way." },
			},
			HephaestusChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0006",
					
					Text = "Just clanking away as always, though let's do some clanking now on your behalf." },
			},
			HephaestusChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0007",
					
					Text = "Reckon you're looking for another tune-up, no problem at all." },
			},
			HephaestusChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0008",
					
					Text = "No charge per usual, I'll just throw it on tab and some point Dad'll pick it up." },
			},
			HephaestusChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0009",
					
					Text = "So you got a bit of metal I could effortlessly bend to my will or something?" },
			},
			HephaestusChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0010",
					
					Text = "I just had the strongest urge to bang on solid metal for a bit." },
			},
			HephaestusChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0011",
					
					Text = "Oi, you're about due for another servicing appointment on that thing." },
			},
			HephaestusChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0012",
					
					Text = "You got a dangerous line of work, witchie. Though I can get you some protection here." },
			},
			HephaestusChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0013",
					
					Text = "How's it going and the like, all good? All good, that's great, now here." },
			},
			HephaestusChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0014",
					
					Text = "{#Emph}Eugh{#Prev}, it's been an awful lot of late! Don't sweat it, though. Always got room for you." },
			},
			HephaestusChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0015",
					
					Text = "{#Emph}Ehh{#Prev}, think I got just the thing to help you with the killing-and-not-dying here, witchie." },
			},
			HephaestusChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "WeaponDagger", "WeaponAxe", "WeaponLob" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0016",
					
					Text = "You know, the more I work those weapons, the more intricacies I can find..." },
			},
			HephaestusChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0017",
					
					Text = "I don't normally just give away my services, but it ain't normally of late." },
			},
			HephaestusChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0018",
					
					Text = "Say, what's that you got there, witchie, a nice weapon of some sort?" },
			},
			HephaestusChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0019",
					
					Text = "{#Emph}Ehh{#Prev}, fancy meeting you again and all, now let me get to work." },
			},
			HephaestusChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0020",
					
					Text = "I always said a bit of evening work is good for you, witchie." },
			},
			HephaestusChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0021",
					
					Text = "Only so much I can do when you're out and about with that walking stick, you know." },
			},
			HephaestusChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0022",
					
					Text = "{#Emph}Ehh{#Prev}, it's that staff again... well, mayhap I can do something about the knots at least." },
			},
			HephaestusChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0023",
					
					Text = "Fine couple of knives you got there, witchie. Though let's make 'em proper vicious here." },
			},
			HephaestusChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0024",
					
					Text = "Hold up those flashy blades of yours for me and I'll have 'em sharper than ever." },
			},
			HephaestusChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0025",
					
					Text = "{#Emph}Ahh{#Prev}, brought my favorite out to play, did you? Just needs a tune-up and you'll be all set." },
			},
			HephaestusChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0026",
					
					Text = "Who needs witchery when you can go on brandishing an axe like that?" },
			},
			HephaestusChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0027",
					
					Text = "Bringing a couple flaming sticks to a fight? Well, whatever works, witchie." },
			},
			HephaestusChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0028",
					
					Text = "{#Emph}Ehh{#Prev}, turns out torches ain't just for lighting your way! Let's see 'em here." },
			},
			HephaestusChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0029",
					
					Text = "All sorts of silver I can work with in that skull of yours, so put 'er up!" },
			},
			HephaestusChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0030",
					
					Text = "{#Emph}Ohh{#Prev}, right sinister choice of weapon you got there, witchie." },
			},
			HephaestusChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponStaffSwing", "WeaponAxe" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hephaestus_0032",
					
					Text = "Soon as I'm through, you go knock some sense into some wretches for me, would you?" },
			},

		},

		BoughtTextLines =
		{
			HephaestusBlindBox01 =
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
				{ Cue = "/VO/Hephaestus_0095",
					Text = "Nobody wants you playing favorites, witchie, so we've got this method of delivering you unmarked Boons where you'll just have to take what you can get. {#Emph}Surprise!" },
			},
			HephaestusBlindBox02 =
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
				{ Cue = "/VO/Hephaestus_0200",
					Text = "Mayhap expecting someone else? Or just as likely not expecting anybody in particular, 'cause a blessing is a blessing, ain't that right?" },
			},

			HephaestusLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0093",
					Text = "That Gold you used to pay for this... {#Emph}hoh{#Prev}, it's shiny-looking, sure. But blasted soft as metal goes! Cannot make halfway decent armaments with it, I've tried!" },
			},
			HephaestusLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0094",
					Text = "Your Boatman over there? He's one of my best customers, you know! Shows up reliably, knows how to keep his mouth shut, all business, no nonsense." },
			},
			HephaestusLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0197",
					Emote = "PortraitEmoteFiredUp",
					Text = "Normally my work fetches a hefty price, but... you're entitled to the family discount! Though Charon there does take a service fee, you understand." },
			},
			HephaestusLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0198",
					Emote = "PortraitEmoteFiredUp",
					Text = "Keep getting shipments of those golden Chronos coins! I melt 'em down, and dump the goop into the Earth from whence it came. So Chronos can make more!" },
			},
			HephaestusLootBought05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0199",
					Emote = "PortraitEmoteFiredUp",
					Text = "Having to pay for blessings strikes me as a bit {#Emph}crass! {#Prev}The favor of the gods only for the deepest pockets? {#Emph}Oi! {#Prev}You don't even {#Emph}have {#Prev}pockets." },
			},

		},

		RejectionTextLines =
		{
			HephaestusRejection01 =
			{
				{ Cue = "/VO/Hephaestus_0096",
					Emote = "PortraitEmoteFiredUp",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Whoever messes with me, they get pounded flat. No exceptions! Not even for {#Emph}you." },
			},
			HephaestusRejection02 =
			{
				{ Cue = "/VO/Hephaestus_0097",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I don't stick up for myself, I'll never hear the end of it. So best ready for the sparks to fly a bit." },
			},
			HephaestusRejection03 =
			{
				{ Cue = "/VO/Hephaestus_0098",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "{#Emph}Eh{#Prev}, much rather keep on hammering this metal over here, but... I can switch over to {#Emph}you {#Prev}instead." },
			},
			HephaestusRejection04 =
			{
				{ Cue = "/VO/Hephaestus_0099",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Push me around, I'm liable to push right back. And I push harder than you might expect..." },
			},
			HephaestusRejection05 =
			{
				{ Cue = "/VO/Hephaestus_0100",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Not going to blow my top... but neither will I take this lying down. Family requirements!" },
			},
			HephaestusRejection06 =
			{
				{ Cue = "/VO/Hephaestus_0101",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You brought this on yourself, witchie! And by {#Emph}this{#Prev}, I mean my favorite hammer here." },
			},
			HephaestusRejection07 =
			{
				{ Cue = "/VO/Hephaestus_0102",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "{#Emph}Eh{#Prev}, don't care for having to retaliate like this, but... it's all part of the deal, you understand." },
			},
			HephaestusRejection08 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "AphroditeUpgrade" },
					},
				},
				{ Cue = "/VO/Hephaestus_0103",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "No denying Aphrodite was the fairer choice, but still! Can't let this go unchecked." },
			},
			HephaestusRejection09 =
			{
				PlayFirst = true,
				{ Cue = "/VO/Hephaestus_0104",
					Emote = "PortraitEmoteFiredUp",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You want to see my handiwork, then {#Emph}fine! {#Prev}Might get a wee bit noisy, though." },
			},
			HephaestusRejection10 =
			{
				PlayFirst = true,
				{ Cue = "/VO/Hephaestus_0105",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Next I offer you protection, witchie? You'd be wise to take me up on it." },
			},


		},
		
		RejectionVoiceLines =
		{
			[1] = GlobalVoiceLines.GodRejectedVoiceLines,
		},

		MakeUpTextLines =
		{
			HephaestusMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0109",
					Text = "All right, we're squared away for now, and break time's over. Back to work!" },
			},
			HephaestusMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0110",
					Text = "That's what I like to call {#Emph}hammering out the details{#Prev}. Leave 'em to me next time." },
			},
			HephaestusMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0111",
					Text = "{#Emph}Eh! {#Prev}Fine, consider me appeased. But don't incur my wrath again lest I— I don't even know." },
			},
			HephaestusMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0112",
					Text = "Was as close as I am liable to get to blowing up. Still working at it, mind!" },
			},
			HephaestusMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0113",
					Text = "Now that you've seen some samples of my work, perhaps you'd like some for yourself?" },
			},
			HephaestusMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0114",
					Text = "Some work you did! Though, looks like you could use some patching up." },
			},
			HephaestusMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0115",
					Text = "{#Emph}Eh{#Prev}, no use staying mad over nothing! Wasn't all that mad, mind." },
			},
			HephaestusMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0116",
					Text = "Been working on my anger issues. Can't blow my top like some of the others here..." },
			},
			HephaestusMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0117",
					Text = "All right, I'd say we're settled up! We can continue bickering another time." },
			},
			HephaestusMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hephaestus_0118",
					Text = "{#Emph}Hrm{#Prev}, that there was not the most productive thing I did all day, but {#Emph}eh... this {#Prev}ought to make up." },
			},

		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			HephaestusGift01 =
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
						PathTrue = { "GameState", "UseRecord", "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0959", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Hephaestus! Your services must be in very high demand. I'm grateful, and doubtless so are the Nocturnal Arms." },
				{ Cue = "/VO/Hephaestus_0085",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Look I don't work for tips. Though ours ain't an ordinary arrangement, and ain't often lately I get new regular clients! So, here. Call it a trade." },
			},
			HephaestusGift02 =
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
						PathTrue = { "GameState", "UseRecord", "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0960", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "For you, mighty Hephaestus! Though, you may not have occasion for such offerings, working a hot forge every night and day..." },
				{ Cue = "/VO/Hephaestus_0086",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Oi, this is just a service job, no need to get all cordial and the like. Nice gesture from you, though. So cheers and all." },
			},
			HephaestusGift03 =
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
						PathTrue = { "GameState", "UseRecord", "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1772", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Great Hephaestus! Your work is beyond compare, and I'm grateful for your candor with me as well. Please, take this offering." },
				{ Cue = "/VO/Hephaestus_0087",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Anytime I get an offering it's 'cause somebody wants something from me. You're already getting premium service, but hey, it's your Nectar! Well, mine now I reckon." },
			},
			HephaestusGift04 =
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
						PathTrue = { "GameState", "UseRecord", "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1773", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Hephaestus, you're so much more than your ingenious craft. I never could have expected you to be so generous to me, and I'm most grateful for it." },
				{ Cue = "/VO/Hephaestus_0088",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Oi witchie, is it hot in here, or are you embarrassing me to no end? Just let me work the blasted forge, no need to make a big deal." },
			},

			-- placeholder
			HephaestusGiftTemp =
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

			{ Cue = "/VO/MelinoeField_0645", Text = "I'm in your debt for this, Hephaestus sir." },
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
			Source = { LineHistoryName = "NPC_Hephaestus_01", SubtitleColor = Color.HephaestusVoice },

			{ Cue = "/VO/Hephaestus_0106", Text = "Best learn to take more punishment than {#Emph}that{#Prev}, witchie." },
			{ Cue = "/VO/Hephaestus_0107", Text = "Mayhap I'm the runt of the litter, but... I still know how to bite.", PlayFirst = true },
			{ Cue = "/VO/Hephaestus_0108", Text = "Careful 'round me, witchie! Lest I tie you in a knot." },
			{ Cue = "/VO/Hephaestus_0201", Text = "Don't like what I see, down comes my hammer just like that!" },
			{ Cue = "/VO/Hephaestus_0202", Text = "I ain't somebody gonna let hisself get pushed around again." },
		},

		RarityUpgradeVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Hephaestus_01", SubtitleColor = Color.HephaestusVoice },
			Cooldowns =
			{
				{ Name = "BoonRarifiedSpeech", Time = 60 },
			},

			{ Cue = "/VO/Hephaestus_0170", Text = "All right then!" },
			{ Cue = "/VO/Hephaestus_0171", Text = "That I can do." },
			{ Cue = "/VO/Hephaestus_0172", Text = "Done and {#Emph}done.", PlayFirst = true },
			{ Cue = "/VO/Hephaestus_0173", Text = "Here you go!" },
			{ Cue = "/VO/Hephaestus_0174", Text = "No problem!" },
			{ Cue = "/VO/Hephaestus_0175", Text = "Simple." },
			{ Cue = "/VO/Hephaestus_0176", Text = "Can do." },
			{ Cue = "/VO/Hephaestus_0177", Text = "Right!" },
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Hephaestus_01", SubtitleColor = Color.HephaestusVoice },
			TriggerCooldowns = { "HephaestusBoonTakenSpeech" },

			{ Cue = "/VO/Hephaestus_0164", Text = "{#Emph}Oi{#Prev}, it's only me!" },
			{ Cue = "/VO/Hephaestus_0165", Text = "Made to order!" },
			{ Cue = "/VO/Hephaestus_0166", Text = "What's going on?" },
			{ Cue = "/VO/Hephaestus_0167", Text = "Just what you wanted, right?" },
			{ Cue = "/VO/Hephaestus_0168", Text = "What a bargain." },
			{ Cue = "/VO/Hephaestus_0169", Text = "Let's get to work!" },
		},
	},

}

OverwriteTableKeys( LootData, LootSetData.Hephaestus )