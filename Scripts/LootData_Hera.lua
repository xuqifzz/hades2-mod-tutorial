LootSetData.Hera =
{
	-- Hera
	HeraUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
			},
			-- first appears in Opening rooms; additional requirements in RoomDataF/N ForcedRewards table
		},
		UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = true,
		Weight = 10,
		BoonInfoIcon = "BoonInfoSymbolHeraIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_HeraUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_HeraUpgrade",
		LootRejectedText = "Player_GodDispleased_HeraUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_HeraUpgrade",
		Icon = "BoonSymbolHera",
		DoorIcon = "BoonDropHeraPreview",
		DoorUpgradedIcon = "BoonDropHeraUpgradedPreview",
		Color = { 64, 120, 255, 255 },
		LightingColor = { 0, 139, 95, 255 },
		LootColor = {32, 128, 255, 255},
		SubtitleColor = Color.HeraVoice,
		EmoteOffsetY = -280,
		EmoteOffsetX = 30,
		SpeakerName = "Hera",
		LoadPackages = { "Hera", },
		ColorGrade = "ZeusLightning",
		LootRejectionAnimation = "BoonDissipateA_Zeus",
		SpawnSound = "/SFX/HeraBoonChoirQuake",
		PortraitEnterSound = "/SFX/HeraBoonChoirQuake",
		UpgradeSelectedSound = "/SFX/HeraBoonChoice",

		Speaker = "NPC_Hera_01",
		Portrait = "Portrait_Hera_Default_01",
		WrathPortrait = "Portrait_Hera_Default_01_Wrath",
		OverlayAnim = "HeraOverlay",
		Gender = "Female",
		FlavorTextIds =
		{
			"HeraUpgrade_FlavorText01",
			"HeraUpgrade_FlavorText02",
			"HeraUpgrade_FlavorText03",
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
			{ Cue = "/VO/MelinoeField_1749", Text = "The Crest of the Queen..." },
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

			{ Cue = "/VO/Melinoe_1472", Text = "It's her." },
			{ Cue = "/VO/Melinoe_1473", Text = "Queen Hera...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1749", Text = "The Crest of the Queen..." },
			{ Cue = "/VO/MelinoeField_3123", Text = "Queen Hera...!" },
		},

		PriorityUpgrades = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
		WeaponUpgrades =
		{
			"HeraWeaponBoon",
			"HeraSpecialBoon",
			"HeraCastBoon",
			"HeraSprintBoon",
			"HeraManaBoon",
		},
		Traits =
		{
			"DamageShareRetaliateBoon",
			"LinkedDeathDamageBoon",
			"BoonDecayBoon",
			"DamageSharePotencyBoon",
			"SpawnCastDamageBoon",
			"CommonGlobalDamageBoon",
			"OmegaHeraProjectileBoon",

			-- Elemental
			"ElementalRarityUpgradeBoon", 

			-- Legendary
			"AllElementalBoon",

			-- Duos
			"SuperSacrificeBoonHera",
			"MoneyDamageBoon",
			"KeepsakeLevelBoon",
			"RaiseDeadBoon",
			"ManaRestoreDamageBoon",
			"CharmCrowdBoon",
			"ManaShieldBoon",
			"BloodRetentionBoon",
		},
		Consumables = { },

		UpgradeMenuOpenVoiceLines =
		{
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
		},

		DuoPickupTextLines =
		{
			HeraWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SuperSacrificeBoonHera" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0097",
					Text = "{#Emph}Ah! {#Prev}Look, my dear! It's my beloved husband. The distinguished {#Emph}King of the Olympians{#Prev}, who shall lead us all out of this mess. How goes it, Son of Chronos, any news?" },
				{ Cue = "/VO/Zeus_0098",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh, {#Emph}hahaha! {#Prev}Come now, Hera dear, for all your jesting with me, it can send the wrong impression to one unaccustomed to your dry and clever wit! You see that, Melinoë? Humor is the bond that makes a marriage strong!" },
			},

			HeraWithZeus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SuperSacrificeBoonHera" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0099",
					Text = "Our family's unity does not come cheap. We all must work together to ensure the bonds connecting us don't fray, or split entirely as was the case with Chronos. My Lord Husband knows this better than anyone, don't you, Zeus?" },
				{ Cue = "/VO/Zeus_0154",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "You're quite right, Dear, that marriage can most certainly begin to feel like work! It was so easy for us in the early days, but our responsibilities have grown since, haven't they?" },
			},

			HeraWithPoseidon01 =
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
				{ Cue = "/VO/Hera_0101",
					Text = "A shame you never knew your father, girl... but at least now you know his good brother Poseidon, here! Imagine this one, but without the foolish grin, nor the inappropriate remarks, with frankly better hair, in finer physical form." },
				{ Cue = "/VO/Poseidon_0268",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah, hahaha! {#Prev}See how strong a family we are, my niece?! For even in the face of such catastrophe as we have all endured, the Queen herself is able to make such humorous remarks! At my expense. But {#Emph}still!" },
			},

			HeraWithApollo01 =
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
				{ Cue = "/VO/Hera_0103",
					Text = "I fear for the younger generation. What can you possibly achieve when you're born with our worst qualities and not merely our best? Take good Apollo here... just like his father." },
				{ Cue = "/VO/Apollo_0094",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Text = "Now, Stepmother, don't all we gods aspire to your husband's excellence? I do appreciate the kind comparison! My fair cousin likewise surely has her father's finest traits!" },
			},

			HeraWithDemeter01 =
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
				{ Cue = "/VO/Hera_0107",
					Text = "Much as your father was custodian of all the dead, so are we responsible for the rest of the world! The hour has grown dark, yes, but... we have the power to {#Emph}restore. {#Prev}Thanks be to my good sister Demeter..." },
				{ Cue = "/VO/Demeter_0102",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "The time for restoration always comes as does the spring. But we're amidst a long winter, without an end in sight. We need concern ourselves with naught else, O Queen." },
			},

			HeraWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "CharmCrowdBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0109",
					Text = "Even Titans and gods are quite vulnerable creatures, deep down. For we are all driven by a most-delicate instrument, as liable to stir our spirits or drive us to despair, as my dear Aphrodite knows full well." },
				{ Cue = "/VO/Aphrodite_0143",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Text = "Come now, my Queen! The heart's the strongest part we've got and tougher than it seems! We've withstood a bit upon this mountaintop, but we can take much more. Especially when our hearts {#Emph}all {#Prev}beat as one!" },
			},

			HeraWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ManaShieldBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0111",
					Text = "I know full well we cannot stand on ceremony whilst our entire way of life is under threat! Yet surely my dear son Hephaestus here need not be so {#Emph}uncouth {#Prev}at every opportunity?" },
				{ Cue = "/VO/Hephaestus_0122",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Text = "Not like you ever taught me proper manners, Mum. Fortunately, I did learn a couple things even without having a role model like you or Dad around to set me straight! Just {#Emph}watch{#Prev}. And witchie, too!" },
			},

			HeraWithHestia01 =
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
				{ Cue = "/VO/Hera_0105",
					Text = "We goddesses can be too proud to beg for aid! I'd never stoop to it myself. Why bother, when my hard-headed sister Hestia shall insist on intervening, anyway? And at this very moment {#Emph}whilst I speak!" },
				{ Cue = "/VO/Hestia_0148",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Text = "Because, respectfully, you just don't know what's {#Emph}good {#Prev}for you, O Queen! Sometimes it's ones can't bring themselves to ask for help that need it {#Emph}most! {#Prev}Now why don't we set a {#Emph}proper {#Prev}example for the latest unceremonious addition to our family?" },
			},

			HeraWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BloodRetentionBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0242",
					Text = "At least Lord Ares is back to where it's {#Emph}easier {#Prev}for me to keep an {#Emph}eye {#Prev}on him. Come, my son, let's make ourselves somewhat presentable? For the benefit of my niece there." },
				{ Cue = "/VO/Ares_0157",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "It shall be as you wish, O Queen. I'm honored that you sought me out, and trust our kin shall be most grateful to you in turn, as the vessel of the sum of our wrath." },
			},

		},

		InteractTextLineSets =
		{
			HeraFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HeraFirstPickUpAlt" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				{ Cue = "/VO/Melinoe_0170", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.2, PowerWordPresentation = true, PowerWordWaitTime = 3.7 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "The family stands united in our cause... {#Emph}In the name of Hades! Olympus, I accept this message!{#Prev}" },
				{ Cue = "/VO/Hera_0081",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Text = "Pleased to make your acquaintance finally, my dear! Already had enough of the surface, yes? {#Emph}Heh{#Prev}, well I promised the family that once you demonstrated your resolve to us, I'd take you under my wing. And I {#Emph}always {#Prev}keep my vows." },
			},
			HeraFirstPickUpAlt =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HeraFirstPickUp" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Melinoe_0170", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 3.7 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "The family stands united in our cause... {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Hera_0080_B",
					PortraitExitWait = 1.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Text = "Pleased to make your acquaintance finally, my dear! Welcome to our world's surface, such as it is. I promised the family that once you demonstrated your resolve to us, then I'd take you under my wing... and, I {#Emph}always {#Prev}keep my vows." },
			},

			-- low health
			HeraLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0072",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "{#Emph}Oh! {#Prev}You're a frightful mess, if you'll forgive my saying, girl! I can't help you when you're practically dead! At least, not very much." },
			},
			HeraLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HeraGift06" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0073",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "What happened to all your lifeblood? That's precious stuff! Yet you've gone spilling it about, then have the {#Emph}nerve {#Prev}to thus present yourself to me." },
			},
			HeraLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0182",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "However much you've trained, it evidently was not {#Emph}nearly {#Prev}enough, if you've {#Emph}already {#Prev}taken such a {#Emph}beating {#Prev}before I can even begin to protect you!" },
			},
			HeraLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0183",
					Text = "Not having a good night...? Your injuries will heal eventually, my dear. But, I can't make any promises about your pride." },
			},

			-- run starts
			HeraRunStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0093",
					Text = "Each night presents to us a new beginning, isn't that so, my dear? And on {#Emph}this {#Prev}night, {#Emph}I {#Prev}shall accompany you from the very start... until the bitter end." },
			},
			HeraRunStartSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0094",
					Text = "Your Underworld has long since fallen, but our Olympus yet stands; you're wise to head this way, where you can make a {#Emph}real {#Prev}difference, here and now. As {#Emph}I {#Prev}shall momentarily!" },
			},
			HeraRunStartSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0181",
					Text = "A single, capable combatant striking our enemies from their exposed flanks may be {#Emph}just {#Prev}what we require to drive them back. Looks like {#Emph}you're {#Prev}up for the job tonight!" },
			},
			HeraAboutRouteChoice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutRouteChoice01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0095",
					
					Text = "My husband Zeus and I have {#Emph}spirited {#Prev}debates regarding how you may ensure our victory. He is too proud to seek your help here on our mountaintop, whilst I would welcome it with open arms, so... come along!" },
			},

			HeraRunStartUnderworld01 =
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
				{ Cue = "/VO/Hera_0180",
					Text = "Your descent into the Underworld has only begun, but I would join you from the very first steps. I'd far prefer it to all my other obligations put together, let me tell you!" },
			},
			HeraAboutSwitchToUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 3,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0292",
					Text = "{#Emph}Ah{#Prev}, good girl, to have turned your attention to the Underworld at last! It's so humiliating all that's happened to us here. Least we can do is clean up after ourselves." },
			},

			-- story events
			HeraAboutMeeting01 = 
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0079",
					Text = "{#Emph}Ah! {#Prev}There you are {#Emph}again{#Prev}, my dear! Pity to have only met in circumstances such as these. Yet families all go through their ups and downs, yes? Let me help you help us all." },
			},

			HeraAboutMission01 = 
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0078",
					Text = "To level with you, girl, I don't know that you've got what it takes to thwart the Titan. But, what choice do we have at this point? I'm willing to give you the benefit of the doubt." },
			},

			HeraAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift02" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0035",
					
					Text = "{#Emph}Ah{#Prev}, your poor father. You must have been the jewel in his eye, only to have been ripped away! He would have been so very proud. Well, perhaps not {#Emph}proud{#Prev}, as such. He was never big on taking pride in anything, now that I think on it. {#Emph}I'm {#Prev}proud of you, at least!" },
			},

			HeraAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0084",
					
					Text = "This is hardly the first time I've been pressed to intervene on {#Emph}your {#Prev}side of the family's behalf. I've stood my ground! We cannot keep getting involved in each other's affairs. Yet, if you've come to our defense, you're owed an exception..." },
			},
			HeraAboutFamily02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraAboutDevotionTest01", "HeraGift04" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0290",
					
					Text = "You've seen how we don't always get along, but once you've lived with this lot long enough, you'll be right there with us. Tolerance becomes a practiced skill! But we do love each other, by and large..." },
			},

			HeraAboutChildren01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift02" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0036",
					
					Text = "Oh, the blessings that my kin and I bestow, why... they're a bit like children, I suppose. You don't always get the kind you want, but if you're clever, you can make them work!" },
			},
			HeraAboutChildren02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift07" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0043",
					
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "I always wanted a little girl, you know? But I got Ares. Hephaestus. {#Emph}Eugh! {#Prev}Zeus' girls Athena and Artemis stay well afield of me, and Aphrodite, oh, she does what she wants. Some family we are." },
			},
			HeraAboutChildren03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift04" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0046",
					Emote = "PortraitEmoteCheerful",
					Text = "Our great big family, why, we would have been just a small fraction of the size, if not for my husband's escapades! So many delightful children in my life as a result." },
			},
			HeraAboutChildren04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift07" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0274",
					Text = "Ever think of having children of your own, my dear? If so, perhaps you're thinking twice after all {#Emph}this. {#Prev}But we shall need another generation soon enough! And it may as well come from good stock." },
			},

			HeraAboutCompliments01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift05" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "MorosGift08", "NemesisGift08", "ErisGift08", "IcarusGift08" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0275",
					Text = "Do find a mate who pays you proper compliments, girl! My Lord Husband, why, he calls me {#Emph}ox-eyed Lady Hera {#Prev}now and then! Says I've the big, beautiful eyes of a large {#Emph}bovine{#Prev}, ever the romantic that he is!" },
			},

			HeraAboutEternity01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0057",
					
					Text = "One thing I've learned, my dear, is that {#Emph}forever {#Prev}is a very long time. It seems to me that nothing {#Emph}truly {#Prev}lasts forever anymore. Perhaps that is why we find ourselves in this particular predicament." },
			},
			HeraAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0065",
					
					Text = "We had an obligation to your father here. Each mortal death adds to the population of the Underworld, after all! I tried to do my blasted part to curb the flow a bit. Have you any idea how onerous it is for mortals to give birth?" },
			},
			HeraAboutMortals02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0165",
					
					Text = "If ever you wondered whence came all the {#Emph}wretches {#Prev}in your Underworld, there are such mortals who see it as {#Emph}our {#Prev}responsibility to protect {#Emph}them! {#Prev}Can you believe it?" },
			},
			HeraAboutMortals03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0092",
					
					Text = "I hardly blame them but {#Emph}some {#Prev}mortals have grown skeptical about our governance. They have this newfangled idea of {#Emph}luck... {#Prev}strokes of fortune from thin air! Sheer {#Emph}mindless {#Prev}happenstance, not the work of gods or the Three Fates." },
			},
			HeraAboutMortals04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraGift04" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0241",
					Emote = "PortraitEmoteDepressed",
					Text = "Oh, mortalkind must take us for a pack of bickering fools, though they'd never admit it. We shall have to save face with them somehow. I'll ask that Demeter ensure more times of plenty are to come, and such." },
			},

			HeraAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0037",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Remember, girl, this world is ours by right. The Fates themselves decided it! Now Chronos seeks to overthrow our reign? He already had his opportunity to rule. There is no going back to how things were." },
			},
			HeraAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0038",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "The Titan Chronos is no father of mine. But your father sprang from him, as did my husband, and Poseidon as well. So, now we're all tied up in this little family affair!" },
			},
			HeraAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0039",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Would that I could put another arrow in between the eyes of Chronos again myself, but alas, you're closer and I'm stuck. Kill him for me, would you?" },
			},
			HeraAboutChronos04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0044",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "This matter with Chronos, it may seem unconscionable that a parent could resent their own children. But let me tell you, girl, there are moments when I {#Emph}almost {#Prev}sympathize." },
			},
			HeraAboutChronos05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosRevealFollowUp", "ChronosMeeting03", "ChronosPostBattleMeeting01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0066",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "I always knew Chronos would return. Zeus kept saying I was fearful over nothing! We buried the old wretch in the depths of Tartarus, after all. But he's a deathless Titan. {#Emph}Time{#Prev}, it seems, slipped through our fingers..." },
			},

			HeraAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "Q_Intro" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0168",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "It's blasted Typhon, girl! The worst monstrosity you can imagine. Chronos up and decided to wake him from his deathly slumber, and pointed him towards {#Emph}us! {#Prev}So what if we cannot die? Things can still be very bad for us..." },
			},
			HeraAboutTyphonW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0230",
					Text = "Old Typhon suffered a bit of a spill last night but already is beginning to stir, Hermes reports. His target clearly is our summit... if only he were as easy to thwart as to predict." },
			},
			HeraAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0231",
					Text = "You truly rid us of that {#Emph}blasted {#Prev}Typhon. Never have we faced such an overwhelming threat, and {#Emph}all {#Prev}we could do was keep him at bay! Now we have the upper hand again because of {#Emph}you{#Prev}, my dear." },
			},
			HeraAboutTyphonDeath02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraGift03", "HeraAboutTyphonDeath01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0291",
					Text = "Such power you possess, my dear... whatever it is you did to Typhon, that's a secret to be guarded well. We could keep it for you! Our vaults have never {#Emph}once {#Prev}been breached. Think on it, yes?" },
			},

			HeraAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0089",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "No surprise that Strife Incarnate recently decided to show up, as she is wont to do. Eris made good sport of us before! Must think we're fools and easy prey. You'll correct her, yes?" },
			},

			HeraAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "EnemyKills", "Prometheus" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = ">",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0163",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "First Chronos and now Prometheus are back to haunt us, all because we failed to get rid of them back when we had a chance. Who next, I wonder? You witches really need to come up with a means to dispense with immortals for good." },
			},
			HeraAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0273",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "My Lord Husband and Prometheus are not on, shall we say, the best of terms. And that Titan has made clear what he thinks of us goddesses and gods. Yet, now we're tolerating him, to clean the mess he helped create? Absurd..." },
			},

			HeraAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "HermesAboutFates01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				
				{ Cue = "/VO/Hera_0091",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "The Fates are gone, then, yes? According to Hermes? Quite the unfortunate turn of events if true. Well, if Chronos is bent on vengeance, it only makes sense that he would take it out on {#Emph}them{#Prev}, not just on {#Emph}us." },
			},
			HeraAboutFates02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZeusPalacePostTrueEnding01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0238",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "I'm to believe that Chronos {#Emph}truly doesn't {#Prev}know where he left the Three Fates? The {#Emph}weavers of destiny {#Prev}themselves, misplaced and forgotten like some {#Emph}trinkets! {#Prev}They're probably {#Emph}enjoying {#Prev}being rid of all of us." },
			},

			HeraAboutWitchcraft01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0050",
					
					Text = "I know something of witchcraft myself, girl. A subtle art, and therein lies its strength. Easy to disbelieve, or to dismiss as mere coincidence. But true power need not assert itself." },
			},

			HeraAboutReputation01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift05" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0162",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "We might not care for it but there's a certain power to being underestimated constantly. Right, girl? Let them think what they want; my blessings aren't merely for couples about to tie the knot. " },
			},

			HeraAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HeraFirstPickUpAlt" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0067",
					Text = "Welcome, my dear, to our world's surface! First time? It's a vast place! All sorts of different climates, mortal cultures, and the like. So don't let your first impression shake your faith; it isn't always such a disaster!" },
			},
			HeraAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0068",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "Mortals complained their city of Ephyra was forsaken by the gods, yet here we are! Ungrateful wretches. Not had many weddings of late. Not many funerals either... though, lots of death, destruction, and the like!" },
			},
			HeraAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0052",
					
					Text = "There are many potent reagents growing on the surface here, if you know where to look! Mere roots and flowers to the untrained eye, but in your hands, or better, in your cauldron? They'll have you working magick like never before." },
			},

			HeraPostTrueEndingAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 3,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0289",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "I don't see {#Emph}why {#Prev}you keep heading this way, when it's {#Emph}your {#Prev}Underworld that seems to need more help. The mountain's {#Emph}fine! {#Prev}Well mostly. Other than these remnant forces of the Titan ruffling our feathers still..." },
			},

			HeraAboutSurfaceSurvival01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0083",
					Text = "They said you weren't cut out for being aboveground! Some Underworld curse holding you back... I'd not believed the hearsay for a moment, and sure enough. Perhaps they merely fear your potential." },
			},

			HeraAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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
						PathFalse = { "GameState", "TextLinesRecord", "DemeterAboutSurfaceThreat01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0164",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "There was a recent rumbling about Olympus, which caused us some concern. A {#Emph}real {#Prev}rumbling, I mean! Even Poseidon was surprised at all the shaking. What, does Chronos mean to topple the entire mountain?" },
			},

			HeraAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0074",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "{#Emph}Eugh{#Prev}, I can barely reach you as it is within that murk, and you seem even farther away now. The very outskirts of your father's realm, is it? That's... not the customary path into the Underworld...." },
			},
			HeraAboutFields01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "H_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0090",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "You've seen the Mourning Fields within your Underworld, yes? A solid portion of the residents there are due to failed marriages... most typically their own. I bless each matrimony that I can, but it can only do so much." },
			},

			HeraAboutRelationships01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraGift06" },
					},
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "TextLinesChoiceRecord", "MorosBecomingCloser01" },
								IsAny = { "Choice_MorosAccept" },
							},
						},
						{
							{
								Path = { "GameState", "TextLinesChoiceRecord", "NemesisPostCombatBecomingCloser01" },
								IsAny = { "Choice_NemesisAccept" },
							},
						},
						{
							{
								Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01" },
								IsAny = { "Choice_ErisAccept" },
							},
						},
						{
							{
								Path = { "GameState", "TextLinesChoiceRecord", "IcarusBecomingCloser01" },
								IsAny = { "Choice_IcarusAccept" },
							},
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosBecomingCloser01",
							"NemesisPostCombatBecomingCloser01",
							"ErisBecomingCloser01",
							"IcarusBecomingCloser01",
						},
						Comparison = ">=",
						Value = 2,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HeraAboutRelationships02" }, Min = 3 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0085",
					
					Text = "Aphrodite has quite gleefully informed me that {#Emph}you {#Prev}and certain friends of yours have grown quite close. Well if one thing leads to another and you decide to make a serious commitment, I should be {#Emph}only {#Prev}too pleased to oblige!" },
			},
			HeraAboutRelationships02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift05", },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "MorosGift09", "NemesisGift09", "ErisGift09", "IcarusGift09" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosGift09",
							"NemesisGift09",
							"ErisGift09",
							"IcarusGift09",
						},
						Comparison = ">=",
						Value = 2,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HeraAboutRelationships01" }, Min = 3 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0249",
					Emote = "PortraitEmoteCheerful",
					Text = "A fine girl such as yourself must have suitors! Just don't be quick to wed if you can help it, yes? Mortals like to tie themselves down for the remainders of their lives but often barely manage it. And {#Emph}their {#Prev}lifetimes are nothing!" },
			},

			HeraAboutMarriage01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift04" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0045",
					
					Text = "I realize this may seem odd coming from me, my dear, but from one goddess to another: Do not rush into marriage! As much as it may seem a wondrous idea. Consider my example; and I'm the blasted goddess of marriage, herself!" },
			},

			HeraAboutZeusMarriage01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "HeraGift03", "ZeusGift03" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0041",
					
					Text = "For all his foibles, my husband makes a dangerous adversary. Why else do you think we've ruled for however many aeons it's been? Zeus doubtless has his enemies, but few are brave or misguided enough to let on." },
			},
			HeraAboutZeusMarriage02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "HeraGift05", "ZeusGift05" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0042",
					
					Text = "Lord Zeus and I, we've known each other for a time. A regular old married couple we are! And yet such awful things are often said of us. I try to brush it off! No couple is beyond reproach; certainly, not one that's survived as long as we." },
			},

			HeraAboutHyperion01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "HestiaFirstPickUp", "DemeterFirstPickUp", "HeraGift01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0040",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "My sisters Demeter and Hestia and I, our father was the Titan called Hyperion. {#Emph}Father {#Prev}by technicality at least. You don't hear much about {#Emph}him {#Prev}anymore! We should have dealt with Chronos just the same back when we had the chance." },
			},

			HeraUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						-- borderline...
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
				{ Cue = "/VO/Hera_0076",
					
					Text = "We saw reports suggesting that you made it to the lowest depths! I thought perhaps you had prevailed... though, not yet, it seems. A sign of progress, nonetheless! Press on." },
			},
			-- misnomer, no longer about clears
			HeraSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0077",
					
					Text = "You came closer than ever to our mountaintop! I hoped, perhaps, that we could meet at last, but... we've more pressing matters to attend to now, the both of us." },
			},

			HeraAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyRevenge" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0096",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "Something about this night feels very odd; and in my experience, such premonitions are {#Emph}never {#Prev}to be ignored. Perhaps the strange forces at work are merely due to your invocations! Just... do be careful, girl." },
			},
			HeraAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0278",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "This night has left me feeling ill-at-ease, for many of our enemies are growing rather bold. Mortals experience fear when their lives are at risk, but this cannot be {#Emph}that!" },
			},
			HeraAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 12,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0279",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "That fearsome feeling in the air, so then it {#Emph}is {#Prev}your doing, isn't it, girl? I fail to see how riling up our enemies shall do us {#Emph}any {#Prev}good. Now you go deal with them at once!" },
			},

			HeraAboutDevotionTest01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny =
						{
							"HeraRejection01",
							"HeraRejection02",
							"HeraRejection03",
							"HeraRejection04",
							"HeraRejection05",
							"HeraRejection06",
							"HeraRejection07",
							"HeraRejection08",
							"HeraRejection09",
							"HeraRejection10",
							"HeraRejection11",
							"HeraRejection12",
							"HeraRejection13",
							"HeraRejection14",
							"HeraRejection15",
						},
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0082",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "The other night, given the opportunity, you sided with my kin, forgoing my Boon when I first generously offered it. Whilst that little scuffle is behind us, I do {#Emph}not {#Prev}appreciate any such slights. I trust I've made myself quite clear?" },
			},

			HeraPostGift01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						-- borderline...
						-- PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0055",
					
					Text = "How fare you in your task of late, my dear? Much better than we fare up here, I hope. Oh, all of us are fine, except... being besieged does mean we're stuck in closer quarters than I'd like. There's not a moment's peace!" },
			},
			HeraPostGift02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0056",
					
					Text = "Take it from me, my dear, don't listen to your heart. I know it's difficult, seeing as the blasted thing tends to be very loud. But if you heed it, it'll lead you straight to your mistakes more often than not." },
			},

			-- legendary
			HeraLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0053",
					Emote = "PortraitEmoteCheerful",
					Text = "How about we break ourselves out of this rut, girl, so here! This is the best I've got for you for now. Do make the most of it?" },
			},
			HeraLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0054",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "My mood darkens again, my dear, although it makes me rather generous, I think. Here, then! The finest of my blessings. Go on, and tie some knots!" },
			},

			-- about characters
			HeraAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift04" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0049",
					
					Text = "The Witch of the Crossroads evidently raised you well! The younger generation here, they lack in character, and their manners oft leave {#Emph}much {#Prev}to be desired. Almost as though {#Emph}my {#Prev}generation did not set the best example!" },
			},

			HeraAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0047",
					
					Text = "Word reached me you've encountered mighty Heracles! Big, thick-headed fellow? You're not to aid him in his labors, do you understand? He's in the middle of what we Olympians like to call a {#Emph}journey of self-discovery." },
			},
			HeraAboutHeracles02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraAboutHeracles01" },
					},
					-- checking CurrentRun + PrevRun
					{
						SumPrevRuns = 2,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0048",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "That Heracles is Zeus' lad, you know. {#Emph}Glory of Hera! {#Prev}I should be honored. He's just another mouth for me to feed, and one with quite an appetite, at that. But, I'll keep him busy, sure! We need all the help we can get." },
			},
			HeraAboutHeracles03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusAboutHeracles01", "ZeusAboutHeracles02", "HeraAboutHeracles02", "HeraGift07" },
					},
					-- checking CurrentRun + PrevRun
					{
						SumPrevRuns = 2,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0246",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "You'd tell us if Heracles wasn't living up to expectations, yes? Confidentially, we're thinking once things finally settle down, we may invite him to join us on a more-permanent basis. He's labored enough, and we could use the muscle." },
			},

			HeraAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Boss01", "N_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0075",
					Portrait = "Portrait_Hera_Displeased_01",
					
					Text = "Confronted Polyphemus, have you, then? That is the sort of {#Emph}help {#Prev}Chronos employs. A hollow fool! But strong, admittedly. No sneaking past {#Emph}him{#Prev}, I'm afraid. We've tried...." },
			},

			-- about other gods
			HeraAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0059",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Ah! {#Prev}I see that my distinguished husband has already been in touch. Well, just in case he doesn't make the sparks fly in {#Emph}quite {#Prev}the manner you expect, I have something for you of my own." },
			},
			HeraAboutZeus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0060",

					Text = "Again, Lord Zeus has reached you first, has he? {#Emph}Heh. {#Prev}The noble Son of Chronos and his lightning speed! You can't imagine just how quickly he flees from {#Emph}me{#Prev}, sometimes." },
			},
			HeraAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0061",
					Text = "Had I but known that stout Poseidon went out of his way for you earlier, I would have got here even sooner. The sea is unreliable, whilst my bond is forever. Figuratively, at least!" },
			},
			HeraAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0135",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Cold vengeance... I can feel it from afar. I suppose my sister Demeter has more at stake in this than anybody on this mountaintop. Our enemies shall rue having crossed her." },
			},
			HeraAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0062",
					Text = "Golden Apollo already offered you his aid, has he now? Always so eager to please. I find his constant doting bothersome... but doubtless you're more tolerant than I." },
			},
			HeraAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0063",
					
					Text = "The goddess of love, always one step ahead of me. How many mortals do you suppose would seek me out to bless their wedding vows, had Aphrodite not already worked her {#Emph}charms {#Prev}on them? It seems our strengths go hand in hand." },
			},
			HeraAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0137",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "{#Emph}Augh{#Prev}, at least Hephaestus is {#Emph}attempting {#Prev}to be of use! You'll have to excuse my sheltered son, girl. He'd much prefer to clang ceaselessly upon his forge than to be a part of polite society." },
			},
			HeraAboutHephaestus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraGift03", "HephaestusGift03" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0287",
					Text = "My soft-spoken son Hephaestus thinks I can be rather {#Emph}too unkind. {#Prev}Perhaps he's right! What, you think my mother showered {#Emph}me {#Prev}with love? Neither {#Emph}you {#Prev}yours. This is a harsh world, girl. No one asks to be born into it." },
			},
			HeraAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0064",
					
					Text = "I'm pleased to see that you're agreeable with Hestia, my dear. Her temper and my own don't often mesh, but I respect her wisdom, and her power to simply burn everything down if and when necessary." },
			},
			HeraAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0271",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "Most all of us have a taste for violence, girl, but my son Ares takes it to a {#Emph}quite {#Prev}uncomfortable extreme. He may be useful in such times, but we mustn't let him get too excited." },
			},
			HeraAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						-- SumPrevRuns = 1 is the same as CurrentRun, SumPrevRuns = 2 is checking PrevRun, etc.
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Artemis_Field_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0282",
					Text = "We've sent young Artemis near to the border of your realm and ours. We require some additional awareness there, and you likely could benefit from a bit of covering fire. Sometimes I miss wielding a bow myself..." },
			},
			HeraAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0136",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Where is that {#Emph}Hermes {#Prev}when you need him, have you seen him lately, girl? Always {#Emph}flitting {#Prev}about, impossible to pin down. {#Emph}Eugh. {#Prev}What news could there be to deliver at a time like {#Emph}this?" },
			},
			HeraAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
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

				{ Cue = "/VO/Hera_0058",
					
					Text = "You know, I saw a flicker in the sky before, as though the moonlight shifted for a moment. But now it's like that light is shining from {#Emph}you. {#Prev}You drew Selene down! She would not answer such a call from most." },
			},
			HeraAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Athena_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0281",
					
					Text = "We've wise Athena holding back the front but probably could use a score of others {#Emph}equally {#Prev}as capable. She has the Titan's raiders running scared, but... even she can't always stop them all." },
			},

			HeraAboutPolymorph01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", },
						HasAny = { "SpellPolymorphTrait" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0184",
					
					Text = "You know the Twilight Curse, oh I can tell. The power to change a form into another! A favorite of mine, and one small step removed from shapeshifting oneself. The possibilities are limitless, really." },
			},

			HeraAboutBows01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0169",
					
					Text = "You seem adept at keeping distance from your enemies. I once excelled at this myself, although I favored an arrow through the heart over magick, which I found rather unreliable. But, whatever works for you!" },
			},

			HeraAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceHeraBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0247",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, if it isn't my Iridescent Fan, illuminated even in the night! The easier with which to spot you wheresoever you may be. Should you require my immediate assistance, merely wave it about a bit." },
			},

			HeraAboutHope01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift06" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0236",

					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					Text = "You always were one of the best hopes that we had in this, my dear. But frankly, I had little faith we would prevail, {#Emph}with {#Prev}you or without. So for this once, I'm pleased to have been wrong, and shall not soon forget all that you've done." },
			},

			HeraAboutPalace01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceFirstMeeting" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0229",
					Text = "Pleased to have finally met in a more-proper way, my dear! You bought this mountain of ours a bit of extra time, so we are bolstering our defenses as best we can... thus I'm beseeching you to hurry back!" },
			},
			HeraAboutPalace02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0235",
					Text = "{#Emph}Tsk{#Prev}, you never even got to see the Palace proper, my dear. It's not presentable anyhow. Perhaps by the time your father's House is back in order, ours shall be as well! I quite insist you visit at that point." },
			},
			HeraAboutLastResort01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HeraAboutTyphonDeath01" }, Min = 2 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0250",
					Text = "That last resort, which we would have used against Typhon, had you not found more of a targeted solution... merely something Hephaestus has been working on, halfheartedly. Would have cost my son his favored forge, and {#Emph}more!" },
			},

			HeraAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
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
				{ Cue = "/VO/Hera_0233",
					Text = "Headed down to check on your mother and father, my dear? The House of Hades probably could use your touch. If only my {#Emph}own {#Prev}children would be so considerate. Though, I suppose they are still aiding you..." },
			},
			HeraAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0234",
					Text = "Traveling this way {#Emph}again{#Prev}, are you, my dear? Doubtless to put the nonsensical theories of your Titan grandfather to the test! If you detect even a whiff of lies, do tell. Even if we're to be merciful, we still mustn't be fools." },
			},
			HeraAboutOlympus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 1,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0245",
					Text = "You've seen the state our poor mountain is in. The embarrassing inventions of Hephaestus run as rampant as our enemies! Some of us remain cooped up in the Palace of Zeus away from it all. Quite lovely here at least!" },
			},
			HeraAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0244",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Such a dreadful fleet that sails our way... when last I witnessed one of such magnitude, the ships were sailing in my honor, rather than against my home." },
			},

			HeraPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0232",
					Text = "My word, girl. To have delivered a groveling, impotent Chronos right into our hands, after having utterly destroyed Typhon... one astonishing feat after another, even for a goddess of your pedigree. How can we ever repay you?" },
			},
			HeraPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0239",
					Text = "The Fates are found! Such a relief our destinies are safely back in their hands. I was beginning to fear the course of our futures would forever be {#Emph}ours {#Prev}to decide. Perhaps once we're older, and more responsible." },
			},
			HeraPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0240",
					Text = "A new age is to dawn soon enough, is {#Emph}that {#Prev}it? That much, the Three Fates guarantee, but otherwise we can do as we please! Well, fine. If mortals think they can get on without {#Emph}our {#Prev}intervention, I should like to see them try!" },
			},
			HeraAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift07" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0251",
					Text = "Well, this {#Emph}has {#Prev}been a real journey, hasn't it, my dear? I may be briefer with you hence, as other matters increasingly demand my attention. Though, you'll have my blessings for as long as you require." },
			},
			-- repeatable lines
			HeraChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0004",
					
					Text = "A blessing for {#Emph}you{#Prev}, and a curse for our enemies, my dear." },
			},
			HeraChat02 =
			{
				GameStateRequirements =
				{
					{
						-- borderline
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0015",
					
					Text = "How odd that this conflict tearing us apart is bringing us closer together, {#Emph}hm?" },
			},
			HeraChat03 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0009",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "Chronos is an old fool whose time has long since passed." },
			},
			HeraChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0005",
					
					Text = "Surely one amongst my blessings ought to suit you well?" },
			},
			HeraChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0006",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Show no weakness, show no mercy, girl." },
			},
			HeraChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0007",
					Text = "Just look at us, girl! Our family's a mess, but we're making it work." },
			},
			HeraChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0008",
					
					Text = "Hera's here for you, girl; and soon, all your enemies shall wish that they were never born." },
			},
			HeraChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0010",
					
					Text = "Your Great Aunt's back, my dear, so let's have ourselves an interesting night." },
			},
			HeraChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0011",
					Text = "Nothing like jointly annihilating our enemies to bring the family closer together, {#Emph}hm?" },
			},
			HeraChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0012",
					
					Text = "Surprise, surprise, you're once again where I expected you to be." },
			},
			HeraChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0013",
					
					Text = "All right, girl, let's just have a look at you and see what we can do." },
			},
			HeraChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0014",
					Portrait = "Portrait_Hera_Displeased_01",			
					Text = "Perhaps our family deserves all this, though we'll keep fighting back against it nonetheless." },
			},
			HeraChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0016",
					
					Text = "To think all we needed was a perilous existential threat to unite this family, for once!" },
			},
			HeraChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0017",
					Text = "Chin up, girl! Things could probably end up much worse than they are now." },
			},
			HeraChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0018",
					
					Text = "Our family may be cursed by the Fates themselves, but we do know how to fight." },
			},
			HeraChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0019",
					
					Text = "We've so many enemies, I cannot curse them all! Though I {#Emph}can {#Prev}bless {#Emph}you." },
			},
			HeraChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0020",
					
					Text = "Care for a little power over life itself? Or death. I've got that, too." },
			},
			HeraChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0021",
					
					Text = "I confess I'm beginning to enjoy these little outings that we share." },
			},
			HeraChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift06", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0022",
					
					Text = "Raised in the Underworld, yet you've more poise and grace than the lot of them up here." },
			},
			HeraChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0023",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "More and more it seems you're just about the only one I can depend on lately, girl." },
			},
			HeraChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0024",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "I'm in a bit of a foul mood right now, so quickly choose, and go." },
			},
			HeraChat22 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift07" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0025",
					
					Text = "This little tradition of ours has become something I look forward to, dear girl." },
			},
			HeraChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0026",
					
					Text = "The Fates denied me any daughters, but at least they brought me you, my dear." },
			},
			HeraChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0027",
					
					Text = "Life has its wretched spans every so often, so the better times stand out." },
			},
			HeraChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0028",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "We on Olympus take our vengeance very personally, girl." },
			},
			HeraChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift05", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0029",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "Would that some others that I knew had even but a shred of your commitment." },
			},
			HeraChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0030",
					
					Text = "It simply is our lot to have to shoulder more than our fair share of any burden, girl." },
			},
			HeraChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0031",
					
					Text = "You've no idea how long it's been since I've depended upon anybody of our line." },
			},
			HeraChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0032",
					Portrait = "Portrait_Hera_Displeased_01",

					Text = "Our enemy has scorned us and we'll make him rue the very day, won't we?" },
			},
			HeraChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0033",
					
					Text = "I've enough power vested in me that I'm pleased to spare you some of it for now." },
			},
			HeraChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hera_0034",
					
					Text = "You have more royal bearing than I would have thought..." },
			},

		},

		BoughtTextLines =
		{
			HeraBlindBox01 =
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
						Path = { "UseRecord", "HeraUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0088",
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "We're not taking any chances, girl. For instance, we are {#Emph}not {#Prev}above having our blessings transported like common parcels, if in so doing, we ensure your victory and ours." },
			},
			HeraBlindBox02 =
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
						Path = { "UseRecord", "HeraUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0253",
					Text = "Admit it, girl! You would have taken any sort of blessing here and now, whether from {#Emph}me {#Prev}or any of my kin. Well as the Fates would have it, you're getting the very best." },
			},

			HeraLootBought01 =
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
						Path = { "UseRecord", "HeraUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0086",
					Text = "We've a long-standing partnership with your good boatman there. I bring mortals into being and marry them off after a bit, he takes them yonder to your realm! Or used to, anyway." },
			},
			HeraLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraLootBought01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "HeraUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0087",
					Text = "Wealth cannot be measured in mere coin! The very idea is absurd; yet, there you are, paying for goods and services as though Chronos has already prevailed!" },
			},
			HeraLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "HeraUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0178",
					Text = "We cannot always reach you in those depths, though your boatman seems to have no trouble at all. Keeps to himself, fends for himself... I quite like him!" },
			},
			HeraLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraLootBought01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "HeraUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0179",
					Text = "At least this was a shorter delivery for your trusted boatman, compared with having to drag our Boons all the way into the Underworld. Although, he probably prefers it there..." },
			},
		},

		RejectionTextLines =
		{
			HeraRejection01 =
			{
				{ Cue = "/VO/Hera_0113",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Need I remind you that I'm not particularly fond of those who turn their backs on me?" },
			},
			HeraRejection02 =
			{
				{ Cue = "/VO/Hera_0114",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "How {#Emph}disappointing {#Prev}yet how typical this is! Now it's my turn." },
			},
			HeraRejection03 =
			{
				{ Cue = "/VO/Hera_0115",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Whom do you take me for? You think I shall simply roll over and accept this?" },
			},
			HeraRejection04 =
			{
				{ Cue = "/VO/Hera_0116",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Perhaps you belong here on Olympus after all, showing such rudeness to me." },
			},
			HeraRejection05 =
			{
				{ Cue = "/VO/Hera_0117",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Beware of angering me thus, my dear. You'll find I have an {#Emph}excellent {#Prev}memory." },
			},
			HeraRejection06 =
			{
				{ Cue = "/VO/Hera_0170",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "You would be wise not to forget yourself with me. {#Emph}Here! {#Prev}Let me remind you." },
			},
			HeraRejection07 =
			{
				{ Cue = "/VO/Hera_0171",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "Deep down, I value dissenting voices and opinions, but outwardly... {#Emph}no." },
			},
			HeraRejection08 =
			{
				{ Cue = "/VO/Hera_0172",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "We must maintain decorum; neither can we tolerate such insubordination." },
			},
			HeraRejection09 =
			{
				{ Cue = "/VO/Hera_0173",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "If you insist on siding against me, then I insist on making {#Emph}you {#Prev}regret it." },
			},
			HeraRejection10 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "PoseidonUpgrade", "ApolloUpgrade" },
					},
				},
				{ Cue = "/VO/Hera_0118",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "We goddesses truly ought to be more committed to each other than {#Emph}this." },
			},
			HeraRejection11 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/Hera_0119",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "My husband is very accustomed to getting his way; you need not indulge him so." },
			},
			HeraRejection12 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Hera_0120",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "This swarthy son of mine is more a draw to you than I? {#Emph}Hahaha!" },
			},
			HeraRejection13 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/Hera_0254",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "When next my Husband and I have a little disagreement, {#Emph}side with me." },
			},
			HeraRejection14 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "AresUpgrade" },
					},
				},
				{ Cue = "/VO/Hera_0255",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "My warmongering son is likely to blame for all this, yet you choose {#Emph}him?" },
			},
			HeraRejection15 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "DemeterUpgrade", "HestiaUpgrade" },
					},
				},
				{ Cue = "/VO/Hera_0256",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Hera_Displeased_01",
					Text = "What my sister may lack for youth she makes up for with wisdom, is that it?" },
			},
		},

		RejectionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "GodRejectedVoiceLines" },
		},

		MakeUpTextLines =
		{
			HeraMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0125",
					Text = "Forgiveness is like a precious healing ointment, to be applied sparingly." },
			},
			HeraMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0126",
					Text = "Fine! That shall be all, I think. This type of squabble is beneath us both." },
			},
			HeraMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0127",
					Text = "You wish to test me, I shall test you back, my dear. Please, do remember that." },
			},
			HeraMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0128",
					Text = "{#Emph}Enough {#Prev}already! Here's a blessing that you could have had {#Emph}without {#Prev}a fight!" },
			},
			HeraMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0129",
					Text = "Your struggles only entertain me for so long. Begone already, girl." },
			},
			HeraMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0130",
					Text = "Look at us, bickering like an old married couple! What say we move on?" },
			},
			HeraMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0174",
					Text = "Consider yourself reprimanded, my dear. Know that you got off lightly this time." },
			},
			HeraMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0175",
					Text = "Oh, we've made enough enemies already that we {#Emph}hardly {#Prev}need more." },
			},
			HeraMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0176",
					Text = "We're royalty, my dear. We ought behave with a more-regal bearing, yes?" },
			},
			HeraMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0177",
					Text = "{#Emph}Tsk! {#Prev}We ought be forming strong alliances, not at each other's throats." },
			},
			HeraMakeUp11 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0257",
					Emote = "PortraitEmoteDepressed",
					Text = "Why are we fighting, blast? You truly {#Emph}are {#Prev}one of us to get such a rise out of me." },
			},
			HeraMakeUp12 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hera_0258",
					Text = "Well! Mustn't keep {#Emph}all {#Prev}our anger bottled up, yet always have some in reserve." },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			HeraGift01 =
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0506", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Queen Hera, out of all the matters you could be attending to, you've chosen to aid me. I am honored, and would honor you in kind." },
				{ Cue = "/VO/Hera_0069",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Is there a wedding date that I should know about or are you merely being generous with me? In any case, when I am offered to, there's always a catch. So, here!" },
			},
			HeraGift02 =
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0507", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Great Queen of Olympus! I am humbled to have earned your favor, and will do everything I can to honor you!" },
				{ Cue = "/VO/Hera_0070",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Unbound by wedlock yet you praise me thus? I must say you are full of surprises, my dear. Or potentially just very ignorant. Or both!" },
			},
			HeraGift03 =
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1771", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "This golden Nectar is nothing in comparison to your splendor, Queen Hera; but it's the very best we have where I am from. To your eternal beauty, grace, and wisdom!" },
				{ Cue = "/VO/Hera_0071",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "You needn't be a flatterer, you know? I aid you not from love but from necessity. If there's a lesson I can impart, it's that you ought to keep your guard up at all times." },
			},
			HeraGift04 =
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2241", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To the Queen of Olympus! Long may you reign, and may that reign be one of great prosperity and peace, both for your devoted family and subjects, and for you!" },
				{ Cue = "/VO/Hera_0134",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Go on, girl. We each know I'm not really your Queen. You're not even an Olympian, so why don't you drop the act? Or if it's not an act, wise up. This is a complicated world." },
			},
			HeraGift05 =
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2242", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Queen Hera, though these exchanges between us must necessarily be brief, I'm grateful for each moment you can spare. I know your family needs you, and Olympus needs you... and your devotion to each is abundantly clear." },
				{ Cue = "/VO/Hera_0166",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Well, my dear, if you find no future to be had in your witchcraft, you could always take up theatrics! For I very nearly believed your every word. Honesty is not our family's trade, but! I commend your effort anyhow." },
			},
			HeraGift06 =
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2243", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "You may not trust me at my word, O Queen; but with this offering of Nectar you shall find I bear no falsehoods or duplicitous intent. You're not just royalty to me... you're my Great Aunt. And as glorious as I could have imagined." },
				{ Cue = "/VO/Hera_0167",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "You're really serious, aren't you? Look, girl. You don't seem to understand what it's like on this mountain. There is no margin for error here; no room to slip! Although perhaps you've had a taste of that sort of {#Emph}pressure {#Prev}for yourself..." },
			},

			-- bond forged
			HeraGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_HeraDemeterGiftHint01",
				CompletedHintId = "Codex_BondForgedHera",
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
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraAboutHope01", "HeraGift06" },
					},
				},
				{ Cue = "/VO/MelinoeField_4166", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Thank you for holding our family together through the most trying of times, Queen Hera! And for having faith in me to make a difference. May the sweetness of this Ambrosia start to dull the memory of our bitter struggles." },
				{ Cue = "/VO/Hera_0237",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Hera_01", Icon = "Keepsake_Hera" },

					Text = "That's very kind of you, my dear. But my memory is {#Emph}long {#Prev}and {#Emph}sharp{#Prev}, and I'd not let it dull on purpose or otherwise. Our memories embolden us, and keep us from repeating our mistakes. Thank the Fates I was not mistaken about you." },
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/MelinoeField_0644", Text = "You truly needn't have, Your Majesty." },
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
				Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "HeraUpgrade" },
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

				{ Cue = "/VO/Hera_0131", Text = "I love a messy break-up!" },
				{ Cue = "/VO/Hera_0132", Text = "Behold the Queen's wrath!", PlayFirst = true },
				{ Cue = "/VO/Hera_0133", Text = "They'll wish they were never born!" },
				{ Cue = "/VO/Hera_0262", Text = "Rise and serve your mistress!" },
				{ Cue = "/VO/Hera_0263", Text = "The dead, be born again!" },
				{ Cue = "/VO/Hera_0264", Text = "Our family grows and grows!" },
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "HeraUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Hera_0259", Text = "You wish to toy with {#Emph}me, girl?", PlayFirst = true },
				{ Cue = "/VO/Hera_0260", Text = "We have a clever one in our midst!" },
				{ Cue = "/VO/Hera_0261", Text = "Well I don't see why {#Emph}not!" },
			},
			{
				RandomRemaining = true,
				ObjectTypes = { "NPC_Heracles_01", "Heracles" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Heracles_0541", Text = "The Queen...?" },
				{ Cue = "/VO/Heracles_0542", Text = "Queen Hera...!", PlayFirst = true },
				{ Cue = "/VO/Heracles_0543", Text = "Stepmother...!" },
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

				{ Cue = "/VO/Chronos_1255", Text = "That so-called {#Emph}Queen?!", PlayFirst = true },
				{ Cue = "/VO/Chronos_1256", Text = "My son's beloved wife?" },
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

				{ Cue = "/VO/Zagreus_0354", Text = "Was that the {#Emph}Queen?", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0355", Text = "Queen Hera...?" },
			},
		},

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
			PreLineWait = 1.25,
			NoTarget = true,

			{ Cue = "/VO/Hera_0121", Text = "You may be a princess; but remember, {#Emph}I {#Prev}am the Queen.", PlayFirst = true },
			{ Cue = "/VO/Hera_0122", Text = "In my position, a certain strictness is required I'm afraid." },
			{ Cue = "/VO/Hera_0123", Text = "We Olympians are famous for our wrath; we have to be." },
			{ Cue = "/VO/Hera_0124", Text = "I took little pleasure in this, girl. Merely a trace, at best." },
		},


		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
				},

				{ Cue = "/VO/Hera_0152", Text = "Splendid." },
				{ Cue = "/VO/Hera_0153", Text = "Very well." },
				{ Cue = "/VO/Hera_0154", Text = "So be it." },
				{ Cue = "/VO/Hera_0155", Text = "Granted." },
				{ Cue = "/VO/Hera_0156", Text = "Perfect!" },
				{ Cue = "/VO/Hera_0157", Text = "{#Emph}Ah{#Prev}, yes." },
				{ Cue = "/VO/Hera_0158", Text = "Then, here." },
				{ Cue = "/VO/Hera_0159", Text = "If you please." },
			},
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
			TriggerCooldowns = { "HeraBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Hera_0146", Text = "It is I." },
			{ Cue = "/VO/Hera_0147", Text = "Behold your Queen." },
			{ Cue = "/VO/Hera_0148", Text = "Good evening, my dear." },
			{ Cue = "/VO/Hera_0149", Text = "What a pleasant surprise!" },
			{ Cue = "/VO/Hera_0150", Text = "Why, hello." },
			{ Cue = "/VO/Hera_0151", Text = "Greetings, my dear!" },
		},

		SuperSacrificeVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
			TriggerCooldowns = { "HeraBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Hera_0265", Text = "Smart girl." },
			{ Cue = "/VO/Hera_0266", Text = "Good girl." },
			{ Cue = "/VO/Hera_0267", Text = "Sacrifices must be made!" },
			{ Cue = "/VO/Hera_0268", Text = "See that, Lord Husband?", PlayFirst = true },
		},
	},

}

OverwriteTableKeys( LootData, LootSetData.Hera )