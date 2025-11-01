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
		RequireUseToGift = true,
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

		ReplaceSpecialForGoldify = true,
		GoldifyValue = 500,
		GoldConversionEligible = true,

		ResourceCosts =
		{
			Money = 100,
		},
		SetupEvents =
		{
			{
				FunctionName = "PregenerateSpells",
			},
		},
		ConfirmSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
		
		Color = { 100, 25, 255, 255 },
		LightingColor = { 100, 25, 255, 255 },
		LootColor = { 100, 25, 255, 255},
		PortraitEnterSound = "/SFX/Menu Sounds/LegendaryBoonShimmer",

		SpeakerName = "Selene",
		Speaker = "NPC_Selene_01",
		LoadPackages = { "Selene", },
		Portrait = "Portrait_Selene_Default_01",
		NarrativeContextArt = "DialogueBackground_Moon",
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
			{ GlobalVoiceLines = "SeleneSaluteLines" },
		},

		PickupFunctionName = "SpellDropInteractPresentation",
		PickupVoiceLines =
		{
			-- Queue = "Interrupt",
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
				{ Name = "SeleneAppearanceSpeech", Time = 3 },
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
				TriggerCooldowns = { "SeleneAppearanceSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/Selene_0116", Text = "Good evening." },
				{ Cue = "/VO/Selene_0117", Text = "I bid you welcome." },
				{ Cue = "/VO/Selene_0118", Text = "I have returned." },
				{ Cue = "/VO/Selene_0119", Text = "We reunite." },
				{ Cue = "/VO/Selene_0131", Text = "I have something for you." },
				{ Cue = "/VO/Selene_0132", Text = "This is for you." },
				{ Cue = "/VO/Selene_0149", Text = "This is for you." },
				{ Cue = "/VO/Selene_0133", Text = "Awaken your true strength." },
				{ Cue = "/VO/Selene_0399", Text = "There you are." },
			}
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "SeleneGrantsHiddenAspect01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3529", Text = "{#Emph}I see you bring bliss and destruction in your outstretched arms..." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 1.05,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "SeleneGrantsOlympianDuos01" },
					},
				},

				{ Cue = "/VO/MelinoeField_2764", Text = "Thank you, Selene." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.05,
				SkipCooldownCheckIfNonePlayed = true,
				RecheckRequirementsPostWait = true,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.2,
				GameStateRequirements =
				{
					{
						PathTrue = { "ActiveScreens", "SpellScreen" },
					},
					{
						PathTrue = { "SessionMapState", "DuoTalentEligible" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGrantsOlympianDuos01" },
					},
				},
				Cooldowns =
				{
					{ Name = "SeleneAnyQuipSpeech", Time = 6 },
				},

				{ 
					GameStateRequirements = {{ PathTrue = { "SessionMapState", "DuoTalentEligibleGender", "Male" }}},
					Cue = "/VO/Selene_0438", Text = "A god may cross your Path..." 
				},
				{ 
					GameStateRequirements = {{ PathTrue = { "SessionMapState", "DuoTalentEligibleGender", "Female" }}},
					Cue = "/VO/Selene_0439", Text = "A goddess may cross your Path..." 
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				PreLineWait = 1.05,
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
				{ Cue = "/VO/Selene_0480", Text = "For the glory of the Silver Sisters, little star.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "SeleneGift09" }
						},
					},
				},
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
					InputDelay = 8.0,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { StartWait = 2.25, Portrait = "Portrait_Mel_Intense_01", EndWait = 5.7, SetBoonAnimation = true },
					PostLineFunctionName = "SpellDropInteractPresentation",
					PostLineFunctionArgs = { SkipInteractAnim = true },
					PortraitExitAnimation = "Portrait_Mel_Intense_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "She's deviated from her path... \n\n {#Emph}Great Titaness, the Eye of Night, \n {#Emph}I draw you down; lend me your might!" },
				{ Cue = "/VO/Selene_0158",
					PortraitExitWait = 1.25,
					Text = "Good evening to you, little star. Our cycles now are intertwined, as I no longer can afford merely to watch. Whichever threat we face, I vow to shine for you." },
			},

			SeleneAboutTask01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0053",
					Text = "I regret our meetings are in haste, and that we are unable to converse when thus we meet. I am expected high aloft for all to see. Our connection is to remain as hidden as the Crossroads. We are to move in shadows." },
			},

			SeleneAboutHecate01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "F_PostBoss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0063",
					Text = "Little star, you grow in strength and knowledge rapidly. How proud your Headmistress must be that you are able to surpass her finally. Yet, we know the burden that you bear." },
			},
			SeleneAboutHecate03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "HecateMissing" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0064",
					Text = "Of late, your Headmistress asked me, do not your rides across the sky become monotonous? I was amused to hear her jest. Each night is like none other I have known." },
			},

			SeleneBackstory01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0215",
					Text = "Long have I been the Eye of Night, watching you grow and train in secrecy; knowing that upon some evening such as this, we Silver Sisters would make our stand. Shall we go?" },
			},
			SeleneAboutSpeech01 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0221",
					Text = "All beings struggle to communicate. I learnt from Nyx how to express myself, as you, from your Headmistress. Our speech is rooted in the past; our connections, tenuous." },
			},
			SeleneAboutNyx01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0056",
					Text = "You have no memory of Nyx? It was the Night herself who found me, discarded and unwanted, and raised me from my youth. But when the Titan Chronos took the House of Hades, she was there. I miss her still." },
			},
			SeleneAboutNyx02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0057",
					Text = "On nights as dark as this I think only of Nyx. She ruled the Underworld within your father's House. And she cared for me, among so many others. She knew I sought the heavens. {#Emph}Go{#Prev}, she said. {#Emph}And please keep watch for me up there." },
			},
			-- alt below
			SeleneAboutNyx03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutNyx01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutNyx03_B" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0058",
					Text = "Mother Nyx, in all her grace, began referring to me as the Eye of Night, for I could see even where she could not. This honor spurs me even now, just as I spur my steeds. We shall avenge her, little star." },
			},
			SeleneAboutNyx03_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutNyx01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutNyx03" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0058_B",
					Text = "Mother Nyx, in all her grace, began referring to me as the Eye of Night, for I could see even where she could not. This honor spurs me even now, just as I spur my steeds." },
			},

			SeleneAboutNyxReturn01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0368",
					Text = "Nyx is finally returned to us, and perhaps in time, you may come to know her as do I. Although her influence never faded, I missed her wisdom and her presence very much. And have you to thank for our reunion." },
			},

			SeleneAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0156",
					Text = "The Titan Chronos, he is Time itself. Thus by his nature, we can never be entirely prepared for him. He seeks the downfall of Olympus, but how exactly, we still do not know." },
			},
			SeleneAboutChronosBossL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0175",
					Text = "You have descended into Tartarus, and must have seen what Chronos made of that most-sacred place. I know your confrontation did not go as you desired, but this is a new night. And you are all the more prepared." },
			},
			SeleneAboutGoodChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0366",
					Text = "I harbored such hatred for the Titan Chronos, for all that he had done; for all he put you through. Yet now he himself is working to undo the harm he caused? Such power you possess, to have brought about such change." },
			},

			SeleneAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0322",
					Text = "That foolish Titan. He has awakened Typhon, the most terrible monstrosity that ever lived. I still bear my scars from when we first clashed very long ago. Together, we did vanquish him before; we shall have to manage it again." },
			},
			SeleneAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0341",
					Text = "The monster Typhon, he has known defeat before. He has since grown in size, and strength, and fury, yet I hold to every faith you shall emerge victorious against him, little star." },
			},
			SeleneAboutTyphonW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0342",
					Text = "Not even a monstrosity such as Typhon could resist you, little star. Your Headmistress and I always knew of your potential. Now, I have witnessed you live up to it, and more." },
			},
			SeleneAboutTyphonW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeStormStop" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0343",
					Text = "By now, that monster Typhon must remember the bitter taste of defeat, yet he does not relent. Thus he has left us with no choice but to pursue the means of his annihilation, little star." },
			},

			SeleneAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutFates01", "HecateBossAboutFates01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0172",
					Text = "I know through your Headmistress of your vision in which Chronos found and captured the Three Fates. This must have been a key component of his plan... but, it does {#Emph}not {#Prev}change ours. The Silver Sisters never cede control." },
			},
			SeleneAboutHelios01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "SeleneAboutNyx01", "SeleneAboutNyx02", "SeleneAboutNyxReturn01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0103",
					Text = "Nyx spoke highly of your brother to me, little star. I too am distant from my brother Helios, the Sun. Sometimes I slow my steeds to catch a glimpse of him as he engulfs the surface. I do not think we would have much to talk about." },
			},
			SeleneAboutEos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutEosAspect01" }, Min = 2 },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0104",
					Text = "Perhaps some morning on the surface you shall finally see Eos, little star. She is quite beautiful, so much that mortals now admire her. But I have never known her very well. She makes her brief appearances, then she is gone." },
			},
			SeleneAboutEosAspect01 =
			{
				PlayOnce = true,
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

			SeleneAboutSeleneAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0336",
					Text = "Behold the Aspect of Xinth that I once wielded, little star; perhaps shall wield again some other age. Back then my light was widely feared, until a subtler approach worked best for me. But you need not hold back." },
			},
			SeleneAboutSeleneAspect02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0337",
					Text = "As bearer of my Aspect of the Black Coat, you instinctively know how to use the Sky Fall Hex; a hidden strength of mine, whose light you may reshape each evening through the Path of Stars." },
			},
			SeleneAboutSeleneAspect03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "SuitHexAspect5" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0338",

					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					Text = "How my Aspect of the Black Coat shines, for I can see it has achieved the apex of its power in your care. Such destruction it can sow that I yet have a certain fear of it myself." },
			},
			SeleneAboutAllSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAll = { "SuitHexAspect", "SpellTalentKeepsake", "SorceryRegenMetaUpgrade" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "SuitHexAspect5" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0484",
					Text = "You bear my Aspect, my Arcana, and my Moon Beam all at once? {#Emph}Oh{#Prev}, little star, you are yourself and need not seek to be like me. Although, perhaps my steeds would welcome a new rider at some point." },
			},

			SeleneAboutNyxAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0339",
					Text = "The Black Coat's Aspect of Mother Nyx... I knew that she once wielded Xinth herself but never witnessed it, for she could bend even {#Emph}my {#Prev}light aside. Such an honor that her Aspect has revealed itself to you." },
			},
			SeleneAboutHiddenAspects01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllHiddenAspects,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllHiddenAspects,
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0345",
					Text = "The hidden Aspects of the Arms of Night... I understand they come from distant gods and goddesses of darkness... all obscure, some likely bearers yet-to-be. Perhaps there is an even deeper pattern that they share..." },
			},

			SeleneAboutLunarCycle01 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0077",
					Text = "We breathe, we bleed, we rest, we start anew. Did we create this cycle, or are we merely part of it? Sometimes I ask myself this question while I ride." },
			},
			SeleneAboutLunarCycle02 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0078",
					Text = "Let us begin another cycle, little star. Each has its unexpected qualities, but in the greater pattern lies a certain pleasure, does it not?" },
			},

			SeleneAboutDarkness01 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0080",
					Text = "So many mortals fear the onset of the dark, but we? The dark is merely where we ply our trade. Come forth, then, little star, and let us shine together in the darkness now." },
			},

			SeleneAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutKeepsake02", "SeleneAboutKeepsake03", "SeleneAboutKeepsake04" }, Min = 3 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0155",
					Text = "My Moon Beams are as innumerable as the stars, and you possess but one; but it is one I chose especially for you, and shall ensure that our connection remains strong." },
			},
			SeleneAboutKeepsake02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutKeepsake01", "SeleneAboutKeepsake03", "SeleneAboutKeepsake04" }, Min = 3 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0331",
					Text = "So long as you have my Moon Beam, I may locate you as swiftly as I can; and from that point, the night shall be ours. Choose now the means by which you shall prevail." },
			},
			SeleneAboutKeepsake03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake", 1, "Rarity" },
						IsAny = { "Rare", "Epic", "Heroic" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutKeepsake01", "SeleneAboutKeepsake02", "SeleneAboutKeepsake04" }, Min = 3 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0332",
					Text = "You bear the solitary Moon Beam that I gave you as a token of our bond and combined strength. Soon you shall shine as I do, and your enemies shall have nowhere to hide." },
			},
			SeleneAboutKeepsake04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "SpellTalentKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutKeepsake01", "SeleneAboutKeepsake02", "SeleneAboutKeepsake03" }, Min = 4 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0340",
					Text = "That Moon Beam of yours has grown exceptionally bright within your care. It shall illuminate your path forevermore; its power, at its peak. And whenever you have need of me, I shall be there." },
			},

			SeleneAboutDagger01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "AxePerfectCriticalAspect", "AxeRallyAspect" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0227",
					Text = "You wield the Moonstone Axe, whose broad blade shimmers with my light. Then you must hear the song it sings. Such strength, combined with yours." },
			},
			SeleneAboutTorch01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
					--[[
					{
						SumPrevRuns = 8,
						Path = { "WeaponsUnlocked", "WeaponLob" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0229",
					Text = "You now possess the Argent Skull Revaal... an everlasting reminder that Death and Fear ought always to be allies in our cause. Woe unto whomever meets her gaze." },
			},
			SeleneAboutSuit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
					--[[
					{
						SumPrevRuns = 8,
						Path = { "WeaponsUnlocked", "WeaponSuit" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0318",
					Text = "The Black Coat... Night's veil and final defense, now yours. You bear a grave responsibility to wield it properly... or unleash such destruction as can blot out the Sun." },
			},

			SeleneAboutSteeds01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift06", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0081",
					Text = "My ride across the sky tends to be quite a solitary one. I have my steeds to speak to, yes. But it is not the same as when I have the opportunity to speak with you." },
			},
			SeleneAboutSteeds03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- sum of the current and two previous two runs
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "SpellDrop" },
						Comparison = "==",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift03" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0086",
					Text = "It has been too long since I saw you last. My steeds had grown rather exhausted from our rides. Where would I be if not for them? Closer to you, yes, but... this is where we belong." },
			},

			SeleneRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0102",
					Text = "You have gone far since last we met... especially for someone with no steeds. Thus I commend you, and may all of your future attempts in turn succeed." },
			},
			SeleneRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0173",
					Text = "You faced the Titan in the lowest depths... that much I knew before your Headmistress confirmed you vanquished him, as I had faith you would. If his life-force is like grains of sand, then you took one; eventually, {#Emph}all." },
			},
			SeleneRunCleared03 =
			{
				PlayOnce = true,
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
						Value = 4,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneRunCleared02" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0174",
					Text = "{#Emph}Death to Chronos. {#Prev}I sense that you are growing closer to manifesting the reality that we have long since sought. May you yet drain whatever light is left in him." },
			},

			SeleneSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0319",
					Text = "You braved the surface and the ardor of the journey to the mountain of the gods, then somehow withstood that monstrous being risen from the past... you are even more than I imagined, little star." },
			},

			SelenePostTrueEndingRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0370",
					Text = "You vanquished Chronos in another time...? Or {#Emph}of {#Prev}another time, and with the self-same Titan's aid. Such mysteries his power holds. But if this is what it takes for our time to flow freely forward, then let us see that it is done." },
			},
			SelenePostTrueEndingRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0371",
					Text = "The threat of Typhon now is gone to us, and yet you are ensuring with the Titan Chronos that even the possibility of such a threat cannot exist? Then so mote it be; as Silver Sisters, we safeguard the realm by all our means." },
			},

			SelenePostGift01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0087",
					Text = "If only you could see the world from where I ride. Some night perhaps? I know just how much ugliness there is. But, it is rather hidden from afar." },
			},

			-- higher-priority alt below
			SeleneAboutBountyBoard01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutBountyBoard01_B" }
					},
					{
						SumPrevRuns = 2,
						Path = { "ActiveBounty" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0224",
					Text = "I felt a weight drawing me toward the Crossroads recently, and realized it was the Pitch-Black Stone. So then it has awakened... almost like an Eye itself, but far older than mine, and peering from the infinite abyss." },
			},
			SeleneAboutBountyBoard01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutBountyBoard01" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountySpellCast", "PackageBountyHecate" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0224",
					Text = "I felt a weight drawing me toward the Crossroads recently, and realized it was the Pitch-Black Stone. So then it has awakened... almost like an Eye itself, but far older than mine, and peering from the infinite abyss." },
			},
			SelenePackageBountyIntro01 =
			{
				PlayOnce = true,
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
				{ Cue = "/VO/Selene_0225",
					Text = "This strange sensation... I remember what it is: the whims of Chaos, affecting our surroundings even if in subtle ways. I have faith that this is due to your actions, not chance." },
			},

			SeleneAboutPackageBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountySpellCast", "PackageBountyHecate" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0218",
					Text = "I sense that something is amiss tonight... as though I did not find you by my will. The Pitch-Black Stone... I see, of course. It is a weight on everything that we perceive." },
			},
			SeleneAboutRandomBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutChaos01" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.AllRandomPackagedBounties,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0476",
					Text = "I sense the greater influence of Chaos on this night, and thus the journey to your destination may take unexpected turns. May my light still be of guidance even now." },
			},

			SeleneAboutErebus01 =
			{
				PlayOnce = true,
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
					{
						PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0166",
					Text = "I feel you closer to my light. You suppressed that Fate-wrought curse that binds you to your realm. I was uncertain such a thing was possible... yet you surprise me fairly often, little star." },
			},

			SeleneAboutSurfaceWards01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0165",
					Text = "You dispelled the Crossroads surface gateway wards... traversed the veil between the world you know and this one that I look upon each night. Perhaps our plan required this new phase..." },
			},

			-- alt below
			SeleneAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SeleneAboutSurfaceCurse01", "SeleneAboutSurface01_B" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0097",
					Text = "I welcome you to our world's surface, little star. I knew you would discover your way here. If you feel lost, you need but look to me. And I shall always be watching." },
			},
			SeleneAboutSurface01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutSurface01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0167",
					Text = "I ought to welcome you more formally to our world's surface, little star. Part of me knew you would discover your way here. If you feel lost, you need but look aloft." },
			},
			SeleneAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutSurface01", },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutSurface03" }, Min = 4 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0098",
					Text = "The city of Ephyra has seen so much strife. If only you could have witnessed it when its people still worshiped your mother and father. We shall avenge them all." },
			},
			SeleneAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutSurface02" }, Min = 4 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0220",
					Text = "Here my light yields no greater strength than you experience below, for I give all I safely can wherever you reside. To be dependable and constant is my charge." },
			},

			SeleneAboutSurfaceWar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" }
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutHermesMission02" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0160",
					Text = "We need you where you are. Your battles through the Underworld are consequential to the war that rages here. But leave the surface to the gods, and me. Do not become distracted by the sealed Crossroads gateway leading up." },
			},

			SeleneAboutOceanus01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						Path = { "CurrentRun", "BiomeDepthCache" },
						Comparison = "<=",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0170",
					Text = "From your perspective, those waters must appear to have no end. But they {#Emph}do {#Prev}end, and you have means to quickly cut across. I shall watch you sail on and help you make haste." },
			},

			SeleneAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift03", "NemesisGift03" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0100",

					Text = "Here in the sky, I am immune to earthly troubles, such as having to share living space with the goddess of retribution. Nemesis never treated me as a sister. She inherited only her mother's strength." },
			},
			SeleneAboutNemesis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneAboutNemesis01", "SeleneGift05", "NemesisBathHouse03" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutNemesis01", "NemesisBathHouse03" }, Min = 3 },
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0460",
					Text = "You have made peace with Nemesis, and more; perhaps beneath the surface she is not the goddess she has always seemed. If you deem her worthy, little star, that is enough." },
			},

			SeleneAboutMoros01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift01", "MorosGift03" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Moros_01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0458",

					Text = "You have conversed more and more frequently with Doom himself; a son of Nyx with whom I am not close. I shall rely upon your instincts about him, for mine say little as of yet." },
			},

			SeleneAboutHypnos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Hypnos_01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" }
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0101",
					Text = "I remain troubled by the ever-sleeping son of Nyx, there in your Crossroads. Neither your Headmistress nor I have thus been able to awaken him. But every ailment must have a remedy..." },
			},
			SeleneAboutHypnosWakeUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0465",
					Text = "You have grown in experience so much using your craft that you managed even to rouse ever-sleeping Hypnos from his dreams? Mother Nyx has notified me that he is now back at his post, though with considerable make-up work..." },
			},

			SeleneAboutMedea01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Story01", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0330",
					Text = "The witch Medea learned to blot out my light, creating an eclipse whenever she required. We had a conversation after that, and all is well between us ever since. Between her curses and my Hexes, you shall be feared." },
			},
			SeleneAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						-- reached Circe this run
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "O_Story01", },
							},
						},
						-- reached Circe last run & heading to Olympus, not in a Chaos Trial
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "O_Story01", },
							},
							{
								PathTrue = { "CurrentRun", "BiomesReached", "N" },
							},
							{
								PathFalse = { "CurrentRun", "ActiveBounty" },
							},
						},
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0351",
					Text = "Long has the enchantress Circe understood that I do more than merely ride across the sky. She practices her incantations in accordance with the phases of my light; you can depend upon the power she bestows." },
			},
			SeleneAboutIcarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift03", "IcarusGift03" },
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Icarus_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0459",
					Text = "How unusual to see the wings of Icarus soaring across the sky. I recall how you encouraged him to overcome his apprehensions and take flight. I shall be watching to ensure he stays aloft." },
			},

			SeleneAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = {
							"HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0113",
					Text = "I saw that you encountered Heracles. Beware that man, who has made many enemies in service to the gods. He even wronged me once, and still walks brazenly as ever in my light." },
			},
			SeleneAboutHeracles02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneAboutHeracles01", "SeleneGift02", "HeraclesGift02" },
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = {
							"HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatP", "HeraclesCombatP2" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutHeracles01" }, Min = 2 },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0462",
					Text = "The lion pelt now worn by Heracles, he took it from a creature dear to me. I hated him, though he was acting at the behest of the gods, who sought to see him prove his fealty. I have since learned to leave my anger far behind." },
			},

			SeleneAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0099",
					Text = "The Cyclops Polyphemus, whom you faced, once hid within a cavern not even {#Emph}my {#Prev}silver light could reach. Now he has taken sides with Chronos. Too many rise against the gods..." },
			},
			SeleneAboutPolyphemus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PolyphemusAboutAltFight01", "PolyphemusAboutAltFight01_B" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 2,
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0461",
					Text = "How strange to see ungainly Polyphemus and Medea work together, even if the Vow of Rivals was the cause. Though stranger is how that Cyclops is the second shepherd I have known with a propensity for lengthy sleeping spells..." },
			},

			SeleneAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutEris02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0176",
					Text = "Black-winged Eris has become an obstacle; she sometimes flies across my path, thus startling my steeds. I am the Eye of Night yet cannot see much worth in her at all..." },
			},
			SeleneAboutEris02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift05", "ErisTaverna02" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneAboutEris01" }, Min = 2 },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0464",
					Text = "I had my doubts concerning your companionship with Eris, though now realize that you must see something in her, which even I cannot. You are most patient to accept one such as she." },
			},

			SeleneAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0321",
					Text = "The Titans never stood together even when the gods and Chronos first fought long ago. Prometheus... he stood with Zeus back then, but now? His purposes are crossed with ours. Another enemy of my own kind..." },
			},
			SeleneAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutMortals01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SelenePostEpilogue01" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0344",
					Text = "The Titans Chronos and Prometheus have forged an alliance, yet are not so much alike. Prometheus longs for a world in which mortals do not answer to gods? He of all beings must know that shall never come to pass." },
			},
			SeleneAboutPrometheus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
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
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 3,
							},
						},
						{
							{
								SumPrevRuns = 2,
								Path = { "EncountersOccurredCache" },
								TableValuesToCount = {
									"HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0463",
					Text = "The Titan of Foresight is conspiring with Heracles. Perhaps their love of mortalkind unites them; that or their relation to the gods. I felt they could have been each other's rivals, not your own." },
			},

			SeleneAboutSilverSisters01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0348",
					Text = "Nothing escapes the notice of the Silver Sisters: I, in the heavens; the goddess of the hunt, on the surface; you, beneath the earth; and the Witch of the Crossroads, between realms. Now we no longer merely observe, but act." },
			},
			SeleneAboutMission01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisFirstMeeting" }, Max = 4 },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0347",
					Text = "Artemis revealed to Olympus what they need to know of you, and now is ranging through your woods. After our troubles have subsided, may all we Silver Sisters rejoice." },
			},

			SeleneAboutArcana01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAll = { "SorceryRegenMetaUpgrade" },
					},
					{
						Path = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Level" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0483",
					Text = "I sense the influence on you of the Arcana for which I am personally known. Then let the magick course through you, and may whichever Hex you manifest lead you to glory." },
			},

			SeleneAboutTalentDrop01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "TalentDrop" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "UseRecord", "TalentDrop", },
						Comparison = "<=",
						Value = 40,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0168",
					Text = "You have seen the Path of Stars, and experienced its connection to my strength and yours. Though our Paths may diverge at times, they often lead us to a single point." },
			},

			SeleneAboutMagick01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsFiredRecord" },
						CountOf = { "WeaponSpellLeap", "WeaponSpellTimeSlow", "WeaponSpellTransform", "WeaponSpellPotion", "WeaponSpellMeteor", "WeaponSpellSummon", "WeaponSpellLaser", "WeaponSpellPolymorph" },
						Comparison = "<",
						Value = 6,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Boss01" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0079",
					Text = "Remember, little star: The magick that my light awakes in you requires active focus on your part; it has no power without your intent. In moments when you need it, do not hesitate." },
			},
			SeleneAboutMagick02 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0055",
					Text = "This gift of magick does not come from me, but from within. Yet, it is also true my luminance awakens innate possibility. An ill-kept secret even mortals of the surface know." },
			},
			SeleneAboutHexes01 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0216",
					Text = "My innumerable journeys through the sky provided me with ample time to understand my light. By now, I have a Hex for each occasion, every phase. And you shall have them, too." },
			},
			SeleneAboutHexes02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponSpellLeap" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "SpellPolymorphTrait" },
						Comparison = ">=",
						Value = 2,
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
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 8,
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
					]]--
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0169",
					Text = "At last you looked upon the Oath of the Unseen... for this night is beyond compare with any I experienced in an age. It is as though Darkness suffuses {#Emph}everything..." },
			},
			SeleneAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0359",
					Text = "You may enact the Testament of Night this eve, as difficult as it may be to overcome the growing Fear that spreads with each and every uttered Vow. I shall be your witness." },
			},
			SeleneAboutShrine03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0360",
					Text = "This night has grown particularly dark, and Fear has spread to every recess of the realms; your doing through the Oath, is that not so? Then do be careful, little star, for none can save you from the choices that you make." },
			},

			SeleneAboutShrineComplete01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "AllShrineBountiesCompleted" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0361",
					Text = "At first, I felt my senses had deceived me, but I grow more certain with each passing eve... you have enacted all the Testaments within the Oath...! And thus for now, the will of Night is truly done. I am in awe of your resilience." },
			},

			SeleneAboutOdysseus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Odysseus_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift03", "OdysseusGift03" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0073",
					Text = "You are fortunate to learn from the wanderer Odysseus. I used to follow all his mortal struggles, from his warring to his voyages. Some of the tales about him are embellished, but not all. He is an interesting man." },
			},

			SeleneAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ApolloFirstPickUp", "ZeusFirstPickUp", "PoseidonFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0076",
					Text = "If the might of Olympus were sufficient, the gods would have already put an end to their predicament. Time itself is against us, yet this is precisely the time for which we Silver Sisters have prepared." },
			},
			SeleneAboutOlympus02 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0059",
					Text = "Olympus has no sense of my true strength, or yours. But it is just as well. We are most powerful when we remain obscure; when we are underestimated. Would you not agree?" },
			},

			SeleneAboutPersephone01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01", },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0074",
					Text = "We shall see to it that the rightful Queen and King of the Underworld retake their throne. Your father I knew only from Nyx's account, though I would see your mother when she visited Olympus. You have her regal bearing, little star." },
			},

			SeleneAboutPhases01 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0082",
					Text = "The great night sky affords an advantageous vantage-point, and I see your struggles plain. Know that the hardship you endure is but a phase. Seek pleasure in the rhythm of it all." },
			},
			SeleneAboutPhases02 =
			{
				PlayOnce = true,
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0485",
					Text = "Each of us undergoes different phases throughout our lives. I but go through phases far more regularly, and more often than do most... for I have always valued constancy, in an existence whose sole constancy is change." },
			},

			SeleneAboutNewMoon01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0070",
					Text = "You have lost much of your lifeblood already. Then perhaps I am too late this time. But while you still can stand, you still can harness the great power I illuminate in you." },
			},
			SeleneLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0071",
					Text = "Such injuries you have sustained already, little star. Pain, it seems, is built into the cycle of our lives. I cannot make it go away; but you may learn to set it well aside." },
			},
			SeleneLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0072",
					Text = "You are hurt; your light is waning, little star. Do not lose heart. Our light never goes out. A new moon always rises." },
			},
			SeleneLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0468",					
					Text = "Your foes made you shed too much blood already on this night. Soon enough it all shall be renewed, but until then, spill not another drop and struggle to survive." },
			},

			-- run starts
			SeleneRunStartIntro01 =
			{
				PlayOnce = true,
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
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0230",
					Text = "Chronos can wait, for he is Time itself. You turn your energies instead toward his armies on the surface, and can slow him down that way. Growing stronger all the while." },
			},
			SeleneAboutSwitchToSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "F" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 5,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0469",
					Text = "I have grown so accustomed to locating you within the Underworld that I am still surprised at times to find you aboveground. This is easier for me, yet more difficult for you, is it not?" },
			},
			SeleneAboutSwitchToUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
					{
						SumPrevRuns = 5,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0470",
					Text = "At last you returned to the realm of shadow after many nights under the naked stars. For what must be done, better for you to be in your element than for me to be in mine." },
			},

			SeleneRunSwitchPostClear01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0471",
					Text = "I see what you now seek to do. With the Titan Chronos reeling from his latest loss, it is an opportunity to aid Olympus in its plight. Shine forth then for the gods." },
			},
			SeleneRunSwitchPostClear02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0473",
					Text = "You possess strength enough even to match with monsters such as Typhon, as the Titan Chronos now must know full well. Perhaps he shall experience dread anticipating you." },
			},
			SeleneRunSwitchPostLoss01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 3,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0474",
					Text = "At least you proved to be a suitable distraction for Typhon last night. You shall have other opportunities to vanquish him, perhaps after the Titan Chronos falls to you this eve." },
			},

			SeleneAboutWinStreak01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						SumPrevRuns = 4,
						-- CurrentRun hasn't 'turned over' yet so this isn't needed
						IgnoreCurrentRun = true,
						Path = { "Cleared" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0475",
					Text = "Night after night, your victories have mounted, and I should like to see you earn another soon enough. Perhaps with my light you can readily ensure the outcome we desire." },
			},

			SeleneAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{

				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0482",
					Text = "Mortals often look upon us either with great reverence or fear; and thus they tell each other tales, making us out to be more than we are, or less. I have ceased blaming them, for what else are they to do?" },
			},

			-- about other gods
			SeleneAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0350",
					Text = "The great King of the Olympians bestowed on you some of his thunderous strength. It ought to be more than sufficient on its own, but let us not leave anything to chance." },
			},
			SeleneAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0092",
					Text = "It is uncommon to have earned Queen Hera's Boon. She would confide in me sometimes while she would bathe. She has been more guarded as of late... as have we all." },
			},
			SeleneAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0090",
					Text = "The sea-god's strength already flows through you? Poseidon holds that he alone controls the tides. For this I cannot blame him. He does not know or understand my influence." },
			},
			SeleneAboutApollo01 =
			{
				PlayOnce = true,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0088",
					Text = "I see you shine already with another light. The god Apollo's doing, I should think. Fear not; his power is compatible with mine. Light envelops light, never rejecting." },
			},
			SeleneAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "GameState", "UseRecord", "DemeterUpgrade" },
						Comparison = "<=",
						Value = 10,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0094",
					Text = "At last you met the goddess of seasons, whose great power often shapes the course of my night's ride. In Demeter, you have a fierce supporter, I can tell." },
			},
			SeleneAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0091",
					Text = "I watched the goddess Aphrodite seek you out. From her I learned a bit of how to influence the heart. But only when my strength is at its peak, and even then, I fear I pale in comparison." },
			},
			SeleneAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0157",
					Text = "A Boon from Master Blacksmith Hephaestus is prized by warriors all the world over. To you he gives it readily, knowing Olympians alone cannot stop what has begun." },
			},
			SeleneAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0093",
					Text = "The fire-goddess Hestia always proved difficult to track, and yet she willingly revealed herself to you? Either your reputation grows, or does the desperation of the gods." },
			},
			SeleneAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0349",
					Text = "The god of war decided that his intervention is required, and has granted you some of his violent strength. It may seem difficult to trust in Ares, but his motivations I have found to be quite clear." },
			},
			SeleneAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0095",
					Text = "There is one god whose swiftness far surpasses any steed's. And he has granted some of it to you, I see. I caution you to not make {#Emph}too {#Prev}much haste. Steadfastness is the key to victory." },
			},
			SeleneAboutHermesMission01 =
			{
				PlayOnce = true,
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
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0163",
					Text = "I held to faith your task would not require you above, only below. But Hermes indicates the threat here on the surface now looms larger than we thought. Rise to us, then; whenever Time permits." },
			},
			SeleneAboutChaos01 =
			{
				PlayOnce = true,
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
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "I_PreBoss02", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
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
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "I_PreBoss02", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0217",
					Text = "I do not care to see the glimmer of the golden coins that Charon takes from you. It is far too much like the light of day, which likewise I can stand only so long." },
			},
			SeleneLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "I_PreBoss02", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0466",
					Text = "I would prefer that you would never have to give up anything to use my power, little star. But if a handful of gold coins lets me locate you even more reliably, then so be it." },
			},
			SeleneLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift03" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "I_PreBoss02", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0467",
					Text = "Among the children of Nyx, Charon has always been one of the most reserved. The kinship that you have with him is not a commonplace occurrence, little star." },
			},
			SeleneLootBought05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Shop01", "F_PreBoss01", "G_Shop01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "I_PreBoss02", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0369",
					Text = "Now that your father's throne has been restored and Mother Nyx is free, perhaps Charon shall resume transporting Shades of the dead to their eternal resting-place. Although I think he shall still see to it that you are well-supplied." },
			},

			SeleneAboutCardUpgradePoints01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades" },
						HasAll = { "WorldUpgradeCardUpgradePoints2" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "PrevRun", "WorldUpgradesAdded" },
						HasAny = { "WorldUpgradeCardUpgradePoints2" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0477",
					Text = "You have become proficient in concocting Moon Dust in your cauldron, little star. I would relinquish so much more to you, but it would be to no avail without your particular intent." },
			},

			SeleneGrantsHiddenAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "SuitHexAspect", "SuitMarkCritAspect" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "SuitHexAspect5", "SuitMarkCritAspect5" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "I_PreBoss01", "I_PreBoss02", "Q_PreBoss01" },
					},
					NamedRequirementsFalse =
					{
						"StaffHiddenAspectRevealInProgress",
						"DaggerHiddenAspectRevealInProgress",
						"TorchHiddenAspectRevealInProgress",
						"AxeHiddenAspectRevealInProgress",
						"LobHiddenAspectRevealInProgress",
						-- "SuitHiddenAspectRevealInProgress"
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0333",
					Text = "You have begun to understand the secrets of the Black Coat. One, I can share; a waking-phrase to utter by the Silver Pool: {#Emph}I see you bring bliss and destruction in your outstretched arms. {#Prev}Remember it, and speak it, little star." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2.5, Title = "HiddenAspectRevealed", Text = "HiddenAspectRevealed_Suit" },
				},
			},
			SeleneAboutHiddenAspectProgress01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "SuitHiddenAspectRevealInProgress" },
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0334",
					Text = "Have you yet spoken to the Silver Pool the waking-phrase I shared with you before? Take the words to heart: {#Emph}I see you bring bliss and destruction in your outstretched arms. " },
			},
			SeleneAboutHiddenAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitComboAspect" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0335",
					Text = "You bear the Aspect I revealed to you before. I know little of this Shiva save their reputation as destroyer of all things. Perhaps the Black Coat partly is responsible, though that is for you to discover now." },
			},
			SeleneGrantsOlympianDuos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "SessionMapState", "DuoTalentEligible" },
					},
					NamedRequirements = { "SeleneDuosUnlocked" },
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0346",
					Text = "Your relatives on Mount Olympus all are well aware of me, of course. In most respects, I now can aid you openly, and even they themselves may grant you greater strength using my light. Let them believe that strength is theirs alone." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2.5, Title = "SeleneDuosAdded", Text = "SeleneDuosAdded_Subtitle" },
				},
			},

			SelenePostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0365",
					Text = "This matter with the Titan Chronos was one of the greatest ordeals that the Silver Sisters ever faced, yet through it all, you have remained steadfast. I know that more is always to be done, but you have earned at least a new moon's rest." },
			},
			SelenePostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0367",
					Text = "Your Headmistress revealed more to me about your current charge; ensuring that our time flows freely forward from here on. I understand this newer task may have no end in sight, so bid you pace yourself accordingly." },
			},
			SelenePostTrueEnding03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0481",
					Text = "Such a joyous night it was when you and your Headmistress and the goddess of the hunt and I all rode together on my steeds. Now we are each once more where we belong, but the Silver Sisters are never truly apart." },
			},

			SelenePostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0382",
					Text = "Your Headmistress informed me that you finally located the Three Fates...? Then all is finally set right, although I feel as before... perhaps they wish to see what shall transpire if we each continue plotting out the course of our own lives." },
			},

			SeleneAboutAltFightQuest01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateBossGrantsShrineUpgrade01", "HecateGrantsShrineUpgrade01" }
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasNone = { "SeleneAboutAltFightQuest02", "SeleneAboutAltFightQuest03", "SeleneAboutAltFightQuest04", "SeleneAboutAltFightQuest05", "SeleneAboutAltFightQuest06" }
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0352",
					Text = "Upon the Oath of the Unseen is one Vow that may rise above the rest. It is my charge as Eye of Night to bear it witness, should you choose to speak this Vow of Rivals. Discover the extent of it, and overcome your strongest foes." },
			},
			SeleneAboutAltFightQuest02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0353",
					Text = "I heard you speak the Vow of Rivals at the Oath of the Unseen. Then you shall soon confront your Headmistress in all her dark glory; how she longed that you would gain the strength to face her thus." },
			},
			SeleneAboutAltFightQuest03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAll = { "BossHecate02", "BossPolyphemus02" },
					},
					{
						Path = { "GameState", "EncountersOccurredCache" },
						HasAll = { "MiniBossCharybdis" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SeleneAboutAltFightQuest04", "SeleneAboutAltFightQuest05", "SeleneAboutAltFightQuest06" }
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0354",
					Text = "You have surpassed each of the two initial obstacles posed by the Vow of Rivals, thus have gained insight with which you may induce still-greater Fear using this Vow. I shall be watching, for you are prepared." },
			},
			SeleneAboutAltFightQuest04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAll = { "BossScylla02", "BossEris02" },
					},
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasNone = { "BossInfestedCerberus02", "BossPrometheus02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SeleneAboutAltFightQuest05", "SeleneAboutAltFightQuest06" }
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0355",
					Text = "The second Guardians that bar your passage fell to you despite the Vow of Rivals granting them the strength of Night herself. But be forewarned: The Vow's effect shall grow more trying from here on." },
			},
			SeleneAboutAltFightQuest05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAll = { "BossInfestedCerberus02", "BossPrometheus02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SeleneAboutAltFightQuest06" }
					},
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "EncountersCompletedCache" },
								HasNone = { "BossChronos02" },
							},
						},
						{
							{
								Path = { "GameState", "EncountersCompletedCache" },
								HasNone = { "BossTyphonHead02" },
							},
						},
					}
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0356",
					Text = "You vanquished Cerberus the hound of hell as well as the Titan of Foresight and his ally, in spite of how the Vow of Rivals filled them with such might. I fear, however, that the Vow's full power shall be near-impossible to overcome..." },
			},
			SeleneAboutAltFightQuest06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAll = { "BossChronos02", "BossTyphonHead02" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0357",
					Text = "I never thought I would pay witness to what you achieved using the Oath of the Unseen. The Titan Chronos and monstrous Typhon, each laid low, your rivals all surpassed. {#Emph}You {#Prev}are the terror in the Night, not they." },
			},
			SeleneAboutAltFightQuestL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						-- failed VoR Hecate
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossHecate02"},
							},
							{
								PathFalse = { "PrevRun", "RoomsEntered", "F_PostBoss01" }
							},
						},
						-- failed VoR Polyphemus
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossPolyphemus02"},
							},
							{
								PathFalse = { "PrevRun", "RoomsEntered", "N_PostBoss01" }
							},
						},
						-- failed VoR Scylla
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossScylla02"},
							},
							{
								PathFalse = { "PrevRun", "RoomsEntered", "G_PostBoss01" }
							},
						},
						-- failed VoR Eris
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossEris02"},
							},
							{
								PathFalse = { "PrevRun", "RoomsEntered", "O_PostBoss01" }
							},
						},
						-- failed VoR Cerberus
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossInfestedCerberus02"},
							},
							{
								PathFalse = { "PrevRun", "RoomsEntered", "H_PostBoss01" }
							},
						},
						-- failed VoR Prometheus
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossPrometheus02"},
							},
							{
								PathFalse = { "PrevRun", "RoomsEntered", "P_PostBoss01" }
							},
						},
						-- failed VoR Chronos
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossChronos02"},
							},
							{
								PathFalse = { "PrevRun", "Cleared" }
							},
						},
						-- failed VoR Typhon
						{
							{
								PathTrue = { "PrevRun", "EncountersOccurredCache", "BossTyphonHead02"},
							},
							{
								PathFalse = { "PrevRun", "Cleared" }
							},
						},
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0358",
					Text = "The Oath of the Unseen compels you to exceed your limitations, but do not give in to the temptation to spread greater Fear than you are able to withstand. The Vow of Rivals is about not merely strength, but perseverance." },
			},

			SeleneAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateBathHouseEpilogue01", "SeleneGift10" },
					},
				},

				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0479",
					Text = "Our faith in one another needs no words. As we have gone through many phases thus, it is my preference to say little when we meet, and let the quiet of the night take hold." },
			},

			-- Repeatable
			SeleneChat01 =
			{
				
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
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift10", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0027",
					Text = "Oh, how your silver shines when bathed within my light." },
			},
			SeleneChat26 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0028",
					Text = "Ours is a never-ending cycle, Sister, is it not?" },
			},
			SeleneChat27 =
			{
				
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
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift04", },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0033",
					Text = "I see you, little star, and I am here for you whenever you require." },
			},
			SeleneChat31 =
			{
				
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
			SeleneChat40 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0478",
					Text = "Hail, fellow Silver Sister, and behold again my guiding light." },
			},
			SeleneChat41 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0491",
					Text = "All that transpires, we observe." },
			},
			SeleneChat42 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0492",
					Text = "We are most powerful when we remain obscure." },
			},
			SeleneChat43 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0493",
					Text = "Whenever you have need of me, I shall be there." },
			},
			SeleneChat44 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0494",
					Text = "Let us shine together, now and always." },
			},
			SeleneChat45 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0495",
					Text = "To be dependable and constant is my charge." },
			},
			SeleneChat46 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0496",
					Text = "The Silver Sisters never cede control." },
			},
			SeleneChat47 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0497",
					Text = "Together let us strive for victory." },
			},
			SeleneChat48 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0498",
					Text = "We breathe, we bleed, we rest, we start anew." },
			},
			SeleneChat49 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0499",
					Text = "Our light never goes out; a new moon always rises." },
			},
			SeleneChat50 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0500",
					Text = "Each night is like none other I have known." },
			},
			SeleneChat51 =
			{
				
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				PreEventFunctionName = "SpellDropInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Selene_0490",
					Text = "Steadfastness is the key to victory." },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0484", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Selene, I now send to you the Nectar of the gods, that it may warm your passage 'cross the sky!" },
				{ Cue = "/VO/Selene_0066",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
					Text = "But, little star, you offer this to me? The connection that we share as Silver Sisters is already more than I can ask. Now be that as it may, {#Emph}I {#Prev}have something for {#Emph}you." },
			},
			SeleneGift02 =
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
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0485", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To you, Selene! I never feel lost knowing the Moon herself is there to help me find my path." },
				{ Cue = "/VO/Selene_0067",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0486", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "O Moon, my steady friend through all these nights, I have for you this humble offering!" },
				{ Cue = "/VO/Selene_0068",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0487", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Great Eye of Night, who watches over me, may your brilliance always shine across the world." },
				{ Cue = "/VO/Selene_0069",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
					Text = "The customary gifting of the gods... I am becoming fond of this cycle. Some traditions of Olympus may be worth adopting after all." },
			},
			SeleneGift05 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3674", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "All creatures need you, Sister, not just gods; from the solitary wolf that howls in the night, to the sailor crossing waters you alone illuminate. You truly are an inspiration." },
				{ Cue = "/VO/Selene_0328",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
					Text = "I sometimes think Olympus takes my constancy for granted; for I receive many offerings from mortals, but not gods. While it should make no difference to me, nonetheless it does, little star. Thank you for the gesture." },
			},
			SeleneGift06 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3675", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Your silver light is shared by everyone, though I am far more fortunate as I know you yourself, Sister Selene. I never could have found my strength if not for yours." },
				{ Cue = "/VO/Selene_0329",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
					Text = "I always wished to be dependable, and you must feel the same. Though I watched over you, out of necessity we were quite distant as you grew and trained, but now? We Silver Sisters have grown close; as though we are one." },
			},
			SeleneGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_SeleneGiftHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift06", "SeleneAboutSeleneAspect03" },
					},
				},
				{ Cue = "/VO/MelinoeField_3639", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Sister Selene, Eye of Night, you always have looked out for me since I was very small. But more than that, you've been a dependable comrade and true friend. The gods bestow such gifts to those they cherish, so I offer this to you." },
				{ Cue = "/VO/Selene_0362",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
					Text = "On countless nights have I observed your family on Olympus at their feasts, Ambrosia flowing in abundance. But, it was not the place for me, nor do we revel in the Crossroads thus. Yet from you, this is a cherished gift." },
			},
			SeleneGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift07" },
					},
				},
				{ Cue = "/VO/MelinoeField_3640", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "In my lowest moments, when I felt most incapable and filled with doubt, you always believed in me, Sister. Your cycles across the sky are a steady source of calm and strength and inspiration, for you yourself are all that and more." },
				{ Cue = "/VO/Selene_0363",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",
					Text = "Thank you for your offering and for your thoughts. I likewise never knew my birthparents when I was small, but Nyx in all her splendor took me in. I saw myself in you, I think, and felt perhaps a big sister could be of benefit..." },
			},
			-- bond forged
			SeleneGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedSelene",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift08" },
					},
				},
				{ Cue = "/VO/MelinoeField_3641", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "May you shine forever bright, Sister Selene, my big sister, who protected me and guided me and taught me so much of patience and grace. This offering cannot begin to convey how much it means to me to have you in my life." },
				{ Cue = "/VO/Selene_0364",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Moon",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Selene_01", Icon = "Keepsake_Selene" },

					Text = "You need not spare such words for me, though I am grateful for them, little star. As for the Ambrosia, I shall keep it for a time we Silver Sisters next may share of it together. As with the bond between us, it shall only grow in quality with age." },
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1733", Text = "You honor me, Sister." },
		},
	
		UsingInPortraitPackage = { "DialogueBackground_Moon_In", },
	},
}

OverwriteTableKeys( LootData, LootSetData.Selene )