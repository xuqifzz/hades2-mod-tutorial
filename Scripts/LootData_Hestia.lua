LootSetData.Hestia =
{
	-- Hestia
	HestiaUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord" },
				HasAny = { "PoseidonUpgrade", "DemeterUpgrade" }
			},
		},
		UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = true,
		Weight = 10,
		BoonInfoIcon = "BoonInfoSymbolHestiaIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_HestiaUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_HestiaUpgrade",
		LootRejectedText = "Player_GodDispleased_HestiaUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_HestiaUpgrade",
		Icon = "BoonSymbolHestia",
		DoorIcon = "BoonDropHestiaPreview",
		DoorUpgradedIcon = "BoonDropHestiaUpgradedPreview",
		Color = { 250, 250, 215, 255 },
		LightingColor = {255, 100, 60, 255},
		LootColor = {255, 46, 12, 255},
		SubtitleColor = Color.HestiaVoice,
		EmoteOffsetY = -280,
		EmoteOffsetX = 45,
		ColorGrade = "ZeusLightning",
		LootRejectionAnimation = "BoonDissipateA_Zeus",
		SpawnSound = "/SFX/HestiaBoonFlameBurst",
		PortraitEnterSound = "/SFX/HestiaBoonFlameBurst",
		UpgradeSelectedSound = "/SFX/HestiaBoonChoice",

		SpeakerName = "Hestia",
		Speaker = "NPC_Hestia_01",
		LoadPackages = { "Hestia", },
		Portrait = "Portrait_Hestia_Default_01",
		WrathPortrait = "Portrait_Hestia_Default_01_Wrath",
		OverlayAnim = "HestiaOverlay",
		Gender = "Female",
		FlavorTextIds =
		{
			"HestiaUpgrade_FlavorText01",
			"HestiaUpgrade_FlavorText02",
			"HestiaUpgrade_FlavorText03",
		},

		PriorityUpgrades = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "HestiaSprintBoon", "HestiaManaBoon" },
		WeaponUpgrades =
		{
			"HestiaWeaponBoon",
			"HestiaSpecialBoon",
			"HestiaCastBoon",
			"HestiaSprintBoon",
			"HestiaManaBoon",
		},
		Traits =
		{
			"OmegaZeroBurnBoon",
			"CastProjectileBoon",
			"FireballManaSpecialBoon",
			"BurnExplodeBoon",
			"BurnArmorBoon",
			"BurnStackBoon",
			"AloneDamageBoon",
			

			-- Elemental
			"ElementalBaseDamageBoon",

			-- Legendary
			"BurnSprintBoon",

			-- Duos
			"EchoBurnBoon",
			"SteamBoon",
			"BurnConsumeBoon",
			"CoverRegenerationBoon",
			"BurnRefreshBoon",
			"DoubleMassiveAttackBoon",
			"ManaRestoreDamageBoon",
			"FireballRendBoon",
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
			{ Cue = "/VO/Melinoe_0644", Text = "The flame sigil..." },
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

			{ Cue = "/VO/Melinoe_1478", Text = "It's Great-Auntie...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift02" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1479", Text = "Hestia...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0644", Text = "The flame sigil..." },
		},

		UpgradeMenuOpenVoiceLines =
		{
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		DuoPickupTextLines =
		{
			HestiaWithZeus01 =
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
				{ Cue = "/VO/Hestia_0145",
					Text = "In olden days I never took strapping young Zeus here for the marrying type, and was none too pleased when he picked my poor sister Hera for the job! But you've been a right good husband to her, haven't you, Zeus?" },
				{ Cue = "/VO/Zeus_0164",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "...I sometimes pity you, Hestia, for never having known the joys of matrimony for yourself. Challenges arise in any such relationship, but together with your beloved partner, you find a way! All you must do is compromise and cooperate." },
			},

			HestiaWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ManaRestoreDamageBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0147",
					Text = "Not always big on family business, though I take exception for my little sis. She of all goddesses has to put up with the most around here, and that's not even counting all this Chronos stuff. How do you manage it, {#Emph}O Queen?" },
				{ Cue = "/VO/Hera_0106",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "I manage it one evening at a time is how, Sister! Perhaps we shall have to burn the old world down and start anew, but... I can think of {#Emph}none {#Prev}more suited, should the need arise." },
			},

			HestiaWithPoseidon01 =
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
				{ Cue = "/VO/Hestia_0149",
					Text = "Take our blessings but {#Emph}don't {#Prev}follow our example's what I say, dearie. A case in point's fish-faced Poseidon over here! Always trying hard to make a splash, {#Emph}never {#Prev}caring much who ends up getting wet. That about right, you big oaf?" },
				{ Cue = "/VO/Poseidon_0274",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Text = "Quite on the contrary, dear Hestia! You're wrong at least on two accounts I think: First, I need never {#Emph}try hard {#Prev}to make a splash! I effortlessly do it every time. And second, don't you call me {#Emph}fish-faced{#Prev}, you mean wrinkly old hag, {#Emph}ha-hah!" },
			},

			HestiaWithApollo01 =
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
				{ Cue = "/VO/Hestia_0151",
					Text = "All right, dearie, let's get a real fire going! No more fussing about merely with sparks and such. Oh, {#Emph}Apollo? {#Prev}Get your buttocks over here right now, 'cause I could use a light!" },
				{ Cue = "/VO/Apollo_0096",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Text = "{#Emph}Erm{#Prev}, right away, dear Lady Hestia! Though, might we please take more precaution not to burn down half the mountaintop this time...?" },
			},

			HestiaWithDemeter01 =
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
				{ Cue = "/VO/Hestia_0153",
					Text = "Would you believe it, hot stuff? I have on good authority that {#Emph}somebody {#Prev}around here's laid a claim to being {#Emph}Eldest of Olympus. {#Prev}Oh, Demeter? Care to explain {#Emph}that {#Prev}one?" },
				{ Cue = "/VO/Demeter_0110",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "Hestia, you had {#Emph}abandoned {#Prev}us! To be an Olympian is not merely a birthright, but a {#Emph}pledge; {#Prev}both to this family, and this mountain. Restore your rightful status, and join me now to aid my granddaughter!" },
			},

			HestiaWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BurnRefreshBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0155",
					Text = "Come on, hop to it, hot stuff! While you've still got your looks! Not like Aphrodite here is going to let you hold to them forever. She doesn't care for competition, you can trust me on that." },
				{ Cue = "/VO/Aphrodite_0147",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Emote = "PortraitEmoteSurprise",
					Text = "Sweet Hestia, whatever do you {#Emph}mean? {#Prev}I'll be the first to admit looks aren't {#Emph}everything. {#Prev}Who even needs them? But on the other hand, we're blessed to have someone of such vast wisdom and experience as {#Emph}you {#Prev}here on our side!" },
			},

			HestiaWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "DoubleMassiveAttackBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0157",
					Text = "If there's one thing I learned from my strong-armed nephew here, dearie, it's that you always have to strike while the iron's still hot. Now {#Emph}come {#Prev}on, {#Emph}hop {#Prev}to it, Hephaestus my lad!" },
				{ Cue = "/VO/Hephaestus_0134",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Emote = "PortraitEmoteSurprise",
					Text = "I'm hoppin', I'm hoppin', Lady, {#Emph}augh! {#Prev}Though if you keep on turning up the heat in here, then this whole {#Emph}forge {#Prev}is going to blow, and take the rest of the damn mountain with it, {#Emph}too! {#Prev}And what would witchie have to fight for then?" },
			},

			HestiaWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "FireballRendBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0204",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "We put poor mortals through an awful lot, no thanks to Ares here. Least he's been occupied with our own troubles for a change, haven't you, laddie? That way most everybody else can catch a break." },
				{ Cue = "/VO/Ares_0161",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "But dearest Lady Hestia, our troubles are of grave concern to more than mortalkind! Ours is a conflict of the highest order, and irresistibly draws each of us to do our part." },
			},
		},

		InteractTextLineSets =
		{
			HestiaFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/Melinoe_0645", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.4, PowerWordPresentation = true, PowerWordWaitTime = 3.6 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "I thought the fire goddess never got involved? {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Hestia_0002",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Emote = "PortraitEmoteCheerful",
					Text = "Well, look at you, hot stuff! Come to help the elderly, {#Emph}ah {#Prev}what a good girl you are. And here I was just about to burn this whole blasted place to the ground myself! Now, here's a little {#Emph}warm-up {#Prev}for ya..." },
			},

			-- low health
			HestiaLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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

				{ Cue = "/VO/Hestia_0071",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Oh, dearie, you look {#Emph}terrible{#Prev}, what happened to you there? Well maybe you can sweat it out or something. Would that I could cauterize your wounds!" },
			},
			HestiaLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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

				{ Cue = "/VO/Hestia_0072",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "{#Emph}Tsk, ooh{#Prev}, you've had more than a scrape or two, there, haven't you? {#Emph}Augh{#Prev}, such is life! Bite down and press on through, that's how we end up in a better spot." },
			},
			HestiaLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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

				{ Cue = "/VO/Hestia_0166",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "{#Emph}Ohh{#Prev}, looks to me like you've been through a {#Emph}lot! {#Prev}Well if you find yourself in a bad place, you just push on through! Or go scorched-earth on everything around you if you must." },
			},
			HestiaLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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

				{ Cue = "/VO/Hestia_0167",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Oh dearie, if you're all banged up from head to toe like this, then you're in no shape for the next stage of our little firefight! So pull yourself together, {#Emph}eh?" },
			},

			-- run starts
			HestiaRunStart01 =
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

				{ Cue = "/VO/Hestia_0077",
					Text = "Why hello, dearie, getting ready for your next excursion, there? You're just a glowing ember for the moment, so how about we get you good and fired up?" },
			},
			HestiaRunStart02 =
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

				{ Cue = "/VO/Hestia_0117",
					Text = "Now don't go wandering into the dark without a proper light! And I don't mean the kind Apollo's offering, although mayhaps I'd settle for the Moon. Anyhow, no matter, {#Emph}here!" },
			},
			HestiaRunStart03 =
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

				{ Cue = "/VO/Hestia_0118",
					Text = "Think you can slip right out of there this late without my noticing? Well, typically you can, but not this time! And your punishment is a fine selection of hearth-warming Boons!" },
			},
			HestiaRunStartUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03" },
					},					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0119",
					Text = "You must live somewhere 'round those parts, don't you, dearie? Well, since it seems a little cold out there tonight, why don't we make some {#Emph}temperature adjustments {#Prev}here..." },
			},
			HestiaRunStartSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutSurface03" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0120",
					Text = "So, headed up this way again? Won't be hearing any arguments from me! Not sure you can hear me at all down there, come to think. Anyhow, let's get you {#Emph}all warmed up!" },
			},

			-- story events
			HestiaAboutFlame01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0033",
					Text = "For every candle that you light, for every cauldron that you boil, that's {#Emph}my {#Prev}flame working its own magick for you, dearie! So you just think of me whenever the sparks fly." },
			},
			HestiaAboutFlame02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0034",
					Text = "Funny thing about flame, dearie, it's warm and pretty, isn't it? But it can kill you in a couple of licks. Really makes you think! And really makes you burn to a crisp, if you're not careful..." },
			},

			HestiaAboutSoot01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0103",
					Emote = "PortraitEmoteCheerful",
					Text = "Guess what, hot stuff, your Great-Aunt's back again to turn your foes to soot! Best way to make it so they never bother you again, though tidying up can be a bit of a pain..." },
			},

			HestiaAboutSisters01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0035",
					Text = "{#Emph}Eh{#Prev}, this mountaintop. Gave up my seat here, you know. Wanted to see the world, not my blasted sisters everyday! But now I'm stuck here with the lot of them. Burns me right up, even to think about!" },
			},

			HestiaAboutDarkness01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0052",
					Text = "You're used to living in darkness, aren't you? Up here, darkness is widely feared. Even in the warmth of my firelight, they jump at shadows, mortals and even gods sometimes! They trust their weak eyes overmuch I think." },
			},

			HestiaAboutParents01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0044",
					Text = "Been on your own all this time, haven't you? Well, might be you're better off. Wish I never knew {#Emph}my {#Prev}blasted dad and mum! They taught me nothing I couldn't have learned better on my own." },
			},

			HestiaAboutHearth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0259",
					Text = "The hearth-flame of this mountain started sputtering a bit after Typhon decided to show up. It's since been burning bright and hot, but I've been tending to it plenty, just in case." },
			},
			HestiaAboutHestiaStatue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "StatueTrap_Hestia" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0253",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "See they've got statues of me up here now, dearie? They didn't use to, but the others, they've been trying to get me back into the fold, pay me respects, there's a nice thought! But I don't want to see my own mug all the time!" },
			},
			HestiaAboutHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift04" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0261",
					Text = "How come you're not living in the House of Hades with your mum and dad? Must be nice and cozy there all deep beneath the Earth. Well, a House isn't always a home. Mayhaps you like your woods..." },
			},

			HestiaAboutOlympians01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0045",
					Text = "Know what this family's problem is, dearie? It's just too big! The others act as though they pity me, {#Emph}poor childless Hestia{#Prev}, they say! But they all long for their childless days, I can see it in their eyes." },
			},
			HestiaAboutOlympians02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "HestiaUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0046",
					Text = "I almost pity you, dearie, all swept up in our affairs! You don't know how hard I've tried to avoid it myself. Must we always have to take a blasted side in everything? But we gods, we just love a good fight..." },
			},
			HestiaAboutOlympians03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift05" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"ZeusGift07",
							"HeraGift07",
							"PoseidonGift07",
							"DemeterGift08",
							"ApolloGift07",
							"AphroditeGift07",
							"HephaestusGift07",
							"AresGift07",
						},
						Comparison = ">=",
						Value = 5,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0248",
					Text = "I figured we could use you, dearie, no real surprise. But, I didn't expect we'd {#Emph}like {#Prev}you, which is to say you're young, you've got your different customs and whatnot. We can be hard to get along with! But you're {#Emph}doing {#Prev}it!" },
			},

			HestiaAboutTitans01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "RoomsEntered" },
						HasAll = { "I_Boss01", "P_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0164",
					Text = "Titans, gods, still couldn't tell you what's the bloody difference anyway! Don't look much different, don't sound much different. Not an age thing, {#Emph}that {#Prev}I can attest! It's just a handy way to brand our enemies." },
			},

			HestiaBackstory01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift04" },
					},
					{
						Path = { "GameState", "UseRecord", "HestiaUpgrade" },
						Comparison = ">=",
						Value = 6,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0038",
					Text = "{#Emph}Ohh{#Prev}, I was something in my glory days. Lots of suitors. {#Emph}Pfeh! {#Prev}I was a crack shot with the Rail of Adamant. You heard of it? Monstrous thing, gave it up. Gave up warring altogether! Until now, apparently!" },
			},
			HestiaBackstory02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift03" },
					},
					{
						Path = { "GameState", "UseRecord", "HestiaUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0042",
					Text = "{#Emph}Ah{#Prev}, the passions of youth! I've smoldered away, not much of a feast for the eyes at this point. Fine. But {#Emph}you? {#Prev}Still just a kindling. Though, we'll make an inferno of you yet!" },
			},

			HestiaAboutWitchcraft01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0041",
					Text = "So you're a bit of a witch, are you? Well, not I! Stuck with {#Emph}this {#Prev}family already, don't see why I'd want another one. But I understand the appeal, I suppose. Plenty of candles and fire to it, isn't there?" },
			},

			HestiaAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0053",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "We ought have been kinder to mortals, really. Then Chronos would've had a harder time compelling the dead to rise against us! I've always tried to look after the living. But our family's best known for looking after ourselves." },
			},
			HestiaAboutMortals02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutMortals01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0054",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "The mortals used to make us many offerings, giving up their own food and the like. They always praised me first among the gods, for it's my fire they used when making sacrifice. It was very sweet!" },
			},
			HestiaAboutMortals03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HestiaAboutMortals02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0238",
					Text = "The others don't agree with me on this, dearie, but you're still young, mayhaps impressionable, so... well {#Emph}I {#Prev}think mortals ought to get from us a bit more than we give. If the Fates are saying it'll happen down the line, then good!" },
			},

			HestiaAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HestiaAboutChronosBossW02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0105",
					Text = "Old Hecate's your teacher, is that it? Known her since I was probably {#Emph}your {#Prev}age, right proper dame! Been far too long since last we saw each other, come to think. {#Emph}Eh{#Prev}, what can you do? She hates everybody, I hate everybody." },
			},

			HestiaAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Intro" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0047",
					Text = "Well, look at you, hot stuff, you made it to the surface after all! I figured that you might. It's maybe even colder here than down below, but {#Emph}that{#Prev}, at least, we can fix right away, I think!" },
			},
			HestiaAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Hub" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "N_PreBoss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0048",
					Text = "Mortals go from worshiping the flame to fearing it. As well they ought! The hearth-fires of every home there in that wretched city you reside in, all of them burned out. Not that I'm mad, oh no." },
			},
			HestiaAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift02" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0036",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Poor thing, been all cooped up inside that Underworld, haven't you? There's a whole great world to see out there, once your business is done. Do let me know, I can suggest some wondrous spots not far from here!" },
			},

			HestiaAboutEphyra01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Hub" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "N_PreBoss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0196",
					Text = "The city of Ephyra burns, but it's not entirely my fault! Flames are like a tool, I suppose... one of those things requiring precaution on one's part. Lose something in a fire, sorry! Can't help you with that!" },
			},

			HestiaAboutSurfacePenalty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0107",
					Text = "You're not supposed to be up here, are ya? Don't think your dad's permitted back up top, at least. But you're a witch, must be you've got your cures for everything under the sun!" },
			},
			HestiaAboutRouteChoice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PoseidonDevotionIntro01", "HestiaGift01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0108",
					Text = "Don't let us keep on jerking you around, all right? First we got you going after Chronos, now we got you coming here to our defense, {#Emph}blast! {#Prev}Though just in case nobody's said it yet, we {#Emph}really do {#Prev}appreciate the help." },
			},

			HestiaAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0049",
					Emote = "PortraitEmoteSurprise",
					Text = "Where in those bloody depths {#Emph}are {#Prev}you, dearie, underneath the sea?! It's hard to get a blaze a-roaring when there's water all about, but if you can handle the pressure down there, I can bring the heat!" },
			},
			HestiaAboutFields01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "H" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "H" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0111",
					Text = "You made it all the way down to the Mourning Fields before? A horrid place, or so I hear, and covered in dry brush, far as the eye can see. Well next time you're there, you burn your way on through! Hear me, hot stuff?" },
			},

			HestiaAboutPhlegethon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0195",
					Text = "Someday I'd like to see the River Phlegethon you've got down in the Underworld! A river full of {#Emph}flame... {#Prev}tried making something like that here on our side, but it sent mortals panicking, and the gods didn't much care for it either..." },
			},

			HestiaAboutPalace01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "Q_Story01" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0223",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "You didn't even get the Palace tour, Hera says. {#Emph}Aw{#Prev}, dearie, if only I could have been there to show you around instead of tending to our flames. But then again, you see one of our fancy columns, mayhaps you've seen 'em all." },
			},

			HestiaAboutChronosBossW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0221",
					Text = "I still remember how it felt when we showed Chronos what we younger generation were made of! Now {#Emph}you're {#Prev}the younger generation, dearie, dealing with the same old problems and worse. Some things never do change!" },
			},
			HestiaAboutChronosBossW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0222",
					Text = "You and old Hecate, you must be sorting out some way to keep that Chronos from recovering, lest you wouldn't keep on going after him like this! You getting any warmer yet?" },
			},

			HestiaUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0113",
					Emote = "PortraitEmoteCheerful",
					Text = "They're saying that you gave him one from all of us! Chronos, that is. A right proper old fashioned {#Emph}beating{#Prev}, that is! Must have felt all warm and cozy, didn't it? Makes you want to do it again and {#Emph}again!" },
			},
			HestiaUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						-- PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0114",
					Emote = "PortraitEmoteFiredUp",
					Text = "You got that bloody Titan, didn't ya? Don't feel too bad you couldn't end him altogether, not like any of the rest of us were able to, as you can plainly see. Instead, mayhaps go kick him while he's {#Emph}down! {#Prev}Happy to help with {#Emph}that!" },
			},
			HestiaUnderworldRunCleared03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPostTrueEnding03" },
 					},
 					{
 						PathFalse = { "CurrentRun", "TextLinesRecord", "ZeusPostTrueEnding03" },
 					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0229",
					Text = "We've relegated Chronos to a cushy job down in the Isles of the Blessed, how nice for him, I get that. But you're still working with him to fight him to stop him from rising to power, {#Emph}eh? {#Prev}Well I suppose I get that, too!" },
			},

			HestiaSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0194",
					Emote = "PortraitEmoteFiredUp",
					Text = "You helped us {#Emph}beat {#Prev}that bloody monster {#Emph}down! Ah{#Prev}, if only I could have seen! You're really something else, hot stuff! Of course our good friend Typhon's already begun on his climb back up. We'll just have to make it extra tough for him..." },
			},
			HestiaSurfaceRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
						PathTrue = { "GameState", "TextLinesRecord", "HestiaSurfaceRunCleared01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0115",
					Emote = "PortraitEmoteCheerful",
					Text = "Regards for helping clear the air a bit up here! Bought us a little moment to recover and regroup. Now everybody's all fired up again to break the siege! {#Emph}Augh{#Prev}, but listen to me! All about the warring like the rest of them..." },
			},
			HestiaSurfaceRunCleared03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0227",
					Text = "So let me see if I understand: Though you rid us of Typhon, you are now supposed to hunt down what remains of him, somewhere out of this bloody world? {#Emph}Oh {#Prev}you can't catch a proper {#Emph}break{#Prev}, hot stuff! But I have got your back." },
			},

			HestiaAboutWinStreak01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 3,
						Path = { "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0255",
					Emote = "PortraitEmoteFiredUp",
					Text = "Great stuff, dearie, giving bad Chronos and then Typhon the old one-two! You make this stuff look proper easy now. Mayhaps I should give it a go myself one of these nights?" },
			},

			HestiaAboutCinder01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "Resources", "MixerFBoss" },
						Comparison = ">=",
						Value = 5,
					}
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0055",
					Text = "Got yourself some Cinder there, don't ya? Not a flashy substance, but it's strong, good source of flame! Most gods and mortals only care for shiny baubles and the like. But some of you witches rather know your stuff!" },
			},
			HestiaAboutCinder02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutCinder01" },
					},
					{
						Path = { "GameState", "Resources", "MixerFBoss" },
						Comparison = ">=",
						Value = 20,
					}
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0199",
					Text = "You're loaded up with Cinder, aren't ya? That much of it I can detect from here... a special kind from torches I know well. Some remnants of your bouts with Hecate? You can't really be fighting. Probably just your nightly exercise!" },
			},

			HestiaAboutMyths01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0112",
					Text = "The others, each in their own way, they do like when mortals make them subjects in their tales and songs. Well, not {#Emph}I! {#Prev}In that regard I think you Underworld gods are in the right. Best keep our business to our own damn selves!" },
			},

			HestiaAboutFighting01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0220",
					Text = "You might be wondering, {#Emph}Great-Auntie Hestia, when does the fighting ever cease? {#Prev}Well, I invite you to imagine back when I was closer to your age... a little leaner, little feistier, but not too different, all in all. We've been fighting ever since." },
			},

			HestiaAboutTorch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0109",
					Emote = "PortraitEmoteSurprise",
					Text = "What's that you got there, Ygnium is it? Reminds me of those twin torches that old Hecate would always have with her. If these are anything like those, they'll never sputter out. But just in case, we'll keep them nice and hot!" },
			},
			HestiaAboutEosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutTorch01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0165",
					Emote = "PortraitEmoteSurprise",
					Text = "What happened to those Flames of yours? Now shining almost like the break of Dawn. Mayhaps that rosy-fingered Eos has decided to pitch in! Much as we'd hate to interrupt her from the one thing on her schedule each day..." },
			},
			HestiaAboutSupayAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutTorch01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchAutofireAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0250",
					Emote = "PortraitEmoteFiredUp",
					Text = "Well look at those fancy flames you've got, sputtering their sparks all uncontrollably! That is a safety hazard, dearie. Back when I was shooting fire at my foes, it sure was not an automatic thing. You youngsters have it {#Emph}easy {#Prev}now!" },
			},
			HestiaAboutSuit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0254",
					Emote = "PortraitEmoteSurprise",
					Text = "Strange contraption that you're using to make everything blow up! I got odd glances too when I still had the Rail of Adamant, but it could make 'em look away right quick." },
			},

			HestiaAboutChronosPlan01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "RoomsEntered" },
						HasAll = { "H_Boss01", "N_Boss01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutTyphonReveal01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0076",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "We've been holding our own up here against that Chronos and his forces, but there's something going on, oh I can feel it. Whatever the Titan thinks he has in store, however, I suspect that it can {#Emph}burn..." },
			},
			HestiaAboutChronosPlan02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutTyphonReveal01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0190",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "We don't quite know what Chronos has been cooking up for us, but we're all thinking that his little recent skirmishes against our mountainside are not the brunt of it. Not keen here to find out." },
			},

			HestiaAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyHestia" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0102",
					Text = "Just earlier I felt the strangest urge to seek you out, dearie! Almost as though it wasn't even me deciding it! Messing with eldritch forces or somesuch? Well if you want to gaze into the cold abyss, I'll keep you nice and warm." },
			},
			HestiaAboutPackageBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.LateStartPackagedBounties,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0188",
					Text = "Don't know how you got so far so quick tonight, hot stuff, but you're not going any farther till you're properly prepared. Got to bring plenty of {#Emph}heat {#Prev}where you're going!" },
			},

			HestiaPostGift01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift01", },
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0039",
					
					Text = "{#Emph}Ah{#Prev}, I like a girl who's ready to gird up her loins, get her hands dirty and the like. Too many just waiting for someone to clean their messes for them, blast it all. Speaking of, why don't you go and do some {#Emph}blasting {#Prev}for me, eh?" },
			},
			HestiaPostGift02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift03" },
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0074",
					Portrait = "Portrait_Hestia_Displeased_01",
					
					Text = "We've burned bright on Olympus I don't know how long already, dearie. Suppose our time has come and gone? Mayhaps we're more like mortals than we care to admit. Well, whatever doom awaits, I welcome it!" },
			},
			HestiaPostGift03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift04" },
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0075",
					Portrait = "Portrait_Hestia_Displeased_01",

					Text = "You really are an odd one, hot stuff. At first I thought you were a little stuck up, much like some others whom I happen to know only too well. But you truly are committed to righting this wrong from before your time, aren't ya?" },
			},

			HestiaAboutCosmetics01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 10,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0239",
					Text = "I know you've all this Chronos business to sort out but want to say, I can appreciate that you're attempting to make life a little cozier back home. Make things warmer and old Hestia can tell!" },
			},
			HestiaAboutCosmetics02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 22,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift06" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0240",
					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },
					Text = "Never been to where you live but I can tell when someone's made a warm and happy home, such as they can. Decorations, little touches for a sense of welcome, that's the stuff! Not everybody gets it but {#Emph}you {#Prev}do." },
			},

			HestiaLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0057",
					
					Text = "Even I'll admit the quaint crackle of the hearth just doesn't always do the job. Sometimes, what we need is a great big conflagration, an inferno of the highest order! How about one, then?" },
			},
			HestiaLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0058",
					
					Text = "The hearth is at the center of the mortal household, dearie, keeping my flames comfortably in place. But I can make a wildfire in a {#Emph}snap! {#Prev}And when I get angry, that's {#Emph}exactly {#Prev}what I do." },
			},

			-- about characters / about other characters
			HestiaAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0037",
					Text = "Your dad and I got on all right, comparatively speaking, I suppose. After we put the Titans in their place, though, he went down into your Underworld, and I drifted away, like a spark from a flame..." },
			},
			HestiaAboutHades02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0110",
					Text = "Your dad and I, we've got a lot in common, I suppose. The two {#Emph}not-technically-Olympians! {#Prev}At least I get to visit when I want, whereas poor Hades, soon as he got saddled with the Underworld, they never counted him among their kind again!" },
			},
			HestiaAboutHades03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0234",
					Text = "I sure am glad to know your dad's all right. Him and your mum, your brother, everybody from that House of his. May they all be warm and comfortable together there." },
			},

			HestiaAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0236",
					Text = "Things have not exactly gone our way, dearie. 'Specially if what I'm hearing about the Fates is so. Whether we ought to be in charge or no, it's they that put us here... and now they've vanished like a puff of smoke?" },
			},

			HestiaAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosRevealFollowUp", "ChronosMeeting03", "ChronosPostBattleMeeting01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0043",
					Text = "You should have seen it, dearie, when we brought old Chronos down! Took six of us, at least, but we got him! Little wonder he's all sore about it still. We'll just have to dispose of him more thoroughly! {#Emph}Cremation{#Prev}, mayhaps?" },
			},

			HestiaAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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

				{ Cue = "/VO/Hestia_0192",
					Text = "Since Typhon's back, I thought I'd say {#Emph}nice knowing you, dearie! {#Prev}Not that we're going down without a fight, but just in case. We barely beat him when we first settled up with Chronos way back when! But now he's grown, a {#Emph}lot!" },
			},
			HestiaAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasNone = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0193",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Don't quite know how we're managing to hold back Typhon from reducing this whole mountaintop to ash. Must be the lightning, flames, floods, and earthquakes and the like! If you've got any bright ideas yourself, just come on up!" },
			},
			HestiaAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0224",
					Emote = "PortraitEmoteSurprise",
					Text = "That bloody monster's down and out? And I mean out for good, as in, we can't find any trace of him at {#Emph}all! {#Prev}They're telling me you turned Typhon to {#Emph}ash{#Prev}, dearie! That's proper scary stuff...!" },
			},

			HestiaAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
						Comparison = ">=",
						Value = 3,
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
						Comparison = "<",
						Value = 20,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0187",
					Text = "So it was Artemis who sniffed you out, was it? Seems like an awful big coincidence, but then we're gods, these things they happen all the time! I'll say I'm glad she found you when she did." },
			},

			HestiaAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "PrevRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0197",
					Text = "Oh while you're up here do watch out for Heracles, big burly sort of man? One of the best we've got but sometimes gives the sense that he's become unhappy with his job. How that is possible, though, is beyond my ken!" },
			},
			HestiaAboutHeracles02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HestiaAboutHeracles01", "HestiaGift05", "HeraGift05", "HeraclesGift05" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0258",
					Text = "Done had a chat with Hera, with {#Emph}Queen Hera {#Prev}I should say, about how maybe we can all go easier on Heracles after all this. He ought to put down that big club of his and have a good long sit!" },
			},

			HestiaAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Boss01", "N_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0198",
					Text = "You had it out with Polyphemus, so I hear! Recall distinctly how he lost his eye. Let's say {#Emph}flame {#Prev}played a vital part and leave it there. Almost felt sorry for the lad, but he's been getting by. And getting in your way..." },
			},

			HestiaAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
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

				{ Cue = "/VO/Hestia_0073",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "You had a bad run-in with that wretched Eris on your way here, eh? Just {#Emph}great{#Prev}, to know that Strife herself is up against us now! And got her grubby little fingers on my Rail of Adamant... I ought have kept the thing." },
			},
			HestiaAboutEris02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0116",
					Text = "Heard you plucked that nasty Eris from the sky! Well, serves her right! Though we could never make her stay away for good. To think she's one of {#Emph}Nyx's {#Prev}many pups! Squeeze out a big litter like that, you're liable to get a runt." },
			},
			HestiaAboutEris03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						SumPrevRuns = 2,
						Path = { "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0247",
					Text = "That Eris keeps on getting in your way, even though Chronos himself has stood down and Typhon's dead and such? Well, she's as stubborn as {#Emph}we {#Prev}are, I am practically impressed!" },
			},

			HestiaAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0162",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "So the Titan of Foresight slipped his chains and fights against us now! A pity, that. Been on the outs with us ever since we caught him red-handed with my flames. Stole fire for the sake of mortalkind! Could have just asked me nice!" },
			},
			HestiaAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutPrometheus01" },
					},
					{
						SumPrevRuns = 2,
						Path = { "EnemyKills", "Prometheus" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0163",
					Text = "Prometheus, he never seemed to lack for smarts as I recall. Was a right level-headed sort, but now? He's serving Chronos, making mayhem for us here! They say he sees the future, so he must know he won't get away with this..." },
			},
			HestiaAboutPrometheus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0232",
					Text = "I figured once we got to Chronos, that Prometheus would not be far behind, longing for the days his liver was an eagle's snack. I know he's been a problem, but... I don't want to see him go through that again. Don't properly know why..." },
			},
			HestiaAboutPrometheus04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutEpilogue01" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0233",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "I know Prometheus supposedly can see what's coming up, but I just can't believe he saw all {#Emph}this! {#Prev}Suppose I should be madder at him, but... least it seems like he's been looking out for mortals still." },
			},
			HestiaAboutPrometheusL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "RoomsEntered", "P_PostBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0256",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Got sent home by Prometheus, I heard. Well if he burned you don't go putting ice on it, no matter what Demeter says. You witches must have ointments and the like..." },
			},

			-- about other gods
			HestiaAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0059",
					
					Text = "You've got Selene's moonlight shine on you, eh? I'll not deny it has a certain power and allure... but such a cold and distant light, next to a scorching flame? There's no comparison!" },
			},
			HestiaAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0060",
					
					Text = "Already had a brush with sister Hera, have you, now? She's more accustomed to attending youngsters such as you, but then again, she's got her own to deal with. So why not stick with me?" },
			},
			HestiaAboutHera02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutHera01", },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0050",
					Text = "Our young Queen Hera, she'd always say one ought to keep her feelings bottled up and carefully in check. Look where that attitude got her! I say let loose your temper and your rage. Let it {#Emph}all {#Prev}out!" },
			},
			HestiaAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0061",
					
					Text = "{#Emph}Oh{#Prev}, the mighty ruler of Olympus gave to you a bit of his {#Emph}thunderous might{#Prev}, did he now? Well that's not going to take you very far at all, so let me set you up with a {#Emph}little extra firepower {#Prev}here." },
			},
			HestiaAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0062",
					
					Text = "Blessed already by the mighty god of earth and sea, are ya? Poseidon's power and my own don't often mix, but then again, neither do he and I, of that you can be certain, there, dearie." },
			},
			HestiaAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0063",
					Emote = "PortraitEmoteFiredUp",
					Text = "Why, the flamboyant god of light has put a little {#Emph}sparkle {#Prev}on you, hasn't he? Shines like the sun, Apollo does, {#Emph}oh sure! {#Prev}But there's more than one way to light up a place, you know." },
			},
			HestiaAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0064",
					
					Text = "You bear the gift of Aphrodite, don't you, there? You know, she's much, {#Emph}much {#Prev}older than she looks. Appearances are everything to her, whilst as for me, I'm about hotness of a different sort..." },
			},
			HestiaAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0104",
					
					Text = "My frosty little sister Demeter has been in touch already, I can tell! Your nan fancies herself the {#Emph}eldest of Olympus{#Prev}, she does! Only true because I'm usually not here. Mayhaps she left you cold, well not to worry, I have {#Emph}just {#Prev}the remedy!" },
			},
			HestiaAboutDemeter02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaAboutDemeter01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					--[[ @purposely omitted
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]-- 
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0051",
					
					Text = "Poor little sister Demeter. She bore but one child, a girl, dearie. Persephone, your mum! And even still, that child caused her at least as much grief as joy. It's not your mum's fault, mind. She was a lovely one, with hair like yours." },
			},
					HestiaAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0067",
					
					Text = "I'm pleased to know you and Hephaestus get along. That one, he's often on his own, as though my flames are all the company he needs. He's not the worst of sorts as we gods go." },
			},
			HestiaAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0203",
					Text = "You know Ares by now, don't ya, dearie? He's cool-headed more than some of us, sure, but I think something's wrong with him. The only kind of warmth {#Emph}he {#Prev}cares for comes from fresh-spilled blood and flames of battle and the like." },
			},
			HestiaAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
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
				{ Cue = "/VO/Hestia_0066",
					
					Text = "You've got a real spring in your step if I'm not mistaken, dearie! The handiwork of swiftest Hermes, I suppose. You know what else moves awful quick? Here, let me give you a little hint!" },
			},
			HestiaAboutChaos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0191",
					
					Text = "I'm sensing something different in you there, dearie. It's like a divine mark of ours but it's most certainly not anybody's here. It's positively ancient, even next to me! Got some old friends that we don't know about?" },
			},

			HestiaAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Athena_01" },
						Comparison = "<=",
						Value = 6,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0200",
					
					Text = "We're not too worried here right now what with Athena holding down the fort. She can be a little much if you two ever meet, but out of everybody here, she'd be the first I'd pick to watch my back." },
			},
			HestiaAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Dionysus_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0202",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "I don't even want to know what's going on with Dionysus anymore. The worse things get, the more he's wanting to cut loose! Whole blasted world could be aflame and he'd just let it burn! Could use some of his wine right now..." },
			},

			-- other reactions
			HestiaAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceHestiaBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0106",
					Emote = "PortraitEmoteCheerful",
					Text = "You got my Everlasting Ember, haven't you? Can faintly see its flicker even here. Your way of signaling to your Great-Auntie Hestia, and all the rest, that you are hankering for Boons with just a {#Emph}little bit {#Prev}of spice!" },
			},

			HestiaAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 6,
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

				{ Cue = "/VO/Hestia_0189",
					Text = "Something about this night gives me the proper chills, hot stuff. It's like the darkness is so thick, it suffocates! And problem is, you can't have fire without air. Careful, all right?" },
			},

			HestiaPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0225",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "What's gotten into Chronos, {#Emph}eh? {#Prev}One moment it's the same-old same-old war, and then the next, he shows up on our mountain all contrite! I know you witches can be serious but this was well past what I reckoned you could do!" },
			},
			HestiaPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0226",
					Emote = "PortraitEmoteCheerful",
					Text = "I got so worked up I didn't properly congratulate you last time, dearie! Bless you for everything! You found us in the middle of a real mess and got us out. Sure we helped and all, but you did the cooking, and you did it good." },
			},

			HestiaPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0237",
					Text = "You found those little weaver-sisters did you now? Just when I thought they'd left the lot of us for good! Don't quite know what to make of their new prophecy, but time eventually will always tell with those." },
			},
			HestiaPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift07" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0252",
					Text = "When all of this is over, I am liable to keep on wandering about I think. See how the mortals and the world are faring, can't do that as easily from on high. Olympus can be nice to visit but I never wanted to live here myself." },
			},

			HestiaAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift07" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0262",
					Emote = "PortraitEmoteDepressed",
					-- Portrait = "Portrait_Hestia_Displeased_01",
					Text = "{#Emph}Augh{#Prev}, I'm proper tired now, you know? Incinerating this and that, on and on, it's taxing after a while! I'll keep on backing you, dearie, but might not be as much for chitchat for a bit." },
			},

			-- repeatable lines
			HestiaChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0003",
					
					Text = "{#Emph}Ah{#Prev}, let's {#Emph}burn {#Prev}it all down, what say you, dearie?" },
			},
			HestiaChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0004",
					
					Text = "We'll turn that flicker in your step into a roaring flame!" },
			},
			HestiaChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0005",
					Emote = "PortraitEmoteCheerful",
					Text = "What say we make a cozy little fire, then put all our enemies in it?" },
			},
			HestiaChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0006",
					
					Text = "Looks like we've got a properly hot night ahead of us!" },
			},
			HestiaChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0007",
					Emote = "PortraitEmoteCheerful",
					
					Text = "Everything's going to be covered in soot by the time we're through!" },
			},
			HestiaChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0008",
					
					Text = "Don't let the fire in your heart sputter out, all right?" },
			},
			HestiaChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0009",
					
					Text = "{#Emph}Hoh{#Prev}, let's have a look and get you good and fired up again, dearie!" },
			},
			HestiaChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0010",
					
					Text = "All right, hot stuff! We're turning up the temperature to get things roaring, then!" },
			},
			HestiaChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0011",
					
					Text = "Been far too long since we incinerated stuff together, hasn't it?" },
			},
			HestiaChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0012",
					
					Text = "Sometimes, you just have to {#Emph}burn {#Prev}everything to the ground and go from there, hot stuff." },
			},
			HestiaChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0013",
					
					Emote = "PortraitEmoteCheerful",
					Text = "Sure everything's rotten, but between us girls, I've not felt this alive in some time!" },
			},
			HestiaChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0014",
					
					Text = "They say never to play with fire, dearie. But you have my permission to go {#Emph}right {#Prev}ahead!" },
			},
			HestiaChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0015",
					
					Text = "Time to turn the heat up to full blast, isn't that right, dearie?" },
			},
			HestiaChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0016",
					
					Text = "Got another little warm-up for you right here, hot stuff!" },
			},
			HestiaChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0017",
					
					Text = "Must be cold down in your whereabouts... but not for long!" },
			},
			HestiaChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0018",
					
					Text = "I'm here again, dearie, so cozy up as we're about to have a real {#Emph}blast!" },
			},
			HestiaChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0019",
					
					Text = "This old flame can never be put out, and don't you forget it, dearie!" },
			},
			HestiaChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0020",
					
					Text = "{#Emph}Oh{#Prev}, if I could only roast more of our blasted enemies myself!" },
			},
			HestiaChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0021",
					
					Text = "Warmest wishes to you, dearie, and a little something extra on the side!" },
			},
			HestiaChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0022",
					Emote = "PortraitEmoteCheerful",
					
					Text = "Some evening, mayhaps you'll settle down to a nice comfortable life, but {#Emph}ohh{#Prev}, not tonight!" },
			},
			HestiaChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0023",
					
					Text = "Sacrifices sometimes must be made, dearie. So round them up and put them to the flame!" },
			},
			HestiaChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0024",
					Emote = "PortraitEmoteFiredUp",
					Text = "We're in for a {#Emph}hot one {#Prev}this evening, oh I can already tell!" },
			},
			HestiaChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0025",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 3.8 },
					
					Text = "You burn proper hot even without my aid, but {#Emph}with {#Prev}it, {#Emph}oh, hohoho!" },
			},
			HestiaChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0026",
					
					Text = "What's cooking there this eve, dearie? Whatever we damn well please, that's what!" },
			},
			HestiaChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0027",
					
					Text = "Well now I reckon it's time to fan the flames a bit, isn't it then?" },
			},
			HestiaChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0028",
					
					Text = "I've been cooking up a little something special just for {#Emph}you{#Prev}, hot stuff!" },
			},
			HestiaChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0029",
					
					Text = "Is something burning over there, dearie? Well it's about to be!" },
			},
			HestiaChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0030",
					
					Text = "Let's keep that everlasting flame alive and well, what say you, hot stuff?" },
			},
			HestiaChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0031",
					
					Text = "Well at least we're living in exciting times, I'll give us that!" },
			},
			HestiaChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0032",
					
					Text = "What say we add a little fuel to this fire we've got going, why don't we?" },
			},
			HestiaChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0208",
					Text = "If mortals can't be having cozy-time, then I've a mind to say, {#Emph}nobody {#Prev}shall!" },
			},
			HestiaChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0209",
					Text = "We could be sitting comfortable beside a fire sipping Nectar or somesuch, but {#Emph}no!" },
			},
			HestiaChat33 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0210",
					Text = "You're always dressed for warmer temperatures full knowing that Great-Auntie won't be far!" },
			},
			HestiaChat34 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0211",
					Text = "Time we start cooking again, hot stuff, while the night's still young and all!" },
			},
			HestiaChat35 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0212",
					Text = "What say we light up the night, dearie, using whichever kindling is at hand?" },
			},
			HestiaChat36 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0214",
					Text = "I've seen an awful lot in my time, but all this lately, got to say it's a bit new!" },
			},
			HestiaChat37 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0215",
					Text = "Never let that fire in your gut go out, dearie, but don't let it burn too hot either!" },
			},
			HestiaChat38 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0216",
					Text = "Don't let any of this get to you as it'll all blow over soon enough, always does." },
			},
			HestiaChat39 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0219",
					Emote = "PortraitEmoteFiredUp",
					Text = "Time again to let the sparks fly, {#Emph}eh? Oh {#Prev}I'm ready whenever you are!" },
			},
			HestiaChat40 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hestia_0218",
					Text = "Heading to our mountain's tippy-top again? Then let's make sure you don't catch cold." },
			},

		},

		BoughtTextLines =
		{
			HestiaBlindBox01 =
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
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0169",
					Emote = "PortraitEmoteFiredUp",
					Text = "Having my Boon just stuffed into some unmarked sack, I {#Emph}swear! {#Prev}Halfway surprised it didn't burn right through. Sometimes it isn't easy getting hold of you, you know!" },
			},
			HestiaBlindBox02 =
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
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaBlindBox01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0244",
					Text = "You probably could tell this was my Boon from all the heat must have been wafting from the parcel there! Surprised it didn't burn right up!" },
			},
			HestiaLootBought01 =
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
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0121",
					Text = "You must have had an excess of those golden coins that Chronos strewed across the land. To tempt the greediest of mortals, I suppose! Or the poorest. Not for me to judge!" },
			},
			HestiaLootBought02 =
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
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0122",
					Text = "That Boatman's good at taking messages, isn't he? Almost like taking corpses down into the Underworld like he used to. {#Emph}Eh{#Prev}, nothing to do for those these days... except to {#Emph}burn!" },
			},
			HestiaLootBought03 =
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
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0123",
					Text = "You really have to pay that Charon character in these situations! What sort of daft system is {#Emph}that? {#Prev}What, no blessings for the poor? Doesn't seem fair at all." },
			},
			HestiaLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0124",
					Text = "My blessing made it all that way on just a rickety old wooden ferryboat? Must be a litany of fire-safety hazards there, although plenty of water near with which to put them out." },
			},
			HestiaLootBought05 =
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
						Path = { "UseRecord", "HestiaUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0168",
					Text = "What, that ferryman having a fire sale there? Don't want you paying an exorbitant amount! Not that there ought to be a price on blessings, anyhow." },
			},

		},

		RejectionTextLines =
		{
			HestiaRejection01 =
			{
				{ Cue = "/VO/Hestia_0125",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Has old Hecate not taught you to respect the elderly a little more than {#Emph}that? {#Prev}Well, here's a quick lesson for ya!" },
			},
			HestiaRejection02 =
			{
				{ Cue = "/VO/Hestia_0126",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Won't do for all the rest taking old Hestia for a pushover in matters such as this. So I've got to burn you up a bit!" },
			},
			HestiaRejection03 =
			{
				{ Cue = "/VO/Hestia_0127",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Don't want my blessings while they're good and hot, do ya? Then {#Emph}this {#Prev}ought to warm you up in the meantime." },
			},
			HestiaRejection04 =
			{
				{ Cue = "/VO/Hestia_0128",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Not really mad at you, dearie! But I don't have the energy right now to go against the daft traditions that we have." },
			},
			HestiaRejection05 =
			{
				{ Cue = "/VO/Hestia_0129",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "{#Emph}Eh{#Prev}, a right good burn like that deserves another. Only fair, don't you agree, hot stuff?" },
			},
			HestiaRejection06 =
			{
				{ Cue = "/VO/Hestia_0130",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Just look at the {#Emph}bickering{#Prev}, sorry mess we've become! But we've all got to pull our weight, don't we?" },
			},
			HestiaRejection07 =
			{
				{ Cue = "/VO/Hestia_0131",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Here I was trying to lend a helping hand, but {#Emph}no! {#Prev}Somebody's always getting in my way. Well I {#Emph}won't {#Prev}have it!" },
			},
			HestiaRejection08 =
			{
				{ Cue = "/VO/Hestia_0132",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Come on now, even mortals know it's best to honor dear old Hestia first and foremost when it comes to such things!" },
			},
			HestiaRejection09 =
			{
				{ Cue = "/VO/Hestia_0133",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Gave up the Boon of Hestia, did ya? Well then how about a quick reminder of the proper way to make a sacrifice!" },
			},
			HestiaRejection10 =
			{
				{ Cue = "/VO/Hestia_0134",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Try as I might, I cannot help feeling a little miffed at that! And I am not someone to simply let it slide..." },
			},
			HestiaRejection11 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HeraUpgrade", "DemeterUpgrade" },
					},
				},
				{ Cue = "/VO/Hestia_0264",

					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Hestia_Displeased_01",
					Text = "Now where do you get off picking one of my younger sisters over me, {#Emph}eh?" },
			},

		},

		RejectionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "GodRejectedVoiceLines" },
		},

		MakeUpTextLines =
		{
			HestiaMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0135",
					Text = "That there is what I call the {#Emph}first {#Prev}degree. Like letting you off with a {#Emph}little {#Prev}warning!" },
			},
			HestiaMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0136",
					Text = "I like you, dearie. So I'm not going to turn you to ash {#Emph}this {#Prev}time. But later down the line, no guarantees." },
			},
			HestiaMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0267",
					Text = "So you got yourself a slap on the wrist! Might want to pour some nice cool water over that." },
			},
			HestiaMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0138",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Eh{#Prev}, you're all right, and {#Emph}I {#Prev}am now all right, so I suppose that {#Emph}everything's {#Prev}all right." },
			},
			HestiaMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0139",
					Text = "Fine, no need to get all hot and bothered for too long about this sort of thing. So let's just carry on!" },
			},
			HestiaMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0140",
					Text = "Got just a little steamed back there, but I am back to my usual quite irritable self, thank you!" },
			},
			HestiaMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0141",
					Text = "Well, there we go again! You know they take me for the calm and peaceful one around here?" },
			},
			HestiaMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0142",
					Text = "Play with fire and you get yourself burned! It's just as simple as that unless I say otherwise." },
			},
			HestiaMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0143",
					Text = "All right, all right, let's just cool off a bit before these flames of mine get {#Emph}way {#Prev}out of control..." },
			},
			HestiaMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hestia_0144",
					Text = "I like a lass who knows how to snap back! Don't ever let anybody up here push you around." },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			HestiaGift01 =
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
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0951", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Dear Goddess Hestia, I hope you will accept this offering. It's a pleasure to have met someone with your warmth, wisdom, and strength." },
				{ Cue = "/VO/Hestia_0068",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteCheerful",
					Text = "Well look at you, making me offerings! Such hospitality, and while I'd throw most customs to the flames, the old exchange of gifts is one that I don't mind. So here, something from me." },
			},
			HestiaGift02 =
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
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0952", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Please accept this, Great-Aunt Hestia! Your generous support means a lot to me. I know there's so much I can learn from you." },
				{ Cue = "/VO/Hestia_0069",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Come on now, I've nothing much to teach. You seem a recluse much the same as I, besides, although a looker still. But it's been nice to have made your acquaintance." },
			},
			HestiaGift03 =
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
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0953", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Great Hestia, goddess of hearth and flame! May your spark burn always as brightly. You've helped me so much on my way!" },
				{ Cue = "/VO/Hestia_0070",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Why, thank you for that, dearie, you're too kind. Mortals were so convinced I only liked {#Emph}burnt {#Prev}offerings, they never gave me good stuff such as this." },
			},
			HestiaGift04 =
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
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2244", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "A tribute for dear Lady Hestia! Your bright flames are a guiding light, and bane to all our enemies. Though your keen wisdom and fiery spirit spur me on at least as much!" },
				{ Cue = "/VO/Hestia_0159",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "No use buttering me up, you know. What, you think I'm going to withhold the best I've got unless you pay me some nice compliment? I can be petty, sure, but not {#Emph}that {#Prev}petty!" },
			},
			HestiaGift05 =
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
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2245", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "If I'm to take another Boon of yours, Great Aunt, I bid you take another offering of Nectar from me! How you can carry yourself with such ease inspires me. If I could become more like you some ages hence, I would be very fortunate." },
				{ Cue = "/VO/Hestia_0160",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteSurprise",
					Text = "You want to be like {#Emph}me? {#Prev}Now {#Emph}that's {#Prev}a first! What I wouldn't give to turn back time and have another go at things, knowing what I do now. Though come to think, we plan to turn back Time, don't we?" },
			},
			HestiaGift06 =
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
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2246", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Grand Auntie Hestia! More and more I wonder what would it have been like if you were always in my life. Perhaps I would have grown up quicker of wit? Or happier! May we yet get to know each other like we knew each other all along!" },
				{ Cue = "/VO/Hestia_0161",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I never wanted kids, you know, dearie. And you're not about to make me second-guess what's more than probably the smartest choice I ever made, mouthing off to me the way you did just then! Now {#Emph}take {#Prev}your blasted Boon and off with you!" },
			},
			-- bond forged
			HestiaGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_HestiaGiftHint01",
				CompletedHintId = "Codex_BondForgedHestia",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HestiaGift06", "HestiaAboutCosmetics02" },
					},
				},
				{ Cue = "/VO/MelinoeField_4346", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "It must have been you who inspired me to make a warm and happy home, Great-Auntie! This Ambrosia, in turn, is for sharing with all those who make your own home feel safe and comforting, the way I feel whenever you call." },
				{ Cue = "/VO/Hestia_0241",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteCheerful",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Hestia_01", Icon = "Keepsake_Hestia" },

					Text = "{#Emph}Oh {#Prev}this is right sweet of you, dearie, and you're on to something there! So many want to be famous or successful and such, but to be safe and comfortable? Nothing beats that, and I know you know. {#Emph}May you be always." },
			},

		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1737", Text = "Something from Great-Auntie Hestia..." },
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
				Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "HestiaUpgrade" },
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

				{ Cue = "/VO/Hestia_0078", Text = "What say we turn up the heat?!" },
				{ Cue = "/VO/Hestia_0079", Text = "They'll burn!" },
				{ Cue = "/VO/Hestia_0080", Text = "Flames take them all!", PlayFirst = true },
				{ Cue = "/VO/Hestia_0268", Text = "Get warm and cozy, everyone!" },
				{ Cue = "/VO/Hestia_0269", Text = "Here's a little warm-up for ya!" },
				{ Cue = "/VO/Hestia_0270", Text = "Oh, {#Emph}now {#Prev}we're cooking!" },
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "HestiaUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Hestia_0271", Text = "Oh {#Emph}now {#Prev}you're cozying up?" },
				{ Cue = "/VO/Hestia_0272", Text = "You're playing with fire, dearie!", PlayFirst = true },
				{ Cue = "/VO/Hestia_0273", Text = "Good burn, hot stuff!" },
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

				{ Cue = "/VO/Chronos_1267", Text = "You dusted off old {#Emph}Hestia!", PlayFirst = true },
				{ Cue = "/VO/Chronos_1268", Text = "Seems rather warm in here...!" },
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

				{ Cue = "/VO/Zagreus_0366", Text = "Lady Hestia?!", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0367", Text = "Hestia, don't...!" },
			},
		},

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.25,
			NoTarget = true,
			Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },

			{ Cue = "/VO/Hestia_0100", Text = "I don't take kindly to such acts." },
			{ Cue = "/VO/Hestia_0101", Text = "Trifle with me, and you'll get burned.", PlayFirst = true },
			{ Cue = "/VO/Hestia_0099", Text = "Who do you take me for?" },
			{ Cue = "/VO/Hestia_0170", Text = "Don't play with fire if you know what's good for ya." },
			{ Cue = "/VO/Hestia_0171", Text = "I'm long since done being a pushover, dearie!" },
			{ Cue = "/VO/Hestia_0172", Text = "Looks like I cooked you for a bit too long, hot stuff..." },
		},

		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
				},

				{ Cue = "/VO/Hestia_0084", Text = "{#Emph}Hah! {#Prev}Fine." },
				{ Cue = "/VO/Hestia_0085", Text = "{#Emph}Eh{#Prev}, all right!" },
				{ Cue = "/VO/Hestia_0173", Text = "Sure!" },
				{ Cue = "/VO/Hestia_0174", Text = "There!" },
				{ Cue = "/VO/Hestia_0175", Text = "Heated up!" },
				{ Cue = "/VO/Hestia_0176", Text = "Fine!" },
				{ Cue = "/VO/Hestia_0177", Text = "Easy." },
				{ Cue = "/VO/Hestia_0178", Text = "Ready!" },
			},
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },
			TriggerCooldowns = { "HestiaBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Hestia_0081", Text = "{#Emph}Oh{#Prev}, there she is!" },
			{ Cue = "/VO/Hestia_0082", Text = "Auntie Hestia's arrived!" },
			{ Cue = "/VO/Hestia_0083", Text = "What's cooking?" },
			{ Cue = "/VO/Hestia_0096", Text = "From me to you!" },
			{ Cue = "/VO/Hestia_0097", Text = "Here's a little something!" },
			{ Cue = "/VO/Hestia_0183", Text = "Coming in hot!" },
			{ Cue = "/VO/Hestia_0184", Text = "Surprise!" },
			{ Cue = "/VO/Hestia_0185", Text = "Hullo, hot stuff!" },
			{ Cue = "/VO/Hestia_0186", Text = "{#Emph}Dearie!" },
		},

		Using = { ProjectileName = "HestiaBurnConsumeStrike", ProjectileName2 = "SteamBlast", ProjectileName3 = "HestiaSprintDefense", }, 
	},

}

OverwriteTableKeys( LootData, LootSetData.Hestia )