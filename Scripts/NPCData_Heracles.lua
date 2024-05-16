UnitSetData.NPC_Heracles = 
{
	-- Heracles, Id = TKTK
	NPC_Heracles_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		Portrait = "Portrait_Heracles_Default_01",
		Groups = { "NPCs" },
		SpeakerName = "Heracles",
		SubtitleColor = Color.HeraclesVoice,
		AnimOffsetZ = -20,
		ThemeMusic = "/Music/IrisMusicHeraclesTheme_MC",
		TurnInPlaceAnimation = "Heracles_Hub_Turn",

		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,

		ShopEventData = 
		{
			DelayMin = 8,
			DelayMax = 16,
			InstantChance = 0.1, -- Chance he will buy it without a chance for the player to interact
			NeverChance = 0.1, -- Chance he will dither indefinitely
			BrowsingVoiceLinesDelay = 4.0,
			FidgetIntervalMin = 5,
			FidgetIntervalMax = 11,
			ExitDelayMin = 2,
			ExitDelayMax = 5,
		},

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
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_0717", Text = "Stay strong, Son of Zeus.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0718", Text = "Gods watch over us." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Heracles_01",

				{ Cue = "/VO/Heracles_0080", Text = "Witches..." },
				{ Cue = "/VO/Heracles_0171", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Heracles_0172", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Heracles_0173", Text = "{#Emph}Mm." },
			},
		},

		PostTextLinesFunctionName = "GenericThankCharacterPresentation",

		BossIntroTextLineSets =
		{
			HeraclesFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RoomRequiredInteractionFalse = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSurfacePenaltyCure" },
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
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1370" },
					},
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
				{ Cue = "/VO/Heracles_0002",
					SecretMusic = "/Music/IrisMusicHeraclesTheme_MC",
					Text = "You're the help? Oh, that's rich. Friendly word of advice, {#Emph}sister: {#Prev}Stay out of my bloody way, else you're liable to get hurt. Now scoot, and tell whomever sent you that I work alone." },
				{ Cue = "/VO/MelinoeField_0228", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Your threat is duly noted, Son of Zeus. I'm headed for the docks, but understand this city's sealed shut." },
				{ Cue = "/VO/Heracles_0003",
					Text = "Then you understand you ought turn back. This town is {#Emph}dead{#Prev}, and doesn't let the living pass." },
				{ Cue = "/VO/MelinoeField_0229", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
				},
				{ Cue = "/VO/Heracles_0005",
					Text = "You. Things are about to turn ugly, and I require neither assistance nor witnesses, sister." },
				{ Cue = "/VO/MelinoeField_0230", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm passing through. And I'm not leaving here until the traitors to the House of Hades lie broken at our feet." },
				{ Cue = "/VO/Heracles_0006",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "{#Emph}Hah! {#Prev}Fine, then. We'll each earn our share. Though the lion's share is coming with me." },
			},

			-- Repeatable
			HeraclesMiscStart01 =
			{
				{ Cue = "/VO/Heracles_0023",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "I'm working here, sister. Care to pitch in, fine, but don't get underfoot." },
			},
			HeraclesMiscStart02 =
			{
				{ Cue = "/VO/Heracles_0024",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "You're either good or ill fortune, not yet made up my mind." },
			},
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
				{ Cue = "/VO/Heracles_0027",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Well don't just stand there, sister; we've a war here to perpetuate." },
			},
			HeraclesMiscStart06 =
			{
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
			HeraclesMiscStart09 =
			{
				{ Cue = "/VO/Heracles_0031",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Keep letting Olympus toss you around, and someday you'll be just like me." },
			},
			HeraclesMiscStart10 =
			{
				{ Cue = "/VO/Heracles_0032",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Why am I even talking to you, sister? You save your breath, I'll save mine." },
			},
		},

		InteractTextLineSets =
		{
			HeraclesFieldAboutEphyra01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
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
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I aim to cleanse the filth down to the source. He resides deep in the Underworld, though I've business to attend to on Olympus first." },
				{ Cue = "/VO/Heracles_0008",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "What a coincidence! I just returned from there not long ago. So the gods are putting all the pieces into place.... You watch yourself, sister." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
			},

			HeraclesFieldAboutWitches01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
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
					Text = "That won't be necessary. Though, I would know how came you to feel this way about us bloody witches? How many have you met?" },
				{ Cue = "/VO/Heracles_0010",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Two questions too many. The more you know, the more you can manipulate. Now, off with you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
			},
			HeraclesFieldAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
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
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Oh, my work history can demonstrate I never get enough of {#Emph}them{#Prev}, either. I take a job, I do it." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
					},
				},
			},
			HeraclesFieldAboutHera01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
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
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "{#Emph}Family. {#Prev}It figures that her grace the Queen presides over the entire concept. Marriage, birthing, and the like. Curses, in a charitable form." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
			},
			HeraclesFieldAboutPolyphemus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
					},
				},
				{ Cue = "/VO/Heracles_0015",
					Text = "You made it out before. Cyclops must have caught your scent, though. He's strong, that one." },
				{ Cue = "/VO/MelinoeField_0236", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's a ringing endorsement, though you must be stronger still. Ever considered putting him to the test? Could save me a lot of trouble." },
				{ Cue = "/VO/Heracles_0016",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "He's not my type. Besides, he's a spawn of the gods, just like you and me. Wouldn't be proper if we were all fighting all the time, now would it?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
			},
			HeraclesFieldAboutFathers01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
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
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Have you {#Emph}met {#Prev}our fathers? Sure, we're in the midst of an interminable war, but at least we're far away from {#Emph}them." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
			},

			HeraclesFieldAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					{
						Path = { "PrevRun", "ResourcesSpent", "Money" },
						Comparison = ">=",
						Value = 200,
					},
					-- @ update with real record requirement
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Heracles_0138"},
					}
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
						{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
					},
				},
			},

			HeraclesFieldAboutBlood01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Hub" },
					},
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
				},
				{ Cue = "/VO/Heracles_0019",
					Text = "Your blood runs red. You're not entirely a goddess. We truly get the best of both worlds." },
				{ Cue = "/VO/MelinoeField_0238", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You were born to a mortal mother, weren't you? My mother's half-mortal. Death itself is in our blood. But you're different..." },
				{ Cue = "/VO/Heracles_0020",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "{#Emph}Different. {#Prev}Neither god, nor mortal, nor Shade. It's as you say; death itself is in my blood. All mortals are born to die. I was born also to kill." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Likewise! Bye, Nem.
						-- { Cue = "/VO/Melinoe_0015_V3", Text = "Likewise! Bye, Nem." },
					},
				},
			},


			HeraclesMiscChat02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0034",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "We get to know each other, you'll live to regret it. Happens all the time." },
			},
			HeraclesMiscChat03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0035",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "You think you know me, sister. But you don't." },
			},
			HeraclesMiscChat04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0036",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "You never saw me, I never saw you. Scoot." },
			},
			HeraclesMiscChat05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0037",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Save it for somebody who cares, sister." },
			},
			HeraclesMiscChat06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				{ Cue = "/VO/Heracles_0038",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Whatever you're about to say to me, don't." },
			},
			HeraclesMiscChat07 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				{ Cue = "/VO/Heracles_0039",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "I look like I want to have ourselves a chat?" },
			},
			HeraclesMiscChat08 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				{ Cue = "/VO/Heracles_0040",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Suggest remaining far afield of me at all times, witch." },
			},
			HeraclesMiscChat09 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				{ Cue = "/VO/Heracles_0041",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "You blasted gods and goddesses are all alike..." },
			},
			HeraclesMiscChat10 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				{ Cue = "/VO/Heracles_0042",
					PostLineThreadedFunctionName = "HeraclesExit", PostLineFunctionArgs = { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 },
					Text = "Go about your business, sister. I'm on the job." },
			},

			-- Repeatable
			HeraclesMiscChat01 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Shop" },
					},
					RequiredUnitAlive = "NPC_Charon_01",
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Heracles",
				{ Cue = "/VO/Heracles_0033",
					Text = "If you're starved for conversation, you'll have better fortune with the Boatman there." },
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
						PathFalse = { "CurrentRun", "EncountersOccurredCache", "HeraclesCombatIntro" },
					},
				},
				{ Cue = "/VO/MelinoeField_0239", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Great Son of Zeus, I offer you this gift of Nectar, that it may quench your thirst as you labor for the gods. They must be grateful for your might." },
				{ Cue = "/VO/Heracles_0021",
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
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01" },
					},
				},
				{ Cue = "/VO/Heracles_0022",
					Text = "Sure you don't want to give me only half the bottle there? Seeing as I'm merely half a god... I got their strength but seldom get their luxury." },
				{ Cue = "/VO/MelinoeField_0240", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nothing's gained from luxury in excess, anyway. But there are times a little doesn't hurt! May this soothe your spirit when the occasion arises." },
			},

			-- placeholder
			HeraclesGiftTemp =
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
					AreIdsNotAlive = { 370006 },

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
						IsAny = { "HeraclesCombatN" },
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
						IsAny = { "HeraclesCombatN", "HeraclesCombatO" },
					},

				},
				{ Cue = "/VO/Heracles_0043", Text = "You." },
				{ Cue = "/VO/Heracles_0044", Text = "You again." },
				{ Cue = "/VO/Heracles_0045", Text = "You're just in time..." },
				{ Cue = "/VO/Heracles_0046", Text = "You're just in time." },
				{ Cue = "/VO/Heracles_0047", Text = "Again we meet, sister." },
				{ Cue = "/VO/Heracles_0048", Text = "Our labors never cease." },
				{ Cue = "/VO/Heracles_0049", Text = "Our paths keep crossing huh." },
				{ Cue = "/VO/Heracles_0050", Text = "Back for more glory, huh?" },
				{ Cue = "/VO/Heracles_0051", Text = "The witch returns..." },
				{ Cue = "/VO/Heracles_0052", Text = "Where'd you come from?" },
				{ Cue = "/VO/Heracles_0053", Text = "Just you, huh?" },
				{ Cue = "/VO/Heracles_0054", Text = "Hullo...!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
						},
					}
				},
				{ Cue = "/VO/Heracles_0055", Text = "Hullo.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
						},
					}
				},
				{ Cue = "/VO/Heracles_0056", Text = "{#Emph}Ah.", PlayFirst = true },
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
						IsAny = { "HeraclesCombatO" },
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
			}
		},

		PlayerInjuredVoiceLineThreshold = 0.66,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.15,
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/Heracles_0084", Text = "Out of the way...!" },
			{ Cue = "/VO/Heracles_0085", Text = "Watch yourself." },
			{ Cue = "/VO/Heracles_0086", Text = "Keep clear.", PlayFirst = true },
			{ Cue = "/VO/Heracles_0087", Text = "Stand aside!" },
			{ Cue = "/VO/Heracles_0088", Text = "Your fault." },
			{ Cue = "/VO/Heracles_0089", Text = "What are you--" },
		},
		PlayerInjuredReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
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
			Cooldowns =
			{
				{ Name = "HeraclesLastStandSpeech", Time = 40 },
			},
			TriggerCooldowns =
			{
				"HeraclesSpokeRecently",
			},

			{ Cue = "/VO/Heracles_0094", Text = "You still alive?" },
			{ Cue = "/VO/Heracles_0095", Text = "Still on your feet?" },
			{ Cue = "/VO/Heracles_0096", Text = "Not finished yet?", PlayFirst = true },
			{ Cue = "/VO/Heracles_0097", Text = "Not dead yet huh..." },
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
				},

				{ Cue = "/VO/Heracles_0063", Text = "Weaklings." },
				{ Cue = "/VO/Heracles_0064", Text = "Pathetic." },
				{ Cue = "/VO/Heracles_0065", Text = "Who else?" },
				{ Cue = "/VO/Heracles_0066", Text = "See that?" },
				{ Cue = "/VO/Heracles_0067", Text = "Down." },
				{ Cue = "/VO/Heracles_0068", Text = "Blood..." },
				{ Cue = "/VO/Heracles_0069", Text = "Fools." },
				{ Cue = "/VO/Heracles_0070", Text = "Die...", PlayFirst = true },
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
			}
		},

		EncounterTiedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,

			-- Let's call this one a draw.
			-- { Cue = "/VO/Thanatos_0346", RequiredPlayed = { "/VO/Thanatos_0347" } },
		},
		EncounterLostVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,

				{ Cue = "/VO/Heracles_0118", Text = "You earned your share.", PlayFirst = true },
				-- { Cue = "/VO/Heracles_0119", Text = "Here's your keep." },
				{ Cue = "/VO/Heracles_0120", Text = "You work, you get paid." },
				-- { Cue = "/VO/Heracles_0121", Text = "For your labor." },
				{ Cue = "/VO/Heracles_0122", Text = "Your cut of the glory." },
				{ Cue = "/VO/Heracles_0123", Text = "The spoils of war." },
				{ Cue = "/VO/Heracles_0124", Text = "Call it even." },
				-- { Cue = "/VO/Heracles_0125", Text = "Here." },
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ChanceToPlay = 0.2,
				ObjectType = "NPC_Heracles_01",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
					},
				},
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 14 },
				},

				{ Cue = "/VO/Heracles_0098", Text = "Out of my way." },
				{ Cue = "/VO/Heracles_0099", Text = "Watch it!" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ChanceToPlay = 0.2,
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
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
					},
				},
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 14 },
				},

				{ Cue = "/VO/Heracles_0100", Text = "Ill-advised.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0101", Text = "I think not." },
				{ Cue = "/VO/Heracles_0102", Text = "Don't push it." },
				{ Cue = "/VO/Heracles_0103", Text = "No." },
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
		},

		ExitVoiceLines =
		{
			{
				Queue = "Always",
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.9,
				PreLineWait = 0.75,
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
				{ Cue = "/VO/Heracles_0137", Text = "We're done here." },
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

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Heracles )