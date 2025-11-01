UnitSetData.NPC_Heracles = 
{
	-- Heracles, Id = TKTK
	NPC_Heracles_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		Portrait = "Portrait_Heracles_Default_01",
		Groups = { "NPCs" },
		SpeakerName = "Heracles",
		LoadPackages = { "Heracles", },
		SubtitleColor = Color.HeraclesVoice,
		EmoteOffsetY = -350,
		EmoteOffsetX = 120,
		AnimOffsetZ = -20,

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},

		ThemeMusic = "/Music/IrisMusicHeraclesTheme_MC",
		TurnInPlaceAnimation = "Heracles_Hub_Turn",
		PreEventFunctionName = "AngleNPCToHero",

		EffectBlocks = { "RavenFamiliarMark", "ChillStatueEffect" },
		ExcludeFromDamageDealtRecord = true,

		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { CreateAnimation = "OlympusColdBreathEmitterLarge", },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
			},
		},

		ShopEventData = 
		{
			TimerStartDistance = 1000,
			DelayMin = 10,
			DelayMax = 18,
			InstantChance = 0.1, -- Chance he will buy it without a chance for the player to interact
			-- NeverChance = 0.1, -- Chance he will dither indefinitely
			BrowsingVoiceLinesDelay = 4.0,
			FidgetIntervalMin = 5,
			FidgetIntervalMax = 11,
			ExitDelayMin = 2,
			ExitDelayMax = 4,
			SkipObjective = true,
		},
		StoreExitFunctionName = "HeraclesExit",

		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.33,
		DefaultAIData =
		{
			TargetRequiredKillEnemy = true,
			IgnoreInvulnerable = true,
			AIWanderDistance = 200,
		},
		OutgoingCritModifiers =
		{
			{
				Chance = 0.35,
			}
		},
		AIOptions = { "AttackerAI" },
		PostCombatAI = "HeraclesPostCombat",

		WeaponOptions = { "HeraclesMeleeArc", "HeraclesLeap" },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0.0,
			}
		},
		IncomingDamageModifiers =
		{
			{
				--Name = "Innate",
				PlayerMultiplier = 0.05,
			}
		},

		ActivateRequirements =
		{
			-- None
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_0718", Text = "Gods watch over us." },
				{ Cue = "/VO/MelinoeField_0717", Text = "Stay strong, Son of Zeus.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "SpeechRecord", "/VO/Heracles_0423" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.32,
				ObjectType = "NPC_Heracles_01",

				{ Cue = "/VO/Heracles_0080", Text = "Witches..." },
				{ Cue = "/VO/Heracles_0171", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Heracles_0172", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Heracles_0173", Text = "{#Emph}Mm." },
				{ Cue = "/VO/Heracles_0425", Text = "What?" },
				{ Cue = "/VO/Heracles_0424", Text = "They won't.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0718" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0426", Text = "No need.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0427", Text = "I know my path.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0428", Text = "Leave me out.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700", "/VO/Melinoe_1704" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0429", Text = "Towards what?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0423", Text = "Don't call me that again.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0717" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HeraclesFieldAboutOlympus01", "HeraclesGift01" },
						},
					},
				},
			},
		},

		BossIntroTextLineSets =
		{
			HeraclesFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RoomRequiredInteractionFalse = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "N_Hub" },
					},
					{
						Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Heracles_0002",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					-- PreLineAnim = "Heracles_Hub_Greet", -- slow flex
					-- PreLineAnim = "Heracles_Hub_Granting", -- finger point
					-- PreLineAnim = "Heracles_Hub_Brooding", -- quick flex
					SecretMusic = "/Music/IrisMusicHeraclesTheme_MC",
					Text = "You're the help? Oh, that's rich. Friendly word of advice, {#Emph}sister: {#Prev}Stay out of my bloody way, else you're liable to get hurt. Now scoot, and tell whomever sent you that I work alone." },
				{ Cue = "/VO/MelinoeField_0228", UsePlayerSource = true,
					Text = "Your threat is duly noted, Son of Zeus. I'm headed for the docks, but understand this city's sealed shut." },
				{ Cue = "/VO/Heracles_0003",
					PreLineAnim = "Heracles_Hub_Granting",
					Text = "Then you understand you ought turn back. This town is {#Emph}dead{#Prev}, and doesn't let the living pass." },
				{ Cue = "/VO/MelinoeField_0229", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm Daughter of Hades; the dead shall answer to me. They may just need a little encouragement." },
				{ Cue = "/VO/Heracles_0004",
					SecretMusicMutedStems = { "Drums" },
					Text = "Try all you like. But remember you were warned." },
			},

			-- pre-fight events
			HeraclesCombat01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
				},
				{ Cue = "/VO/Heracles_0005",
					Text = "You. Things are about to turn ugly, and I require neither assistance nor witnesses, sister." },
				{ Cue = "/VO/MelinoeField_0230", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm passing through. And I'm not leaving here until the traitors to the House of Hades lie broken at our feet." },
				{ Cue = "/VO/Heracles_0006",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "{#Emph}Hah! {#Prev}Fine, then. We'll each earn our share. Though the lion's share is coming with me." },
			},

			HeraclesPreEncounterAboutAltFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
				},
				{ Cue = "/VO/Heracles_0233",
					Text = "Hold, sister. Remember, not a word about before, or else. We can have ourselves another happy massacre and then be on our way." },
				{ Cue = "/VO/MelinoeField_3762", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "And then perhaps we'll meet again on my way to the summit, if the conditions are just right. Wouldn't that be nice?" },
				{ Cue = "/VO/Heracles_0234",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Sure it would. We understand each other, then. Now to the bloodletting at hand." },
			},

			HeraclesPreEncounterAboutTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Heracles_0277",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I heard the tidings of your victory, but knew this wasn't over. Always more to be done. Now, come on." },
			},

			HeraclesPreEncounterAboutTimePassing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
					},
					{
						SumPrevRuns = 6,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Heracles_0281",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Look who decided to show her shining face again. You want to earn some extra coin, have I the opportunity for you." },
			},

			-- Repeatable
			HeraclesMiscStart01 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasNone = { "/VO/Heracles_0047" },
					},
				},
				{ Cue = "/VO/Heracles_0023",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I'm working here, sister. Care to pitch in, fine, but don't get underfoot." },
			},
			-- 02 transferred to pre-fight
			HeraclesMiscStart03 =
			{
				{ Cue = "/VO/Heracles_0025",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Much as I'd love to have ourselves a {#Emph}chat{#Prev}, I'm on the job. And better get to work." },
			},
			HeraclesMiscStart04 =
			{
				{ Cue = "/VO/Heracles_0026",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "You look like you've a taste for blood. Come get your fill for now." },
			},
			HeraclesMiscStart05 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasNone = { "/VO/Heracles_0047" },
					},
				},
				{ Cue = "/VO/Heracles_0027",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Well don't just stand there, sister; we've a war here to perpetuate." },
			},
			HeraclesMiscStart06 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasNone = { "/VO/Heracles_0047" },
					},
				},
				{ Cue = "/VO/Heracles_0028",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Enjoy the silence, sister. We'll have company here any moment now." },
			},
			HeraclesMiscStart07 =
			{
				{ Cue = "/VO/Heracles_0029",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Need a break from all the slaughter, just stand back. {#Emph}Far {#Prev}back." },
			},
			HeraclesMiscStart08 =
			{
				{ Cue = "/VO/Heracles_0030",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "The gods must want for us to give another glorious performance, huh." },
			},
			-- 09 transferred to pre-fight
			HeraclesMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasNone = { "/VO/Heracles_0047" },
					},
				},
				{ Cue = "/VO/Heracles_0032",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Why am I even talking to you, sister? You save your breath, I'll save mine." },
			},
			HeraclesMiscStart11 =
			{
				{ Cue = "/VO/Heracles_0034",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "We get to know each other, you'll live to regret it. Happens all the time." },
			},
			HeraclesMiscStart12 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasNone = { "/VO/Heracles_0047" },
					},
				},
				{ Cue = "/VO/Heracles_0035",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "You think you know me, sister. But you don't." },
			},
			HeraclesMiscStart13 =
			{
				{ Cue = "/VO/Heracles_0040",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Suggest remaining far afield of me at all times, witch." },
			},
			HeraclesMiscStart14 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HeraclesGift07" },
					},
				},
				{ Cue = "/VO/Heracles_0041",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "You blasted gods and goddesses are all alike..." },
			},
			HeraclesMiscStart16 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasNone = { "/VO/Heracles_0047" },
					},
				},
				{ Cue = "/VO/Heracles_0042",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Go about your business, sister. I'm on the job." },
			},
			HeraclesMiscStart17 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0206",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "This vessel's going back to the bottom of the sea, whether you're here or not." },
			},
			HeraclesMiscStart18 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Heracles_0438" },
					},
				},
				{ Cue = "/VO/Heracles_0207",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Rough waters ahead, sister. End up overboard, I won't be diving in to get you out." },
			},
			HeraclesMiscStart19 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Heracles_0440" },
					},
				},
				{ Cue = "/VO/Heracles_0208",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Another stowaway aboard. And here I thought I was the only one." },
			},
			HeraclesMiscStart20 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0209",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "The sea took these ships' crews once before, and it's about to take them back." },
			},
			HeraclesMiscStart21 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0210",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "This ship's a mess, but let me go ahead and swab the deck, if you'll stand clear." },
			},
			HeraclesMiscStart22 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0211",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "What a coincidence, I was just heading to the mountain of the gods myself." },
			},
			HeraclesMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0332",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I've an urge to smash this ship to splinters, but then we'd be forced to swim." },
			},
			HeraclesMiscStart24 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0333",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I claim this ship in the name of the gods, although you're one of them, aren't you?" },
			},
			HeraclesMiscStart25 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0334",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Not much room here to maneuver, so best stay far afield of my club." },
			},
			HeraclesMiscStart26 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Heracles_0335",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "The darkness of these waters brings about a certain peace, doesn't it, sister?" },
			},
			HeraclesMiscStart27 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0336",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Go someplace else. This blasted mountain's defenses are already spread too thin." },
			},
			HeraclesMiscStart28 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0337",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "The gods require all the aid they can muster, which is why we're both here." },
			},
			HeraclesMiscStart29 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0338",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Oh good. I was beginning to feel lonesome having to shoulder all the work myself..." },
			},
			HeraclesMiscStart30 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0339",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Suggest you stand clear before you're driven back from this mountain like all the rest." },
			},
			-- 31 transferred to pre-fight
			HeraclesMiscStart32 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0341",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Everybody wants a piece of Olympus lately, don't they. But it's not for the taking." },
			},
			-- 33 transferred to pre-fight
			HeraclesMiscStart34 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0343",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Best watch your step in all this ice and snow. Wouldn't want you to slip." },
			},
			HeraclesMiscStart35 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0344",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Now what could be more glorious than crushing Satyrs into frozen earth?" },
			},
			HeraclesMiscStart36 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Heracles_0345",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I was here first, sister. Go find your own Harpies and such to massacre." },
			},
			HeraclesMiscStart37 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0346",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "This is just a warm-up for what's to come later this evening, isn't it, sister?" },
			},
			HeraclesMiscStart38 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0347",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I'll pull my strikes should you happen to get in the way here, but at the summit? No." },
			},
			HeraclesMiscStart39 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0348",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Soon you shall face me and the Flame Thief once again, but let's keep up the act for now." },
			},
			HeraclesMiscStart40 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
					},
				},
				{ Cue = "/VO/Heracles_0350",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I'm just about to start killing everything that moves, other than you and your pet." },
			},
			HeraclesMiscStart41 =
			{
				{ Cue = "/VO/Heracles_0351",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Credit to the most efficient killer here; you do the work, you get the coin." },
			},
			HeraclesMiscStart42 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 5,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = "<",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift06" },
					},
				},
				{ Cue = "/VO/Heracles_0638",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "It's been too long since last we slaughtered everything that moved about this place." },
			},
			HeraclesMiscStart43 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "F_Opening01", "F_Opening02", "F_Opening03" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift06" },
					},
				},

				{ Cue = "/VO/Heracles_0639",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "While you've been navigating your father's catacombs, I've had all the glory to myself." },
			},
			HeraclesMiscStart44 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 5,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift07" },
					},
				},
				{ Cue = "/VO/Heracles_0641",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "We're making a regular habit of crushing the life from anything that moves." },
			},
			HeraclesMiscStart45 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.4, },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
					},
				},
				{ Cue = "/VO/Heracles_0643",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "You're bloodied, so you'd best stand back and leave the taking of the glory all to me." },
			},
		},

		InteractTextLineSets =
		{
			HeraclesFieldAboutEphyra01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
				},
				{ Cue = "/VO/Heracles_0007",
					Text = "You live. By my good graces, granted, but... first I've seen somebody stand against the filth that's overtaken this accursed town." },
				{ Cue = "/VO/MelinoeField_0231", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I aim to cleanse the filth down to the source. He resides deep in the Underworld, though I've business to attend to on Olympus first." },
				{ Cue = "/VO/Heracles_0008",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "What a coincidence! I just returned from there not long ago. So the gods are putting all the pieces into place.... You watch yourself, sister." },
			},

			HeraclesFieldAboutWitches01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
				},
				{ Cue = "/VO/Heracles_0009",
					Text = "I know what you are. You bloody witches. One foreign word... one finger-wagging gesture directed at me... and I'll squeeze you till you pop." },
				{ Cue = "/VO/MelinoeField_0232", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That won't be necessary... though I would know how came you to feel this way about us {#Emph}bloody witches? {#Prev}How many have you met?" },
				{ Cue = "/VO/Heracles_0010",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Two questions too many. The more you know, the more you can manipulate. Now, off with you." },
			},

			HeraclesFieldAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/MelinoeField_3765", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sir, what are you doing in the middle of the Rift of Thessaly. How did you even get here? Although, you must be a powerful swimmer." },
				{ Cue = "/VO/Heracles_0239",
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "I'm proficient in a wide variety of athletics, since you mention it. Swimming, leaping, striking things with clubs." },
				{ Cue = "/VO/MelinoeField_3766", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So this is part of your patrol path? To think my journey could have been even more infested with foes if not for you." },
				{ Cue = "/VO/Heracles_0240",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Much would be different if not for me. Though you're one of the few I've met of late to admit it. Fair voyaging, sister." },
			},

			HeraclesFieldAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
				},
				{ Cue = "/VO/MelinoeField_0233", UsePlayerSource = true,
					Text = "Olympus is fortunate to have your strength and service, Son of Zeus." },
				{ Cue = "/VO/Heracles_0011",
					Text = "I serve the gods all right. Served them a long time, one tall order after another. They've brought me fame, glory... {#Emph}everything. {#Prev}They never get enough of me." },
				{ Cue = "/VO/MelinoeField_0234", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But {#Emph}you've {#Prev}had enough of {#Emph}them. {#Prev}Then... what are you doing here?" },
				{ Cue = "/VO/Heracles_0012",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Oh, my work history can demonstrate I never get enough of {#Emph}them{#Prev}, either. I take a job, I do it." },
			},

			HeraclesFieldAboutOlympus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
				},
				{ Cue = "/VO/Heracles_0241",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Welcome to your ancestral mountain, sister. Everything you dreamed of? I once yearned to be here, too. I got over it." },
				{ Cue = "/VO/MelinoeField_3767", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yet you're still defending this place. You speak as though you've lost your purpose, but I've seen you fight." },
				{ Cue = "/VO/Heracles_0242",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "{#Emph}Purpose. {#Prev}The gods asked the world of me before I could join them here, only to have to defend their honor some more. You'll find your {#Emph}own {#Prev}purpose, soon enough." },
			},

			HeraclesFieldAboutHera01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
				},
				{ Cue = "/VO/Heracles_0013",
					PreLineWait = 0.35,
					Text = "...You have her blessing, then. Just like that, she gave you her strength. Her approval..." },
				{ Cue = "/VO/MelinoeField_0235", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean Hera? Of course she did; we're all on the same side. More than that, we're family." },
				{ Cue = "/VO/Heracles_0014",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "{#Emph}Family. {#Prev}It figures that her grace the Queen presides over the entire concept. Marriage, birthing, and the like. Curses, in a charitable form." },
			},
			HeraclesFieldAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
					},
				},
				{ Cue = "/VO/Heracles_0253",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "If you're a daughter of Hades for true, that makes us cousins, doesn't it? Although knowing my father, you must have a lot of those..." },
				{ Cue = "/VO/MelinoeField_3989", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've met quite a few recently among the Olympians themselves. But I grew up mostly in solitude." },
				{ Cue = "/VO/Heracles_0254",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Thank the Fates for that. Fewer relatives means fewer obligations... fewer wars to be recruited into through no doing of your own, other than being born..." },
			},
			HeraclesFieldAboutFame01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift04" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_FanPoster01b" },
					},
				},
				{ Cue = "/VO/Heracles_0284",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },					
					Text = "Everywhere I go, the dead know me; it's irksome. Used to be able to show up to a slaughter without drawing attention." },
				{ Cue = "/VO/MelinoeField_3997", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The consequence of notoriety. The Shades where I'm from all think the world of you! We may or may not even have a wall-scroll depicting your adventures." },
				{ Cue = "/VO/Heracles_0285",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "They don't know anything about me, only the falsehoods and half-truths. I don't need a cult of mindless followers." },
			},

			HeraclesFieldAboutMedea01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Medea_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesGift02", "MedeaGift02" },
					},
				},

				{ Cue = "/VO/MelinoeField_3993", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You ever see Lady Medea around here? Long dark hair and attire. She could probably help thin the crowd. No denying we're outnumbered." },

				{ Cue = "/VO/Heracles_0275",
					PreLineWait = 0.35,
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "Already owe her for a time I wasn't... at my best. Won't be asking further favors from a witch. You take more than you give." },

				{ Cue = "/VO/MelinoeField_3994", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What did witches ever do to you? It sounds as though she helped you out, yet you still speak of her with such disdain." },

				{ Cue = "/VO/Heracles_0276",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "I know what you're capable of. I respect the power of an erupting volcano, doesn't mean I want to be near one." },
			},

			HeraclesFieldAboutIcarus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutHeracles01", "HeraclesGift07", "IcarusGift08" },
					},
				},

				{ Cue = "/VO/MelinoeField_4009", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "In all your travels back and forth from Mount Olympus, have you ever seen a young man with wings soaring over the waters, dropping explosives to disrupt the Titan's fleets?" },

				{ Cue = "/VO/Heracles_0261",
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "The son of the artificer Daedalus. Those are not real wings, and he's a Shade now. He and his father both. What of him?" },

				{ Cue = "/VO/MelinoeField_4010", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, it's just that... he's quite an admirer of yours, apparently. He'd give anything to meet you at some point. I thought perhaps I could facilitate an introduction." },

				{ Cue = "/VO/Heracles_0262",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Not interested in admirers. Especially ones whose drowned corpses I had to bury. He's better off with the idea of me." },
			},
			HeraclesFieldAboutIcarus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutHeracles02" },
					},
				},

				{ Cue = "/VO/MelinoeField_4011", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, the son of Daedalus we spoke of, he was very moved to learn you may have helped administer his final rites. He said to tell you cheers... I think he'd want to say much more." },

				{ Cue = "/VO/Heracles_0263",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "{#Emph}Urgh. {#Prev}Would you just leave me be with all his sentiment." },
			},

			HeraclesFieldAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesGift03", "MorosPostTrueEnding02" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Heracles_0352",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Word is the Fates themselves are gone. Too bad. I always wanted that job for myself. Not that they can be killed." },
				{ Cue = "/VO/MelinoeField_3771", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You always wanted to kill the Three Fates... for deciding you'd become a great hero of exceeding strength whose achievements would inspire countless others?" },
				{ Cue = "/VO/Heracles_0353",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Certainly if not for them I wouldn't be here. Well now they know what it's like... getting strung about with no say in the matter. The Fates be damned! Justice is all we need." },
			},

			HeraclesFieldAboutPolyphemus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
				},
				{ Cue = "/VO/Heracles_0015",
					Text = "You made it out before. Cyclops must have caught your scent, though. He's strong, that one." },
				{ Cue = "/VO/MelinoeField_0236", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's a ringing endorsement. Though {#Emph}you {#Prev}must be stronger still! Ever considered putting him to the test? Could save me a lot of trouble." },
				{ Cue = "/VO/Heracles_0016",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "He's not my type. Besides, he's a spawn of the gods, just like you and me. Wouldn't be proper if we were all fighting all the time, now would it?" },
			},
			HeraclesFieldAboutFathers01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Heracles_0017",
					Text = "Our fathers sure made a mess of things for us, didn't they, sister. Born to the mightiest of gods, yet living like outcasts... like bloody animals." },

				{ Cue = "/VO/MelinoeField_0237", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's Chronos that made a mess of things. If he'd have just stayed dead, we'd be at peace. And together with our fathers, no doubt." },

				{ Cue = "/VO/Heracles_0018",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Have you {#Emph}met {#Prev}our fathers? Sure, we're in the midst of an interminable war, but at least we're far away from {#Emph}them." },
			},
			HeraclesFieldAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						Path = { "PrevRun", "ResourcesSpent", "Money" },
						Comparison = ">=",
						Value = 200,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraclesMiscChat01", "HeraclesMiscChat08" },
					},
				},
				{ Cue = "/VO/MelinoeField_0241", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You seem to know the Boatman pretty well. Worked together before?" },

				{ Cue = "/VO/Heracles_0184",
					Text = "I've had occasion to visit your realm in the past. The Boatman is my supplier. And evidently yours as well... buying up all the merchandise." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_0485", Text = "I've not exactly been discreet..." },
					},
				},
			},

			HeraclesFieldAboutBoar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_MiniBoss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Heracles_0271",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Friendly word of advice: beware a large and not-entirely-dead boar snuffing about in the Ephyra alleyways. It's come for me." },

				{ Cue = "/VO/MelinoeField_3992", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're being hunted by a boar, not the other way around? Did I hear that correctly?" },

				{ Cue = "/VO/Heracles_0272",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "We... had our troubles in the past while it was more... alive. This is what I get for not finishing the job when I had the chance." },
			},

			HeraclesFieldAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusFirstMeeting" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
				},
				{ Cue = "/VO/MelinoeField_3768", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you had any run-ins with the Titan Prometheus while on Olympus recently? He seems to be the one leading the assault forces besieging your family's home." },

				{ Cue = "/VO/Heracles_0257",
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "Is he now? That's rich. Wasn't he supposed to be tied up on some mountain someplace else, getting picked apart?" },

				{ Cue = "/VO/MelinoeField_3769", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How do you not know he's free? You should be hunting {#Emph}him{#Prev}, not this fodder. Who's setting your objectives?" },

				{ Cue = "/VO/Heracles_0258",
					PreLineAnim = "Heracles_Hub_Granting",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "My orders come directly from the King and Queen. If you've any concerns with how I'm carrying out my work, just go complain to them." },
			},

			HeraclesFieldAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
				{ Cue = "/VO/Heracles_0259",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "You make it to the mountaintop as yet? In case you haven't, nothing good awaits you there. Or so I hear." },

				{ Cue = "/VO/MelinoeField_3770", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What, you mean Typhon? I'm surprised the Olympians don't have you helping out with {#Emph}him{#Prev}, instead of bashing a bunch of weaklings far from where the real danger is." },

				{ Cue = "/VO/Heracles_0260",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "The Olympians won't abide some half-god stealing their glory. I get the drudgery, not the important work. Thank the Fates that {#Emph}you {#Prev}get some of each." },
			},
			HeraclesFieldAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
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
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
					},
				},
				{ Cue = "/VO/Heracles_0634",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "What is it like... being up against that monster at the summit. I've not faced something of that size. Not yet at least." },

				{ Cue = "/VO/MelinoeField_4021", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've not faced anything of Typhon's size either. His enormity is to his disadvantage in some ways, but facing {#Emph}him{#Prev}, a torrential storm, and his broodlings all at once can be a lot." },

				{ Cue = "/VO/Heracles_0635",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "To think the multi-headed Hydra I once slew was merely one of his offspring. But there shall be worse monsters to fight in ages hence..." },
			},

			HeraclesFieldAboutAltFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
				},
				{ Cue = "/VO/Heracles_0235",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "There's no more work here to be done... but it never ends. No hard feelings, by the way, about before." },

				{ Cue = "/VO/MelinoeField_3763", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, none at all. I always wondered what it'd feel like to get struck full-on by the force of your club, and now I don't." },

				{ Cue = "/VO/Heracles_0236",
					PreLineAnim = "Heracles_Hub_Granting",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Nor do I like leaving any room for doubt. And if you need a reminder about my club, you know where to locate me." },
			},

			HeraclesFieldAboutAltFightWin01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Heracles" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Heracles_0295",
					Text = "You're not what I thought. Kept your mouth shut about me. Even somehow overcame Prometheus after I butted in. Why and how?" },

				{ Cue = "/VO/MelinoeField_3777", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have my reasons and my ways. Why should I be forthcoming about them? You've not exactly been eager to open up." },

				{ Cue = "/VO/Heracles_0296",
					Text = "Thought if I asked {#Emph}nicely{#Prev}, but that doesn't work on me either. Well, suit yourself. Not like I can drag it out of you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
					},
				},
				EndEvents =
				{
					{
						-- heart unlock
						FunctionName = "RelationshipAdvancedPresentation",
						FunctionArgs = { Delay = 3.5 },
					},
					{
						FunctionName = "HeraclesExit",
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				},
			},

			HeraclesFieldAboutReturning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
						Comparison = ">=",
						Value = 1,
					},
					{
						-- SumPrevRuns = 1 is the same as CurrentRun, SumPrevRuns = 2 is checking PrevRun, etc.
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Heracles_01" },
						IgnoreCurrentRun = true,
						CountPathTrue = true,
						Comparison = "<",
						Value = 1,
					},
					{
						SumPrevRuns = 3,
						Path = { "SpeechRecord" },
						TableValuesToCount = { "/VO/Heracles_0104", "/VO/Heracles_0105", "/VO/Heracles_0106", "/VO/Heracles_0107" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
				},
				{ Cue = "/VO/Heracles_0237",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Last we had a skirmish such as this, after the dust settled, you were nowhere to be found. Fled, like a thief in the night." },

				{ Cue = "/VO/MelinoeField_3764", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I had to make an early exit. Figured you would have no trouble resolving the matter, seeing as you work alone." },

				{ Cue = "/VO/Heracles_0238",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "That I do. But I don't like combatants disappearing on me. Stay where I can see you, or stay out of the way." },
			},

			HeraclesFieldAboutBlood01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "PlayerTookDamage" },
					},
				},
				{ Cue = "/VO/Heracles_0019",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Your blood runs red. You're not entirely a goddess. We truly get the best of both worlds." },
				{ Cue = "/VO/MelinoeField_0238", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You were born to a mortal mother, weren't you? My mother's half-mortal. Death itself is in our blood. But you're different..." },
				{ Cue = "/VO/Heracles_0020",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "{#Emph}Different. {#Prev}Neither god, nor mortal, nor Shade. It's as you say; death itself is in my blood. All mortals are born to die. I was born also to kill." },
			},

			HeraclesFieldAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DecayingBoostKeepsake" },
					},					
				},
				{ Cue = "/VO/Heracles_0255",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Well, if it isn't my old Lion Fang. I had multiples to spare, and you looked like you could use some of its savagery yourself." },
				{ Cue = "/VO/MelinoeField_3990", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Its strength is useful certainly, though why give it away? The stronger I am, the more I can encroach on your glory." },
				{ Cue = "/VO/Heracles_0256",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Simple, sister: I don't want it anymore. Neither the Fang nor the glory. Take my work for all I care; there's always more." },
			},

			HeraclesFieldAboutMagick01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
				},
				{ Cue = "/VO/Heracles_0326",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Those magick tricks... you're borrowing that power. How can you trust it when strength belongs to you alone?" },
				{ Cue = "/VO/MelinoeField_3998", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Magick and raw strength are not in opposition; both ultimately come from within, they're just trained differently." },
				{ Cue = "/VO/Heracles_0327",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "I don't think so, sister. You're drawing from the moon, and the earth, and... who knows what else. But in this world, you can't rely on anybody but yourself." },
			},

			HeraclesFieldAboutWeapons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllWeaponAspects,
						Comparison = ">=",
						Value = 10,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift04" },
					},
				},
				{ Cue = "/VO/Heracles_0243",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "You've more aptitude for weaponry than one might expect. I once sought to master every armament under the sun, but in the end... I settled for the simple club." },
				{ Cue = "/VO/MelinoeField_3985", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am bearer of the Arms of Night in all their various Aspects; I'd never settle for just one. Do you not fear you've grown complacent?" },
				{ Cue = "/VO/Heracles_0244",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "No. Tread this path long enough, you'll find that any weapon can do the job. At that point, there's no real choice. Though I still carry all these other arms just to put on a show." },
			},

			HeraclesFieldAboutTimePassing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesPreEncounterAboutTimePassing01" },
					},
					{
						SumPrevRuns = 6,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Heracles_0282",
					Text = "I'd given you no thought at all while you were gone. Otherwise I would have figured you had given up." },
				{ Cue = "/VO/MelinoeField_3995", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't know what I'm supposed to say to that except I hadn't given you much thought lately either. Is there anyone you {#Emph}do {#Prev}regularly think about?" },
				{ Cue = "/VO/Heracles_0283",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "I think mainly of the bodies I have crushed beneath my club and feet. You're welcome to join them, at any point." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_3996", Text = "No thank you, that's all right." },
					},
				},
			},

			HeraclesFieldAboutTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Heracles_0278",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "They said the war was finally drawing to a close. Somebody must have forgotten to notify those we slaughtered." },

				{ Cue = "/VO/MelinoeField_4005", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We need them here for the time being anyhow. Has Olympus informed you of the nature of the next phase of our plan?" },

				{ Cue = "/VO/Heracles_0279",
					Text = "I got the gist: We fight on. Nothing changes. Never has before, so... why would it now?" },

				{ Cue = "/VO/MelinoeField_4006", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What are you talking about? A lot's changed! Olympus is no longer in danger. The House of Hades is restored." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Heracles_01",
						{ Cue = "/VO/Heracles_0280", Text = "The way it always was." },
					},
				},
				EndEvents =
				{
					{
						FunctionName = "HeraclesExit",
						Threaded = true,
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				}
			},
			HeraclesFieldAboutTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift07" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 6 },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }, Min = 3 },
					},
				},

				{ Cue = "/VO/MelinoeField_4022", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What will you do when all of this is over, sir? Or rather, what would you desire to do?" },

				{ Cue = "/VO/Heracles_0636",
					PreLineWait = 0.35,
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "...Why ask? I tend not to give desire too much thought, beyond any immediate and bestial cravings I may have." },

				{ Cue = "/VO/MelinoeField_4023", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I would appreciate any perspective, that's all. All my life I had an obligation to my family to fulfill. I'm not certain what to do with myself now that I have..." },

				{ Cue = "/VO/Heracles_0637",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "I am the last individual whose perspective you should heed, sister. Chase your dreams if you still have any. Now scoot." },
			},

			HeraclesFieldAboutEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutEpilogue01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4007", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Titan Prometheus seems rather pleased of late. Why do you suppose that is?" },

				{ Cue = "/VO/Heracles_0286",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "How should I know, and why should it matter? Seeing as we don't discuss him here, or anywhere." },

				{ Cue = "/VO/MelinoeField_4008", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Then let's discuss you. Have you gotten what you sought? With the Fates declaring that an age of mortals is to come." },

				{ Cue = "/VO/Heracles_0287",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "I'm a mere half-god, as you may recall. I never get what I want. But when finally comes a time for change, I'll welcome it. May that next age no longer need for gods or men like me." },
			},
			HeraclesFieldAboutEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesFieldAboutEpilogue01", "HeraclesGift06" },
					},
				},
				{ Cue = "/VO/Heracles_0354",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Greet", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "Having given it all some further thought, I must admit I undersold what you achieved, sister. Your task was difficult." },
				{ Cue = "/VO/MelinoeField_4019", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It could have been worse. I had the strength of mighty Heracles on my side, at least for the most part. But thank you; that means a lot coming from you." },
				{ Cue = "/VO/Heracles_0355",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "No need. For now, it seems we get to ply our trade without the pressure to accomplish the impossible. I'll take it." },
			},

			HeraclesFieldAboutSayingLittle01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift07" },
					},
				},
				{ Cue = "/VO/Heracles_0330",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "You talk too much, you know that, witch? Dispense with the pleasantries, and we could be killing even more." },
				{ Cue = "/VO/MelinoeField_4018", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not certain which pleasantries you mean, but if you'd like to speak even less, that's certainly your prerogative." },
				{ Cue = "/VO/Heracles_0331",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Speaking never was my specialty. And as you may have surmised, I'm more the sort to focus on my strengths." },
			},

			-- Repeatable Shop
			HeraclesMiscChat01 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0033",
					Text = "If you're starved for conversation, you'll have better fortune with the Boatman there." },
			},
			HeraclesMiscChat04 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0036",
					Text = "You never saw me, I never saw you. Scoot." },
			},
			HeraclesMiscChat05 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0037",
					Text = "Save it for somebody who cares, sister." },
			},
			HeraclesMiscChat06 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0038",
					Text = "Whatever you're about to say to me, don't." },
			},
			HeraclesMiscChat07 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0039",
					Text = "I look like I want to have ourselves a chat?" },
			},
			HeraclesMiscChat08 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0358",
					Text = "{#Emph}Urgh. {#Prev}You just made me lose count of all my blasted coin." },
			},

		},

		GiftTextLineSets =
		{
			HeraclesGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/MelinoeField_0239", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Great Son of Zeus, I offer you this gift of Nectar, that it may quench your thirst as you labor for the gods. They must be grateful for your might." },
				{ Cue = "/VO/Heracles_0021",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "{#Emph}Heh. {#Prev}Saves me having to find another bottle for when next I have to prove my fealty. Here, something for your trouble." },
			},
			HeraclesGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/Heracles_0022",
					Text = "Sure you don't want to give me only half the bottle there? Seeing as I'm merely half a god... I got their strength but seldom get their luxury." },
				{ Cue = "/VO/MelinoeField_0240", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					Text = "Nothing's gained from luxury in excess, anyway. But there are times a little doesn't hurt! May this soothe your spirit when the occasion arises." },
			},
			HeraclesGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/Heracles_0288",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Heracles_Hub_Granting", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "You truly take me for a fool, believing I would drink from {#Emph}this? {#Prev}You could have ensorcelled the contents in any number of ways, to drive me to madness, or worse..." },
				{ Cue = "/VO/MelinoeField_3772", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I swear to you upon my father's name that I've done no such thing. And it would have obviously spoiled if I had. Do you want to see me drink it first?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Heracles_01",
						{ Cue = "/VO/Heracles_0289", Text = "No. I can dispose of it myself." },
					},
				},
				EndEvents =
				{
					{
						FunctionName = "HeraclesExit",
						Threaded = true,
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				}
			},
			HeraclesGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/Heracles_0290",
					Text = "My favor, in exchange for {#Emph}drink? {#Prev}No. You waste your resources and time; {#Emph}my {#Prev}time as well. You'll get a share of spoils if you earn your kills, but nothing more. " },
				{ Cue = "/VO/MelinoeField_3773", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I understand. Nevertheless, we're both working for the same family, and I have seen firsthand the efforts you're taking to drive back their enemies. And I'm grateful." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Heracles_01",
						{ Cue = "/VO/Heracles_0170", Text = "{#Emph}<Scoff>" }
					},
				},
				EndEvents =
				{
					{
						FunctionName = "HeraclesExit",
						Threaded = true,
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				}
			},
			HeraclesGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/Heracles_0291",
					Text = "They never give this stuff to me themselves, the mountain gods. Developed a distaste for it as a result, especially after a certain... contest with the god of wine. But that was long ago." },
				{ Cue = "/VO/MelinoeField_3774", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You tried to out-drink Lord Dionysus? Even with all your fortitude, that sounds like a very dangerous undertaking from what I understand." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Heracles_01",
						{ Cue = "/VO/Heracles_0292", Text = "It was." },
					},
				},
				EndEvents =
				{
					{
						FunctionName = "HeraclesExit",
						Threaded = true,
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				}
			},
			HeraclesGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/MelinoeField_3775", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You say the gods never shared Nectar with you; well, I'm sharing some now. Perhaps you can regain a taste for it." },
				{ Cue = "/VO/Heracles_0293",
					Text = "No more of this, witch. I told you I don't care for it, and presently I have no plans to go make any offerings myself. My tolerance for {#Emph}you {#Prev}likewise nears its limit." },
				{ Cue = "/VO/MelinoeField_3776", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your tolerance is enough, sir. I see how hard you work, expecting nothing in return. For all you've given to Olympus, may you never give your soul." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Heracles_01",
						{ Cue = "/VO/Heracles_0294", Text = "...That would require me to have one still." },
					},
				},
				EndEvents =
				{
					{
						FunctionName = "HeraclesExit",
						Threaded = true,
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				}
			},
			-- bond forged
			HeraclesGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- SkipGiftPresentationPost = true,
				LockedHintId = "Codex_HeraclesGiftHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedHeracles",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesGift06", "HeraclesFieldAboutAltFightWin01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3778", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You said I wasn't what you thought; neither are you what I expected, sir. I'd heard tales of your exploits, and truly never seen so fierce a fighter. But I know there's more to you. Here, then! For one of your divinity, a divine gift." },

				{ Cue = "/VO/Heracles_0297",
					Text = "Ambrosia... you would take me for another god. I am half-man; such stuff is not for me, and you sully its purpose merely in the offering. What do you want from me?" },

				{ Cue = "/VO/MelinoeField_3779", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I want you to accept that there are gods and goddesses who hold you in esteem. If falling short of perfection means falling short of godhood, then none of us are divine." },

				{ Cue = "/VO/Heracles_0298",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Heracles_01", Icon = "Keepsake_Heracles" },

					Text = "...Now you're on to something, sister. Well, if and when the rest of the family gets around to accepting your terms, let's all share this bottle. I'll just hang onto it for now." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0055", Text = "Until then." },
					},
				},
				EndEvents =
				{
					{
						FunctionName = "HeraclesExit",
						Threaded = true,
						Args = { WaitTime = 3.0, SkipIfStillInteractable = true, },
					},
				}
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/MelinoeField_0642", Text = "No trouble at all, thank you." },
		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					PlayOnceFromTableThisRun = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 370006 }, Alive = false },
						},
					},
				},
			},
		},

		EntranceVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				SuccessiveChanceToPlayAll = 0.25,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatP", "HeraclesCombatP2" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesCombat01" },
					},
				},

				{ Cue = "/VO/Melinoe_1388", Text = "Heracles..." },
				{ Cue = "/VO/Melinoe_1389", Text = "Him again...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1096", Text = "Peace, sir." },
				{ Cue = "/VO/Melinoe_1097", Text = "Good evening." },		
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesCombat01" }
					},
				},
				{ Cue = "/VO/Heracles_0043", Text = "You." },
				{ Cue = "/VO/Heracles_0044", Text = "You again." },
				{ Cue = "/VO/Heracles_0045", Text = "You're just in time..." },
				{ Cue = "/VO/Heracles_0046", Text = "You're just in time." },
				{ Cue = "/VO/Heracles_0048", Text = "Our labors never cease." },
				{ Cue = "/VO/Heracles_0049", Text = "Our paths keep crossing huh." },
				{ Cue = "/VO/Heracles_0050", Text = "Back for more glory, huh?" },
				{ Cue = "/VO/Heracles_0051", Text = "The witch returns..." },
				{ Cue = "/VO/Heracles_0052", Text = "Where'd you come from?" },
				{ Cue = "/VO/Heracles_0053", Text = "Just you, huh?" },
				{ Cue = "/VO/Heracles_0056", Text = "{#Emph}Ah.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0430", Text = "Could have been you." },
				{ Cue = "/VO/Heracles_0433", Text = "Witch." },
				{ Cue = "/VO/Heracles_0436", Text = "That worked." },
				{ Cue = "/VO/Heracles_0437", Text = "No you don't." },
				{ Cue = "/VO/Heracles_0447", Text = "Keep your distance." },
				{ Cue = "/VO/Heracles_0438", Text = "Rough waters.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0439", Text = "Call it a mutiny.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0440", Text = "Another stowaway.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0441", Text = "Ahoy.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0442", Text = "A fellow sailor.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0443", Text = "Going my way?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0446", Text = "Took you for a Harpy.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O", "P" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0444", Text = "Cold out.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0445", Text = "Welcome.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0448", Text = "Blasted snow.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0449", Text = "You're the backup?",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0434", Text = "Been a while.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
						},
						{
							SumPrevRuns = 4,
							IgnoreCurrentRun = true,
							Path = { "SpawnRecord", "NPC_Heracles_01" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Heracles_0435", Text = "Still around?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							SumPrevRuns = 4,
							IgnoreCurrentRun = true,
							Path = { "SpawnRecord", "NPC_Heracles_01" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Heracles_0431", Text = "Surprise.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0432", Text = "Evening.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0047", Text = "Again we meet, sister.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift01" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0054", Text = "Hullo...!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0055", Text = "Hullo.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				SuccessiveChanceToPlay = 0.2,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "HeraclesCombatO", "HeraclesCombatO2" },
					},
				},

				{ Cue = "/VO/MelinoeField_1963", Text = "Welcome aboard...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1964", Text = "Welcome aboard...?" },
				{ Cue = "/VO/MelinoeField_1965", Text = "How does he do that?" },
			},
		},
		EncounterStartVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.7,

				{ Cue = "/VO/Heracles_0057", Text = "They come." },
				{ Cue = "/VO/Heracles_0058", Text = "Prepare." },
				{ Cue = "/VO/Heracles_0059", Text = "There." },
				{ Cue = "/VO/Heracles_0060", Text = "Stay out of my path.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0061", Text = "Stand clear!" },
				{ Cue = "/VO/Heracles_0062", Text = "Stand clear." },
				{ Cue = "/VO/Heracles_0363", Text = "Time to get to work..." },
				{ Cue = "/VO/Heracles_0450", Text = "Now, then..." },
				{ Cue = "/VO/Heracles_0451", Text = "The more the better." },
				{ Cue = "/VO/Heracles_0452", Text = "They're mine." },
				{ Cue = "/VO/Heracles_0454", Text = "Come on, then." },
				{ Cue = "/VO/Heracles_0455", Text = "To the slaughter." },
				{ Cue = "/VO/Heracles_0456", Text = "They come." },
				{ Cue = "/VO/Heracles_0457", Text = "More work!" },
				{ Cue = "/VO/Heracles_0458", Text = "Ought to be quick." },
				{ Cue = "/VO/Heracles_0459", Text = "Come, friends." },
				{ Cue = "/VO/Heracles_0460", Text = "Earn your keep if you like." },
				{ Cue = "/VO/Heracles_0462", Text = "What have we here..." },
				{ Cue = "/VO/Heracles_0453", Text = "Don't get underfoot.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "HeraclesMiscStart01" },
						},
					},
				},
				{ Cue = "/VO/Heracles_0461", Text = "Split the proceeds?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.2,
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/Heracles_0185", Text = "It begins!!" },
				{ Cue = "/VO/Heracles_0186", Text = "Face me!!" },
				{ Cue = "/VO/Heracles_0187", Text = "Come on!!", PlayFirst = true },
				{ Cue = "/VO/Heracles_0188", Text = "Come on!!" },
				{ Cue = "/VO/Heracles_0189", Text = "Stand and fight!!" },
				{ Cue = "/VO/Heracles_0190", Text = "I'll tear you limb from limb!!" },
				{ Cue = "/VO/Heracles_0191", Text = "Olympus!!" },
				{ Cue = "/VO/Heracles_0192", Text = "Olympus!" },
				{ Cue = "/VO/Heracles_0193", Text = "{#Emph}Hoaaaahhh!!" },
				{ Cue = "/VO/Heracles_0194", Text = "{#Emph}Hrrooaaaahh!!" },
				{ Cue = "/VO/Heracles_0195", Text = "{#Emph}Hrraaaahhh!!" },
				{ Cue = "/VO/Heracles_0672", Text = "{#Emph}Nraaaauggh!" },
				{ Cue = "/VO/Heracles_0673", Text = "{#Emph}Hraaaauggh!" },
				{ Cue = "/VO/Heracles_0660", Text = "To {#Emph}battle!!" },
				{ Cue = "/VO/Heracles_0661", Text = "Who would dare?!" },
				{ Cue = "/VO/Heracles_0662", Text = "You {#Emph}first!!" },
				{ Cue = "/VO/Heracles_0663", Text = "To the {#Emph}slaughter!!" },
				{ Cue = "/VO/Heracles_0664", Text = "We {#Emph}fight!!" },
				{ Cue = "/VO/Heracles_0665", Text = "Blood shall spill!!" },
				{ Cue = "/VO/Heracles_0666", Text = "I'll crush you {#Emph}all!" },
				{ Cue = "/VO/Heracles_0667", Text = "For you, Father!!" },
				{ Cue = "/VO/Heracles_0668", Text = "For the Queen!!" },
				{ Cue = "/VO/Heracles_0669", Text = "Gods, watch this!!" },
				{ Cue = "/VO/Heracles_0670", Text = "Who dies first?!" },
				{ Cue = "/VO/Heracles_0671", Text = "Face my club!!" },
			}
		},

		PlayerHitNoDamageVoiceLinesVoiceLineThreshold = 0.66,
		PlayerHitNoDamageVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.15,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "P_Boss01" },
				},
			},
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/Heracles_0084", Text = "Out of the way...!" },
			{ Cue = "/VO/Heracles_0085", Text = "Watch yourself." },
			{ Cue = "/VO/Heracles_0086", Text = "Keep clear.", PlayFirst = true },
			{ Cue = "/VO/Heracles_0087", Text = "Stand aside!" },
			{ Cue = "/VO/Heracles_0088", Text = "Your fault." },
			{ Cue = "/VO/Heracles_0089", Text = "What are you—" },
			{ Cue = "/VO/Heracles_0501", Text = "Careful!" },
			{ Cue = "/VO/Heracles_0502", Text = "Let me handle this." },
			{ Cue = "/VO/Heracles_0503", Text = "Watch yourself!" },
			{ Cue = "/VO/Heracles_0504", Text = "What are you doing!" },
			{ Cue = "/VO/Heracles_0505", Text = "Trying to get killed?" },
			{ Cue = "/VO/Heracles_0506", Text = "Get behind me." },
		},
		PlayerHitNoDamageReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "P_Boss01" },
				},
			},
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 18 },
			},

			{ Cue = "/VO/Heracles_0090", Text = "Keep fighting." },
			{ Cue = "/VO/Heracles_0091", Text = "Got you huh." },
			{ Cue = "/VO/Heracles_0092", Text = "Hurts, doesn't it?", PlayFirst = true },
			{ Cue = "/VO/Heracles_0093", Text = "Ignore the pain." },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			SuccessiveChanceToPlay = 0.85,
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
				{ Name = "HeraclesLastStandSpeech", Time = 40 },
			},

			{ Cue = "/VO/Heracles_0095", Text = "Still on your feet?" },
			{ Cue = "/VO/Heracles_0096", Text = "Not finished yet?", PlayFirst = true },
			{ Cue = "/VO/Heracles_0097", Text = "Not dead yet huh..." },
			{ Cue = "/VO/Heracles_0516", Text = "Careless." },
			{ Cue = "/VO/Heracles_0094", Text = "You still alive?",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0515", Text = "Be more careful.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0517", Text = "Stand back...!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0518", Text = "Blundering witch...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0519", Text = "You'll die yet...!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0520", Text = "Bleeding, witch?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0521", Text = "Resisted that...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0522", Text = "Go {#Emph}down{#Prev}, blast you...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0523", Text = "Not finished...?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0524", Text = "She's angry...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "EnemyKills", "Prometheus" },
					},
				},
			},
		},
		
		KillingEnemyVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlay = 0.75,
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 10 },
					{ Name = "HeraclesKillingSpeech", Time = 25 },
				},

				{ Cue = "/VO/Heracles_0063", Text = "Weaklings." },
				{ Cue = "/VO/Heracles_0473", Text = "Weaklings." },
				{ Cue = "/VO/Heracles_0064", Text = "Pathetic." },
				{ Cue = "/VO/Heracles_0065", Text = "Who else?" },
				{ Cue = "/VO/Heracles_0066", Text = "See that?" },
				{ Cue = "/VO/Heracles_0067", Text = "Down." },
				{ Cue = "/VO/Heracles_0068", Text = "Blood..." },
				{ Cue = "/VO/Heracles_0069", Text = "Fools." },
				{ Cue = "/VO/Heracles_0070", Text = "Die...", PlayFirst = true },
				{ Cue = "/VO/Heracles_0463", Text = "Slaughtered." },
				{ Cue = "/VO/Heracles_0464", Text = "Soft." },
				{ Cue = "/VO/Heracles_0465", Text = "Dead." },
				{ Cue = "/VO/Heracles_0466", Text = "Broken." },
				{ Cue = "/VO/Heracles_0467", Text = "Destroyed." },
				{ Cue = "/VO/Heracles_0468", Text = "Gone." },
				{ Cue = "/VO/Heracles_0469", Text = "Amateurs." },
				{ Cue = "/VO/Heracles_0470", Text = "Useless." },
				{ Cue = "/VO/Heracles_0471", Text = "{#Emph}Heh." },
				{ Cue = "/VO/Heracles_0472", Text = "{#Emph}Hah." },
				{ Cue = "/VO/Heracles_0474", Text = "Weak." },
			},
		},

		KillStolenVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.5,
			PlayOnceFromTableThisRun = true,
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 8 },
			},

			{ Cue = "/VO/Heracles_0075", Text = "That was mine." },
			{ Cue = "/VO/Heracles_0076", Text = "You're in my way." },
			{ Cue = "/VO/Heracles_0077", Text = "Oh, you...", PlayFirst = true },
			{ Cue = "/VO/Heracles_0078", Text = "Really?" },
			{ Cue = "/VO/Heracles_0079", Text = "Really." },
			{ Cue = "/VO/Heracles_0479", Text = "Hey...!" },
			{ Cue = "/VO/Heracles_0480", Text = "Get your own." },
			{ Cue = "/VO/Heracles_0481", Text = "Step back." },
			{ Cue = "/VO/Heracles_0482", Text = "My kill..." },
			{ Cue = "/VO/Heracles_0483", Text = "Thief..." },
		},

		EncounterEndVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.25,

				{ Cue = "/VO/Heracles_0108", Text = "There." },
				{ Cue = "/VO/Heracles_0109", Text = "There..." },
				{ Cue = "/VO/Heracles_0110", Text = "Done here." },
				{ Cue = "/VO/Heracles_0111", Text = "No survivors...?" },
				{ Cue = "/VO/Heracles_0112", Text = "All dead." },
				{ Cue = "/VO/Heracles_0113", Text = "All dead!" },
				{ Cue = "/VO/Heracles_0114", Text = "Weak." },
				{ Cue = "/VO/Heracles_0115", Text = "Enjoy the show, you gods?" },
				{ Cue = "/VO/Heracles_0116", Text = "{#Emph}Ahh..." },
				{ Cue = "/VO/Heracles_0117", Text = "{#Emph}<Sigh>" },
				{ Cue = "/VO/Heracles_0179", Text = "{#Emph}<Sigh>" },
				{ Cue = "/VO/Heracles_0547", Text = "All's well." },
				{ Cue = "/VO/Heracles_0548", Text = "That's it." },
				{ Cue = "/VO/Heracles_0549", Text = "Done." },
				{ Cue = "/VO/Heracles_0550", Text = "That was it." },
				{ Cue = "/VO/Heracles_0551", Text = "We're done." },
				{ Cue = "/VO/Heracles_0552", Text = "Satisfied, O Queen?" },
				{ Cue = "/VO/Heracles_0553", Text = "Anyone else...?" },
				{ Cue = "/VO/Heracles_0554", Text = "That's that." },
				{ Cue = "/VO/Heracles_0555", Text = "How many was that..." },
				{ Cue = "/VO/Heracles_0556", Text = "Let's see..." },
				{ Cue = "/VO/Heracles_0557", Text = "Clear." },
				{ Cue = "/VO/Heracles_0558", Text = "All clear." },
				{ Cue = "/VO/Heracles_0559", Text = "Silence..." },
				{ Cue = "/VO/Heracles_0560", Text = "None remain." },
			},
		},

		DuesPaidVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "HeraclesMoney" },
						Comparison = "==",
						Value = 0,
					}
				},

				{ Cue = "/VO/Heracles_0167", Text = "{#Emph}<Scoff>" },
				{ Cue = "/VO/Heracles_0168", Text = "{#Emph}<Scoff>" },
				{ Cue = "/VO/Heracles_0169", Text = "{#Emph}<Scoff>" },
				{ Cue = "/VO/Heracles_0170", Text = "{#Emph}<Scoff>" },
				{ Cue = "/VO/Heracles_0181", Text = "{#Emph}<Chuckle>" },
				{ Cue = "/VO/Heracles_0608", Text = "Truly a feat.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0607", Text = "Mightily impressive.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift07" },
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,

				{ Cue = "/VO/Heracles_0118", Text = "You earned your share.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0119", Text = "Here's your keep." },
				{ Cue = "/VO/Heracles_0120", Text = "You work, you get paid." },
				{ Cue = "/VO/Heracles_0121", Text = "For your labor." },
				{ Cue = "/VO/Heracles_0122", Text = "Your cut of the glory." },
				{ Cue = "/VO/Heracles_0123", Text = "The spoils of war." },
				{ Cue = "/VO/Heracles_0124", Text = "Call it even." },
				{ Cue = "/VO/Heracles_0125", Text = "Here." },
				{ Cue = "/VO/Heracles_0128", Text = "This was my fight." },
				{ Cue = "/VO/Heracles_0129", Text = "Another victory." },
				{ Cue = "/VO/Heracles_0127", Text = "I get the lion's share." },
				{ Cue = "/VO/Heracles_0561", Text = "This should cover it." },
				{ Cue = "/VO/Heracles_0562", Text = "Your share." },
				{ Cue = "/VO/Heracles_0563", Text = "Your keep." },
				{ Cue = "/VO/Heracles_0564", Text = "Your portion." },
				{ Cue = "/VO/Heracles_0565", Text = "What you're owed." },
				{ Cue = "/VO/Heracles_0566", Text = "Count it." },
				{ Cue = "/VO/Heracles_0567", Text = "All yours." },
				{ Cue = "/VO/Heracles_0568", Text = "We're even." },
				{ Cue = "/VO/Heracles_0569", Text = "For the Boatman." },
				{ Cue = "/VO/Heracles_0570", Text = "Spend it well." },
				{ Cue = "/VO/Heracles_0571", Text = "Your proceeds." },
				{ Cue = "/VO/Heracles_0572", Text = "You earned this." },
				{ Cue = "/VO/Heracles_0573", Text = "Your earnings." },
				{ Cue = "/VO/Heracles_0574", Text = "Your wages." },
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 14 },
				{ Name = "HeraclesHitRecentlySpeech", Time = 25 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Heracles_01",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
					},
					ChanceToPlay = 0.33,
				},

				{ Cue = "/VO/Heracles_0098", Text = "Out of my way." },
				{ Cue = "/VO/Heracles_0099", Text = "Watch it!" },
				{ Cue = "/VO/Heracles_0525", Text = "Excuse me?" },
				{ Cue = "/VO/Heracles_0526", Text = "Step back, witch." },
				{ Cue = "/VO/Heracles_0527", Text = "Give me space." },
				{ Cue = "/VO/Heracles_0528", Text = "Get away." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Heracles_01",
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" }
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
					},
					ChanceToPlay = 0.33,
				},

				{ Cue = "/VO/Heracles_0100", Text = "Ill-advised.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0101", Text = "I think not." },
				{ Cue = "/VO/Heracles_0102", Text = "Don't push it." },
				{ Cue = "/VO/Heracles_0103", Text = "No." },
				{ Cue = "/VO/Heracles_0164", Text = "I think not." },
				{ Cue = "/VO/Heracles_0165", Text = "No chance." },
				{ Cue = "/VO/Heracles_0529", Text = "Unwise." },
				{ Cue = "/VO/Heracles_0530", Text = "I'll remember this." },
			},
		},

		BrowsingVoiceLines =
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.75,
			PreLineWait = 0.0,
			ObjectType = "NPC_Heracles_01",
			GameStateRequirements =
			{
				--
			},
			Cooldowns =
			{
				{ Name = "HeraclesBrowsingSpeech", Time = 200 },
			},

			{ Cue = "/VO/Heracles_0138", Text = "Let's see...", PlayFirst = true },
			{ Cue = "/VO/Heracles_0139", Text = "{#Emph}Hrm..." },
			{ Cue = "/VO/Heracles_0140", Text = "Maybe..." },
			{ Cue = "/VO/Heracles_0141", Text = "Fleecing me here..." },
			{ Cue = "/VO/Heracles_0142", Text = "How much do I have..." },
			{ Cue = "/VO/Heracles_0617", Text = "...or this...?" },
			{ Cue = "/VO/Heracles_0618", Text = "Which one..." },
			{ Cue = "/VO/Heracles_0619", Text = "Should have the Gold..." },
			{ Cue = "/VO/Heracles_0620", Text = "That much...?" },
			{ Cue = "/VO/Heracles_0621", Text = "Can't afford both..." },
		},
		PurchasedVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Heracles_01",
			GameStateRequirements =
			{
				--
			},

			{ Cue = "/VO/Heracles_0143", Text = "I'll take it." },
			{ Cue = "/VO/Heracles_0144", Text = "All right." },
			{ Cue = "/VO/Heracles_0145", Text = "This one!" },
			{ Cue = "/VO/Heracles_0146", Text = "This one." },
			{ Cue = "/VO/Heracles_0147", Text = "Fine." },
			{ Cue = "/VO/Heracles_0161", Text = "Fair." },
			{ Cue = "/VO/Heracles_0162", Text = "Very well." },
			{ Cue = "/VO/Heracles_0163", Text = "{#Emph}Mm." },
			{ Cue = "/VO/Heracles_0622", Text = "Give me that." },
			{ Cue = "/VO/Heracles_0623", Text = "Don't you dare." },
			{ Cue = "/VO/Heracles_0624", Text = "I saw it first." },
			{ Cue = "/VO/Heracles_0625", Text = "I need that." },
		},
		PurchaseStolenVoiceLines =
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			PreLineWait = 0.4,
			ObjectType = "NPC_Heracles_01",
			GameStateRequirements =
			{
				--
			},

			{ Cue = "/VO/Heracles_0148", Text = "That was..." },
			{ Cue = "/VO/Heracles_0149", Text = "Hey, I..." },
			{ Cue = "/VO/Heracles_0150", Text = "Had my eye on that." },
			{ Cue = "/VO/Heracles_0151", Text = "Blast..." },
			{ Cue = "/VO/Heracles_0175", Text = "{#Emph}Hrm?" },
			{ Cue = "/VO/Heracles_0176", Text = "{#Emph}Hrm..." },
			{ Cue = "/VO/Heracles_0178", Text = "{#Emph}Ungh..." },
			{ Cue = "/VO/Heracles_0170", Text = "{#Emph}<Scoff>" },
			{ Cue = "/VO/Heracles_0626", Text = "But I..." },
			{ Cue = "/VO/Heracles_0627", Text = "What...?" },
			{ Cue = "/VO/Heracles_0628", Text = "Thwarted..." },
			{ Cue = "/VO/Heracles_0629", Text = "No..." },
		},

		ExitVoiceLines =
		{
			{
				Queue = "Always",
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.9,
				PreLineWait = 0.8,
				ObjectType = "NPC_Heracles_01",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Heracles_0130", Text = "I go.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0131", Text = "Enough of this." },
				{ Cue = "/VO/Heracles_0132", Text = "All right then." },
				{ Cue = "/VO/Heracles_0133", Text = "You never saw me." },
				{ Cue = "/VO/Heracles_0134", Text = "Peace, sister." },
				{ Cue = "/VO/Heracles_0135", Text = "Peace." },
				{ Cue = "/VO/Heracles_0136", Text = "My work is finished here." },
				{ Cue = "/VO/Heracles_0575", Text = "On to the next...!" },
				{ Cue = "/VO/Heracles_0576", Text = "Try not to die...!" },
				{ Cue = "/VO/Heracles_0577", Text = "Go on, witch...!" },
				{ Cue = "/VO/Heracles_0578", Text = "I was never here." },
				{ Cue = "/VO/Heracles_0579", Text = "Been a pleasure." },
				{ Cue = "/VO/Heracles_0581", Text = "Till next we meet." },
				{ Cue = "/VO/Heracles_0582", Text = "Look at the time." },
				{ Cue = "/VO/Heracles_0583", Text = "Fight on." },
				{ Cue = "/VO/Heracles_0584", Text = "Let's do this again." },
				{ Cue = "/VO/Heracles_0580", Text = "Till the summit.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
						},
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/Heracles_0137", Text = "We're done here.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Heracles_0110" },
						},
					},
				},
			},
			--[[
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.5,
				PreLineWait = 0.35,

				{ Cue = "/VO/Melinoe_1253", Text = "Farewell." },
			},
			]]--			
		},

	},
}

