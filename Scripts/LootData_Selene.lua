LootSetData.Selene =
{
	-- Selene
	SpellDrop =
	{
		InheritFrom = {},
		-- GameStateRequirements handled in RunProgress table
		SpawnSound = "/SFX/SeleneMoonDrop",
		ConsumeSound = "/SFX/SeleneMoonPickup",
		DoorIcon = "SpellDropPreview",
		UseText = "UseSpellDrop",
		UseTextTalkAndGift = "UseLootAndGift",
		UseTextTalkAndSpecial = "UseLootAndSpecial",
		UseTextTalkGiftAndSpecial = "UseLootGiftAndSpecial",
		BlockedLootInteractionText = "UseLootLocked",
		ManualRecordUse = true,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		BlockExitText = "ExitBlockedByMoney",
		PlayInteract = true,
		HideWorldText = true,
		ExitUnlockDelay = 1.1,
		TextLinesIgnoreQuests = true,
		OnUsedFunctionName = "OpenSpellScreen",
		BoonInfoTitleText = "Codex_BoonInfo_Selene",
		SubtitleColor = Color.SeleneVoice,
		SurfaceShopText = "SpellDrop_Store",
		SurfaceShopIcon = "SpellDropPreview",
		AnimOffsetZ = 100,
		ResourceCosts =
		{
			Money = 150,
		},
		ConfirmSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
		
		Color = { 100, 25, 255, 255 },
		LightingColor = { 100, 25, 255, 255 },
		LootColor = { 100, 25, 255, 255},
		PortraitEnterSound = "/SFX/Menu Sounds/LegendaryBoonShimmer",

		SpeakerName = "Selene",
		Speaker = "NPC_Selene_01",
		Portrait = "Portrait_Selene_Default_01",
		OverlayAnim = "ChaosOverlay",
		SkipContextArt = true,
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_SeleneUpgrade",
		Gender = "F",
		FlavorTextIds =
		{
			"SpellDrop_FlavorText01",
			"SpellDrop_FlavorText02",
			"SpellDrop_FlavorText03",
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "SpellDrop" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_1881", Text = "May your light never wane.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1882", Text = "Moonlight gui— {#Emph}ugh. {#Prev}Sorry. Habit." },
				{ Cue = "/VO/Melinoe_1711", Text = "Together we shine, Sister." },
				{ Cue = "/VO/Melinoe_1698", Text = "Salutations." },
				{ Cue = "/VO/Melinoe_1699", Text = "Salutations!" },
			},
			{
				PreLineWait = 0.5,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
				Cooldowns =
				{
					{ Name = "SeleneSaluteSpeech", Time = 30 },
				},

				{ Cue = "/VO/Selene_0233", Text = "It never shall.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1881" },
						},
					},
				},
				{ Cue = "/VO/Selene_0234", Text = "{#Emph}Hmm.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1882" },
						},
					},
				},
				{ Cue = "/VO/Selene_0235", Text = "Always.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1711" },
						},
					},
				},
				{ Cue = "/VO/Selene_0236", Text = "Salutations.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Selene_0237", Text = "Darkness guide you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Selene_0238", Text = "Forever more.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1711" },
						},
					},
				},
				{ Cue = "/VO/Selene_0136", Text = "I am obliged.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1881" },
						},
					},
				},
			},
		},

		PickupFunctionName = "SpellDropInteractPresentation",
		PickupVoiceLines =
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 0.15,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "UseRecord", "SpellDrop" },
				},
			},
			Cooldowns =
			{
				{ Name = "SeleneAppearanceSpeech", Time = 5 },
			},

			{ Cue = "/VO/Melinoe_0024", Text = "{#Emph}I draw you down, O Moon. Lend me your light!" },
			{ Cue = "/VO/MelinoeField_1936", Text = "{#Emph}I draw you down, O Moon. Lend me your light!" },
			{ Cue = "/VO/MelinoeField_1935", Text = "{#Emph}I call upon the Moon, and draw you down!" },
			{ Cue = "/VO/MelinoeField_1937", Text = "{#Emph}Let us together shine this night, O Moon!" },
			{ Cue = "/VO/MelinoeField_1938", Text = "{#Emph}I bid you shine for me again tonight!" },
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
			{ Cue = "/VO/Melinoe_0026", Text = "Moonlight..." },
		},

		OnSpawnVoiceLines =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HealthRestore" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "N_PreBoss01" },
				},
				NamedRequirements = { "OlympianOnSpawnVoiceLinesAllowed" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.1,
				PreLineWait = 0.55,

				{ Cue = "/VO/Melinoe_0026", Text = "Moonlight..." },
				{ Cue = "/VO/Melinoe_0027", Text = "Sister Selene...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0189", Text = "A Moon Drop..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.5,
				PreLineWait = 0.8,
				Queue = "Always",
				Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
				Cooldowns =
				{
					{ Name = "SeleneAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Selene_0116", Text = "Good evening." },
				{ Cue = "/VO/Selene_0117", Text = "I bid you welcome." },
				{ Cue = "/VO/Selene_0118", Text = "I have returned." },
				{ Cue = "/VO/Selene_0119", Text = "We reunite." },
				{ Cue = "/VO/Selene_0131", Text = "I have something for you." },
				{ Cue = "/VO/Selene_0132", Text = "This is for you." },
				{ Cue = "/VO/Selene_0149", Text = "This is for you." },
				{ Cue = "/VO/Selene_0133", Text = "Awaken your true strength." },
			}
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				PreLineWait = 1.15,
				RecheckRequirementsPostWait = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "ActiveScreens", "SpellScreen" },
					},
				},
				Cooldowns =
				{
					{ Name = "SeleneAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Selene_0123", Text = "Behold." },
				{ Cue = "/VO/Selene_0130", Text = "Please make your choice." },
				{ Cue = "/VO/Selene_0178", Text = "Look forth." },
				{ Cue = "/VO/Selene_0179", Text = "The choice is yours." },
				{ Cue = "/VO/Selene_0180", Text = "Which suits you?" },
				{ Cue = "/VO/Selene_0181", Text = "Now..." },
				{ Cue = "/VO/Selene_0182", Text = "Your choice?" },
				{ Cue = "/VO/Selene_0183", Text = "Behold my light." },
			},
		},

		InteractTextLineSets =
		{
			SeleneFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/MelinoeField_1934", UsePlayerSource = true,
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { StartWait = 2.25, Portrait = "Portrait_Mel_Intense_01", EndWait = 5.7, SetBoonAnimation = true },
					PostLineFunctionName = "SpellDropInteractPresentation",
					PostLineFunctionArgs = { SkipInteractAnim = true },
					PortraitExitAnimation = "Portrait_Mel_Intense_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "She's deviated from her path... \n\n {#Emph}Great Titaness, the Eye of Night, \n {#Emph}I draw you down; lend me your might!" },
				{ Cue = "/VO/Selene_0158",
					PortraitExitWait = 1.25,
					SkipContextArt = true,
					Text = "Good evening to you, little star. Our cycles now are intertwined, as I no longer can afford merely to watch. Whichever threat we face, I vow to shine for you." },
			},

			SeleneAboutTask01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0053",
					Text = "I regret our meetings are in haste, and that we are unable to converse when thus we meet. I am expected high aloft for all to see. Our connection is to remain as hidden as the Crossroads. We are to move in shadows." },
			},

			SeleneAboutHecate01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift01", "HecateGift01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0062",
					Text = "Your Headmistress and I have worked together ever since Mother Nyx asked we watch over our domains, while she kept watch over the Underworld. Two Titanesses, bound by Night." },
			},
			SeleneAboutHecate02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MemPointsCommon" },
						Comparison = ">=",
						Value = 50,
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "F_PostBoss01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0063",
					Text = "Little star, you grow in strength and knowledge rapidly. How proud your Headmistress must be that you are able to surpass her finally. Yet, we know the burden that you bear." },
			},
			SeleneAboutHecate03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "SeleneAboutHecate01", "SeleneAboutHecate02" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0064",
					Text = "Of late, your Headmistress asked me, do not your rides across the sky become monotonous? I was amused to hear her jest. Each night is like none other I have known." },
			},

			SeleneBackstory01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0215",
					Text = "Long have I been the Eye of Night, watching you grow and train in secrecy; knowing that upon some evening such as this, we Silver Sisters would make our stand. Shall we go?" },
			},
			SeleneAboutSpeech01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0221",
					Text = "All beings struggle to communicate. I learnt from Nyx how to express myself, as you, from your Headmistress. Our speech is rooted in the past; our connections, tenuous." },
			},
			SeleneAboutNyx01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0056",
					Text = "You have no memory of Nyx? It was the Night herself who found me, discarded and unwanted, and raised me from my youth. But when the Titan Chronos took the House of Hades, she was there. I miss her still." },
			},
			SeleneAboutNyx02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0057",
					Text = "On nights as dark as this I think only of Nyx. She ruled the Underworld within your father's House. And she cared for me, among so many others. She knew I sought the heavens. {#Emph}Go{#Prev}, she said. {#Emph}And please keep watch for me up there." },
			},
			SeleneAboutNyx03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutNyx01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0058",
					Text = "The goddess Nyx, in all her grace, began referring to me as the Eye of Night. For I could see even where she could not. This honor spurs me even now, just as I spur my steeds. We shall avenge her, little star." },
			},

			SeleneAboutChronos01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "P_PostBoss01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0156",
					Text = "The Titan Chronos, he is Time itself. Thus by his nature, we can never be entirely prepared for him. He seeks the downfall of Olympus, but how exactly, we still do not know." },
			},
			SeleneAboutChronosBossL01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0175",
					Text = "You have descended into Tartarus, and must have seen what Chronos made of that most-sacred place. I know your confrontation did not go as you desired, but this is a new night. And you are all the more prepared." },
			},

			SeleneAboutFates01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutFates01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0172",
					Text = "I know through your Headmistress of your vision in which Chronos found and captured the Three Fates. This must have been a key component of his plan... but, it does {#Emph}not {#Prev}change ours. The Silver Sisters never cede control." },
			},
			SeleneAboutHelios01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutNyx01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0103",
					Text = "Nyx spoke highly of your brother to me, little star. I too am distant from my brother Helios, the Sun. Sometimes I slow my steeds to catch a glimpse of him as he engulfs the surface. I do not think we would have much to talk about." },
			},
			SeleneAboutEos01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "SeleneAboutEosAspect01" }, Count = 2 },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0104",
					Text = "Perhaps some morning on the surface you shall finally see Eos, little star. She is quite beautiful, so much that mortals now admire her. But I have never known her very well. She makes her brief appearances, then she is gone." },
			},
			SeleneAboutEosAspect01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0219",
					Text = "You bear the Flames of Ygnium, but in the guise of Eos. My sister, in her youthful ignorance, knows nothing about this. May she enjoy her morning rides until a distant age." },
			},

			SeleneAboutLunarCycle01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0077",
					Text = "We breathe, we bleed, we rest, we start anew. Did we create this cycle, or are we merely part of it? Sometimes I ask myself this question while I ride." },
			},
			SeleneAboutLunarCycle02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0078",
					Text = "Let us begin another cycle, little star. Each has its unexpected qualities, but in the greater pattern lies a certain pleasure, does it not?" },
			},

			SeleneAboutDarkness01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0080",
					Text = "So many mortals fear the onset of the dark, but we? The dark is merely where we ply our trade. Come forth, then, little star, and let us shine together in the darkness now." },
			},

			SeleneAboutKeepsake01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0155",
					Text = "My Moon Beams are as innumerable as the stars, and you possess but one; but it is one I chose especially for you, and shall ensure that our connection remains strong." },
			},

			SeleneAboutDagger01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponDagger" },
						Comparison = ">=",
						Value = 200,
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0226",
					Text = "I see often the gleaming Sister Blades within your grasp. I knew eventually that they would reawaken and accept you as their bearer. May their swiftness overwhelm your foes." },
			},
			SeleneAboutAxe01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0227",
					Text = "You wield the Moonstone Axe, whose broad blade shimmers with my light. Then you must hear the song it sings. Such strength, combined with yours." },
			},
			SeleneAboutTorch01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0228",
					Text = "The Umbral Flames suit you quite well... so much akin to the twin torches of your Headmistress, however old they are. In any form, a guiding light is welcome company." },
			},
			SeleneAboutLob01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0229",
					Text = "You now possess the Argent Skull Revaal... an everlasting reminder that Death and Fear ought always to be allies in our cause. Woe unto whomever meets her gaze." },
			},

			SeleneAboutSteeds01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0075",
					Text = "Whenever you invoke me thus, I urge my steeds toward the earth, as far as they dare tread. They are becoming braver, I should think. Now please use well the power I reveal in you." },
			},
			SeleneAboutSteeds02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0081",
					Text = "My ride across the sky tends to be quite a solitary one. I have my steeds to speak to, yes. But it is not the same as when I have the opportunity to speak with you." },
			},
			SeleneAboutSteeds03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					-- sum of the current and two previous two runs
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "SpellDrop" },
						Comparison = "==",
						Value = 0,
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Selene_01" },
					},
					--[[
					{
						PathFalse = { "PrevRun", "UseRecord", "SpellDrop" },
					},
					]]--
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0086",
					Text = "It has been too long since I saw you last. My steeds had grown rather exhausted from our rides. Where would I be if not for them? Closer to you, yes, but... this is where we belong." },
			},

			SeleneRunCleared01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0102",
					Text = "You have gone far since last we met, especially for someone with no steeds. Thus I commend you, and may all of your future attempts in turn succeed." },
			},
			SeleneRunCleared02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutChronosBossW01" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0173",
					Text = "You faced the Titan in the lowest depths... that much I knew before your Headmistress confirmed you vanquished him, as I had faith you would. If his life-force is like grains of sand, then you took one; eventually, {#Emph}all." },
			},
			SeleneRunCleared03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneRunCleared02" }
					},
					-- @ update with additional requirements 1.0
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0174",
					Text = "{#Emph}Death to Chronos. {#Prev}I sense that you are growing closer to manifesting the reality that we have long since sought. May you yet drain whatever light is left in him." },
			},

			SelenePostGift01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0087",
					Text = "If only you could see the world from where I ride. Some night perhaps? I know just how much ugliness there is. But it is rather hidden from afar." },
			},

			SeleneAboutBountyBoard01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathTrue = { "PrevRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0224",
					Text = "I felt a weight drawing me toward the Crossroads recently, and realized it was the Pitch-Black Stone. So then it has awakened; almost like an Eye itself, but far older than mine, and peering from the infinite abyss." },
			},
			SeleneAboutPackageBounty01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0224",
					Text = "I felt a weight drawing me toward the Crossroads recently, and realized it was the Pitch-Black Stone. So then it has awakened; almost like an Eye itself, but far older than mine, and peering from the infinite abyss." },
			},

			SeleneAboutPackageBounty02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountySpellCast" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0218",
					Text = "I sense that something is amiss tonight... as though I did not find you by my will. The Pitch-Black Stone... I see, of course. It is a weight on everything that we perceive." },
			},

			SeleneAboutErebus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Intro" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0096",
					Text = "To have lived all your life in misty Erebus... the world is so much vaster than that place. You shall see much more of it, I think, ere your task is complete." },
			},

			SeleneAboutSurfaceCurse01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0164",
					Text = "You are not meant to be here, little star. Your cursed blood shall fight your every step. Yet Nyx herself would understand the struggle that you face. She too once thwarted what the Fates foretold..." },
			},
			SeleneAboutSurfaceCurse02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "SeleneAboutSurfaceCurse01", "SeleneAboutSurfaceWards01", "SeleneAboutSurfaceWar01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0166",
					Text = "I feel you closer to my light. You suppressed that Fate-wrought curse that binds you to your realm. I was uncertain such a thing was possible... yet you surprise me fairly often, little star." },
			},

			SeleneAboutSurfaceWards01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" }
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0165",
					Text = "You dispelled the Crossroads surface gateway wards... traversed the veil between the world you know and this one that I look upon each night. Perhaps our plan required this new phase." },
			},

			-- alt below
			SeleneAboutSurface01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutSurface01_B" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0097",
					Text = "I welcome you to our world's surface, little star. I knew you would discover your way here. If you feel lost, you need but look to me. And I shall always be watching." },
			},
			SeleneAboutSurface01_B =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutSurface01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0167",
					Text = "I ought to welcome you more formally to our world's surface, little star. Part of me knew you would discover your way here. If you feel lost, you need but look aloft." },
			},
			SeleneAboutSurface02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutSurface01", },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0098",
					Text = "The city of Ephyra has seen so much strife. If only you could have witnessed it when its people still worshiped your mother and father. We shall avenge them all." },
			},
			SeleneAboutSurface03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0220",
					Text = "Here my light yields no greater strength than you experience below, for I give all I safely can wherever you reside. To be dependable and constant is my charge." },
			},

			SeleneAboutSurfaceWar01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutHermesMission02" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0160",
					Text = "We need you where you are. Your battles through the Underworld are consequential to the war that rages here, but leave the surface to the gods and me; do not become distracted by the sealed Crossroads gateway leading up." },
			},

			SeleneAboutOceanus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0110",
					Text = "I found you, though my light is but a flicker at these depths. You trace the secret path between Poseidon's and your father's realms. What lurks here has no love for either one." },
			},
			SeleneAboutFields01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0171",
					Text = "None of my light pierces this dismal region normally, but for you, little star? I shall not hesitate to pierce the heavens and the earth alike. Together, let us strive for victory." },
			},
			SeleneAboutThessaly01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0170",
					Text = "From your perspective, those waters must appear to have no end. But they {#Emph}do {#Prev}end, and you have means to quickly cut across. I shall watch you sail on and help you make haste." },
			},

			SeleneAboutNemesis01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0100",

					Text = "Here in the sky, I am immune to earthly troubles, such as having to share living space with the goddess of retribution. Nemesis never treated me as a sister. She inherited only her mother's strength." },
			},

			SeleneAboutHypnos01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Hypnos_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0101",
					Text = "I remain troubled by the ever-sleeping son of Nyx, there in your Crossroads. Neither your Headmistress nor I have thus been able to awaken him. But every ailment must have a remedy..." },
			},

			SeleneAboutMedea01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Story01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0330",
					Text = "The witch Medea learned to blot out my light, creating an eclipse whenever she required. We had a conversation after that, and all is well between us ever since. Between her curses and my Hexes... you shall be feared." },
			},

			SeleneAboutHeracles01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0113",
					Text = "I saw that you encountered Heracles. Beware that man, who has made many enemies in service to the gods. He even wronged me once, and still walks brazenly as ever in my light." },
			},

			SeleneAboutPolyphemus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "N_Boss01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0099",
					Text = "The Cyclops Polyphemus, whom you faced, once hid within a cavern not even {#Emph}my {#Prev}silver light could reach. Now he has taken sides with Chronos. Too many rise against the gods..." },
			},
			SeleneAboutEris01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Boss01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0176",
					Text = "Black-winged Eris has become an obstacle; she sometimes flies across my path, thus startling my steeds. I am the Eye of Night yet cannot see much worth in her at all..." },
			},

			--[[
			SeleneAboutSilverSisters01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0054",
					Text = "At last, we Silver Sisters four unite. I, in the heavens; the goddess of the hunt, on the surface; your great Headmistress, between realms; and you, within the Underworld. All that transpires, we observe." },
			},
			]]--
			SeleneAboutMission01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Intro" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0161",
					Text = "Our charge as Silver Sisters is to work in shadow to uphold the will of Night. Olympus remains unaware of us; that their own Goddess of the Hunt is one of us; that their own Messenger serves us as well. Let us keep it this way." },
			},
			SeleneAboutObscurity01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
					},
					MaxRunsSinceAnyTextLines = { TextLines = { "ArtemisFirstMeeting" }, Count = 4 },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0162",
					Text = "Now that Artemis has revealed to Olympus what they need to know of you, she had pretext to return to your woods. But your reunion needed to be brief. Once our troubles have subsided, may we Silver Sisters meet together, and rejoice." },
			},

			SeleneAboutTalentDrop01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "TalentDrop" },
					},
					{
						Path = { "GameState", "UseRecord", "TalentDrop", },
						Comparison = "<=",
						Value = 12,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0168",
					Text = "You have seen the Path of Stars, and experienced its connection to my strength and yours. Though our Paths may diverge at times, they often lead us to a single point." },
			},

			SeleneAboutMagick01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0079",
					Text = "Remember, little star: The magick that my light awakes in you requires active focus on your part; it has no power without your intent. In moments when you need it, do not hesitate." },
			},
			SeleneAboutMagick02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0055",
					Text = "This gift of magick does not come from me, but from within. Yet it is also true my luminance awakens innate possibility. An ill-kept secret even mortals of the surface know." },
			},
			SeleneAboutHexes01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0216",
					Text = "My innumerable journeys through the sky provided me with ample time to understand my light. By now, I have a Hex for each occasion, every phase. And you shall have them, too." },
			},
			SeleneAboutHexes02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellLeap" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellTimeSlow" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellTransform" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellPotion" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellMeteor" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellSummon" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellLaser" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0231",
					Text = "You have grown quite familiar with my Hexes, little star. By now you must have a particular favorite or two. Perhaps you shall continue to discover new dimensions in them all." },
			},

			SeleneAboutShrine01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0169",
					Text = "At last you looked upon the Oath of the Unseen... for this night is beyond compare with any I experienced in an age. It is as though Darkness suffuses everything..." },
			},

			SeleneAboutOdysseus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01", },
						Comparison = ">=",
						Value = 4,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0073",
					Text = "You are fortunate to learn from the wanderer Odysseus. I used to follow all his mortal struggles, from his warring to his voyages. Some of the tales about him are embellished, but not all. He is an interesting man." },
			},

			SeleneAboutOlympus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ApolloFirstPickUp", "ZeusFirstPickUp", "PoseidonFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0076",
					Text = "If the might of Olympus were sufficient, the gods would have already put an end to their predicament. Time itself is against us, yet this is precisely the time for which we Silver Sisters have prepared." },
			},
			SeleneAboutOlympus02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ApolloFirstPickUp", "ZeusFirstPickUp", "PoseidonFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp" },
					},
					{
						Path = { "GameState", "ItemInteractions", "SpellDrop" },
						Comparison = ">=",
						Value = 4,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0059",
					Text = "Olympus has no sense of my true strength, or yours. But it is just as well. We are most powerful when we remain obscure; when we are underestimated. Would you not agree?" },
			},

			SeleneAboutPersephone01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
					-- @ update with additional requirements 1.0
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0074",
					Text = "We shall see to it that the rightful Queen and King of the Underworld retake their throne. Your father I knew only from Nyx's account, though I would see your mother when she visited Olympus. You have her regal bearing, little star." },
			},

			SeleneAboutPhases01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0082",
					Text = "The great night sky affords an advantageous vantage-point, and I see your struggles plain. Know that the hardship you endure is but a phase. Seek pleasure in the rhythm of it all." },
			},

			SeleneAboutNewMoon01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0232",
					Text = "I am entirely enshrouded now; a new moon, for a new beginning. Use my cover of darkness to advance toward your goals." },
			},

			-- low health
			SeleneLowHealth01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0070",
					Text = "You have lost much of your lifeblood already. Then perhaps I am too late this time. But while you still can stand, you still can harness the great power I illuminate in you." },
			},
			SeleneLowHealth02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0071",
					Text = "Such injuries you have sustained already, little star. Pain, it seems, is built into the cycle of our lives. I cannot make it go away; but you may learn to set it well aside." },
			},
			SeleneLowHealth03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0072",					
					Text = "You are hurt; your light is waning, little star. Do not lose heart. Our light never goes out; a new moon always rises." },
			},

			-- run starts
			SeleneRunStartIntro01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0320",
					Text = "Another evening filled with possibility. I ride from Dawn and cannot stay for long; I see your own night's journey has begun, so let us shine together, now and always." },
			},
			SeleneRunStart01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0083",
					Text = "The dark of night begins, as does your task. And I am here to usher you into that dark, toward inevitable victory, and death." },
			},
			SeleneRunStart02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0084",
					Text = "I have arrived to join you at the outset of this cycle, to illuminate each step along your path. The path only appears familiar, so take care." },
			},
			SeleneRunStart03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0085",
					Text = "As daylight fades upon the surface, we begin to shine. I shall distract your enemies, while you press ever closer to the resolution that we Silver Sisters vowed would come to pass." },
			},
			SeleneRunStart04 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0222",
					Text = "Another night now beckons, and I shall cast such shadows as to bring you strength and comfort each in turn. Choose well the magick that shall be of greatest benefit." },
			},
			SeleneAboutSwitchToSurface01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
					{
						PathTrue = { "Prev", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0230",
					Text = "Chronos can wait, for he is Time itself. You turn your energies instead toward his armies on the surface, and can slow him down that way. Growing stronger all the while." },
			},

			-- about other gods
			SeleneAboutZeus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0089",
					Text = "I saw the great King of the Olympians already bestowed on you his thunderous strength. He would contend it is more than sufficient on its own. But we Silver Sisters four know otherwise." },
			},
			SeleneAboutHera01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0092",
					Text = "It is uncommon to have earned Queen Hera's Boon. She would confide in me sometimes while she would bathe. But she has been more guarded, as of late. As have we all..." },
			},
			SeleneAboutPoseidon01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0090",
					Text = "The sea-god's strength already flows through you? Poseidon holds that he alone controls the tides. For this I cannot blame him. He does not know or understand my influence." },
			},
			SeleneAboutApollo01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "ApolloUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0088",
					Text = "I see you shine already with another light. The god Apollo's doing, I should think. Fear not; his power is compatible with mine. Light envelops light, never rejecting." },
			},
			SeleneAboutDemeter01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "GameState", "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 8,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0094",
					Text = "At last you met the goddess of the seasons, whose great power often shapes the course of my night's ride. In Demeter, you have a fierce supporter, I can tell." },
			},
			SeleneAboutAphrodite01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0091",
					Text = "I watched the goddess Aphrodite seek you out. From her I learned a bit of how to influence the heart. But only when my strength is at its peak, and even then, I fear I pale in comparison." },
			},
			SeleneAboutHephaestus01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0157",
					Text = "A Boon from Master Blacksmith Hephaestus is prized by warriors all the world over. To you he gives it readily, knowing Olympians alone cannot stop what has begun." },
			},
			SeleneAboutHestia01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0093",
					Text = "The fire-goddess Hestia always proved difficult to track, and yet she willingly revealed herself to you? Either your reputation grows, or does the desperation of the gods." },
			},
			SeleneAboutHermes01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0095",
					Text = "There is one god whose swiftness far surpasses any steed's. And he has granted some of it to you, I see. I caution you to not make too much haste. Steadfastness is the key to victory." },
			},
			SeleneAboutHermesMission01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0159",
					Text = "We have heard nothing from fleet-footed Hermes since he told us of our enemy's advance. Thus we strike, yet hold to faith that some night hence he shall return to us with news about what else the Titan Chronos has in store." },
			},
			SeleneAboutHermesMission02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HermesFirstPickUp" }, Count = 2 },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0163",
					Text = "I held to faith your task would not require you above, only below. But Hermes indicates the threat here on the surface now looms larger than we thought. Rise to us, then; whenever Time permits." },
			},
			SeleneAboutChaos01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0223",
					Text = "You bear the mark of Chaos, little star. The most ancient being in existence lost a child to our common foe. Thus, the great creator becomes the great destroyer, through you." },
			},

			SeleneLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01", "P_Shop01", "P_PreBoss01" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0177",
					Text = "The Boatman Charon is familiar with every twisted pathway through this world. Yet, I provide for him my light nevertheless. He need not always find his way alone." },
			},
			SeleneLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01", "P_Shop01", "P_PreBoss01" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0217",
					Text = "I do not care to see the glimmer of the golden coins that Charon takes from you. It is far too much like the light of day, which likewise I can stand only so long." },
			},

			-- Repeatable
			SeleneChat01 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0004",
					Text = "May my light guide you on, and blind your enemies." },
			},
			SeleneChat02 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0005",
					Text = "I shine only for you now, little star." },
			},
			SeleneChat03 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0006",
					Text = "Together, little star, we shall always shine." },
			},
			SeleneChat04 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0007",
					Text = "Until the Silver Sisters can lay down their arms." },
			},
			SeleneChat05 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0008",
					Text = "I hear your call and bring my luminance." },
			},
			SeleneChat06 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0009",
					Text = "I am the Eye of Night, and shall watch over you." },
			},
			SeleneChat07 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0010",
					Text = "I have descended, and my light again is yours." },
			},
			SeleneChat08 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0011",
					Text = "My light is at full strength, and yours to do with as you please." },
			},
			SeleneChat09 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0012",
					Text = "Though my light wanes for now, I have enough to spare." },
			},
			SeleneChat10 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0013",
					Text = "My steeds were more than happy for this moment's rest." },
			},
			SeleneChat11 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0014",
					Text = "You have such hidden strength, so clear to me..." },
			},
			SeleneChat12 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "~=",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0015",
					Text = "The night is clear, my steeds are fresh; our power, unsurpassed." },
			},
			SeleneChat13 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0016",
					Text = "The night is dark; my steeds require rest. But I shall spare what power I yet have." },
			},
			SeleneChat14 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0017",
					Text = "My light is waning presently, although I always have some in reserve for you." },
			},
			SeleneChat15 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0018",
					Text = "As we are Silver Sisters, all my strength is yours." },
			},
			SeleneChat16 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0019",
					Text = "Take now my luminance, and shine as brightly as do I." },
			},
			SeleneChat17 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0039",
					Text = "My steeds are fresh, my strength is at its peak. And presently, so too shall be your own." },
			},
			SeleneChat18 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0020",
					Text = "To struggle is a phase; we ride it out as though it were the sky." },
			},
			SeleneChat19 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},					
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0021",
					Text = "A new night sky affords a new beginning, does it not?" },
			},
			SeleneChat20 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0022",
					Text = "You called to me, and now my brilliance is yours." },
			},
			SeleneChat21 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0023",
					Text = "The dark of night envelops us; let us expel our light." },
			},
			SeleneChat22 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0024",
					Text = "My silver light is yours again to wield as you wish." },
			},
			SeleneChat23 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0025",
					Text = "Within my brilliance, may all of your intentions be concealed." },
			},
			SeleneChat24 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0026",
					Text = "Once more we meet in secret in the dead of night." },
			},
			SeleneChat25 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0027",
					Text = "Oh, how your silver shines when bathed within my light." },
			},
			SeleneChat26 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0028",
					Text = "Ours is a neverending cycle, Sister, is it not?" },
			},
			SeleneChat27 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0029",
					Text = "It pleases me whenever you have opportunity to call." },
			},
			SeleneChat28 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0031",
					Text = "Our enemy resides in darkness, but he cannot hide from us." },
			},
			SeleneChat29 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0032",
					Text = "It seems you need my power more than I do, little star." },
			},
			SeleneChat30 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0033",
					Text = "I see you, little star, and I am here for you whenever you require." },
			},
			SeleneChat31 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0034",
					Text = "I do not need my luminance to see that your Headmistress trained you well." },
			},
			SeleneChat32 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0035",
					Text = "Patience and relentlessness, Sister. Now, here." },
			},
			SeleneChat33 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0036",
					Text = "As I am full, I almost feel a tinge of pity for our enemies..." },
			},
			SeleneChat34 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0037",
					Text = "Let us begin this phase of our collaboration, little star." },
			},
			SeleneChat35 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0038",
					Text = "The night grows dark again, though you possess what light I now can offer." },
			},
			SeleneChat36 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0040",
					Text = "Even in darkest Erebus, I hear and see you, little star." },
			},
			SeleneChat37 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0041",
					Text = "Light such as mine may cut straight through the surface, down to you." },
			},
			SeleneChat38 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0042",
					Text = "The city of Ephyra welcomes your return, such as it can." },
			},
			SeleneChat39 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0043",
					Text = "I always shall illuminate your journey to the mountain of the gods." },
			},

		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			SeleneGift01 =
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
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
				},
				{ Cue = "/VO/Melinoe_0484", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "Selene, I now send to you the Nectar of the gods, that it may warm your passage 'cross the sky!" },
				{ Cue = "/VO/Selene_0066",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					Text = "But, little star, you offer this to me? The connection that we share as Silver Sisters is already more than I can ask. Now be that as it may, {#Emph}I {#Prev}have something for {#Emph}you." },
			},
			SeleneGift02 =
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
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
				},
				{ Cue = "/VO/Melinoe_0485", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "To you, Selene! I never feel lost knowing the Moon herself is there to help me find my path." },
				{ Cue = "/VO/Selene_0067",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					Text = "You are most kind to honor me this way. It doubtless shall sustain my steeds and me on long nights such as these. You have our thanks." },
			},
			SeleneGift03 =
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
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
				},
				{ Cue = "/VO/Melinoe_0486", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "O Moon, my steady friend through all these nights, I have for you this humble offering!" },
				{ Cue = "/VO/Selene_0068",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					Text = "I am grateful for your generosity. Though the kinship that we share is more than sufficient, and makes the lonely nights seem to soar by." },
			},
			SeleneGift04 =
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
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
				},
				{ Cue = "/VO/Melinoe_0487", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "Great Eye of Night, who watches over me, may your brilliance always shine across the world." },
				{ Cue = "/VO/Selene_0069",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					Text = "The customary gifting of the gods... I am becoming fond of this cycle. Some traditions of Olympus may be worth adopting after all." },
			},

			-- placeholder
			SeleneGift05 =
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

			{ Cue = "/VO/Melinoe_1733", Text = "You honor me, Sister." },
		},
	},
}

OverwriteTableKeys( LootData, LootSetData.Selene )