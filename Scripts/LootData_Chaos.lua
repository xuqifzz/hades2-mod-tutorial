LootSetData.Chaos =
{
	-- Chaos
	TrialUpgrade = 
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
		GodLoot = false,
		Weight = 10,
		SurfaceShopText = "Blank",
		SurfaceShopIcon = "Blank",
		BoonInfoIcon = "BoonInfoSymbolChaosIcon",
		BoonInfoTitleText = "UpgradeChoiceMenu_Chaos",
		Icon = "BoonSymbolChaos",
		DoorIcon = "BoonSymbolChaos",
		SpawnSound = "/SFX/Menu Sounds/KeepsakeChaosEgg",
		ConfirmSound = "/SFX/Menu Sounds/ChaosBoonConfirm",
		PortraitEnterSound = "/EmptyCue",
		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/SkillUpgradeConfirm",
		UpgradeSelectedSound = "/SFX/ChaosBoonChoice",
		MenuTitle = "UpgradeChoiceMenu_Chaos",
		EchoLastRewardId = "EchoLastRewardBoon_Chaos",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_ChaosUpgrade",
		BoxAnimation = "DialogueSpeechBubble",
		BoxExitAnimation = "DialogueSpeechBubbleOut",
		NarrativeTextColor = Color.DialogueText,
		SkipContextArt = true,
		PackageName = "TrialUpgrade",

		Color = { 100, 25, 255, 255 },
		LightingColor = { 100, 25, 255, 255 },
		LootColor = { 100, 25, 255, 255},
		SubtitleColor = {1.000, 0.973, 0.733, 1.0},

		NameplateSpeakerNameColor = Color.DialogueSpeakerName,
		NameplateDescriptionColor = {120, 220, 180, 192},

		SpeakerName = "Chaos",
		Speaker = "NPC_Chaos_01",
		Portrait = "Portrait_Chaos_Default_01",
		OverlayAnim = "ChaosOverlay",
		Gender = "X",
		FlavorTextIds =
		{
			"TrialUpgrade_FlavorText01",
			"TrialUpgrade_FlavorText02",
			"TrialUpgrade_FlavorText03",
		},
		TransformingTraits = true,
		PermanentTraits = { 
			"ChaosWeaponBlessing", "ChaosSpecialBlessing", "ChaosCastBlessing", "ChaosHealthBlessing", 
			"ChaosRarityBlessing", "ChaosMoneyBlessing", "ChaosLastStandBlessing", "ChaosManaBlessing", 
			"ChaosManaOverTimeBlessing", "ChaosExSpeedBlessing", "ChaosElementalBlessing", "ChaosManaCostBlessing",
			"ChaosSpeedBlessing", "ChaosDoorHealBlessing", "ChaosHarvestBlessing",
			"ChaosOmegaDamageBlessing"},
		TemporaryTraits = { 
			"ChaosNoMoneyCurse", "ChaosHealthCurse", "ChaosHiddenRoomRewardCurse", 
			"ChaosDamageCurse", "ChaosPrimaryAttackCurse", "ChaosSecondaryAttackCurse",
			"ChaosDeathWeaponCurse", "ChaosSpeedCurse", "ChaosExAttackCurse",
			"ChaosCommonCurse", "ChaosCastCurse", "ChaosDashCurse", "ChaosManaFocusCurse",
			"ChaosRestrictBoonCurse", "ChaosStunCurse", "ChaosTimeCurse", "ChaosMetaUpgradeCurse" }, 
			
		BoonRaritiesOverride =
		{
			Rare = 0.40,
			Epic = 0.10,
			Duo = 0,
			Legendary = 0.05,
		},
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "ChaosGift01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.2,
				-- RandomRemaining = true,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/MelinoeField_0975", Text = "Salutations...?", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0976", Text = "Thank you for summoning me." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				Cooldowns =
				{
					{ Name = "ChaosSaluteSpeech", Time = 30 },
				},

				{ Cue = "/VO/Chaos_0164", Text = "And to you.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0975", "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Chaos_0165", Text = "Go on.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0975", "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Chaos_0166", Text = "A desirable outcome.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Chaos_0167", Text = "No light reaches me here.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Chaos_0150", Text = "Do not forget my mark." },
				{ Cue = "/VO/Chaos_0145", Text = "Remember my mark." },
			}
		},

		UpgradeMenuOpenVoiceLines =
		{
			[1] = GlobalVoiceLines.FoundRareBoonVoiceLines,
		},

		InteractTextLineSets =
		{
			ChaosFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/MelinoeField_0763", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 4.0, PowerWordPresentation = true, PowerWordWaitTime = 5.65 },
					PostLineFunctionName = "ChaosInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					Text = "What sort of Boon is this, in such a place? Well, {#Emph}in the name of Hades! Olympus... {#Prev}are you there...?" },
				{ Cue = "/VO/Chaos_0097", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					SecretMusicActiveStems = { "ChaosBass" },
					PortraitExitWait = 1.25,
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Olympus cannot hear you, Spawn of Hades. But I can. And I have for you a proposition: Assist with a quandary of mine, and benefit. Your response?" },
				{ Cue = "/VO/MelinoeField_0764", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Almighty Chaos...! I'm honored to make your acquaintance. Wh-what sort of quandary would concern the Origin of All Existence...? And, how do I fit in?" },
				{ Cue = "/VO/Chaos_0003",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosBoonChange",
					Text = "Time shall tell. But at present, I have inferred that your response, in essence, was affirmative. Thus, may our newly formed arrangement prove most interesting. Accept my mark, and go; and later I shall open the abyss for you again." },
			},

			-- low health
			ChaosLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0053",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You have suffered in your journey to reach me. Perhaps I should reward your struggle; or hasten your likely failure. You shall have to decide." },
			},
			ChaosLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0054",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I created life, which later gave rise to death; so I can sense how close you are now to the latter state. Even if your godhood means that you can never truly die, it must be quite unpleasant." },
			},
			ChaosLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0055",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Your present ailments are not beyond my notice. Perhaps it was unwise of you to visit me within this space whilst you are in such a state. Though I have also made mistakes before." },
			},
			ChaosLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0056",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I understand that physical injuries, such as the ones you have sustained, mean little to you gods. Though even gods are able to withstand only so much. Thus, caution is advised." },
			},

			-- run starts
			ChaosRunStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0057",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "As you commence your evening's pursuit, you may be best prepared to receive my mark and overcome its undesirable effects. Subsequently you shall have more opportunity to test the limits of the possibilities that it creates." },
			},
			ChaosRunStart02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0058",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You need not venture far to find me, Spawn of Hades. For I am everywhere, particularly where the darkness coalesces into seeming nothingness. Perhaps we shall see each other again when you are closer to your goal." },
			},

			-- story events
			ChaosUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ChaosUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0212",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "There was a recent moment when Time briefly ceased to be, and I alone could tell. I believe this coincided with your confrontation with Chronos. Now you return to me, attempting to repeat the same outcome. Interesting." },
			},
			ChaosUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ChaosUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0213",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You recently entered your father's residence within the Underworld's depths, but did not remain there. Did you at least discover what you sought? Do not respond; I am considering all the potential truths." },
			},

			ChaosAboutLife01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0028",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "When I created life, I had my doubts: Would it invite more problems than it solved? I would be curious to see. Thus my experiment continues to unfold; its outcome, yet uncertain." },
				{ Cue = "/VO/MelinoeField_0765", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Almighty Chaos... with your experiment so vast in scope, what can one individual achieve? The quandary you mentioned when first we met... what would you have me do?" },
				{ Cue = "/VO/Chaos_0029",
					PreContentSound = "/SFX/Menu Sounds/ChaosBoonChange",
					SecretMusicActiveStems = { "ChaosBass" },
					Text = "Spawn of Hades, I ought to clarify I do not care for idle talk. Ask me no questions. Respond only when prompted, or when necessary in absolute. But above all, do as you will." },
			},

			ChaosAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0030",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I once created a similar arrangement with a different Spawn of Hades. He was an interesting subject. The interval since last we met grows ever-longer now. Do you know his status? Respond." },
				{ Cue = "/VO/MelinoeField_0766", UsePlayerSource = true,
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean my brother Zagreus. Chronos took him, along with my parents and their closest associates. They're in the lowest reaches of the Underworld, where I am headed now." },
				{ Cue = "/VO/Chaos_0031",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosBoonChange",
					Text = "I see. Time appears to be the source of many problems recently. As for your brother, I found him to be quite amusing. How interesting that offspring can be so dissimilar." },
			},

			ChaosGrantsBountyBoard01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					NamedRequirements = { "BountyBoardUnlockAvailable" },
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0039",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "To make the most of our arrangement, I bid you activate a certain artifact where you reside. Within the pitch-black facets of this standing-stone are possibilities to be explored. I shall reveal how to see them all, but first..." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeBountyBoard", VoiceLines = HeroVoiceLines.CauldronSpellLearnedVoiceLines },
				},
			},
			ChaosAboutBountyBoardUnlock01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsBountyBoard01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0040",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I sense that you have not yet activated the pitch-black standing-stone as I requested earlier. You may take as long as you wish to do so. Our experiment proceeds nevertheless." },
			},
			ChaosAboutBountyBoard01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsBountyBoard01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						Path = { "GameState", "BountiesCompleted" },
						UseLength = true,
						Comparison = "<=",
						Value = 4,
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0041",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You have restored the standing-stone where you reside, and now can see the possibilities within. Should you assist me in exploring my ability to determine outcomes like the Fates themselves, I shall make it worth your while." },
			},
			ChaosAboutBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ChaosAboutBounties02", "ChaosAboutBounties03" }, Count = 3 },
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0042",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I anticipated speaking to you thus as you explore the possibilities within the standing-stone. Perhaps you see them as a series of important missions to complete; but they are merely part of our experiment." },
			},
			ChaosAboutBounties02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ChaosAboutBounties01", "ChaosAboutBounties03" }, Count = 3 },
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0209",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Perhaps I should not actively participate within the Trials of my own design, for I unduly influence the outcome. But I believe this way, it shall be much more interesting for us both." },
			},
			ChaosAboutBounties03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ChaosAboutBounties01", "ChaosAboutBounties02" }, Count = 3 },
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0210",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Trials I devised all begin precisely as planned; but from that point, not even I can influence the outcomes entirely. For instance, I did not expect to find {#Emph}you {#Prev}here, Spawn of Hades." },
			},
			ChaosAboutBounties04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "PackageBountyClears" },
						UseLength = true,
						Comparison = ">=",
						Value = 5,
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0279",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You have completed a number of the Trials I have put before you, Spawn of Hades. I would offer you my gratitude, except I thought my Star Dust would be of more use." },
			},
			ChaosAboutBountyChaosIntro01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyChaosIntro" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0208",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Your usage of the pitch-black standing-stone enables me to temporarily emerge from my abyss, and I thank you for that. I can observe more clearly, both the outcome of your Trial, and all else." },
			},

			ChaosAboutStarDust01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0215",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The act of creation is not always pristine. The residue of it you know as Star Dust, which retains some power over consciousness. Consider it an incentive to look upon the standing-stone and undertake the Trials you see there." },
			},

			ChaosAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0211",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I sensed the growing influence of the goddess Nyx; as though my daughter plunged the world into deeper darkness recently. Yet it was not she who did this; I believe it was you." },
			},

			ChaosAboutWeapons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0216",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I recognize the artifacts you bear. Their brother-weapons of infernal origin drink deep the blood of Titans and grow strong, whilst these? Fate-forged servants of the Underworld that thrive on pure Nightmare itself." },
			},

			ChaosAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "RandomBlessingKeepsake" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0052",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You bear the Embryo I gave to you. It creates an impression as though a part of me is with you, even whilst you are absent from this space. You may continue to make use of it, or not." },
			},

			ChaosAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0032",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "When you return to shadow, I briefly sense your presence in the infinite abyss. So I have seen that the servant of the Three Fates found you in that hidden place. He relayed to you a secret, did he not? Respond." },
				{ Cue = "/VO/MelinoeField_0767", UsePlayerSource = true,
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean Moros. His secret was about the surface... about how I can survive up there. I know this goes against the Fates' designs, but Olympus needs me. And to achieve my task, I need {#Emph}them." },
				{ Cue = "/VO/Chaos_0033",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosBoonChange",
					Text = "I see. As you may know, I am uninterested in the Fates having undue influence. Perhaps you may find a catalyst here for this incantation. Whether they like it or not." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "ChaosUnlockAdded", Text = "PlantChaosThalamusSeedIcon", VoiceLines = GlobalVoiceLines.ChaosSeedsUnlockedVoiceLines, GiftResource = true, WaitTime = 0.25, ResourceName = "PlantChaosThalamusSeed", SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },
				},
			},
			ChaosAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Boss01" },
					}
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0034",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Recently I found myself unable to detect you much at all, and deduced that you must have completed your forbidden incantation. Thus the surface is laid bare to you. Perhaps I shall ask you to describe it to me sometime." },
			},
			ChaosAboutSurfaceAppearance01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurface02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0035",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Your ability to reach beyond the boundaries that the Fates placed upon you proved inspiring to me. After some consideration, I discovered how to call upon you even from the surface of this world. I find it rather interesting there." },
			},
			ChaosAboutSurfaceAppearance02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurfaceAppearance01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ChaosAboutSurfaceAppearance01" }, Count = 4 },
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0202",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Perhaps I ought to start over again: That is what I think when I observe all that has transpired on the surface of this world. Eventually I expect I shall, though for now, I permit my offspring to continue to multiply and interact as they will." },
			},

			ChaosAboutPostSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0214",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You have been exploring the surface of this world, where my influence is comparatively limited. I was amused to consider the possibilities, though I did anticipate you would return." },
			},

			ChaosAboutChaosGates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift03" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0203",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I understand entering gateways to my domain is not a pleasant sensation, and my mark by its nature yields mixed results. Thus I ask myself why you often venture here; perhaps you merely wish to look upon me thus." },
			},
			ChaosAboutChaosGateItem01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "TraitUses" },
						HasAny = { "TemporaryForcedSecretDoorTrait" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0204",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "A Spark of Ixion brought you to me... an ember from the flame forever burning in the Underworld. Its light reveals gateways into my abyss, and relieves the common side effects of entering. I recommend continued use of it." },
			},

			ChaosAboutTrust01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0037",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Some who sought to answer my call turned out to lack the fortitude for the descent. Thus I never call on mortals anymore, and seldom anyone. For Titans and gods can be duplicitous, I know. I ask that you do not betray my trust." },
			},

			ChaosAboutCreation01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0038",
					TextLimit = 285,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Responsibility is partly mine for all that has transpired. I attempted to create this world with a degree of care. I nurtured it. Adhered to certain principles, as might a mother and father; for I created them, too. But this world is no longer young. It persists now by its own whim." },
			},

			ChaosGrantsDarkness01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0047",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Once there was Darkness all throughout the Underworld, but now... Chronos works to re-shape the realm to suit his preferences. However, there shall always be Darkness here in this space. And I have made it visible to you." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "ChaosUnlockAdded", Text = "Mixer6Common", VoiceLines = GlobalVoiceLines.DarknessUnlockedVoiceLines, GiftResource = true, WaitTime = 0.25, ResourceName = "Mixer6Common", SoundName = "/SFX/Player Sounds/DarknessCollectionPickup" },
				},
			},

			ChaosAboutOlympians01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0036",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Olympians send you their blessings and their messages, having some limited awareness of your circumstances and your whereabouts. So shall it be with me, whilst you are here." },
			},

			ChaosAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0200",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Olympians often speak of family, but I do not entirely understand what they mean. All beings have a common origin, yet are not considered family. Chronos, for example: Is he family, or not? I shall not ask you to respond." },
			},

			ChaosAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0043",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Time, of course, did not always exist. Chronos provided a means of measuring the rate at which everything grew and changed, or did not. He was quite useful by his very nature. But Time can be a source of problems, too, I know." },
			},
			ChaosAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0044",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I believe that I am an impartial being, Spawn of Hades. However, even I can be provoked, as Chronos soon shall come to realize. Our experiment concerns his fate; if he believes that he can change his fate, then so may we." },
			},
			ChaosAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChronosNightmare01" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0045",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I shall hold Chronos to account for what has come to pass. But I am not without blame, myself. For I fear that I made present matters worse. We shall see whether any such mistakes can be corrected." },
			},

			ChaosAboutChronosNightmare01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {
							"ChronosNightmare01",
							"HecateAboutFates01",
							"MorosAboutFates02",
							"NemesisAboutChronosNightmare02",
							"HadesAboutChronosNightmare01",
							"HermesAboutFates01",
						},
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0098",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The weavings of the Fates are said to bind both mortals and immortals alike. The course and outcome of all lives, all preordained. Thus the sense of choice is merely an illusion. Do you believe this, Spawn of Hades? Respond." },
				{ Cue = "/VO/MelinoeField_1209", UsePlayerSource = true,
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think the Fates determine much about our lives... when and where we are born, for instance, and to whom. But I don't think they set every detail. And, I know they're not weaving at all right now... because Chronos has them." },
				{ Cue = "/VO/Chaos_0099",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosBoonChange",
					Text = "I see. For the most part, I concur with your assessment. I am the reason Chronos has them now. He asked me where to find them, and I decided to tell him; to verify such choices could be made without their influence. Now do you understand my quandary? Respond..." },
				{ Cue = "/VO/MelinoeField_1210", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					SecretMusicMutedStems = { "ChaosBass" },
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, no. Almighty Chaos, you were deceived! Chronos wished to find the Fates for his own gain. They were one of the only forces in this world powerful enough to stop him." },
				{ Cue = "/VO/Chaos_0100",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosBoonChange",
					Text = "Yet they are not so powerful as they appeared. Nevertheless, I think you are correct. Chronos indicated his intentions were benign. I am unfamiliar with deceit, and was misled. I remain quite displeased about this still." },
			},
			ChaosAboutChronosNightmare02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutChronosNightmare01" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0101",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "In retrospect, I ought not have permitted Chronos to speak with me, but he was persuasive. I still do not fully understand how you communicate; what you say is not always what you mean, and your intentions may be carefully veiled. So I pay closer notice now." },
			},

			ChaosAboutChronosFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0102",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "There was a certain rumbling I felt within the depths... you reached your destination, did you not? Confronted Chronos, and prevailed. And yet his influence remains. But perhaps the Titan shall relinquish control with further persuasion." },
			},

			ChaosAboutTitans01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0206",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "What are the essential differences between Titans and gods? I cannot easily distinguish the two. Yet those differences must be significant, if they provoked a self-perpetuating war." },
			},

			ChaosAboutNyx01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0046",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Fates' designs for us perhaps are intertwined. For we each seek our close kin. I have lost contact with my spawn and daughter, Nyx, who resided in your father's House. Her influence remains, yet I feel her absence..." },
			},
			ChaosAboutNyx02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChaosAboutNyx01", "ChronosNightmare01" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0197",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "If Chronos holds the goddess Nyx as captive in your father's House, along with other members of her family and yours, then I would like for that to change. Perhaps he shall release them if you use sufficient violence." },
			},

			ChaosAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "NemesisTakeExitRecord", "TrialUpgrade" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0198",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Recently a daughter of Nyx entered my domain. Such is her likeness that I mistook her for her mother-goddess at first, for many beings appear similar to me. I shall permit her here." },
			},
			ChaosAboutNemesis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutNemesis01" },
					},
					{
						Path = { "GameState", "NemesisTakeExitRecord", "TrialUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0199",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "That daughter of Nyx resembling her mother-goddess is assisting with my quandary, much like you. She is dutiful, but some offspring are not. Perhaps I should have ensured all obeyed; but that would not be quite as interesting." },
			},
			ChaosAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurfaceAppearance01" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0201",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "One of the offspring of the goddess Nyx, the one called Strife... I find it interesting Nyx spawned one such as her, but then, we all make mistakes. I acknowledge all that I have wrought can be seen as disorderly as well." },
			},

			ChaosAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0207",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You come from a domain not of the surface nor the Underworld, but between. The caretaker of that domain I have seen occasionally for some time, and serves the goddess Nyx; you are reminiscent of her to me." },
			},

			ChaosAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Intro" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0205",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I cannot know what it is like to meet one's creator, but you may, and perhaps have. Your father is no longer in his residence, where I sense much has changed. Yet he is not far from there. Perhaps I shall assist you in locating him." },
			},

			-- about olympians
			ChaosAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0170",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You bear the blessing of the King of the Olympians himself. I expected that he would have been too preoccupied to be of direct assistance, although he does have a vested interest in your victory..." },
			},
			ChaosAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
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
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0171",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You know the one called Queen Hera of Olympus. She has a certain power over creation, herself. Mortals worship her, begging her favor as they bond and bring their offspring into being. She must enjoy the attention." },
			},
			ChaosAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0172",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You have been visited by Lord Poseidon. The waters that he claims are his, they were among the first of my creations, and turned out rather well I think. I wonder if he comprehends the extent of the power they conceal." },
			},
			ChaosAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0173",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The golden son of Zeus has given you his blessing, I see. Apollo was not always so willing to involve himself in your family's struggles. Perhaps the present matter gives him little choice." },
			},
			ChaosAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0174",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Even the goddess Hestia has lent you her power. She typically has been content merely to stoke the little flames warming the hearths of mortal homes. But now those flames threaten to spread beyond even her control." },
			},
			ChaosAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0175",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The blessing of Hephaestus is upon you. The god of the forge fashions arms and armor fit for war, whilst I created the very things he uses for his trade. No one's work is solely their own, Spawn of Hades." },
			},
			ChaosAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0176",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Does there remain a place for beauty and for objects of desire in a world such as this? The goddess Aphrodite must think so, and you work now as allies. I believe it a worthwhile cause; this world was born of a certain desire, after all." },
			},
			ChaosAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0177",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The goddess Demeter is set for war, and lends to you her wrathful strength. The mother of your mother has experience fighting Titans... her predecessors. You all have grown so numerous that very little common ground remains." },
			},
			ChaosAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0178",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I am aware the goddess of the hunt has lately plied her trade at the boundaries between realms. Artemis was not always so bold; but it is little wonder she was drawn deeper into shadow. You seem to know each other well." },
			},
			ChaosAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0179",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "We have eternity to conduct our experiment. I am unconvinced as to whether the results shall come more quickly with the haste of Hermes benefiting you. That is another facet to explore." },
			},
			ChaosAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0180",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Selene rides across the sky, yet her attentions she directs towards you. Perhaps she is wondering, {#Emph}what is the Moon without Night? {#Prev}Yet I suspect that she is capable in Nyx's absence." },
			},

			-- repeatable lines
			ChaosChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0004",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Whatever shall transpire, I shall be curious to see." },
			},
			ChaosChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0005",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You have a proposition to continue to uphold, O Spawn of Hades." },
			},
			ChaosChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0006",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Let us continue our experiment, if you would make your choice." },
			},
			ChaosChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0007",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "My mark shall be of benefit, once the initial discomfort subsides." },
			},
			ChaosChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0008",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Spawn of Hades has returned, and has a choice to make." },
			},
			ChaosChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0009",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "What is life, if not a series of unexpected complications?" },
			},
			ChaosChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0010",
					SecretMusicActiveStems = { "ChaosBass" },
					Text = "How shall I reshape your existence this time, Spawn of Hades?" },
			},
			ChaosChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0011",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The results of our experiment are not entirely conclusive as of yet..." },
			},
			ChaosChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0012",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "This world is born of impulse, not of carefully considered plans." },
			},
			ChaosChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0013",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I have no patience for discussion, Spawn of Hades, so you need but choose." },
			},
			ChaosChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0014",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Collect your thoughts whilst you are here, but do not stay for long." },
			},
			ChaosChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0015",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I am amused to find myself again swept up in the affairs of gods." },
			},
			ChaosChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0016",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "You may take comfort in the darkness and the silence here." },
			},
			ChaosChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0017",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "There are no decisions that are not life-changing, Spawn of Hades." },
			},
			ChaosChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0018",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Reality is what we make of it, O Spawn of Hades; or I, at least." },
			},
			ChaosChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					RequiredLootChoices = 3,
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0019",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "For your convenience, I have reduced infinite possibilities to three." },
			},
			ChaosChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0020",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Fates have their whims, as we have ours, is that not so?" },
			},
			ChaosChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0021",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I trust our arrangement continues to be of interest, Spawn of Hades?" },
			},
			ChaosChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0022",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Do as you shall with my mark; my eyes shall be watching." },
			},
			ChaosChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0023",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "So many different possibilities to be explored, in no particular order..." },
			},
			ChaosChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0024",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Do you believe the Fates planned for this outcome, or did I?" },
			},
			ChaosChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0025",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I must admit life has become a rather complicated thing..." },
			},
			ChaosChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "RunDepthCache" },
						Comparison = "<",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "N", },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0026",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Allow me to make your coming venture more interesting from the very start." },
			},
			ChaosChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						Path = { "CurrentRun", "RunDepthCache" },
						Comparison = "<",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "N", },
					},
				},
				PreEventFunctionName = "ChaosInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0 },
				{ Cue = "/VO/Chaos_0027",
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Perhaps the Fates themselves expected we would meet this soon." },
			},

		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			ChaosGift01 =
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
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_0768", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "If you'll permit me, almighty Chaos, I wish you to have this gift of Nectar, in accordance with my family's custom among relatives and friends. None of this would have been possible if not for you..." },
				{ Cue = "/VO/Chaos_0048",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Then I shall grant you this wish, and the freedom to bestow upon me further gifts as you see fit. For I have familiarity with this custom of yours, and am prepared to reciprocate." },
			},
			ChaosGift02 =
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
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_0770", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "Almighty Chaos, I wish to exercise my freedom here by giving you this. Though I suppose you probably could have made it yourself..." },
				{ Cue = "/VO/Chaos_0049",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "This Nectar that you offer me is quite an interesting substance. When I created the fabric of reality, I had a sense of the ways in which it could be used; but I did not necessarily anticipate all possible results, including this one." },
			},
			ChaosGift03 =
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
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_0771", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "I know such sweetness as this Nectar is never to be taken for granted, almighty Chaos. Please, it's yours! Wondrous creations such as this are only possible because of you." },
				{ Cue = "/VO/Chaos_0050",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Such gestures are unnecessary to the arrangement between us. If this is an act of supplication, then simply speak your mind. Although I sense no deeper motive presently..." },
			},
			ChaosGift04 =
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
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_0772", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "You can sense my motive in giving you this. Sometimes we simply feel an impulse to express our admiration. Knowing how important your whims are to you, surely you understand." },
				{ Cue = "/VO/Chaos_0051",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "The Olympians often demand tribute from their worshipers, do they not? Their custom, perhaps, but not mine. I merely ask that you honor our arrangement in perpetuity. Though neither shall I reject your offering." },
			},
			ChaosGift05 =
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
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1774", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "It's heartening to know that the origin of all existence also is a source of such limitless curiosity. Here's to finding great interest even in the simplest of things!" },
				{ Cue = "/VO/Chaos_0168",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "Substances such as this Nectar... is it not interesting how they can be made, but not unmade? Everything, in essence, is itself. Thus your offering to me is truly unique in its own right. And I thank you for it." },
			},
			ChaosGift06 =
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
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1775", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "Such a strange journey your creations take, almighty Chaos! This particular bottle, for instance... formed after untold aeons, only to find its way back to you. Inevitably or not." },
				{ Cue = "/VO/Chaos_0169",
					PortraitExitWait = 1.0,
					SecretMusicActiveStems = { "ChaosBass" },
					PreContentSound = "/SFX/Menu Sounds/ChaosMiscSFX",
					Text = "I still possess some of the Nectar that your brother once gave to me, when he was dealing with a certain quandary of his. I think that I shall keep this offering close by to that. You follow in his path, yet seem to choose your own way." },
			},

			-- placeholder
			ChaosGiftTemp =
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

			{ Cue = "/VO/MelinoeField_0769", Text = "Whatever this is... it's remarkable, truly." },
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
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.25,
				NoTarget = true,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},

				{ Cue = "/VO/Chaos_0131", Text = "Although you failed this attempt, I was amused." },
				{ Cue = "/VO/Chaos_0132", Text = "I understand reality can be quite difficult to bear." },
				{ Cue = "/VO/Chaos_0133", Text = "Not every possibility is realized." },
				{ Cue = "/VO/Chaos_0134", Text = "This outcome was but one of many possibilities." },
				{ Cue = "/VO/Chaos_0135", Text = "I did not observe as much as I would have liked." },
				{ Cue = "/VO/Chaos_0136", Text = "An inconclusive result in our experiment." },
				{ Cue = "/VO/Chaos_0137", Text = "Expected outcomes can be disappointing nonetheless." },
				{ Cue = "/VO/Chaos_0138", Text = "I do believe the possibility exists that you succeed." },
				{ Cue = "/VO/Chaos_0139", Text = "This type of failure was a highly probable result." },
				{ Cue = "/VO/Chaos_0140", Text = "Small variances in your actions led to this." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.25,
				NoTarget = true,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "TookChaosCurseDamage" },
					},
				},

				{ Cue = "/VO/Chaos_0153", Text = "It seems my mark has had an undesirable effect." },
				{ Cue = "/VO/Chaos_0154", Text = "This is all part of our experiment." },
				{ Cue = "/VO/Chaos_0155", Text = "I take it this was not the outcome you desired." },
				{ Cue = "/VO/Chaos_0156", Text = "Thus my mark is washed away, for now." },
				{ Cue = "/VO/Chaos_0157", Text = "Life is ever-capable of folly, is it not?" },
			},

		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
			TriggerCooldowns = { "DemeterBoonTakenSpeech" },

			-- How do you do, young man.
			-- { Cue = "", Text = "TODO(BuildText) Zeus_0078" },
		},

	},	

}

OverwriteTableKeys( LootData, LootSetData.Chaos )