-- Global Heracles Lines
GlobalVoiceLines.HeraclesBoonReactionVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 1.65,
	ObjectType = "NPC_Heracles_01",
	RecheckRequirementsForSubLines = true,
	SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements =
	{
		--
	},
	Cooldowns =
	{
		{ Name = "HeraclesAnyQuipSpeech", Time = 4 },
	},

	{ Cue = "/VO/Heracles_0152", Text = "Even the gods have their price." },
	{ Cue = "/VO/Heracles_0153", Text = "Olympus..." },
	{ Cue = "/VO/Heracles_0630", Text = "A blessing for a price..." },
	{ Cue = "/VO/Heracles_0631", Text = "Such a farce." },
	{ Cue = "/VO/Heracles_0633", Text = "What do I care." },
	{ Cue = "/VO/Heracles_0155", Text = "That's all it takes, huh." },
	{ Cue = "/VO/Heracles_0154", Text = "She's aiding {#Emph}you?", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentLootData", "Name" },
				IsAny = { "HeraUpgrade" },
			},
		},
	},
	{ Cue = "/VO/Heracles_0632", Text = "The Queen can be bought.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentLootData", "Name" },
				IsAny = { "HeraUpgrade" },
			},
		},
	},
}
GlobalVoiceLines.HeraclesDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Heracles_01", SubtitleColor = Color.HeraclesVoice },

	{ Cue = "/VO/Heracles_0104", Text = "Blasted weaklings everywhere in sight..." },
	{ Cue = "/VO/Heracles_0105", Text = "The gods are poor at choosing champions...", PlayFirst = true },
	{ Cue = "/VO/Heracles_0106", Text = "I said to stay out of my blasted way..." },
	{ Cue = "/VO/Heracles_0107", Text = "No mercy for the weak out here, sister." },
}
GlobalVoiceLines.HeraclesGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectTypes = { "NPC_Heracles_01", "Heracles" },
		GameStateRequirements =
		{
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
		},
		Cooldowns =
		{
			{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Heracles_0585", Text = "Easily distracted." },
		{ Cue = "/VO/Heracles_0586", Text = "That couldn't wait?", PlayFirst = true },
		{ Cue = "/VO/Heracles_0587", Text = "Unnecessary risk." },
		{ Cue = "/VO/Heracles_0588", Text = "Leave it!" },
		{ Cue = "/VO/Heracles_0589", Text = "Leave it be...!" },
		{ Cue = "/VO/Heracles_0590", Text = "We're {#Emph}fighting {#Prev}here!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		SkipCooldownCheckIfNonePlayed = true,
		ObjectType = "NPC_Heracles_01",
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
		},
		Cooldowns =
		{
			{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Heracles_0591", Text = "The dregs of battle...", PlayFirst = true },
		{ Cue = "/VO/Heracles_0592", Text = "Common filth." },
		{ Cue = "/VO/Heracles_0593", Text = "Put that back..." },
		{ Cue = "/VO/Heracles_0594", Text = "Naught of worth." },
		{ Cue = "/VO/Heracles_0595", Text = "More spoils?" },
		{ Cue = "/VO/Heracles_0596", Text = "Why bother." },
	},
}
GlobalVoiceLines.HeraclesExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.25,
	ObjectType = "NPC_Heracles_01",
	Cooldowns =
	{
		{ Name = "HeraclesAnyQuipSpeech", Time = 4 },
	},

	{ Cue = "/VO/Heracles_0613", Text = "Temptress of the dead..." },
	{ Cue = "/VO/Heracles_0614", Text = "Foul witchery..." },
	{ Cue = "/VO/Heracles_0615", Text = "The dead are of no use..." },
	{ Cue = "/VO/Heracles_0616", Text = "Leave the dead to rot...", PlayFirst = true },
}

GlobalVoiceLines.HeraclesTagInLines =
{
	PlayOnceFromTableThisRun = true,
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlay = 0.33,
	SuccessiveChanceToPlayAll = 0.33,
	ObjectType = "Heracles",
	Cooldowns =
	{
		{ Name = "HeraclesAnyQuipSpeech", Time = 12 },
	},

	{ Cue = "/VO/Heracles_0375", Text = "Prometheus!" },
	{ Cue = "/VO/Heracles_0376", Text = "{#Emph}Go{#Prev}, Prometheus!" },
	{ Cue = "/VO/Heracles_0377", Text = "Flame Thief!" },
	{ Cue = "/VO/Heracles_0378", Text = "{#Emph}Now{#Prev}, Flame Thief!" },
	{ Cue = "/VO/Heracles_0379", Text = "{#Emph}His {#Prev}turn now...", PlayFirst = true },
	{ Cue = "/VO/Heracles_0380", Text = "Now for the flames..." },
}

GlobalVoiceLines.PrometheusKnockedOutLines =
{
	Queue = "Interrupt",
	{
		RandomRemaining = true,
		PreLineWait = 0.25,
		ObjectType = "Heracles",
		SkipCooldownCheckIfNonePlayed = true,
		TriggerCooldowns = { "HeraclesAnyQuipSpeech" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Heracles" },
				Comparison = ">=",
				Value = 0.2,
			},
		},

		{ Cue = "/VO/Heracles_0387", Text = "Prometheus...!", PlayFirst = true },
		{ Cue = "/VO/Heracles_0388", Text = "Prometheus!" },
		{ Cue = "/VO/Heracles_0389", Text = "Get up, Flame Thief...!" },
		{ Cue = "/VO/Heracles_0390", Text = "That's it, Flame Thief?" },
		{ Cue = "/VO/Heracles_0391", Text = "Already...?" },
		{ Cue = "/VO/Heracles_0392", Text = "I'll clean up." },
		{ Cue = "/VO/Heracles_0393", Text = "{#Emph}<Growl>" },
		{ Cue = "/VO/Heracles_0394", Text = "Gods...!" },
		{ Cue = "/VO/Heracles_0395", Text = "Blasted witch..." },
		{ Cue = "/VO/Heracles_0396", Text = "You and me!" },
		{ Cue = "/VO/Heracles_0397", Text = "Here, witch!" },
		{ Cue = "/VO/Heracles_0398", Text = "We're not finished." },
		{ Cue = "/VO/Heracles_0399", Text = "This isn't over." },
		{ Cue = "/VO/Heracles_0400", Text = "He predicted that..." },
	},
},

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Heracles )
