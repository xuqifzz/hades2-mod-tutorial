LootSetData.Ares =
{
	-- Ares
	AresUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "AresFirstPickUp" },
			},
			-- first appears in Opening rooms; additional requirements in RoomDataF/N ForcedRewards table
		},

		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = true,
		Weight = 10,

		BoonInfoIcon = "BoonInfoSymbolAresIcon",
		Icon = "BoonSymbolAres",
		DoorIcon = "BoonDropAresPreview",
		DoorUpgradedIcon = "BoonDropAresUpgradedPreview",
		MenuTitle = "UpgradeChoiceMenu_Title_AresUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_AresUpgrade",
		LootRejectedText = "Player_GodDispleased_AresUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_AresUpgrade",

		SpawnSound = "/SFX/AresBoonBattle",
		PortraitEnterSound = "/SFX/AresBoonBattle",
		UpgradeSelectedSound = "/SFX/AresBoonChoice",

		Color = { 255, 0, 0, 255 },
		LightingColor = {255, 0, 0, 255},
		LootColor = {255, 0, 0, 255},
		SubtitleColor = Color.AresVoice,
		SpeakerName = "Ares",
		Speaker = "NPC_Ares_01",
		LoadPackages = { "Ares", },
		Portrait = "Portrait_Ares_Default_01",
		WrathPortrait = "Portrait_Ares_Default_01_Wrath",
		OverlayAnim = "AresOverlay",
		Gender = "Male",
		FlavorTextIds =
		{
			"AresUpgrade_FlavorText01",
			"AresUpgrade_FlavorText02",
			"AresUpgrade_FlavorText03",
		},
	
		PriorityUpgrades = 
		{ 
			"AresWeaponBoon", 
			"AresSpecialBoon", 
			"AresCastBoon", 
			"AresSprintBoon", 
			"AresManaBoon" 
		},
		WeaponUpgrades =
		{
			"AresWeaponBoon", 
			"AresSpecialBoon", 
			"AresCastBoon", 
			"AresSprintBoon", 
			"AresManaBoon" 
		},
		Traits =
		{ 
			"AresExCastBoon",
			"RendBloodDropBoon",
			"AresStatusDoubleDamageBoon",
			"BloodDropRevengeBoon",
			"MissingHealthCritBoon",
			"LowHealthLifestealBoon",
			"OmegaDelayedDamageBoon",
			-- Elemental
			"ElementalOlympianDamageBoon",

			-- Legendary
			"DoubleBloodDropBoon",
			
			-- Duos
			"SelfCastBoon",
			"AutoRevengeBoon",
			"BloodRetentionBoon",
			"RapidSwordBoon",
			"DoubleSplashBoon",
			"DoubleSwordBoon",
			"FireballRendBoon",
			"BloodManaBurstBoon",
		},
		Consumables = { },

		UpgradeMenuOpenVoiceLines =
		{
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
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
			{ Cue = "/VO/MelinoeField_2915", Text = "The warrior sigil..." },
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

			{ Cue = "/VO/MelinoeField_2918", Text = "The god of war..." },
			{ Cue = "/VO/MelinoeField_2919", Text = "Here for the violence..." },
			{ Cue = "/VO/MelinoeField_2920", Text = "Lord Ares...", PlayFirst = true },
		},

		DuoPickupTextLines =
		{
			AresWithZeus01 =
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
				{ Cue = "/VO/Ares_0079",
					Text = "Forgive me here, my kin, but my Lord Father and I, we were in the midst of a discussion that I felt ought not to wait... concerning what I learned whilst visiting more-distant lands." },
				{ Cue = "/VO/Zeus_0199",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "Oh calm yourself on that account, Ares! We had best deal with matters close to home prior to worrying about that which may be amiss in distant corners of the world! We'll deal with {#Emph}them {#Prev}in time." },
			},

			AresWithHera01 =
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
				{ Cue = "/VO/Ares_0156",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I wish never to burden my mother the Queen, so heavy is her crown; but she insists on being here, perhaps believing that my aid alone shall not suffice. Is that quite so, Mother?" },
				{ Cue = "/VO/Hera_0243",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "Spare me your concern, Ares, and whilst in company, address me not as {#Emph}Mother. {#Prev}If I cannot trust you with basic matters of decorum, whyever should I trust the efficacy of your {#Emph}blessings?" },
			},

			AresWithPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "DoubleSplashBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0081",
					Text = "Our Uncle Poseidon here tends to give counsel more than any of our kin, perhaps believing volume of advice is tied to quality. What ought to be our current course, Uncle?" },
				{ Cue = "/VO/Poseidon_0354",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Our current course ought to be straight toward our foes, where we can smash them like a tempest does a ship! {#Emph}Ah{#Prev}, but I feel all fired up and fit for battle! Come to think of it I always get this way when my good nephew Ares is around!" },
			},

			AresWithDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SelfCastBoon" },
					},
					{
						-- close enough. [gk]
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0162",
					Text = "I am impressed with how our great goddess of seasons here has taken to our war. The more personal we make it, the more bitterly we fight! Is that not so, dear Lady Demeter?" },
				{ Cue = "/VO/Demeter_0191",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "It was not I who made this personal, Ares. Perhaps if at some future point you have your own children and grandchildren taken from you, then you shall understand. For now, however... you need but to comply." },
			},

			AresWithApollo01 =
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
				{ Cue = "/VO/Ares_0158",
					Text = "My half-brother Lord Apollo here claims he was first amongst our family to reach you thus, my kin. Perhaps if {#Emph}I {#Prev}had in his stead, this all could have been well over by now..." },
				{ Cue = "/VO/Apollo_0170",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Text = "Oh come on, Ares, you've never been big on bringing conflicts to an end. Probably why you showed up so late to this one! But you saw how great a time the rest of us were having and just {#Emph}had {#Prev}to get involved." },
			},

			AresWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BloodManaBurstBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0164",
					Text = "Love and hate, my kin! The most powerful emotions, and the underlying causes of war. So it is that glorious Aphrodite here has taken interest in my leanings, and I in hers." },
				{ Cue = "/VO/Aphrodite_0214",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Text = "Your preoccupations are my passions, Lord Ares! What would drive someone to lose themselves entirely to feeling? I would like to know {#Emph}every {#Prev}last possible reason." },
			},

			AresWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "RapidSwordBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0166",
					Text = "Hard-working Hephaestus and I are the only true-born sons of the King and Queen of Mount Olympus. I keep telling him, we ought to rise to the occasion, and assert ourselves!" },
				{ Cue = "/VO/Hephaestus_0238",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Text = "Want more responsibility, Ares, have at it! Otherwise I don't know what you're after, and don't want any of it, Aphrodite notwithstanding. Got my forge, got my wife... it's enough." },
			},

			AresWithHestia01 =
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
				{ Cue = "/VO/Ares_0160",
					Text = "I'm pleased to see dear Lady Hestia putting her capabilities to greater use. Why, here she is right now! I always knew you had a disposition toward destruction, Goddess, as so prevalent is flame in war!" },
				{ Cue = "/VO/Hestia_0205",
					Portrait = "Portrait_Hestia_Displeased_01",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Text = "It's a side of myself I don't often like to show, as much as you seem to like seeing it, Ares. I figure we can't properly control our powers if we can't control ourselves." },
			},
		},

		InteractTextLineSets =
		{
			AresFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/MelinoeField_2916", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.5, PowerWordPresentation = true, PowerWordWaitTime = 3.8 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					-- UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "Was beginning to think this one would never show his face. {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Ares_0201",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Text = "{#Emph}Ah{#Prev}, a fellow student of death! To have confronted monstrous Typhon with such zeal. My kin insisted that I act upon the violence spiraling out of control, and I do wish to see your prowess, so {#Emph}here... {#Prev}a first of many contributions to the cause." },
			},

			-- low health
			AresLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0039",
					Text = "Your blood runs red just as your brother's did, and you've lost quite a bit already for the night. I only wish I could have reached you sooner, to have witnessed more of it myself." },
			},
			AresLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0168",
					Text = "Such grievous wounds you suffer from, my kin! In war, of course, no one gets out unscathed. May you inflict {#Emph}far {#Prev}greater suffering on any who would dare to do us harm." },
			},
			AresLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0169",
					Text = "So much life already lost this eve; although I should not use that term myself. Lives extinguished are never {#Emph}lost{#Prev}, always {#Emph}spent... {#Prev}if but for the good of your father's realm." },
			},
			AresLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0170",
					Text = "You suffer injuries which would have caused even the strongest mortal to succumb; but you fight on as though you are unscathed! Perhaps you even find a thrill in it?" },
			},

			-- run clears
			AresUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0055",
					Text = "Word reached us that you defeated the Titan of Time last night, and we were most impressed; but I was left to wonder whether he experienced the throes of agony before the end. Perhaps he eventually can be dissuaded thus." },
			},
			AresUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresUnderworldRunCleared01" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0056",
					Text = "I was not even born when first our fathers slew the Titan Chronos... and neither could I see him thwarted by your hand last night. But I've a good imagination for such things." },
			},
			AresUnderworldRunCleared03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "PrevRun", "ActiveBounty" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0136",
					Text = "I thought that I might find you there tonight. Whilst the Titan Chronos reels from your recent victory, his forces on the surface must be shaken, and more vulnerable to attack." },
			},
			AresSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0053",
					Text = "To have driven back the Father of All Monsters is a monumental achievement, my kin. But the war is not yet won! Which means still-greater victories await; perhaps with the occasional ignoble defeat." },
			},
			AresSurfaceRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0054",
					Text = "Such a monstrosity, Typhon... slow, enormous, stubborn as he clambers toward our highest peak; driven by vengeance, rage...! In some respects I do admire him. Though I am grateful you were there to dash his hopes." },
			},

			-- legendary
			AresLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0044",
					Text = "I'm quite partial to such wars as have a certain ebb and flow... when the upper hand is hard earned, and easily ceded! For now, my kin, it's yours. Hold on to it." },
			},
			AresLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0171",
					Text = "In war, the victor is whomever is the strongest or the most ruthless of all. Although I too have a degree of influence, and bestow on you that very power {#Emph}now." },
			},

			-- run starts
			AresRunStart01 =
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
				{ Cue = "/VO/Ares_0040",
					Text = "As you set forth on this night's campaign, I would accompany you from the outset, so that you may fight and slay your enemies entirely without restraint." },
			},
			AresRunStart02 =
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
				{ Cue = "/VO/Ares_0041",
					Text = "I sensed the possibility of concentrated violence from your current whereabouts. Soon then, the killing shall commence. You need but choose the means by which it shall be done." },
			},
			AresRunStart03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "PrevRun", "ActiveBounty" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0137",
					Text = "Your latest effort to stop Typhon did not go as you presumably desired, yet we still were able to use the diversion you created to our advantage. Now for the Titan Chronos, yes?" },
			},
			AresRunStartSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0042",
					Text = "How soft the earth you walk upon must be, and not from rainwater, I think. Well if you wish to tour war-torn landscapes near and far, then let me be your guide." },
			},
			AresRunStartSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0043",
					Text = "You've quite a distance to traverse until you reach the battlefield that is our mountainside; though rest assured, fighting shall be fierce along the way!" },
			},

			-- about other gods
			AresAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0145",
					Text = "I understand that the Three Fates are held against their will? I would be more concerned for them, except... perhaps this means that war itself shall finally be the sole determiner of its results...!" },
			},

			AresAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
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

				{ Cue = "/VO/Ares_0064",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Lord Father Zeus is most experienced at war, having both fought and conquered many times. Yet he often favors counsel from Athena over my own, even as she struggles to defend this mountain. At least you see we should {#Emph}attack." },
			},
			AresAboutZeus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0146",
					Text = "My father's blessing is most-powerful indeed. The strength to vanquish Typhon himself! Although this circumstance in which we find ourselves has still-greater demands, and I stand ready to provide." },
			},

			AresAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0065",
					Text = "My dear mother the Queen is careful not to show any member of the family undue favor, not even the children to whom she gave birth... I like to think that my propensity to be objective comes from her." },
			},

			AresAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0149",
					Text = "Our uncle Poseidon puts on a veneer of confidence, yet I believe that it is perspiration, not sea-water, often visible upon his brow. War can be disconcerting, certainly." },
			},
			AresAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0150",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "My half-brother Apollo graced you, has he now? Whilst I pursued my one vocation, he chased flights of fancy, growing talented at many different things, yet having mastered arguably none." },
			},
			AresAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0151",
					Text = "The goddess Demeter is known for causing crops to flourish... though, she may as easily spread famine 'cross the land. Such power is the ideal complement to mine." },
			},
			AresAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0066",
					Text = "You know, I wouldn't offer you my blessings readily if not for fairest Aphrodite, who I see has graced you once again. You've seen the beauty in my work, and it is thanks to her." },
			},
			AresAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0067",
					Text = "My poor brother Hephaestus, relegated to a life of toil in a foundry... creating arms and armor that have seen such glory as he'll never see himself. At least he's been of use to {#Emph}you{#Prev}, my kin." },
			},
			AresAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0152",
					Text = "You have inspired the reluctant Hestia to join this fight! To think her flame serves mostly to warm mortals' homes. I {#Emph}so {#Prev}wish to see her use it to its fullest potential!" },
			},
			AresAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0153",
					Text = "The goddess of the hunt is by her nature seldom to be seen; I've often tried persuading Artemis to use her talents on the battlefield, not merely in the woods. But she is stubborn, as perhaps you know." },
			},
			AresAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
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

				{ Cue = "/VO/Ares_0154",
					Text = "A successfully conducted war requires crisp communication, for which we still depend on swift-footed Hermes. It is to be expected that he reached you first; with blessings not mere tidings, I trust." },
			},

			AresAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "N", "O", "P", "Q" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "~=",
						Value = 5,
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0155",
					Text = "Upon nights such as this, what sole illumination can be found is from Selene on her shining chariot aloft. You have her light about you, my kin; her hidden power as well, yes?" },
			},

			AresAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Athena_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0068",
					Text = "My dear sister Athena has a great burden to bear, beyond that heavy suit of armor that you've seen. Not only does she manage our defenses, she must answer for the failures thereof. I trust her wisdom shall help see her through." },
			},

			-- about other characters
			AresAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "I_PostBoss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0033",
					Text = "If our grandfather seeks war, then who am I to deny him such a thing? Neither is the irony of such a matter lost on me; I simply think we {#Emph}all {#Prev}can get what we desire." },
			},
			AresAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache", },
						TableValuesToCount = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "NemesisRandomEvent", "BridgeNemesisRandomEvent", },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0183",
					Text = "Before the Titan took the Underworld, a daughter of the goddess Nyx would often punish those who took more than their share. She was called Nemesis, and I admired her... perhaps of late she's seeking retribution for her kin." },
			},
			AresAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesGift02", "AresGift02" },
					},
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0184",
					Text = "You've met my mother's champion called Heracles, famed amongst mortals for his rugged skill. His club has claimed perhaps more lives than you! Though he had a head start." },
			},
			AresAboutMedea01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "AresGift02", "MedeaGift02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0185",
					Text = "The witch Medea is of service to you, yes? The plagues and poisons for which she is infamous in some respects reduce the possibility of war; but they achieve results, so one must keep an open mind." },
			},
			AresAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Story01" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0045",
					Text = "I owe your father a great deal, for the more work I did, the more he'd have to do in turn. I trust that he valued our collaboration for his part? It hasn't been the same without him since." },
			},
			AresAboutNyx01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift02" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0048",
					Text = "I knew the goddess Nyx, my kin, and learned from her about your realm and its customs. She and your nearest relatives were very close. If now it takes a war to win them back, so much the better." },
			},
			AresAboutNyx02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0197",
					Text = "The goddess Nyx, returned unto the Underworld, my kin! Although I felt quite melancholy at the thought of our war drawing to a close, I am most pleased that the presence of Night Incarnate is more strongly felt again, as well it should." },
			},

			-- higher priority alt below
			AresAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift03" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AresAboutZagreus01_B" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0057",
					Text = "You're reminiscent of your brother quite a bit. A consummate dealer of death he was, born in the pressures of the deepest hells! Although perhaps you wouldn't get along, just as my siblings and I have our little spats." },
			},
			AresAboutZagreus01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift03" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AresAboutZagreus01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "I_PostBoss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0057",
					Text = "You're reminiscent of your brother quite a bit. A consummate dealer of death he was, born in the pressures of the deepest hells! Although perhaps you wouldn't get along, just as my siblings and I have our little spats." },
			},

			AresAboutZagreus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "C_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0198",
					Text = "Your brother Zagreus is doing well? I trust that you shall get on famously, for you have much in common: brutality, mercilessness...! Would that I had such a sibling here..." },
			},

			AresAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0059",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I understand the goddess Eris hounds you quite incessantly each night that you approach. I have to say it puts me in a bit of a predicament, for Strife has benefited what I do far more than most. Yet I know that she cannot be controlled." },
			},
			AresAboutEris02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0060",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "The goddess Eris is quite unpopular up here, and I expect also where you reside. But I have certain sympathies for her, shunned as she is. We cannot change our nature; we deathless gods, we cannot even be destroyed, it seems." },
			},
			AresAboutEris03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Eris_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0199",
					Text = "There is some kinship 'twixt you and the incarnate of Strife? I thought perhaps a bitter feud and nothing more. Yet you apparently see Eris as I do. We are all forces of nature, are we not?" },
			},

			AresAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0049",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Clearly Prometheus the Titan is no stranger to conducting war. He knows, for instance, just how fragile most alliances can be. Do you suppose he stood with our fathers in the past only to better learn their weaknesses?" },
			},
			AresAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0050",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I always took Prometheus for a mere pacifist, so readily did he accept his fate when he was caught defying my lord father's will. Since found his fighting spirit, has he? At times it takes some pain and suffering to discover who we are." },
			},
			AresAboutPrometheus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0200",
					Text = "You and Prometheus are to perpetuate your conflict, then? He has his complicated reasons why, which my kin have accepted grudgingly. I am simply pleased to see him fight. " },
			},

			AresAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0051",
					Text = "Colossal Typhon is an even greater threat than I could have imagined, my kin! How envious I felt, hearing the tales of our elders fending off the Father of All Monsters... but now, we all are witness to his wild rage firsthand!" },
			},
			AresAboutTyphonL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0052",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I'd certainly not call our latest battle against Typhon anything close to a victory, yet we were able to repel him finally after your forced retreat. But now it seems he has resumed his slow ascent..." },
			},
			AresAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0189",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "The Father of All Monsters, slain! I scarce believed it when I heard, but my lord father and dear mother quite insisted this was true. It seems that you possess a power {#Emph}far {#Prev}more terrifying {#Emph}even {#Prev}than our vanquished foe." },
			},

			-- other reactions
			AresAboutPalace01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "Q_Story01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0188",
					Text = "I regret not having had the opportunity to give you my regards whilst you were here, my kin. But the need to dispose of trespassers took precedence. I trust we may yet meet in time?" },
			},

			AresAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0138",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "It has been long since I witnessed the goings-on beneath the earth, not that mere Boons allow me to see much. Some of those dark places you lay waste to, I scarcely see at all." },
			},
			AresAboutUnderworld02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0194",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "When shall your father restore passage through the Underworld's gates? Perhaps his realm is not in the condition yet to take in so many new residents at once. Well then, all in good time." },
			},

			AresAboutSacrifice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift06" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "SatyrCultist", "SatyrCultist_Elite", "SatyrLancer", "SatyrLancer_Elite", "SatyrRatCatcher", "SatyrRatCatcher_Elite", "SatyrRatCatcher_Miniboss", "SatyrCrossbow", "SatyrCrossbow2", "SatyrCrossbow2_Elite", "SatyrLancer2", "SatyrLancer2_Elite", "SatyrSapper", "SatyrSapper_Elite", "HarpyCutter", "HarpyCutter_Elite", "HarpyDropper", "HarpyDropper_Elite" },
						Comparison = ">=",
						Value = 200,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0143",
					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },
					Text = "Pain and death contain so many mysteries, my kin. Each Satyr, each Harpy whose life you take, their sacrifice has something to teach us. And you have learned voraciously; may our studies continue far into the future." },
			},

			AresAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 14,
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

				{ Cue = "/VO/Ares_0073",
					Text = "Such terror permeates the atmosphere this night. It almost feels as though the goddess Nyx herself has touched the hearts of all those who oppose us, such is their fervor. This battle shall be difficult I think!" },
			},
			AresAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
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

				{ Cue = "/VO/Ares_0074",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Do you detect a certain fear that hangs in the air this night, my kin? I suspect yes; perhaps you are its very source... a goddess not merely of the Underworld, but of nightmares themselves." },
			},

			AresAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyAres" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0071",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "There is a stir of something different in the air tonight... you feel it too, yes? The sense of great and ancient possibility. Let us bring it into being through sheer force." },
			},
			AresAboutPackageBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0072",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I admit even we gods may be subject to forces beyond our knowledge or control. I sense such influences even now... intensifying this great war of ours. Spurring us to act." },
			},
			AresAboutRandomBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.LateStartPackagedBounties,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0187",
					Text = "What forces could have brought you suddenly as far as you have come? Perhaps there are such Underworld gods whom even we cannot detect; allegiances of which we need not know." },
			},

			AresAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceAresBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0035",
					Text = "That Sword Hilt which you bear belonged once to a warrior who spilled much other blood before his own. It is of common fashion otherwise, but worked so many battles that I feel a connection; perhaps you do as well." },
			},
			AresAboutKeepsake02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceAresBoonKeepsake" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "ForceAresBoonKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0177",
					Text = "By now that Sword Hilt which I offered you has seen such bloodshed in your care that I should think its former owner would be pleased! At least {#Emph}I {#Prev}am most certainly, both to contribute {#Emph}and {#Prev}observe." },
			},

			AresAboutMorosKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BlockDeathKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0178",
					Text = "I sense that you possess an artifact from Doom himself! I have crossed paths on more than one occasion with Lord Moros, for my area of expertise often requires his. This must be an exciting time for him!" },
			},

			AresAboutTravels01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0032",
					Text = "I recently returned from certain travels, for my work is never done. I was pleased to see that matters here were well in hand; much better off than when I left, in many ways. I take it you're to thank in no small part?" },
			},
			AresAboutWar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0061",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I have to say I was reluctant to participate in these affairs at first. A war must run its course; I often set the wheels in motion, yes, but then observe impartially. This one, however, has become a bit of an exception." },
			},
			AresAboutWar02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0034",
					Text = "War can be such a complex thing. I can bring it into being, yes, but soon it takes on a life of its own; perhaps akin to rearing a child! And this child with whom we're dealing now has grown a bit unruly, I have to say." },
			},
			AresAboutWar03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift02" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0062",
					Text = "This is by no means the first occasion that our family has become embroiled in a war. Yet I have never before seen a case that swept so many of us up! I get a bit emotional about it still..." },
			},

			AresAboutWeapons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirements = { "AllWeaponsUnlocked" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0046",
					Text = "I know the weapons which you wield; glorious Nyx told me of them herself! I've an insatiable hunger for such knowledge, not unlike how the Nocturnal Arms cannot be sated whilst your realm remains under duress." },
			},
			AresAboutWeapons02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					NamedRequirements = { "AllWeaponsUnlocked" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0179",
					Text = "Knowing my brother Hephaestus, he could identify each one of your dark armaments by name! But I recognize their purpose and their form, and wish to see how much destruction they can cause." },
			},
			AresAboutNergalAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0180",
					Text = "Now that is an exquisite weapon you possess! The Rock Lion Mace has a storied, bloody past, and you shall grow its legacy. I never knew it was a form of the Nocturnal Arms..." },
			},
			AresAboutNyxAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0181",
					Text = "The markings on your armaments are reminiscent of the goddess Nyx. I know she oversaw the forging of the Nocturnal Arms, but she once wielded them herself...?" },
			},
			AresAboutThanatosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0182",
					Text = "I recognize that ornate scythe you bear; it ought be in the hands of Death himself! Though in yours, close enough. To think that even Thanatos was taken by the Titan unawares." },
			},

			AresAboutEphyra01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Opening01", "N_PreHub01", "N_Boss01", "N_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0186",
					Text = "{#Emph}Oh{#Prev}, how the city of Ephyra reeks of death! I practically can breathe the stench from here. Now only wretchedness and misery remain, all of it well beyond salvation I should think." },
			},
			AresAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0047",
					Text = "Of late, my obligations have required me to go abroad, for I can only do so much from our quite-isolated mountaintop. But now there's so much to take care of here at home!" },
			},
			AresAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0176",
					Text = "A growing number of terrific wars are lately being fought at sea, my kin. You are in some respects leading the charge on the evolving nature of the craft!" },
			},
			AresAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0063",
					Text = "Though I may be the firstborn son to our King and Queen, I have no greater share of influence. We all offer our counsel, but who's heeded, who can say? I'm oft reminded that, in war, diplomacy can play a vital part." },
			},

			AresAboutSatyrs01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "SatyrCultist", "SatyrCultist_Elite", "SatyrLancer", "SatyrLancer_Elite", "SatyrRatCatcher", "SatyrRatCatcher_Elite", "SatyrRatCatcher_Miniboss", "SatyrCrossbow", "SatyrCrossbow2", "SatyrCrossbow2_Elite", "SatyrLancer2", "SatyrLancer2_Elite", "SatyrSapper", "SatyrSapper_Elite" },
						Comparison = ">=",
						Value = 1000,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0058",
					Text = "You've slain at least a thousand Satyrs thus far during your campaign; a modest army, single-handedly destroyed! And that is but a {#Emph}fraction {#Prev}of the sheer totality of the destruction you have caused!" },
			},

			AresAboutDevotionTest01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0070",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Our bickering over whose favor you decide on first? Pageantry, destructive and uncalled for! A war we wage within to settle our disputes. It's something of a tradition!" },
			},

			AresPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0190",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "It is quite common to experience mixed emotions at the outcome of a war! And to have been denied a violent resolution to our plight... although from what I gather, there is violence still to come." },
			},
			AresPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0195",
					Text = "This latest war shall not be easily surpassed; admittedly in part because we gods were at the center of it. But I trust another shall exceed it at some point! One always does." },
			},

			AresPostTrueEndingAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0191",
					Text = "We're to continue warring with the Titan Chronos but in different {#Emph}times? {#Prev}Or different circumstances, I should say... had you but failed to succeed before. A fight without an end... {#Emph}oh{#Prev}, my kin." },
			},
			AresPostTrueEndingAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0192",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "How many of these Chronos impostors are we dealing with, do you suppose? To think we shall eradicate them all, one at a time. Yet no two battles are to be the same!" },
			},
			AresPostTrueEndingAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0193",
					Text = "I understand you are somehow still able to confront the Father of All Monsters here! So then his raging spirit yet remains, in some dark recesses of time. Would that I could look upon him there!" },
			},

			AresPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0196",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "The Fates have been discovered after all? And they intend to take a break from all their traditional manipulations? I do not entirely believe it, but... war would be so exhilarating were its victors never preordained." },
			},

			-- repeatable lines
			AresChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0003",
					Text = "Nothing compares to witnessing the slaughter of one's enemies, don't you agree?" },
			},
			AresChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0004",
					Text = "Wherever blood is to be shed, I can be counted on at least to be intrigued, if not involved." },
			},
			AresChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0005",
					Text = "Mortals all must die; I merely wish for them to do so in a fitting way." },
			},
			AresChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0006",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "There are such conflicts as can only be resolved with violence; no need to fight the urge." },
			},
			AresChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0007",
					Text = "Wherever there's a wave of death, I seek it out, and lately, there you are." },
			},
			AresChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0008",
					Text = "Life spreads much like a plague across this world, but there are ways to keep it to a manageable flow." },
			},
			AresChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0009",
					Text = "No single war may last forever, yet no single war shall ever be the last." },
			},
			AresChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0010",
					Text = "How readily your enemies commit themselves to slaughter, time after bloody time." },
			},
			AresChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0011",
					Text = "Pain and suffering tend to subside, so this shall be a reminder for all involved." },
			},
			AresChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0012",
					Text = "Bloodshed can often be avoided, yet I seek never to let such opportunities slip by." },
			},
			AresChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0013",
					Text = "Such times in which we live, when even the dead can still experience the full extent of war." },
			},
			AresChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0014",
					Text = "Let us savor these moments whilst the ashes of destruction come to rest." },
			},
			AresChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0015",
					Text = "The spirits of the dead haunt every battlefield, do they not? Perhaps you can even see them there." },
			},
			AresChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0016",
					Text = "War is in our very nature, thus not something to reject, but to embrace." },
			},
			AresChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0017",
					Text = "Violence does not always put an end to conflict, but can reduce it to a simmer for a while." },
			},
			AresChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift07" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0018",
					Text = "Your each and every battle is a pleasure to behold, my hellborn kin." },
			},
			AresChat17 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0019",
					Text = "So many wars are lost to time, but this one perhaps shall not be soon forgotten." },
			},
			AresChat18 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0020",
					Text = "A war that spreads across the surface, and below... we have outdone ourselves, my kin." },
			},
			AresChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0021",
					Text = "Let's not perpetuate this bloodshed for vengeance alone; there are many perfectly good reasons." },
			},
			AresChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0022",
					Text = "Some find my work to be unpleasant! You have witnessed it firsthand, and know the truth." },
			},
			AresChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0023",
					Text = "So many battles to be fought! It can be almost overwhelming, that I know." },
			},
			AresChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0024",
					Text = "Victory in war is bittersweet; but the end of anything is rarely the best part." },
			},
			AresChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0025",
					Text = "There may appear to be no perfect outcomes in my work, although perhaps you'll come to see it as do I." },
			},
			AresChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Shop01", "F_PreBoss01", "F_Reprieve01", "G_Shop01", "G_Reprieve01", "G_PreBoss01", "H_Bridge01", "H_PreBoss01", "N_Opening01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_Reprieve01", "O_PreBoss01", "P_Shop01", "P_Reprieve01", "P_PreBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0026",
					Text = "Whilst I admire your efficiency, do take a moment to appreciate the calm after the storm." },
			},
			AresChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0027",
					Text = "Each night gives us fresh opportunity to enact slaughter in entirely new ways." },
			},
			AresChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0028",
					Text = "For the greatest conflicts, I am always willing to provide my services, and bring about a sensible result." },
			},
			AresChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0029",
					Text = "We all have a will to fight, is that not so? I merely seek that we be truer to ourselves." },
			},
			AresChat28 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0030",
					Text = "Your battle for this eve has just begun, and I wish not to miss a single kill." },
			},
			AresChat29 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0031",
					Text = "If there is to be bloodshed this night, then let us make every drop count." },
			},
			AresChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0069",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "How are we to assert our dominion over this world, if not through violence?" },
			},
			AresChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0095",
					Text = "Violence is not always strictly necessary, but it often works." },
			},
			AresChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0208",
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Whoever said that violence never solves anything likely never even tried!" },
			},
			AresChat33 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0209",
					Text = "May you slay all who oppose you with as much efficiency or cruelty as you like." },
			},
			AresChat34 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0210",
					Text = "The Earth drinks deeply of the blood you spill, and I would see you slake her thirst." },
			},
			AresChat35 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "H" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0211",
					Text = "So many foes within your father's realm lack flesh and blood, but they shall have to do." },
			},
			AresChat36 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0212",
					Text = "To think that war could rage even beneath the earth; what an exciting time!" },
			},
			AresChat37 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0213",
					Text = "You mean to carve another bloody path up to our mountaintop? Then that I wish to see!" },
			},
			AresChat38 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I", "N", "O", "P" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0214",
					Text = "The remnants of the Titan's legions have a battle-hunger I feel warrants some respect." },
			},
			AresChat39 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0215",
					Text = "War isn't for the squeamish and the weak, but you've a real taste for it, I see." },
			},
			AresChat40 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift07" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0216",
					Text = "I so look forward to seeing which methods you employ against your enemies each night!" },
			},
			AresChat41 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift05" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Ares_0217",
					Text = "Perhaps we need some sort of rally-cry tonight, my kin. Would {#Emph}kill them all {#Prev}suffice?" },
			},
		},

		BoughtTextLines =
		{
			AresBlindBox01 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0077",
					Text = "{#Emph}Ah! {#Prev}It seems this message was successfully delivered in utter secrecy! We ought to take more such precautions, although perhaps it would hinder your ability to plan." },
			},
			AresBlindBox02 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0078",
					Text = "You need not be surprised to find me thus. Our family often takes a more-direct approach, but I am not above skulking in shadows; I rather quite enjoy it." },
			},
			AresBlindBox03 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0174",
					Text = "In war, one must prepare for {#Emph}all {#Prev}eventualities. This could have been one of your other kin lending their Boon, but I was swift to take decisive action in their stead." },
			},
			AresBlindBox04 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0175",
					Text = "Our blessings are difficult to resist, are they not? Even without knowing which you shall receive, let alone whose, you are always willing to pay the Boatman's price." },
			},

			AresLootBought01 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0075",
					Text = "The river-boatman may no longer ferry souls into the Underworld, but has become quite valuable to the ongoing war effort. He's quite effective with that oar of his!" },
			},
			AresLootBought02 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0076",
					Text = "There were occasions on which I would pay the boatman's fare myself, so many souls did I send down at once into the Underworld! Those were good times." },
			},
			AresLootBought03 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0172",
					Text = "War cannot endure should supply lines be disrupted for too long; so I am ever-grateful for your Boatman, as I'd not have reached you now if not for him." },
			},
			AresLootBought04 =
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
						Path = { "UseRecord", "AresUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0173",
					Text = "Gold is a fascinating metal, is it not? Mortals often fought and killed over the stuff. Only the rarest Gemstones from your father's domain appeal to them more!" },
			},
		},

		RejectionTextLines =
		{
			AresRejection01 =
			{
				{ Cue = "/VO/Ares_0083",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "You realize what this means, don't you, my kin? I trust I do not even have to say the words." },
			},
			AresRejection02 =
			{
				{ Cue = "/VO/Ares_0084",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Bitter wars are sometimes waged for less; really over nothing much at all." },
			},
			AresRejection03 =
			{
				{ Cue = "/VO/Ares_0085",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "Perhaps this was a mere misunderstanding, though I tend to presume malicious intent." },
			},
			AresRejection04 =
			{
				{ Cue = "/VO/Ares_0086",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "My other kin also at times brush me aside, and look where {#Emph}that {#Prev}got them." },
			},
			AresRejection05 =
			{
				{ Cue = "/VO/Ares_0087",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "If you truly wish to war with me, you'll find I'm more than happy to oblige." },
			},
			AresRejection06 =
			{
				{ Cue = "/VO/Ares_0088",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I truly feel for you my kin; no recourse but to choose a side, and suffer the result." },
			},
			AresRejection07 =
			{
				{ Cue = "/VO/Ares_0089",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "It would be a lie to say it brings me little pleasure to do what I now have to do, my kin." },
			},
			AresRejection08 =
			{
				{ Cue = "/VO/Ares_0090",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I do not begrudge your decision; I am most-grateful for it, since it means I can do {#Emph}this." },
			},
			AresRejection09 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Ares_0091",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "My dear brother has been chosen over me before, and neither did I appreciate it then." },
			},
			AresRejection10 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "ZeusUpgrade", "HeraUpgrade" },
					},
				},
				{ Cue = "/VO/Ares_0092",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "I would have chosen similarly in your stead, but have my pride nevertheless." },
			},
			AresRejection11 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "AphroditeUpgrade" },
					},
				},
				{ Cue = "/VO/Ares_0093",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "You're wise to side with Aphrodite, though for now you've made an enemy of {#Emph}me." },
			},
			AresRejection12 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "ZeusUpgrade", "HeraUpgrade" },
					},
				},
				{ Cue = "/VO/Ares_0094",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Portrait = "Portrait_Ares_Displeased_01",
					Text = "A calculating choice, perhaps. But not without its violent repercussions." },
			},
		},
		
		RejectionVoiceLines =
		{
			{ GlobalVoiceLines = "GodRejectedVoiceLines" },
		},

		MakeUpTextLines =
		{
			AresMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0099",
					Text = "An exquisite performance befitting our lineage! You are to be rewarded for all that." },
			},
			AresMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0100",
					Text = "Sometimes I like to benefit the losing side, to give them a false hope." },
			},
			AresMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0101",
					Text = "Do you suppose your foolish enemies believed they had you there?" },
			},
			AresMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0102",
					Text = "An occasional show of hostility is just how we assert ourselves, my kin." },
			},
			AresMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0103",
					Text = "So many battles to be fought, yet I just cannot help myself sometimes..." },
			},
			AresMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0104",
					Text = "{#Emph}Ah{#Prev}, but that was excellent, although the best this eve perhaps is yet to come." },
			},
			AresMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0105",
					Text = "You've satisfied my need for retribution, or at least my thirst for blood. For now." },
			},
			AresMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0106",
					Text = "I sense that no survivors of that clash remain, save you. A fine outcome." },
			},
			AresMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0107",
					Text = "To the victor of the battle, a reward. And I, in turn, experienced quite the spectacle." },
			},
			AresMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0108",
					Text = "My work at times requires me to side against my kin. You understand, of course?" },
			},
			AresMakeUp11 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0109",
					Text = "This was but an inconsequential skirmish, and even still, it was such a delight." },
			},
			AresMakeUp12 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Ares_0110",
					Text = "Your foes believed they stood a chance; such optimism fascinates me to no end." },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			AresGift01 =
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
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2962", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Ares, I know mortal warriors often would make offerings to you before their battles to the death. I likewise wish to pay you my respects. No mercy for our foes!" },
				{ Cue = "/VO/Ares_0036",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I shall not take such honors without giving in return, especially from one who understands my work. A living weapon such as you ought to have {#Emph}this." },
			},
			AresGift02 =
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
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2964", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "It's not for me to decide how many battles I have left; but knowing I have your support in them means a great deal, my lord. May we achieve all our objectives soon enough." },
				{ Cue = "/VO/Ares_0037",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Such Nectar often is withheld till victory. Although in many ways, I feel as though we have already won! I have, at least; and to that end, I'll find a moment to enjoy this properly." },
			},
			AresGift03 =
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
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2965", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "No war can last forever, but we shall always be family, isn't that so, my lord? This is but a simple reminder that there's more to unite us than the thrill of the fight." },
				{ Cue = "/VO/Ares_0038",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "You've given me far greater gifts than even this fine Nectar, which I do of course appreciate. But the slaughter you have thus far caused... that is truly second-to-none." },
			},
			AresGift04 =
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
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3378", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I find that there are moments when the thrill of battle practically consumes me; a feeling I once tried to suppress. But now I realize it leads to victory... and {#Emph}you{#Prev}, my lord." },
				{ Cue = "/VO/Ares_0140",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I used to think no others in our family shared preoccupations such as mine. In this I'm pleased to have been very much mistaken. Whenever the whim to dole out death strikes you, know I shall be there." },
			},
			AresGift05 =
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
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3669", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I did not know what to expect from you before we met, Lord Ares... but I've found that you have a certain candor others lack. Thank you for always being clear with me." },
				{ Cue = "/VO/Ares_0141",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I must admit, I do not frequently receive such offerings because of my demeanor. Many are so {#Emph}easily {#Prev}unsettled, by honesty, by various passions; you seem not to be, my kin." },
			},
			AresGift06 =
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
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3670", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I wonder, Lord Ares, when mortals on opposing sides all pray to you for victory, how do you choose whom to bless? I trust this offering has no such complications." },
				{ Cue = "/VO/Ares_0142",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Such gifts are welcome to a point. Mortals believe they can gain favor from me, but it is their own will to fight that most determines how quickly they die. I appreciate your interest in these smaller details!" },
			},
			-- bond forged
			AresGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_AresGiftHint01",
				CompletedHintId = "Codex_BondForgedAres",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "AresGift06", "AresAboutSacrifice01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3671", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To all our triumphs in the past or still to come, Lord Ares! But this Ambrosia is not merely for that... I know you also learn from painful losses and defeats. In this especially, I find we are alike." },
				{ Cue = "/VO/Ares_0144",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Ares_01", Icon = "Keepsake_Ares" },

					Text = "I share the sentiment, my hellborn kin. Our family tends to focus overmuch on victories; we do not look unflinchingly at failures and defeats, where deeper insight may be found. In this and more, you have been a welcome exception." },
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/MelinoeField_2963", Text = "This I accept from you, my lord." },
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
				Source = { LineHistoryName = "NPC_Ares_01", SubtitleColor = Color.AresVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "AresUpgrade" },
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

				{ Cue = "/VO/Ares_0111", Text = "All shall suffer!" },
				{ Cue = "/VO/Ares_0112", Text = "Let there be {#Emph}war!", PlayFirst = true },
				{ Cue = "/VO/Ares_0113", Text = "Violence and destruction!" },
				{ Cue = "/VO/Ares_0204", Text = "Let us shed some {#Emph}blood!" },
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "AresUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Ares_0205", Text = "How utterly {#Emph}depraved!", PlayFirst = true },
				{ Cue = "/VO/Ares_0206", Text = "Have you no {#Emph}decorum?" },
				{ Cue = "/VO/Ares_0207", Text = "Mock me if you {#Emph}dare!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				ObjectTypes = { "Eris" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/ErisField_0477", Text = "Was that {#Emph}Ares?!" },
				{ Cue = "/VO/ErisField_0478", Text = "{#Emph}Ares{#Prev}, is that {#Emph}you?!", PlayFirst = true },
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

				{ Cue = "/VO/Chronos_1269", Text = "The vicious god of war..." },
				{ Cue = "/VO/Chronos_1270", Text = "I'll show that Ares real war..." },
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

				{ Cue = "/VO/Zagreus_0368", Text = "Ares, it's {#Emph}me!", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0369", Text = "{#Emph}Come on{#Prev}, Ares...!" },
			},
		},

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
			PreLineWait = 1.25,
			NoTarget = true,

			{ Cue = "/VO/Ares_0096", Text = "Either you are with me or against, my kin; no in-between.", PlayFirst = true },
			{ Cue = "/VO/Ares_0097", Text = "You must have thought this little war would go {#Emph}your {#Prev}way." },
			{ Cue = "/VO/Ares_0098", Text = "I am unmerciful by nature, if I didn't make it clear?" },
		},

		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Ares_01", SubtitleColor = Color.AresVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
				},

				{ Cue = "/VO/Ares_0126", Text = "Certainly." },
				{ Cue = "/VO/Ares_0127", Text = "Of course." },
				{ Cue = "/VO/Ares_0128", Text = "Very well." },
				{ Cue = "/VO/Ares_0129", Text = "As you wish.", PlayFirst = true },
				{ Cue = "/VO/Ares_0130", Text = "As you desire." },
				{ Cue = "/VO/Ares_0131", Text = "Yes." },
				{ Cue = "/VO/Ares_0132", Text = "Done." },
				{ Cue = "/VO/Ares_0133", Text = "Like so?" },
			},
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Ares_01", SubtitleColor = Color.AresVoice },
			TriggerCooldowns = { "AresBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Ares_0120", Text = "I greet you." },
			{ Cue = "/VO/Ares_0121", Text = "{#Emph}Ah{#Prev}, yes." },
			{ Cue = "/VO/Ares_0122", Text = "At last.", PlayFirst = true },
			{ Cue = "/VO/Ares_0123", Text = "There you are." },
			{ Cue = "/VO/Ares_0124", Text = "How fare you?" },
			{ Cue = "/VO/Ares_0125", Text = "My regards." },
		},
	},

}

OverwriteTableKeys( LootData, LootSetData.Ares )