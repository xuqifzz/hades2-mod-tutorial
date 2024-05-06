UnitSetData.NPC_Nemesis =
{
	-- Nemesis, Hub_Main Id = 557113
	NPC_Nemesis_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Nemesis_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.NemesisVoice,
		SpeakerName = "Nemesis",
		InvincibubbleScale = 1.2,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		ThemeMusic = "/Music/IrisMusicNemesisTheme_MC",
		TurnInPlaceAnimation = "Nemesis_Turn",
		DoorTakenText = "CannotUseObject",
		ExitSpeed = 500,
		HideHealthBar = true,
		Icon = "NemesisRewardFinderIcon",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetal",
			Rapid = "HitSparkEnemyDamagedMetal",
		},

		PreferredSpawnPoint = "EnemyPoint",

		ShopEventData = 
		{
			DelayMin = 8,
			DelayMax = 16,
			InstantChance = 0.1, -- Chance she will buy it without a chance for the player to interact
			NeverChance = 0.1, -- Chance she will dither indefinitely
			BrowsingVoiceLinesDelay = 4.0,
			FidgetIntervalMin = 5.0,
			FidgetIntervalMax = 11.0,
			ExitDelayMin = 3,
			ExitDelayMax = 4,
		},
		StoreExitFunctionName = "NemesisTeleportExitPresentation",
		PostTradeEvents =
		{
			{
				FunctionName = "NemesisPostTradeCheckExits",
				Threaded = true,
				Args =
				{
					Delay = 4.0,
				},
			},
		},

		GiftGameStateRequirements = 
		{
			-- on individual events instead
			{
				-- PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		PreBathAnimationName = "Nemesis_Hub_Salute",
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "NPC_Nemesis_01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				PlayOnceThisRun = true,
				-- RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_1712", Text = "Death to Chronos?" },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				ObjectType = "NPC_Nemesis_01",
				Cooldowns =
				{
					{ Name = "NemesisSaluteSpeech", Time = 30 },
				},

				{ Cue = "/VO/Nemesis_0292", Text = "Sure." },
				{ Cue = "/VO/Nemesis_0293", Text = "Hey.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0294", Text = "{#Emph}Ugh...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1712" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0295", Text = "Leave it to me...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0296", Text = "Here?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0297", Text = "Same.",
					PreLineAnim = "Nemesis_Hub_Salute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0298", Text = "Thanks.",
					PreLineAnim = "Nemesis_Hub_Salute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0299", Text = "Please.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0120", Text = "Whatever.", PlayFirst = true },
				{ Cue = "/VO/Nemesis_0123", Text = "Right." },
				{ Cue = "/VO/Nemesis_0180", Text = "Come on..." },
				{ Cue = "/VO/Nemesis_0198", Text = "Keep practicing." },
				{ Cue = "/VO/Nemesis_0199", Text = "Nice try." },
				{ Cue = "/VO/Nemesis_0164", Text = "Get lost." },
				{ Cue = "/VO/Nemesis_0122", Text = "Fine.",
					PreLineAnim = "Nemesis_Hub_Salute" },
				{ Cue = "/VO/Nemesis_0124", Text = "{#Emph}<Sigh>",
					PreLineAnim = "Nemesis_Hub_Salute" },
				{ Cue = "/VO/Nemesis_0125", Text = "{#Emph}Hrm.",
					PreLineAnim = "Nemesis_Hub_Salute" },
			},
		},

		ActivateRequirements =
		{
			-- None
		},

		SpawnVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.5,
				PlayOnce = true,
				PlayOnceContext = "NemesisFieldIntroVO",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent" },
					},
				},

				{ Cue = "/VO/MelinoeField_0037", Text = "What's she doing here?" },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.95,
				SuccessiveChanceToPlay = 0.25,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},

				{ Cue = "/VO/MelinoeField_0038", Text = "Her again?",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "NemesisGift02" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0039", Text = "Hi, Nem.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift05" },
						}
					}
				},
				{ Cue = "/VO/MelinoeField_0034", Text = "Nemesis..." },
				{ Cue = "/VO/MelinoeField_0035", Text = "Nemesis?" },
				{ Cue = "/VO/MelinoeField_0036", Text = "Nemesis!" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.5,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "GeneratedH_PassiveSmall", "GeneratedH_Passive" }, 
					},
				},

				{ Cue = "/VO/NemesisField_0232", Text = "Beware the evil eye.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0233", Text = "Just in time." },
				{ Cue = "/VO/NemesisField_0234", Text = "Gonna handle this." },
				{ Cue = "/VO/NemesisField_0235", Text = "How about a friendly wager." },
				{ Cue = "/VO/NemesisField_0236", Text = "Care for a little wager here?" },
				{ Cue = "/VO/NemesisField_0237", Text = "Bet I'll take more of them than you." },
				{ Cue = "/VO/NemesisField_0238", Text = "Stand back or else." },
				{ Cue = "/VO/NemesisField_0239", Text = "Think you'll take more than me?" },
				{ Cue = "/VO/NemesisField_0240", Text = "Just stay out of my way." },
				{ Cue = "/VO/NemesisField_0241", Text = "Still think you can beat me?" },
				{ Cue = "/VO/NemesisField_0242", Text = "Think you're better, prove it." },
				{ Cue = "/VO/NemesisField_0243", Text = "Beat me here, can have my Gold." },
				{ Cue = "/VO/NemesisField_0244", Text = "I slay more, I get your Gold." },
				{ Cue = "/VO/NemesisField_0245", Text = "Get set to fight, or get out the way." },
				{ Cue = "/VO/NemesisField_0246", Text = "Good, could use more Gold." },
				{ Cue = "/VO/NemesisField_0247", Text = "Had a feeling you'd show up." },
			},
		},

		EncounterStartVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
				},
				Cooldowns =
				{
					{ Name = "NemesisAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/NemesisField_0248", Text = "Heads up." },
				{ Cue = "/VO/NemesisField_0249", Text = "There they are." },
				{ Cue = "/VO/NemesisField_0250", Text = "Come on out..." },
				{ Cue = "/VO/NemesisField_0251", Text = "Here we go." },
				{ Cue = "/VO/NemesisField_0252", Text = "About damn time." },
				{ Cue = "/VO/NemesisField_0253", Text = "Watch this." },
				{ Cue = "/VO/NemesisField_0254", Text = "They're in for it." },
				{ Cue = "/VO/NemesisField_0255", Text = "Finally..." },
				{ Cue = "/VO/NemesisField_0256", Text = "Been waiting for this." },
				{ Cue = "/VO/NemesisField_0257", Text = "Let's get started.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0258", Text = "Let's see how quick you are." },
				{ Cue = "/VO/NemesisField_0259", Text = "They had this coming." },
				{ Cue = "/VO/NemesisField_0260", Text = "Come on in." },
				{ Cue = "/VO/NemesisField_0261", Text = "Here comes the reckoning." },
				{ Cue = "/VO/NemesisField_0262", Text = "I'll make them come around." },
				{ Cue = "/VO/NemesisField_0263", Text = "Make yourself useful." },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.65,

				{ Cue = "/VO/MelinoeField_0040", Text = "I see them.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/NemesisField_0248" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0041", Text = "Just fight.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/NemesisField_0253" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0042", Text = "So impatient...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "NemesisField_0252", "/VO/NemesisField_0255" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0043", Text = "Just watch.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/NemesisField_0258" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0044", Text = "One of us will.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/NemesisField_0262" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0045", Text = "Focus on yourself.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/NemesisField_0263" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0046", Text = "Then let's {#Emph}go!" },
				{ Cue = "/VO/MelinoeField_0047", Text = "Come on, then!" },
				{ Cue = "/VO/MelinoeField_0048", Text = "Race you." },
				{ Cue = "/VO/MelinoeField_0049", Text = "Let's see it, Nem!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
						},
						{
							PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/NemesisField_0158" }
						},
					},
				},
			}
		},

		InteractTextLineSets =
		{
			NemesisFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					-- @ update with additional requirements
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0002",
					-- PreLineAnim = "Nemesis_Hub_Salute",
					-- PreLineAnim = "Nemesis_Hub_Greet",
					-- PreLineAnim = "Nemesis_Hub_Glare_Start",
					-- PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Already hit a wall! Knocked your scrawny ass all the way back here. It's insane that she's sending you out on foot, all on your own." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_1540", Text = "Your skepticism's duly noted." },
					},
				},
			},

			NemesisAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesViewed", "WorldUpgradeQuestLog" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutMoros01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0034",
					Text = "They're not going to help you, you know. The Fates, I mean. They don't take pity on whoever asks. If anything, you'll make things even worse." },
				{ Cue = "/VO/Melinoe_1541", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Maybe you just don't give your sisters enough credit. If they once aided my brother, then there has to be a chance they'll aid us. They have a stake in this, too." },
				{ Cue = "/VO/Nemesis_0035",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "What, you mean their {#Emph}family? {#Prev}They couldn't care less. Too busy messing with everybody's lives, making it look like an accident." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1542", Text = "You mustn't speak of them that way." },
					},
				},
			},

			NemesisAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01"},
						Comparison = "<=",
						Value = 2,
					},
					MaxRunsSinceAnyTextLines = { TextLines = { "MorosSecondAppearance" }, Count = 3 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0036",
					Text = "Can't believe sucking up to the Fates actually worked. That big scroll over there... that's really from them?" },
				{ Cue = "/VO/Melinoe_1543", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Personally delivered by Lord Moros, no less. He seemed a little pressed for time, so we didn't get to talk much. Are the two of you close?" },
				{ Cue = "/VO/Nemesis_0037",
					Text = "We're children of Nyx; none of us are close. But we crossed paths. When certain mortals get what they deserve, it involves us both." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_1544", Text = "I can only imagine." },
					},
				},
			},
			NemesisAboutMoros02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithMoros01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = "<=",
						Value = 2,
					},
					AreIdsAlive = { 560612 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0038",
					Text = "Never thought I'd see Moros here of all places. But then again, it only makes sense Doom would come to the Crossroads sooner or later." },
				{ Cue = "/VO/Melinoe_1545", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You make it sound like it's a bad thing. All Nyx's kin are welcome here. Headmistress gave her word." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0039", Text = "Whatever. Guess I better go say hello..." },
					},
				},
			},

			NemesisAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisShopping01", "NemesisShopping02", "NemesisShopping03", "NemesisShopping04" },
					},
					AreIdsAlive = { 557743 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_2234", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Strictly business between you and Lord Charon, isn't it? Never seen you speak except about his wares. At least you're providing him with Gold." },
				{ Cue = "/VO/Nemesis_0133",
					Text = "You might technically have a brother, but you don't know what it's like having one around. Charon doesn't like to talk; I respect that." },
				{ Cue = "/VO/Melinoe_2235", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Truly? He never seems to mind speaking with me, in his way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 1.5,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0134", Text = "Maybe it's 'cause you're {#Emph}special." },
					},
				},
			},

			NemesisAboutChaos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "NemesisTakeExitRecord", "TrialUpgrade" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0258",
					Text = "So you've been chatting it up with Chaos, of all beings... trying to get the oldest force in the world to take sides? A fundamentally {#Emph}impartial {#Prev}force. Smart." },
				{ Cue = "/VO/Melinoe_3228", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sounds like you've been chatting it up yourself! I saw you plunge into a Chaos Gate, as though you knew exactly where it led. Not your first time?" },
				{ Cue = "/VO/Nemesis_0259",
					Text = "Not your business. Just don't go thinking Chaos is going to help {#Emph}you {#Prev}and no one else. Seeing as that wouldn't be fair." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3229", Text = "I suppose not." },
					},
				},
			},

			NemesisAboutQuestLog01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "QuestLog" },
					},
					RequiredMaxQuestsComplete = 8,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0042",
					Text = "Let me guess. The Fates have nothing but a bunch of busywork laid out for you. No grand revelations, just odd jobs." },
				{ Cue = "/VO/Melinoe_1546", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know better than to question their designs. A minor prophecy fulfilled may result in a greater one coming to pass." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0043", Text = "Just keep telling yourself that." },
					},
				},
			},

			NemesisAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0044",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "We're getting nowhere. I should be out there fighting! Not standing watch over a place nobody comes to uninvited. Damn it..." },
				{ Cue = "/VO/Melinoe_0679", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think the circumstances justify heightened security around here. But if you don't, go take it up with the Headmistress, not me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Nemesis_01",
						PreLineAnim = "Nemesis_Hub_Greet",
						{ Cue = "/VO/Nemesis_0045", Text = "{#Emph}Ugh..." },
					},
				},
			},
			NemesisAboutTask02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "F_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0048",
					Text = "You don't deserve this. Any of this. It's unfair. But you're stuck with it. So the only question is, what are you going to do about it now?" },
				{ Cue = "/VO/Melinoe_1548", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There's no such question in my mind. And what do you even know about fairness, or who deserves what?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						RequiredMinElapsedTime = 1.5,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0049", Text = "{#Emph}Hah! {#Prev}You almost had me going there." },
					},
				},
			},
			NemesisAboutTask03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0050",
					Text = "Don't worry, you didn't miss much while you were out. Lot of standing around, chanting prayers for your victory and protection. How'd those work out for you, by the way?" },
				{ Cue = "/VO/Melinoe_1549", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fine, thanks. And your own lack of support is a more significant motivator than you realize." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0051", Text = "You know all about lack of support..." },
					},
				},
			},
			NemesisAboutTask04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 15,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0081",
					Text = "How many attempts was that now? Good thing our Titan friend's too busy with your topside relatives to pay you much attention." },
				{ Cue = "/VO/Melinoe_1568", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sorry, not been keeping count. I'll get there when I get there. Though surely {#Emph}you {#Prev}would have vanquished the Titan Lord on your very first go?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0082", Text = "Guess we'll never know, will we?" },
					},
				},
			},

			NemesisAboutTraining01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0046",
					Text = "I always thought... if I could just train harder than you, she'd reconsider. And give the task to me. Worked my ass off. But it didn't matter." },
				{ Cue = "/VO/Melinoe_1547", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I worked, too. And Headmistress always made herself clear about our roles. You can't change your birthright, nor can I change mine." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0047", Text = "It isn't fair..." },
					},
				},
			},

			NemesisAboutWaiting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0077",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "The hell are you doing talking to me, you get your scrawny ass back out there and get that Titan! What are you waiting for?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1567", Text = "Rude!" },
					},
				},
			},

			NemesisAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0052",
					Text = "Another failed attempt. About ready to give in? You don't have the fire. This isn't personal enough for you." },
				{ Cue = "/VO/Melinoe_1550", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Isn't {#Emph}personal? {#Prev}You don't see my mother around, either, do you, Nem? Nor my father, nor my brother. Chronos took them all!" },
				{ Cue = "/VO/Nemesis_0053",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "I lost more than my mother, too. And I {#Emph}knew {#Prev}mine. What's yours to {#Emph}you? {#Prev}All you ever did was fall out of her womb." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_1551", Text = "Silence." },
					},
				},
			},
			NemesisAboutFamily02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutFamily01" },
					},
				},
				-- OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_0602", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What you said to me before, about my mother. That was very cruel." },
				{ Cue = "/VO/Nemesis_0054",
					Text = "{#Emph}Hm{#Prev}. Fair enough. Can't kill each other here, but we can use our words. If we were fighting for real I wouldn't have held back, either." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_0603", Text = "I figured not." },
					},
				},
			},

			NemesisAboutChronosBossL02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutChronosBossW01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0249",
					Text = "They're saying you got all the way to Tartarus before. How far'd you get? Make it all the way back to your {#Emph}rightful home?" },
				{ Cue = "/VO/Melinoe_3223", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you're referring to the House of Hades, then yes, I did make it there. Though you could best describe it as the House of {#Emph}Chronos {#Prev}at this point. He was waiting within, just as expected, and... was strong, just as expected, too." },
				{ Cue = "/VO/Nemesis_0250",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "{#Emph}Too {#Prev}strong, you mean. Well, can't fault you for trying. So what's the plan now, keep throwing yourself at him till you're totally demoralized? If that hasn't happened already?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3224", Text = "The task remains the same." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0251", Text = "Fair enough!" },
					},
				},
			},
			-- alt below with different requirements
			NemesisAboutChronosBossL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "NemesisAboutChronosBossW01", "NemesisAboutChronosBossL01_B" }
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0224",
					Text = "Can't believe you got to Chronos before me. Knew you stood no chance against him, but... didn't think you'd get there at all anytime soon." },
				{ Cue = "/VO/Melinoe_3098", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Is that supposed to be some sort of compliment? Or an apology, perhaps?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0225", Text = "No." },
					},
				},

			},
			-- alt if you didn't get to Chronos again
			NemesisAboutChronosBossL01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisAboutChronosBossL02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "NemesisAboutChronosBossW01", "NemesisAboutChronosBossL01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0224",
					Text = "Can't believe you got to Chronos before me. Knew you stood no chance against him, but... didn't think you'd get there at all anytime soon." },
				{ Cue = "/VO/Melinoe_3098", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Is that supposed to be some sort of compliment? Or an apology, perhaps?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0225", Text = "No." },
					},
				},

			},

			NemesisAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					-- @ update with additional requirements
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0226",
					Text = "Come here to gloat, I bet. {#Emph}I beat him! I beat the Titan! {#Prev}Well, hardly matters. He's still alive, you realize, don't you?" },
				{ Cue = "/VO/Melinoe_2965", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wasn't coming here to gloat, and yes, I realize. But this is still a step. If I could vanquish Chronos once, I can do it again. And one of these nights... he's not going to come back." },
				{ Cue = "/VO/Nemesis_0227",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Yeah. 'Cause one of these nights, I'll get my hands on him myself." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2966", Text = "Then you can do the gloating, right?" },
					},
				},

			},

			NemesisAboutChronosBossFights01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0252",
					Text = "Ought to admit it when I'm wrong. Never thought you'd get to Chronos in the first place, before I did anyway. Much less beat him down, repeatedly. So — I was wrong. Sorry." },
				{ Cue = "/VO/Melinoe_3225", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nemesis, I want you to know it was astonishing to hear those words coming from you just now. It seems we're each more than capable of surprising the other. But mainly... thank you." },
				{ Cue = "/VO/Nemesis_0253",
					PreLineAnim = "Nemesis_Hub_Salute",
					Text = "No need. Fair is fair. Had my chances to catch up with you, but couldn't get through all the pitfalls in the way. Might be I could have taken Chronos, too. But now I'm not so sure." },
				{ Cue = "/VO/Melinoe_3226", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Now don't lose heart! There's much left to be done, and we need all your strength and vigilance. We're the Unseen; together we prevail, or we fail." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0254", Text = "Couldn't resist giving one of your pep talks, huh." },
					},
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3227", Text = "...No." },
					},
				},

			},

			NemesisAboutChronosNightmare01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_1570", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Had one of my dreams, Nem. Your mother was there, and my father. He showed concern for her, she... was under the Titan's spell." },
				{ Cue = "/VO/Nemesis_0090",
					Text = "Mother Nyx made a mistake entrusting Hades with so much of the Underworld. This realm was never his by right, not till the Fates decided otherwise. Mother worked hard. They were probably just trying to send her help." },
				{ Cue = "/VO/Melinoe_0621", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're saying the Fates granted my father authority over the realm of the dead just to give Nyx a hand with all her responsibilities?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0091", Text = "That's right." },
					},
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0622", Text = "Huh." },
					},
				},
			},
			NemesisAboutChronosNightmare02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutChronosNightmare01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_0623", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nemesis, about the dream I had... Chronos, he... demanded that my father tell him where the Fates reside." },
				{ Cue = "/VO/Nemesis_0092",
					Text = "Smart. Mother Nyx never would have told him. The Fates may be my sisters but even I have no idea where they are. Long as they're hidden, no one can mess with their designs." },
				{ Cue = "/VO/Melinoe_1571", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You don't sound especially concerned that Chronos apparently found the three weavers of destiny and may be forcing their plans for the future." },
				{ Cue = "/VO/Nemesis_0093",
					Text = "{#Emph}Really? {#Prev}I ever give you the impression I had any hope this would end well?" },
				{ Cue = "/VO/Melinoe_1572", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How could he have found them? Wouldn't the Fates see the threat coming?" },
				{ Cue = "/VO/Nemesis_0094",
					Text = "They're always weaving. That means even they know only so much in advance. Chronos is Time. {#Emph}Time {#Prev}moves faster than expected." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- { Cue = "/VO/Melinoe_0626", Text = "No, but..." },
					},
				},
			},

			NemesisAboutWeapons01 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0086",
					Text = "Even Mother Nyx's weapons favor you. Always thought the Nocturnal Arms would wake for me first. Guess the Fates had other ideas." },
				{ Cue = "/VO/Melinoe_1569", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think the Fates had you covered. You're the bearer of Stygius! Vanquisher of heroes, gods, and Titans." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0087", Text = "Seems it was due for a long break." },
					},
				},
			},

			NemesisAboutGoldenAge01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift01", "NemesisAboutEvil01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_0613", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nem. You care so much for mortal justice. Where's your passion for ours? Chronos took {#Emph}everything {#Prev}from us! You said we all should get what we deserve, right?" },
				{ Cue = "/VO/Nemesis_0083",
					Text = "{#Emph}Khh. {#Prev}Well, that's the thing. If you knew anything about mortals, they had it better once. When Chronos ruled. Called it the {#Emph}Golden Age." },
				{ Cue = "/VO/Melinoe_2749", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How splendid that must have been for them! If only Chronos could have been so generous with his sons and foster-children. You think him being somewhat nice to some mortals makes up for what he did?" },
				{ Cue = "/VO/Nemesis_0084",
					Text = "No. Look. What if... what if this {#Emph}is {#Prev}what we deserve?" },
				{ Cue = "/VO/Melinoe_0615", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We deserve better than this, Nemesis. Living in shadows. Denied our families. Don't you want justice for {#Emph}them?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0085", Text = "{#Emph}Hah." },
					},
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Fine.
						{ Cue = "/VO/Melinoe_0616", Text = "Fine." },
					},
				},
			},

			NemesisAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutSurface01_B" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "N_Hub" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_1561", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					-- PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...How long has it been since you've visited the surface?" },
				{ Cue = "/VO/Nemesis_0070",
					Text = "Too long. Cooped up here now in case you hadn't noticed. But, it's a lost cause anyway. Why do you ask?" },
				{ Cue = "/VO/Melinoe_1562", UsePlayerSource = true,
					-- PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes requested that I pay a visit when I can. Wanted to know what to expect." },
				{ Cue = "/VO/Nemesis_0071",
					Text = "It's like I said. The dead are out and about up there thanks to our Titan friend. You'll feel right at home." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_1563", Text = "Sounds great." },
					},
				},
			},
			NemesisAboutSurface01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutSurface01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "N_Hub" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Boss01" },
						Comparison = "<=",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_1561", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					-- PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...How long has it been since you've visited the surface?" },
				{ Cue = "/VO/Nemesis_0070",
					Text = "Too long. Cooped up here now in case you hadn't noticed. But, it's a lost cause anyway. Why do you ask?" },
				{ Cue = "/VO/Melinoe_3211", UsePlayerSource = true,
					-- PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes requested that I pay a visit when I can. Figured I should ask if you had any notes." },
				{ Cue = "/VO/Nemesis_0071",
					Text = "It's like I said. The dead are out and about up there thanks to our Titan friend. You'll feel right at home." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_1563", Text = "Sounds great." },
					},
				},
			},

			NemesisAboutSurface02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutSurface03" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0166",
					Text = "You really went up there. They could have called for somebody with experience, but I guess I don't deserve it as much as I thought." },
				{ Cue = "/VO/Melinoe_1575", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm needed there as part of my task. Though, they must miss you on the surface. So much suffering..." },
				{ Cue = "/VO/Nemesis_0167",
					Text = "Justice doesn't matter anymore. The mortals had it coming. Maybe we all did." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1576", Text = "Don't say that..." },
					},
				},
			},
			NemesisAboutSurface03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0168",
					Text = "You keep heading up when you ought to be heading down, toward your objective. Forget about the mountain. Not your fight." },
				{ Cue = "/VO/Melinoe_0618", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My family on Olympus is under assault by the legions of Chronos, and it's not my fight?" },
				{ Cue = "/VO/Nemesis_0169",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "No. He's down below, all comfy on your father's throne. And you don't have anything to worry about besides him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Sure I don't.
						{ Cue = "/VO/Melinoe_0619", Text = "Sure I don't." },
					},
				},
			},

			NemesisAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Eris_01" },
						Comparison = "<=",
						Value = 10,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					AreIdsAlive = { 585573 }
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0228",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Eris is back. What did you do? Did you summon her? I saw you talking." },
				{ Cue = "/VO/Melinoe_3099", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're not remotely pleased to see your sister again? I don't have any more control over her than you do. Headmistress still is giving her the silent treatment, though." },
				{ Cue = "/VO/Nemesis_0229",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Ideally, Eris should be somewhere very far from here. Good thing this place is impossible to find, otherwise I'd half expect she would have led Chronos straight to us by now." },
				{ Cue = "/VO/Melinoe_3100", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You truly think a daughter of Nyx would betray us? I know Eris is a different sort, but still." },
				{ Cue = "/VO/Nemesis_0230",
					Text = "Your father is a son of Chronos. How'd {#Emph}they {#Prev}get on?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3101", Text = "...That's fair." },
					},
				},
			},

			NemesisAboutErisFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3102", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris stands against us. Just as I neared my destination on the surface, she was there. Let the Adamant Rail do much of the talking." },
				{ Cue = "/VO/Nemesis_0231",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Imagine my surprise. So what to do? Can't kick her out, since {#Emph}all children of Nyx are welcome here{#Prev}, whosever bright idea that was. Maybe give her some {#Emph}more {#Prev}second chances?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.43,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3103", Text = "You've made your point." },
					},
				},
			},
			NemesisAboutErisFight02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3220", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Isn't there something you can do to talk some sense into Eris? Get her out of my blasted way to Olympus. Or failing that, pin her in an arm bar or leg lock, perhaps?" },
				{ Cue = "/VO/Nemesis_0247",
					Text = "Won't waste my time with her at all, though the arm bar or leg lock do have a certain appeal. Not seen her flying through the Underworld lately, have you." },
				{ Cue = "/VO/Melinoe_3221", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not other than these Crossroads. Though what's your point, that I should stay out of her way as well as focus solely on Chronos below? It's not so simple for me anymore." },
				{ Cue = "/VO/Nemesis_0248",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Didn't say it was. But if you don't want to deal with {#Emph}Eris{#Prev}, you could always stick to your main objective. Or just leave it to {#Emph}me{#Prev}, like you should have in the first place." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3222", Text = "Duly noted." },
					},
				},
			},

			NemesisAboutErisFightW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Eris" },
					},
					AreIdsAlive = { 585573 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0244",
					Text = "Showed Eris didn't you. Could hear her crying practically from here. Been far too long since last I kicked her ass myself. At least {#Emph}somebody{#Prev}'s picked up the slack." },
				{ Cue = "/VO/Melinoe_3218", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps all of those savage fights between you two contributed to her disagreeable nature. Or yours, for that matter. Unless you're certain neither one of you has changed a bit, in which case, what was all the fighting even for?" },
				{ Cue = "/VO/Nemesis_0245",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "You've met her. She always liked picking fights. And you've met {#Emph}me. {#Prev}I've never liked backing down from them. As for you, go learn to take a compliment next time." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3219", Text = "...I must have missed it." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0246", Text = "Sure did." },
					},
				},
			},

			NemesisAboutHecate01 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisWithHecate01" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Melinoe_1552", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So, just how much trouble are you in for mouthing off to Headmistress, Nem? That was utterly disrespectful, even for you." },
				{ Cue = "/VO/Nemesis_0057",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "{#Emph}Heh! {#Prev}Well, looks like I've got a lot more guard duty ahead of me. But it was worth it. Help balance out you sucking up to her all the time." },
				{ Cue = "/VO/Melinoe_1553", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It figures you have no ability to distinguish between basic courtesy, and what you call sucking up." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0058", Text = "You're just a tool to her, you know." },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisAboutHecate02 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutHecate01" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Melinoe_1554", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Was it always like this, between you and Headmistress? I used to think it was {#Emph}me {#Prev}you hated most of all." },
				{ Cue = "/VO/Nemesis_0059",
					Text = "You've always been naive, Princess. As for Hecate, I liked her better before she decided this right here was the best use of my talents." },
				{ Cue = "/VO/Melinoe_1555", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She made that decision long ago. So you're going to resent her forever? Or are you going to do something about it?" },
				{ Cue = "/VO/Nemesis_0060",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "I {#Emph}am {#Prev}doing something about it! I'm honoring my vow to Mother Nyx. Else I'd be long gone, much to your disappointment, I'm sure." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1556", Text = "I would be very disappointed, yes." },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisAboutLosingToHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "F_PostBoss01" },
					},
					{
						PathFalse = { "CurrentRun", "EnemyKills", "Hecate" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0061",
					Text = "Wondered why Hecate took off all of a sudden. Was just to get in your way! Send you crying home. Guess she doesn't want you to succeed." },
				{ Cue = "/VO/Melinoe_1557", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She expects me to be prepared for whatever lies ahead." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0062", Text = "You're such a pushover sometimes." },
					},
				},
			},
			NemesisAboutDefeatingHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Hecate" },
					},
					{
						Path = { "GameState", "RoomsEntered", "F_PostBoss01" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "H" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0063",
					Text = "You passed her little test that time. Must have felt so good beating her ass to the ground. Don't get to spar with her, so I can only imagine." },
				{ Cue = "/VO/Melinoe_1558", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're not just sparring. You don't know our craft." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0064", Text = "I know I could take her..." },
					},
				},
			},

			NemesisAboutOdysseus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutNemesis01", "OdysseusAboutNemesis02" },
					},
				},
				{ Cue = "/VO/Nemesis_0137",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Next time you got something to say about me, you come say it to my face. Know you witches would much rather sneak around, though." },
				{ Cue = "/VO/Melinoe_2236", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What are you even talking about? I think you're being accusatory and abrasive. There! I said {#Emph}that {#Prev}to your face." },
				{ Cue = "/VO/Nemesis_0138",
					Text = "Odysseus tried giving me one of his talks. Telling me you didn't go complaining to him?" },
				{ Cue = "/VO/Melinoe_2237", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He was concerned with how we're getting on. You're not exactly being subtle, and he's quite perceptive in case you hadn't noticed." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						PreLineAnim = "Nemesis_Hub_Glare_End",
						{ Cue = "/VO/Nemesis_0139", Text = "Be. Quiet." },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},

			NemesisAboutArtemis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "NemesisCombatFirstIntro", "NemesisGetFreeItemIntro01" }, 
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_1559", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Ran into Artemis out there, at long last. Did she pass through and say hello at least?" },
				{ Cue = "/VO/Nemesis_0069",
					Text = "No, she didn't. So she's been skulking around in these woods? Thought she was busy rallying your aunts and uncles for you. Wait, you couldn't go the distance even with {#Emph}her {#Prev}help?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1560", Text = "It's not that simple...!" },
					},
				},
			},
			NemesisAboutArtemis02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisCombatFirstIntro", "NemesisGetFreeItemIntro01" }, 
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_2242", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you met Artemis out there? I suppose it may be worth repeatedly disobeying orders for the chance to see her." },
				{ Cue = "/VO/Nemesis_0143",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "What would you know of it. You really think I'm sneaking out into those woods just to fool around?" },
				{ Cue = "/VO/Melinoe_2243", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Is everything all right between the two of you, at least?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0144", Text = "It's fine." },
					},
				},
			},

			NemesisAboutHypnos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Hypnos_01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Hypnos_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Nemesis_0065",
					Text = "Been talking to Hypnos again? He can't hear you, you know. Kind of what happens when somebody's fast asleep." },
				{ Cue = "/VO/Melinoe_0686", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sleep is not as simple as you make it out to be. I think he can sense my words and intentions." },
				{ Cue = "/VO/Nemesis_0066",
					Text = "Sensing words and intentions, yeah... sounds exactly like the Hypnos I knew." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},

			NemesisAboutNarcissus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisWithNarcissus01_FollowUp" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_2238", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why all the rancor toward Narcissus, by the way? I see how he could be a little irritating, but he doesn't seem all that bad." },
				{ Cue = "/VO/Nemesis_0140",
					Text = "Should have seen what he did to this poor Nymph. Absolutely broke her heart. Didn't even notice, or care." },
				{ Cue = "/VO/Melinoe_2239", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Didn't take you for the sentimental type. I thought you concerned yourself with worse than lovers' quarrels." },
				{ Cue = "/VO/Nemesis_0141",
					Text = "Narcissus cared only for himself, not for anyone around him. Had to make an example of him. He wound up madly in love. With his own reflection. Till the day he died." },
				{ Cue = "/VO/Melinoe_2240", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So now he's a Shade in the Underworld. And still staring longingly into his own eyes." },
				{ Cue = "/VO/Nemesis_0142",
					Text = "Hey, you're the witch, not me. You know how it is with curses." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2241", Text = "They're easily misused." },
					},
				},
			},
			NemesisAboutNarcissus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusWithEcho01" },
					},
					{
						Path = { "CurrentRun", "UseRecord" },
						HasAny = { "NPC_Narcissus_01", "NPC_Echo_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3232", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, about Narcissus. I won't undo the curse you put on him, even if I could. He seems to be rather content, and besides... I can tell you truly believe he deserved it. Only problem is, that curse did nothing to aid Echo in her plight." },
				{ Cue = "/VO/Nemesis_0267",
					Text = "Echo... that was the Nymph who put Narcissus on my list of things to do. You're telling me getting divine retribution with no strings attached wasn't enough to put her mind at peace?" },
				{ Cue = "/VO/Melinoe_3233", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Correct. You evened the score between them, though you didn't set things right for either one. They had to set things right for themselves." },
				{ Cue = "/VO/Nemesis_0268",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "With your help and encouragement, I guess? {#Emph}Eh{#Prev}, same difference to me long as neither one ends up much better off. Sounds like you lectured both of them, so I'm sure it's close." },
				{ Cue = "/VO/Melinoe_3234", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So you don't care how they end up, as long as they're even." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0269", Text = "You're catching on." },
					},
				},
			},

			NemesisAboutCauldron01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = ">=",
						Value = 6,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0088",
					Text = "Been hunched over that cauldron so much, least your craft is finally doing something around here. So much toiling with no results..." },
				{ Cue = "/VO/Melinoe_0691", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Our craft is typically about the self, and such results tend not to be immediate. Though, I appreciate you noticing." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0089", Text = "Yeah, well..." },
					},
				},
			},
			NemesisAboutTrainingGrounds01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_3235", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why don't I ever see you in the training grounds anymore? You used to let all your aggression out over there, but now it's like you're saving it for {#Emph}me." },
				{ Cue = "/VO/Nemesis_0270",
					Text = "Don't flatter yourself. Saving it for {#Emph}Chronos. {#Prev}And the training grounds increasingly are custom-fit for {#Emph}you{#Prev}, in case you haven't noticed. From that Altar, to the weapons display." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3236", Text = "I'm the only one who uses it..." },
					},
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0271", Text = "Need my space." },
					},
				},
			},

			NemesisAboutEvil01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_1564", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nemesis, for all the time you used to spend on the surface... surely there was something there that made it worth your while?" },
				{ Cue = "/VO/Nemesis_0072",
					Text = "Oh, {#Emph}there was. {#Prev}Mortals like to reach beyond their means, thinking they're just like us. I'd sniff them out, and put them back in their place." },
				{ Cue = "/VO/Melinoe_1565", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Put them back in their place... by punishing them in some inventive fashion, I suppose?" },
				{ Cue = "/VO/Nemesis_0073",
					Text = "That's right. We all should get what we deserve, no more, no less." },
				{ Cue = "/VO/Melinoe_0608", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "But don't mortals already have ways to ensure justice is served, like my father did?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0074", Text = "{#Emph}Hah! {#Prev}Sure they do." },
					},
				},
			},
			NemesisAboutEvil02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_0680", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey. You miss being up there, don't you? Among the mortals and all that." },
				{ Cue = "/VO/Nemesis_0075",
					Text = "You know, mortals have a word for deliberate cruelty or callous negligence: They call it evil. I could always catch wind of it. I'd go to the source. And whoever it was, I'd make them pay." },
				{ Cue = "/VO/Melinoe_1566", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "But now you're stuck here, and the evil goes unchecked..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0076", Text = "A lot of it, I'm sure." },
					},
				},
			},

			NemesisAboutNectar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateGift01", "DoraGift01", "OdysseusGift01", "MorosGift01", "ErisGift01", "ErisGift01_B", "SkellyGift01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisGift05" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0078",
					Text = "That Nectar you've been passing around? Don't see why you bother. Not everybody deserves it, anyhow." },
				{ Cue = "/VO/Melinoe_0611", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "{#Emph}Deserves? {#Prev}And I suppose you think you're fit to be the judge of that?" },
				{ Cue = "/VO/Nemesis_0079",
					Text = "Yes. Who do you think I am? If everybody just magically got what they deserved, I'd have no reason to exist." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0612", Text = "That's awful..." },
					},
					{
						PreLineWait = 0.1,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0080", Text = "That's life." },
					},
				},
			},
			NemesisAboutNectar02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift04" },
					},
				},
				-- OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_1573", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I didn't mean to make you uncomfortable, with the Nectar from before. It's just, I've always looked up to you, and... I'm doing the best I can." },
				{ Cue = "/VO/Nemesis_0100",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Don't sweat it. Had myself a little drink the other day, and it didn't poison me as far as I know, so we're clear." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1574", Text = "Want any more?" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0101", Text = "Eh..." },
					},
				},
			},

			NemesisAboutFieldMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisCombatFirstIntro", "NemesisGetFreeItemIntro01" }, 
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0126",
					Text = "Back on your feet again there, Princess? All's well in the Crossroads, nothing to report." },
				{ Cue = "/VO/Melinoe_2229", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's fortunate we have you vigilantly keeping watch here, Nemesis...! Oh come on, drop the act. What happened, when did you return?" },
				{ Cue = "/VO/Nemesis_0127",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Don't know what you're talking about, and it's not your business anyway. Fates help you on your {#Emph}task." },
				{ Cue = "/VO/Melinoe_2230", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not quite as easy as you imagined, is it? To think that the embodiment of Retribution could be so arrogant." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0128", Text = "Shut up." },
					},
				},
			},
			NemesisAboutFieldMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutFieldMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_2231", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Does Headmistress know yet of your little excursions? Not much escapes her notice, last I checked." },
				{ Cue = "/VO/Nemesis_0129",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Strongly advise you mind your own responsibilities. Hecate doesn't control me, and {#Emph}you {#Prev}should show a little gratitude." },
				{ Cue = "/VO/Melinoe_2232", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For what, endangering us all? I didn't ask for your assistance, Nemesis." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0130", Text = "Because you're weak." },
					},
				},
			},
			NemesisAboutFieldMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutFieldMeeting02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll =
						{
							"NemesisBuyItemIntro01",
							"NemesisTakeDamageForItemIntro01",
							"NemesisGiveTraitForItemIntro01",
							"NemesisDamageContestIntro01",
						 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3230", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The first few times I saw you out there, I figured you were just venting your anger. But you keep heading out night after night. You're determined, but you're going to get caught." },
				{ Cue = "/VO/Nemesis_0260",
					Text = "Not if no one says anything. Besides, Hecate likely already knows. She isn't dense. Just letting me learn whatever she thinks I stand to learn the hard way. Works out for both of us." },
				{ Cue = "/VO/Melinoe_3231", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fine. We're both learning a lot I think. But I don't intend to let up on any of my responsibilities, just because you're trying to achieve what I've been tasked to do." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0261", Text = "Somebody's got to do it." },
					},
				},
			},

			NemesisAboutCombatFailure01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", }, 
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0131",
					Text = "Got careless. All because of a little wager. You want to show me up that bad?" },
				{ Cue = "/VO/Melinoe_2233", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I could ask you the same thing. What are you doing back already? You couldn't have gone much farther." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0132", Text = "Yeah. I got careless, too..." },
					},
				},
			},

			-- Partner Conversations
			OdysseusWithNemesis01 =
			{
				Partner = "NPC_Odysseus_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
			},

			NemesisWithHypnos01 =
			{
				Partner = "NPC_Hypnos_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},
				},

				PlayOnce = true,
				-- BlockDistanceTriggers = true,
				-- IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				-- GiftableOffSource = true,
				TeleportToId = 566612,
				TeleportOffsetX = 100,
				-- TeleportOffsetY = 100,
				AngleTowardTargetId = 370024,
				InteractDistance = 300,
				BlockDistanceTriggers = true,
				{ Cue = "/VO/Hypnos_0006", Portrait = "Portrait_Hypnos_Sleeping_01", Speaker = "NPC_Hypnos_01",
					-- Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Zzzzzzzzz{#Prev}...." },
				{ Cue = "/VO/Nemesis_0067",
					PreLineWait = 0.35,
					Text = "Look at him, all peaceful. Not a care in the world. Could you imagine?" },
				{ Cue = "/VO/Melinoe_0681", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's beautiful. He has this wisdom about him, even asleep. Nyx must have taught you all so much." },
				{ Cue = "/VO/Nemesis_0068",
					Text = "Not really. Hypnos served in the House of Hades under Mother's care. Ran into him now and then, though. He ever wakes up, hope I can be there when you finally meet." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0682", Text = "Thank you, Nem..." },
				},
			},
			NemesisWithHecate01 =
			{
				Partner = "NPC_Hecate_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
				},
				StatusAnimation = false,
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 556921,
				InteractDistance = 450,
				{ Cue = "/VO/Hecate_0205", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "You are required at your post, Nemesis. Or shall you take to openly defying me just as your sister does? I shudder to think what your mother would say of you two." },
				{ Cue = "/VO/Nemesis_0055",
					PreLineWait = 0.35,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "...You have no right to invoke my mother. None of this would be happening had you fulfilled your role as Handmaiden, and warned her an attack was imminent." },
				{ Cue = "/VO/Hecate_0206", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					Text = "Best watch your mouth or I shall seal it shut! You may continue dwelling on a past you were not witness to, or you may do what is expected of Nyx's daughters. Or whatever Eris is up to! Your choice." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Nemesis_01",
					{ Cue = "/VO/Nemesis_0056", Text = "{#Emph}<Sigh>", PreLineAnim = "Nemesis_Hub_Glare_End",
					},
				},
			},
			NemesisWithMoros01 =
			{
				PlayOnce = true,
				Partner = "NPC_Moros_01",
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
				},
				-- UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 560612,
				TeleportOffsetX = 130,
				TeleportOffsetY = 130,
				AngleTowardTargetId = 560612,
				InteractDistance = 250,
				{ Cue = "/VO/Nemesis_0040",
					Text = "...And there she is! Shouldn't you be halfway down to Tartarus by now?" },
				{ Cue = "/VO/Moros_0065", Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					Text = "Princess. Thank the Fates you're well. Nemesis and I, we were just catching up. She's told me a lot about you." },
				{ Cue = "/VO/Melinoe_0906", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, great. I can imagine! Though, you never told me about your brother, Nemesis..." },
				{ Cue = "/VO/Nemesis_0041",
					Text = "Got a lot of brothers. What's to tell? Never a good sign when he shows up." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0066", Text = "I'm afraid she's right." },
					},
				},
			},

			NemesisWithMoros02 =
			{
				PlayOnce = true,
				Partner = "NPC_Moros_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisWithMoros01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "NemesisWithMoros01" }, Count = 6 },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				TeleportToId = 560612,
				TeleportOffsetX = 130,
				TeleportOffsetY = 130,
				AngleTowardTargetId = 560612,
				InteractDistance = 450,

				{ Cue = "/VO/Nemesis_0232",
					Text = "...It's my job, Moros. Simple as that. No one else wants to do it. No one else {#Emph}can {#Prev}do it." },

				{ Cue = "/VO/Moros_0331", Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					PreLineAnim = "Moros_Perplexed_Start",
					PreLineAnimTarget = 560612,
					Text = "But the retribution you see fit to dole out... how can you be so certain that decisions about such consequences are yours alone? {#Emph}The Fates {#Prev}have quite a bit of say in it as well." },

				{ Cue = "/VO/Nemesis_0233",
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "What, you think I'm just another mindless puppet our sisters are pushing around? Come on! Their prophecies are vague because they don't really know what's coming." },

				{ Cue = "/VO/Moros_0332", Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					PreLineAnim = "Moros_Perplexed_End",
					PreLineAnimTarget = 560612,
					Text = "Even if that were true, the burden of choosing who deserves what... I wouldn't want to bear it on my own. Otherwise my judgment would have to be perfect at all times; yet we are fallible beings." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0234", Text = "Speak for yourself." },
					},
					{
						PreLineWait = 0.1,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0333", Text = "I was..." },
					},
				},
			},

			NemesisWithMorosAboutRelationships01 =
			{
				PlayOnce = true,
				Partner = "NPC_Moros_01",
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift06", "MorosGift06", "NemesisBathHouse02", "MorosBathHouse02" }
					},
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				TeleportToId = 560612,
				TeleportOffsetX = 130,
				TeleportOffsetY = 130,
				AngleTowardTargetId = 560612,
				InteractDistance = 350,

				{ Cue = "/VO/Moros_0334", Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					PreLineAnim = "Moros_Perplexed_Start",
					PreLineAnimTarget = 560612,
					Text = "Quite a predicament we find ourselves in, Sister. Certainly not one I could have anticipated when first I arrived. How odd... so what are we to do? It's not my wish to interfere." },

				{ Cue = "/VO/Nemesis_0235",
					Text = "Don't worry about that, worry about keeping your mouth shut when she's walking up on us. All casual like she doesn't know what's going on." },

				{ Cue = "/VO/Melinoe_3241", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, what {#Emph}is {#Prev}going on? What are you two talking about, if I may ask?" },

				{ Cue = "/VO/Nemesis_0236",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Talking about {#Emph}you{#Prev}, Princess, though it's nothing you need to worry your {#Emph}pretty little head {#Prev}about. You've got enough going on, and... we can sort this out ourselves. If you'll excuse us?" },

				{ Cue = "/VO/Moros_0335", Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					PreLineAnim = "Moros_Perplexed_End",
					PreLineAnimTarget = 560612,
					Text = "Wait. No, I would prefer to be forthright. Princess, the issue is we each developed certain feelings for you that, in some cases, can manifest as the kind of envy that Nemesis is committed to punishing. An outcome we are trying to avoid." },

				{ Cue = "/VO/Melinoe_3242", UsePlayerSource = true,
					-- Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh! {#Prev}I... I see. Thank you for letting me know. I would never want to hurt either of you. Well maybe {#Emph}you{#Prev}, Nemesis, but only when we spar. How do we resolve this? Our feelings mustn't get in our way." },

				{ Cue = "/VO/Nemesis_0237",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "They won't get in our way. And besides, you're busy, not like you were going to devote yourself to one of us, body and soul. Like some mortal that doesn't know any better." },

				{ Cue = "/VO/Melinoe_3243", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Certainly not... why should I or any of us have to choose? We're gods. If you wish to know me better, wonderful. But please accept that I won't let myself be bound to anyone, nor would I expect any different from you. Are we clear?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.43,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0238", Text = "...Yeah." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0336", Text = "Yes, we are." },
					},
				},

			},

			NemesisWithEris01 =
			{
				Partner = "NPC_Eris_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				GameStateRequirements =
				{
					{
					},
				},
				-- BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 590426,
				AngleTowardTargetId = 585573,
				InteractDistance = 450,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Nemesis_0239",
					PreLineWait = 0.35,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "...No, one last thing, Eris. The Headmistress might have promised Mother she'd look after you, but I did no such thing. So get out of here before I get upset." },
				{ Cue = "/VO/Eris_0108", Portrait = "Portrait_Eris_Default_01", Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineAnimTarget = 585573,
					Text = "Oh please, Nemmie, you're already upset! And I'll come and go as I like, thanks. So damn boring here I can't stand it for long anyways." },
				{ Cue = "/VO/Nemesis_0240",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "{#Emph}Come and go as you like? {#Prev}You're jeopardizing the task. Don't be such a child." },
				{ Cue = "/VO/Eris_0109", Portrait = "Portrait_Eris_Default_01", Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Greet",
					PreLineAnimTarget = 585573, 
					Text = "{#Emph}Don't be such a child. {#Prev}Waitwaitwait... does that make you my {#Emph}mom? {#Prev}I never answered to Nyx. Think I'm about to start with {#Emph}you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0241", Text = "You'll get what's coming to you either way." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Eris_01",
						PreLineAnim = "Enemy_Eris_Hub_Flattered",
						PreLineAnimTarget = 585573,
						{ Cue = "/VO/Eris_0110", Text = "{#Emph}Ooh! {#Prev}A threat!" },
					},
				},
			},
			NemesisWithEris02 =
			{
				Partner = "NPC_Eris_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = false,

				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisWithEris01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "NemesisWithEris01" }, Count = 5 },
				},
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 590426,
				AngleTowardTargetId = 585573,
				InteractDistance = 450,

				{ Cue = "/VO/Eris_0111", Portrait = "Portrait_Eris_Default_01", Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineAnimTarget = 585573,
					PreLineWait = 0.35,
					Text = "{#Emph}...Yeah? {#Prev}And just what do you think you're gonna do about it, there, Nemmie? Can't just have it out with me in the middle of your little {#Emph}Crossroads." },
				{ Cue = "/VO/Nemesis_0242",
					PreLineWait = 0.35,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Can't do anything about it {#Emph}here. {#Prev}But might run into you out there, snooping around. And then you won't get any special treatment. Just another target." },
				{ Cue = "/VO/Eris_0112", Portrait = "Portrait_Eris_Default_01",
					Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Greet",
					PreLineAnimTarget = 585573, 
					Text = "{#Emph}Heh! {#Prev}Nemesis, how could you be so cruel? You're my {#Emph}sister! {#Prev}We don't have to {#Emph}fight! {#Prev}And besides, what makes you think you'd ever {#Emph}catch {#Prev}me? You're too {#Emph}slow." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						PreLineAnim = "Nemesis_Hub_Glare_End",
						{ Cue = "/VO/Nemesis_0243", Text = "We'll see." },
					},
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Eris_01",
						PreLineAnim = "Enemy_Eris_Hub_Flattered",
						PreLineAnimTarget = 585573,
						{ Cue = "/VO/Eris_0113", Text = "{#Emph}You'll {#Prev}see." },
					},
				},
			},


			-- Repeatable
			NemesisChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0003",
					Text = "Mortals must be thinking they can get away with anything lately..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0006",
					Text = "Awful busy standing guard as you can see." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat03 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0004",
					Text = "So much evil happening out there, unchecked..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat04 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0010",
					Text = "Go on. That task of yours isn't going to complete itself." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat05 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0005",
					Text = "Could've been topside right now, bringing down what's rightfully deserved..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat06 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0007",
					Text = "Not going anywhere, so go on and do your {#Emph}task." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat07 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0008",
					Text = "We all get what we deserve. No more, no less." },
			},
			NemesisChat08 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0009",
					Text = "Missed all the excitement while you were out." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat09 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0012",
					Text = "Go knock yourself out. I'll be right here." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat10 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0013",
					Text = "Excuse me, I'm on duty still, as you can see." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat11 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0014",
					Text = "{#Emph}Ungh, {#Prev}what did I ever do to deserve this..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat12 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0015",
					Text = "Back on the beat again already there, Princess?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0016",
					Text = "Go crack some skulls for me, they have it coming." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat14 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0017",
					Text = "Can only imagine what you've been up to out there." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat15 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0018",
					Text = "Counting on you not to get too greedy out there." },
			},
			NemesisChat16 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0019",
					Text = "Better get your scrawny ass back out there huh?" },
			},
			NemesisChat17 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					AreIdsAlive = { 556921 },
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0020",
					Text = "Go cry to the Headmistress. She's right there." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0021",
					Text = "The ways of the Witch of the Crossroads can only take you so far." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat19 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0022",
					Text = "Sooner or later, everything always comes full circle, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat20 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "O_Boss01" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0023",
					Text = "You were topside for a while there, huh..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat21 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomCountCache" },
						HasAny = { "H_Intro", "P_Intro" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0024",
					Text = "Gone so long that time, figured you lost your way." },
			},
			NemesisChat22 =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomCountCache" },
						HasAny = { "G_Intro", "O_Intro" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0025",
					Text = "All the way back, just to lick your wounds and go again?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 30,
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0026",
					Text = "Thought for sure you would have given up by now." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat24 =
			{
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0027",
					Text = "All's quiet in the Crossroads, for the thousandth time..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat25 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0028",
					Text = "Just going to keep putting yourself through this, huh." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat26 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0029",
					Text = "Got the pointless guard duty well under control." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat27 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0030",
					Text = "Go on, you've got more important things to do than talk to me." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat28 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0031",
					Text = "Want to take over for me, go right ahead." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat29 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0032",
					Text = "Find Chronos, kill Chronos. Go." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat30 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0033",
					Text = "Death to Chronos, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
			NemesisChat31 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0011",
					Text = "Ready to give up, tell Hecate I'm still available." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
			},
		},

		GiftTextLineSets =
		{
			NemesisGiftDecline01 =
			{
				PlayOnce = true,
				Cost =
				{
					GiftPoints = 1,
				},
				SkipGiftPresentationPost = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/MelinoeField_0022", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Here, Nemesis! To your willful disobedience. May those instincts of yours never lead you astray." },
				{ Cue = "/VO/NemesisField_0024",
					PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "Really think this is the perfect time for us to just kick back and have a few laughs over a nice bottle? Like I got nothing better to do right now." },
			},

			NemesisGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				HintId = "Codex_NemesisGiftHint01",
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Melinoe_0685", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nemesis? Maybe we could start again. Here, I got you something..." },
				{ Cue = "/VO/Nemesis_0095",
					PostLineAnim = "Nemesis_Hub_Toss",
					Text = "Don't need your charity, Princess, or temptations while I'm on duty or off. You're doing this because you want something from me anyway, so here! Knock yourself out." },
			},
			NemesisGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				SkipGiftPresentationPost = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0096",
					Text = "You trying to get me in trouble with the Headmistress or something? Why don't you take your bottle before I smash it, and get your scrawny ass out of here." },
				{ Cue = "/VO/Melinoe_0627", UsePlayerSource = true,
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "I wasn't trying to get you in trouble, Nem, I was just... {#Emph}ungh{#Prev}. You know what, forget it." },
			},
			NemesisGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift02" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0097",
					Text = "Oh, for me? Can't find another way to test one of your poisons, I guess. You witches aren't as subtle as you think." },
				{ Cue = "/VO/Melinoe_0628", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's exactly what someone who was unknowingly poisoned by a witch might say, you know." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						{ Cue = "/VO/Nemesis_0163", Text = "{#Emph}Ugh." },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
			},
			NemesisGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0145",
					Text = "Oh no, not this again. Look, I forgave you for last time. Didn't mean it as an invitation to get me more of this stuff. Don't like owing anybody any favors." },
				{ Cue = "/VO/Melinoe_2097", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Just take it and enjoy it, Nem. Besides, I heard you were looking for some more of our witches' poison. Nobody seems to appreciate it quite like you." },
			},
			NemesisGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift04" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0098",
					Text = "Why do you keep doing this? You won, OK? You beat me. Before you even started. Last thing I need now is your sympathy." },
				{ Cue = "/VO/Melinoe_0629", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nemesis... I don't know what I'm supposed to do. We're surrounded by enemies out there. Do we really need more?" },
				{ Cue = "/VO/Nemesis_0099",
					PreLineWait = 0.35,
					Text = "...You're not my enemy, Melinoë. I just... Just go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						{ Cue = "/VO/Melinoe_2250", Text = "Bye, Nem..." },
					},
				},
			},
			-- taverna
			NemesisTaverna01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				HintId = "Codex_TavernaGiftHint",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift05" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				{ Cue = "/VO/Melinoe_3354", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, I know there's an extraordinary likelihood you're going to say {#Emph}no{#Prev}, but... I've an extra-special poison bottle here, and thought maybe we could split it at the taverna, you and I?" },

				{ Cue = "/VO/Nemesis_0146",
					-- PreLineAnim = "Moros_Greet",
					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					Text = "So damn polite! Well, it's less excessive if we split the bottle, I guess... {#Emph}ungh{#Prev}, you know what? Whatever, sure." },

				{ Cue = "/VO/Nemesis_0147",
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					Text = "...Come on, say it: Got your ass kicked. By me. Think that was when I first thought I had a chance. That Hecate would pick me. If I could take you just like that a few more times." },

				{ Cue = "/VO/Melinoe_2099", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're a monster, Nem! I practically started to fear having to spar with you. But, the best way to get stronger is to train against a stronger opponent." },

				{ Cue = "/VO/Nemesis_0148",
					Text = "Maybe that's why I've been stagnating. We don't get to fight like we used to. Makes me sick even thinking about it." },

				{ Cue = "/VO/Melinoe_2100", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait... you stand around thinking about how we used to spar? Should I be flattered or afraid?" },

				{ Cue = "/VO/Nemesis_0149",
					Text = "Finish your half of the damn poison already! Don't have all night to sit around and stroke your ego. I swear, mortals take after our worst qualities." },

				{ Cue = "/VO/Melinoe_2101", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wasn't being serious. Though, maybe I'm more self-centered than I realize. I {#Emph}am {#Prev}part-mortal on my mother's side..." },

				{ Cue = "/VO/Nemesis_0150",

					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "Makes you different, I will give you that. Now come on, I got to get back. Else Hecate might catch us making nice and then neither one of us will hear the end of it." },

				{ Cue = "/VO/Nemesis_0151",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					Text = "...Can feel the poison starting to kick in. You'd better get your ass out of here before I keel over." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2102", Text = "It'll be our secret." },
					},
				},

			},

			NemesisBathHouse01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_NemesisHotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_3104", UsePlayerSource = true,
					Text = "Nemesis, we've been going on like this a while, and I wondered if you'd be up to take a break. Over at the Springs." },
				{ Cue = "/VO/Nemesis_0203",
					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "{#Emph}Hm. {#Prev}Come to think, could really use a bath. {#Emph}You{#Prev}, I mean. But I could too, I guess, so... why not." }, 

				{ Cue = "/VO/Melinoe_3105", 
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "How long has it been since you last took off the armor?" },

				{ Cue = "/VO/Nemesis_0213", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "A while. Not been much incentive. You saw how much of a pain it is to undo the lacing, and the straps. Feels strange without, like I'm... I... I don't know."
				},

				{ Cue = "/VO/Melinoe_3106", UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "...Unburdened? Or more comfortable at least?" },

				{ Cue = "/VO/Nemesis_0214", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "{#Emph}Heh. {#Prev}Good letting off some steam sometimes, I guess. But there's a fine line between rest and complacency." },

				{ Cue = "/VO/Melinoe_3107", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I don't know that we're at risk of becoming complacent here, Nem." },

				{ Cue = "/VO/Nemesis_0215", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "The risk is greater than you think. We're lounging in a bath while who-knows-what is going on out there..." },

				{ Cue = "/VO/Melinoe_3108", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "We're not lounging. We'll be better equipped to deal with the who-knows-what out there if our muscles aren't all knotted up." },

				{ Cue = "/VO/Nemesis_0217",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "All right, got to get back to work. Though, this suit does feel a little lighter now..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3109", Text = "Take care, Nem." },
					},
				},

			},
			NemesisBathHouse02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_NemesisHotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift05" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Intro" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_3110", UsePlayerSource = true,
					Text = "Hey Nem, are you available to make another visit to the springs? Take a load off, come back to our senses a bit..." },
				{ Cue = "/VO/Nemesis_0204",
					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "{#Emph}Eh. {#Prev}Shoulder's been acting up again, could be it helps with that. Don't like having to take the suit off, but that's the trade." }, 

				{ Cue = "/VO/Nemesis_0218",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "First time you beat me in a fight? {#Emph}Sparring match{#Prev}, whatever. Got me right in the back of the neck. Took advantage of our height difference. Was a surprise."
				},

				{ Cue = "/VO/Melinoe_3111", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I'd lost to you so often, at some point I figured I could lull you into overconfidence. That even you could be susceptible to such a thing." },

				{ Cue = "/VO/Nemesis_0219", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "You weren't wrong. Made me so {#Emph}angry. {#Prev}Swore I'd never underestimate my opponent again. Then proceeded to convince myself you'd never beat me at the task. {#Emph}Our {#Prev}task."
				},

				{ Cue = "/VO/Melinoe_3112", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "So you've a bit of pride. You're not trying to stamp it out completely, right? Just keep it in check. Besides, I'd like to think we're not at odds in what we're trying to achieve." },

				{ Cue = "/VO/Nemesis_0220", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "We're not. But I can only push myself so hard. Seeing you getting stronger, getting closer... gives me the extra push I need." },

				{ Cue = "/VO/Melinoe_3113", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I'd no idea. I always thought I got my competitive spirit from {#Emph}you. {#Prev}Anyway... do let me know if you need anything else. Such as lending a hand putting on that suit of yours." },

				{ Cue = "/VO/Nemesis_0221", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "Or taking it off, yeah. Though, can't let myself become too used to this." },

				{ Cue = "/VO/Nemesis_0222",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "Well, enough sitting around. Time for some standing around to balance it out." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3115", Text = "Off we go, then." },
					},
				},	

			},

			-- placeholder
			NemesisGiftTemp =
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

			NemesisBathHouseDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- { Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},				
				{ Cue = "/VO/Melinoe_0683", UsePlayerSource = true,
					Text = "Hey, {#Emph}erm{#Prev}, I suspect I know the answer, though I don't suppose you want to pay a visit to the springs? Clear our heads?" },
				{ Cue = "/VO/Nemesis_0170",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "Oh, {#Emph}uh... {#Prev}Appreciate the invite, but I'm on guard duty right now, probably until Time claims us all. And this suit takes forever to get on or off..." },
			},

			NemesisFishingDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Melinoe_0684", UsePlayerSource = true,
					Text = "Say, would you accompany me to the riverbank a bit? Blow off some steam, or... maybe I could push you in or something?" },
				{ Cue = "/VO/Nemesis_0171",
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "Could be going after perpetrators of unspeakable evil across the surface, but you're asking me to go after some poor fish? Uh, no." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Maybe some other time.
						-- { Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},
			},

			NemesisFishing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithLuresIcon",
				FilledIcon = "FilledHeartWithLuresIcon",
				HintId = "Codex_FishingGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
					},
				},
				{ Cue = "/VO/Melinoe_3487", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I thought I saw some movement by the fishing pier. A thorough investigation is probably in order, right?" },
				{ Cue = "/VO/Nemesis_0172",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					Text = "Either that or rot here standing guard, right? Know what, fine, I'll bite. Doubt anything else will." },

				{ Cue = "/VO/Nemesis_0255",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					Text = "To have been born a fish. A life spent mucking about in the River of Lamentation, only to be plucked out by {#Emph}you. {#Prev}What did they do to deserve this?" },
				{ Cue = "/VO/Melinoe_3237", UsePlayerSource = true,
					SkipContextArt = true,
					Text = "Shouldn't you be the one to know the answer to that? Perhaps it's the will of the Fates that determines how we're born. Then you ensure we get our dues based on the choices that we make." },
				{ Cue = "/VO/Nemesis_0256",
					SkipContextArt = true,
					Text = "Be a lot easier if everyone was born on equal footing. But no one in my family thinks life's meant to be fair, other than me." },
				{ Cue = "/VO/Melinoe_3238", UsePlayerSource = true,
					SkipContextArt = true,
					Text = "How can life possibly be fair, knowing there are creatures of all sorts, such as those dwelling in these waters?" },
				{ Cue = "/VO/Nemesis_0257",
					SkipContextArt = true,
					Text = "We'd have to put a bit more structure into who decides how mortals are born. Or how their souls come back to life. Topic for a different time. Think I saw a bit of movement over there.",
					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Nemesis_0202",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash" },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "Gave them a fair shot, didn't we. Real battle of wits back there." },
				EndWait = 0.5,
				EndVoiceLines =
				{
					--
				},

			},

		},

		MissingDistanceTrigger =
		{
			WithinDistance = 300,
			VoiceLines =
			{
				GameStateRequirements =
				{
					{
						Path = { "PreviousDeathAreaRoom", "Name" },
						IsNone = { "Hub_PreRun" },
					},
					-- checking for Odysseus as well
					-- AreIdsNotAlive = { 557112 },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					PlayOnceFromTableThisRun = true,
					GameStateRequirements =
					{
						AreIdsNotAlive = { 557113 },
					},

					{ Cue = "/VO/Melinoe_2308", Text = "Nemesis must have a head start...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
							}
						},
					},
					{ Cue = "/VO/Melinoe_2309", Text = "Nem's still out there I guess...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAll = { "NemesisCombatFirstIntro", "NemesisGift03" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_1152", Text = "Nemesis on break I guess..." },
					{ Cue = "/VO/Melinoe_1153", Text = "Where'd Nemesis go?", PlayFirst = true },
				},
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_0682", Text = "Thank you, Nem..." },
		},

		PlayerInjuredVoiceLineThreshold = 0.66,
		PlayerInjuredReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				MaxDistanceFromHero = 3000,
			},
			Cooldowns =
			{
				{ Name = "NemesisAnyQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/NemesisField_0308", Text = "What's the matter?" },
			{ Cue = "/VO/NemesisField_0309", Text = "Must have hurt." },
			{ Cue = "/VO/NemesisField_0310", Text = "You had it coming." },
			{ Cue = "/VO/NemesisField_0311", Text = "Too slow." },
			{ Cue = "/VO/NemesisField_0312", Text = "Oh come on." },
			{ Cue = "/VO/NemesisField_0313", Text = "Wake up." },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				MaxDistanceFromHero = 3000,
			},
			Cooldowns =
			{
				{ Name = "NemesisLastStandSpeech", Time = 40 },
			},
			TriggerCooldowns =
			{
				"NemesisAnyQuipSpeech",
			},

			{ Cue = "/VO/NemesisField_0314", Text = "Still going?" },
			{ Cue = "/VO/NemesisField_0315", Text = "Made you mad." },
			{ Cue = "/VO/NemesisField_0316", Text = "Tougher than you look." },
			{ Cue = "/VO/NemesisField_0317", Text = "Give up." },
			{ Cue = "/VO/NemesisField_0318", Text = "Not bad..." },
			{ Cue = "/VO/NemesisField_0319", Text = "Come on, fight!" },
		},

		KillingEnemyVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.45,
			SuccessiveChanceToPlay = 0.2,
			Cooldowns =
			{
				{ Name = "NemesisFoeSlainSpeech", Time = 30 },
				{ Name = "NemesisAnyQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/NemesisField_0264", Text = "Stygius take you." },
			{ Cue = "/VO/NemesisField_0265", Text = "Souls for Stygius." },
			{ Cue = "/VO/NemesisField_0266", Text = "Comeuppance." },
			{ Cue = "/VO/NemesisField_0267", Text = "Deliverance." },
			{ Cue = "/VO/NemesisField_0268", Text = "Retribution." },
			{ Cue = "/VO/NemesisField_0269", Text = "That's what you get." },
			{ Cue = "/VO/NemesisField_0270", Text = "There you go." },
			{ Cue = "/VO/NemesisField_0271", Text = "What did you expect?" },
			{ Cue = "/VO/NemesisField_0272", Text = "That's for you." },
			{ Cue = "/VO/NemesisField_0273", Text = "There." },
			{ Cue = "/VO/NemesisField_0274", Text = "Got you." },
			{ Cue = "/VO/NemesisField_0275", Text = "Mine." },
			{ Cue = "/VO/NemesisField_0276", Text = "Destroyed." },
			{ Cue = "/VO/NemesisField_0277", Text = "Easy." },
			{ Cue = "/VO/NemesisField_0278", Text = "Weak." },
			{ Cue = "/VO/NemesisField_0279", Text = "No." },
			{ Cue = "/VO/NemesisField_0280", Text = "Out." },
			{ Cue = "/VO/NemesisField_0281", Text = "Gone." },
			{ Cue = "/VO/NemesisField_0282", Text = "What else." },
			{ Cue = "/VO/NemesisField_0283", Text = "Remember that." },
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
				{ Name = "NemesisAnyQuipSpeech", Time = 8 },
			},

			{ Cue = "/VO/NemesisField_0290", Text = "Back off." },
			{ Cue = "/VO/NemesisField_0291", Text = "Out of my way." },
			{ Cue = "/VO/NemesisField_0292", Text = "Show off." },
			{ Cue = "/VO/NemesisField_0293", Text = "Come on..." },
			{ Cue = "/VO/NemesisField_0294", Text = "Damn it." },
			{ Cue = "/VO/NemesisField_0295", Text = "Get your own." },
		},
		EncounterEndVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 1.25,

			{ Cue = "/VO/NemesisField_0336", Text = "That settles it." },
			{ Cue = "/VO/NemesisField_0337", Text = "It's settled." },
			{ Cue = "/VO/NemesisField_0338", Text = "All right." },
			{ Cue = "/VO/NemesisField_0339", Text = "All clear." },
			{ Cue = "/VO/NemesisField_0340", Text = "We're clear." },
			{ Cue = "/VO/NemesisField_0341", Text = "Anyone else?" },
			{ Cue = "/VO/NemesisField_0342", Text = "That's that." },
			{ Cue = "/VO/NemesisField_0343", Text = "There we go..." },
			{ Cue = "/VO/NemesisField_0344", Text = "Simple." },
			{ Cue = "/VO/NemesisField_0345", Text = "Easy." },
			{ Cue = "/VO/NemesisField_0346", Text = "Got what they deserved." },
			{ Cue = "/VO/NemesisField_0347", Text = "Still here?" },
		},

		EncounterWonVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,

			{ Cue = "/VO/NemesisField_0348", Text = "Can't believe I lost...", PlayFirst = true },
			{ Cue = "/VO/NemesisField_0349", Text = "Lost to you again..." },
			{ Cue = "/VO/NemesisField_0350", Text = "I lost...?" },
			{ Cue = "/VO/NemesisField_0351", Text = "Fine, you win." },
			{ Cue = "/VO/NemesisField_0352", Text = "Should have had you..." },
			{ Cue = "/VO/NemesisField_0353", Text = "You and your damn magick." },
			{ Cue = "/VO/NemesisField_0354", Text = "Got me again, somehow." },
			{ Cue = "/VO/NemesisField_0355", Text = "Take the damn Gold." },
			{ Cue = "/VO/NemesisField_0356", Text = "Fair's fair." },
		},
		EncounterWonBigVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.15,

				{ Cue = "/VO/MelinoeField_0053", Text = "Got you.", PlayFirst = true, },
				{ Cue = "/VO/MelinoeField_0054", Text = "Got you again." },
				{ Cue = "/VO/MelinoeField_0055", Text = "Don't act so surprised." },
			},			
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.4,

				{ Cue = "/VO/NemesisField_0357", Text = "Really not my night..." },
				{ Cue = "/VO/NemesisField_0358", Text = "How did I lose this bad..." },
				{ Cue = "/VO/NemesisField_0359", Text = "Go on and gloat..." },
				{ Cue = "/VO/NemesisField_0360", Text = "Clearly underestimated you..." },
				{ Cue = "/VO/NemesisField_0361", Text = "Made me look like a fool..." },
				{ Cue = "/VO/NemesisField_0362", Text = "{#Emph}Ugh{#Prev}, that was terrible..." },
			},
		},
		EncounterTiedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,

			{ Cue = "/VO/NemesisField_0372", Text = "We tied so keep your coin." },
			{ Cue = "/VO/NemesisField_0373", Text = "We'll call this one a draw." },
			{ Cue = "/VO/NemesisField_0374", Text = "We broke even I guess." },
			{ Cue = "/VO/NemesisField_0375", Text = "Nobody wins this time." },
			{ Cue = "/VO/NemesisField_0376", Text = "Another draw I guess." },
			{ Cue = "/VO/NemesisField_0377", Text = "Dead even huh." },
		},
		EncounterLostVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.15,

				{ Cue = "/VO/MelinoeField_0050", Text = "I lost..." },
				{ Cue = "/VO/MelinoeField_0051", Text = "I failed..." },
				{ Cue = "/VO/MelinoeField_0052", Text = "{#Emph}Ungh. {#Prev}I concede." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.4,

				{ Cue = "/VO/NemesisField_0363", Text = "You lost. Pay up.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0364", Text = "Beat you, so pay up." },
				{ Cue = "/VO/NemesisField_0365", Text = "You lose, give me the Gold." },
				{ Cue = "/VO/NemesisField_0366", Text = "Don't take it too hard." },
				{ Cue = "/VO/NemesisField_0367", Text = "I won, so give it up." },
				{ Cue = "/VO/NemesisField_0368", Text = "Hand over the coin." },
				{ Cue = "/VO/NemesisField_0369", Text = "Got you, got your Gold." },
				{ Cue = "/VO/NemesisField_0370", Text = "Looks like I win again." },
				{ Cue = "/VO/NemesisField_0371", Text = "Fair's fair..." },
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Nemesis_01",
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/NemesisField_0220" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveObjectives", "NemesisDamageConest" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
					},
					MaxDistanceFromHero = 2000,
				},
				Cooldowns =
				{
					{ Name = "NemesisAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/NemesisField_0210", Text = "Bad idea.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0211", Text = "Stop." },
				{ Cue = "/VO/NemesisField_0212", Text = "Stop it." },
				{ Cue = "/VO/NemesisField_0213", Text = "Weak." },
				{ Cue = "/VO/NemesisField_0214", Text = "Cut it out." },
				{ Cue = "/VO/NemesisField_0215", Text = "Come off it." },
				{ Cue = "/VO/NemesisField_0216", Text = "Don't tempt me." },
				{ Cue = "/VO/NemesisField_0217", Text = "Really?" },
				{ Cue = "/VO/NemesisField_0218", Text = "Really?" },
				{ Cue = "/VO/NemesisField_0219", Text = "Not now." },
				{ Cue = "/VO/NemesisField_0220", Text = "Last warning." },
				{ Cue = "/VO/NemesisField_0221", Text = "Watch it." },
				{ Cue = "/VO/NemesisField_0222", Text = "Please." },
				{ Cue = "/VO/NemesisField_0223", Text = "You little..." },

				{ Cue = "/VO/Nemesis_0085", Text = "{#Emph}Khh..." },
				{ Cue = "/VO/Nemesis_0104", Text = "{#Emph}Urgh..." },
				{ Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
				{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Huh!" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Nemesis_01",
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
					MaxDistanceFromHero = 1000,
				},
				Cooldowns =
				{
					{ Name = "NemesisAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/NemesisField_0224", Text = "Watch it!", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0225", Text = "Watch your spacing." },
				{ Cue = "/VO/NemesisField_0226", Text = "Check your aim." },
				{ Cue = "/VO/NemesisField_0227", Text = "Step back!" },
				{ Cue = "/VO/NemesisField_0228", Text = "What are you..." },
				{ Cue = "/VO/NemesisField_0229", Text = "Want to go?" },
				{ Cue = "/VO/NemesisField_0230", Text = "Cut it out!" },
				{ Cue = "/VO/NemesisField_0231", Text = "Fight {#Emph}them!" },
			},
		},

		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { "NemesisAnyQuipSpeech" },

			{ Cue = "/VO/NemesisField_0320", Text = "Hey!" },
			{ Cue = "/VO/NemesisField_0321", Text = "Watch it!", PlayFirst = true },
			-- { Cue = "/VO/NemesisField_0322", Text = "Turn me back!" },
			{ Cue = "/VO/NemesisField_0323", Text = "Cut that out!" },
			{ Cue = "/VO/NemesisField_0324", Text = "Why you..." },
			-- { Cue = "/VO/NemesisField_0325", Text = "Oh come on..." },
		},

		GivingItemVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.66,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "TextLinesRecord" },
						HasNone = { "NemesisGetFreeItemIntro01", "NemesisGetFreeItemIntro02" },
					}
				},
				Cooldowns =
				{
					-- { Name = "NemesisAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/NemesisField_0055", Text = "Catch.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0056", Text = "Catch..." },
				{ Cue = "/VO/NemesisField_0057", Text = "Here." },
				{ Cue = "/VO/NemesisField_0058", Text = "Here then." },
				{ Cue = "/VO/NemesisField_0059", Text = "There." },
				{ Cue = "/VO/NemesisField_0060", Text = "There you go." },
				{ Cue = "/VO/NemesisField_0061", Text = "Yours." },
				{ Cue = "/VO/NemesisField_0062", Text = "All yours." },
				{ Cue = "/VO/NemesisField_0063", Text = "You're welcome." },
				{ Cue = "/VO/NemesisField_0064", Text = "Enjoy." },
				{ Cue = "/VO/NemesisField_0065", Text = "Surprise." },
				{ Cue = "/VO/NemesisField_0066", Text = "Take it." },
				{ Cue = "/VO/NemesisField_0067", Text = "One of these." },
			},
			{
				RandomRemaining = true,
				UsePlayerSource = true,
				PreLineWait = 0.65,
				SuccessiveChanceToPlay = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2142", Text = "...I'll take it. But be careful, Nem.", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Melinoe_2145", Text = "...Thank you..." },
				{ Cue = "/VO/MelinoeField_0064", Text = "Thanks..." },
				{ Cue = "/VO/MelinoeField_0065", Text = "Appreciate that..." },
				{ Cue = "/VO/MelinoeField_0066", Text = "I'm saved." },
				{ Cue = "/VO/MelinoeField_0067", Text = "Cheers." },
			},
		},

		DealApprovedVoiceLines =
		{
			TriggerCooldowns =
			{
				"CharonSpokeRecently",
			},
			{
				-- RandomRemaining = true,
				UsePlayerSource = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlay = 0.1,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/Melinoe_2144", Text = "...I'll take it..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.65,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/NemesisField_0080", Text = "Deal's a deal." },
				{ Cue = "/VO/NemesisField_0081", Text = "It's a deal." },
				{ Cue = "/VO/NemesisField_0082", Text = "Deal." },
				{ Cue = "/VO/NemesisField_0083", Text = "Fair enough." },
				{ Cue = "/VO/NemesisField_0084", Text = "Fair's fair." },
				{ Cue = "/VO/NemesisField_0085", Text = "Done." },
				{ Cue = "/VO/NemesisField_0086", Text = "Done deal." },
				{ Cue = "/VO/NemesisField_0087", Text = "Smart." },
				{ Cue = "/VO/NemesisField_0088", Text = "Hand it over." },
				{ Cue = "/VO/NemesisField_0089", Text = "Then it's settled." },
			},
		},
		DealDeclinedVoiceLines =
		{
			[1] = GlobalVoiceLines.NemesisDealDeclineVoiceLines,
			[2] =
			{
				RandomRemaining = true,
				PreLineWait = 0.5,
				Cooldowns =
				{
					{ Name = "NemesisAnyQuipSpeech", Time = 6 },
				},
				{ Cue = "/VO/NemesisField_0090", Text = "Suit yourself.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0091", Text = "Your loss.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0092", Text = "{#Emph}Eh." },
				{ Cue = "/VO/NemesisField_0093", Text = "Fine." },
				{ Cue = "/VO/NemesisField_0094", Text = "Figures." },
				{ Cue = "/VO/NemesisField_0095", Text = "Don't have enough do you." },
				{ Cue = "/VO/NemesisField_0096", Text = "Not good enough, huh." },
				{ Cue = "/VO/NemesisField_0097", Text = "No difference anyway." },
				{ Cue = "/VO/NemesisField_0098", Text = "Then get out of here." },
				{ Cue = "/VO/NemesisField_0099", Text = "Go on then." },
			},
		},

		HitAcceptedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.45,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/NemesisField_0112", Text = "It'll be my pleasure." },
				{ Cue = "/VO/NemesisField_0113", Text = "My pleasure." },
				{ Cue = "/VO/NemesisField_0114", Text = "Ah good." },
				{ Cue = "/VO/NemesisField_0115", Text = "Oh good." },
				{ Cue = "/VO/NemesisField_0116", Text = "Say no more." },
				{ Cue = "/VO/NemesisField_0117", Text = "Coming right up." },
				{ Cue = "/VO/NemesisField_0118", Text = "Smile." },
				{ Cue = "/VO/NemesisField_0119", Text = "Then hold still." },
				{ Cue = "/VO/NemesisField_0120", Text = "Perfect." },
				{ Cue = "/VO/NemesisField_0121", Text = "If you insist." },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/MelinoeField_1394", Text = "...Cheers." },
				{ Cue = "/VO/MelinoeField_1395", Text = "...What, that's it?" },
				{ Cue = "/VO/MelinoeField_1396", Text = "...Not bad." },
				{ Cue = "/VO/MelinoeField_1397", Text = "...{#Emph}Ow." },
				{ Cue = "/VO/MelinoeField_1398", Text = "...{#Emph}Guh, heh.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1399", Text = "...{#Emph}Urgh! Tsk." },
			}
		},
		HitDeclinedVoiceLines =
		{
			[1] = GlobalVoiceLines.NemesisDealDeclineVoiceLines,
			[2] =
			{
				RandomRemaining = true,
				PreLineWait = 0.8,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/NemesisField_0122", Text = "Didn't think so." },
				{ Cue = "/VO/NemesisField_0123", Text = "Too scary, huh." },
				{ Cue = "/VO/NemesisField_0124", Text = "Not so tough now huh." },
				{ Cue = "/VO/NemesisField_0125", Text = "That's what I thought." },
				{ Cue = "/VO/NemesisField_0126", Text = "Always next time." },
				{ Cue = "/VO/NemesisField_0127", Text = "Coward..." },
				{ Cue = "/VO/NemesisField_0128", Text = "Knew it." },
				{ Cue = "/VO/NemesisField_0129", Text = "Maybe next time." },
				{ Cue = "/VO/NemesisField_0130", Text = "Aw, what's the matter?" },
				{ Cue = "/VO/NemesisField_0131", Text = "Aw, too bad..." },
			},
		},

		StartDamageContestVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/NemesisField_0156", Text = "Go on." },
				{ Cue = "/VO/NemesisField_0157", Text = "Go on, then." },
				{ Cue = "/VO/NemesisField_0158", Text = "Let's see it." },
				{ Cue = "/VO/NemesisField_0159", Text = "Hit me." },
				{ Cue = "/VO/NemesisField_0160", Text = "Hit me!" },
				{ Cue = "/VO/NemesisField_0161", Text = "Come on." },
				{ Cue = "/VO/NemesisField_0162", Text = "Show me." },
				{ Cue = "/VO/NemesisField_0163", Text = "Do it." },
				{ Cue = "/VO/NemesisField_0164", Text = "Do it!" },
				{ Cue = "/VO/NemesisField_0165", Text = "Let me have it.", PlayFirst = true },
			},
		},
		PlayerWonDamageContestVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.5,

				{ Cue = "/VO/Melinoe_0314", Text = "{#Emph}Tsch!" },
				{ Cue = "/VO/Melinoe_0315", Text = "{#Emph}Hah!" },
				{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
				{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh!" },
				{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm!" },
				{ Cue = "/VO/MelinoeField_0609", Text = "{#Emph}Heh." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.8,

				{ Cue = "/VO/NemesisField_0166", Text = "Not bad... here." },
				{ Cue = "/VO/NemesisField_0167", Text = "{#Emph}Oof... {#Prev}fine." },
				{ Cue = "/VO/NemesisField_0168", Text = "All right, all right." },
				{ Cue = "/VO/NemesisField_0169", Text = "Stronger than I thought." },
				{ Cue = "/VO/NemesisField_0170", Text = "Felt something at least." },
				{ Cue = "/VO/NemesisField_0171", Text = "Been practicing." },
				{ Cue = "/VO/NemesisField_0172", Text = "Good enough." },
				{ Cue = "/VO/NemesisField_0173", Text = "OK relax." },
				{ Cue = "/VO/NemesisField_0174", Text = "Easy now." },
				{ Cue = "/VO/NemesisField_0175", Text = "All better now?" },
			},
		},
		PlayerWonDamageContestBigVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.5,

				{ Cue = "/VO/NemesisField_0176", Text = "I... {#Emph}urgh..." },
				{ Cue = "/VO/NemesisField_0177", Text = "You're... {#Emph}ungh..." },
				{ Cue = "/VO/NemesisField_0178", Text = "How did... {#Emph}ugh..." },
				{ Cue = "/VO/NemesisField_0179", Text = "You... how..." },
				{ Cue = "/VO/NemesisField_0180", Text = "Not... bad..." },
				{ Cue = "/VO/NemesisField_0181", Text = "{#Emph}Heh... {#Prev}ow." },
				{ Cue = "/VO/NemesisField_0182", Text = "{#Emph}Ungh... {#Prev}fine." },
				{ Cue = "/VO/NemesisField_0183", Text = "That... hurt..." },
				{ Cue = "/VO/NemesisField_0184", Text = "That's... fair..." },
				{ Cue = "/VO/NemesisField_0185", Text = "Not... fair..." },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlayAll = 0.75,

				{ Cue = "/VO/MelinoeField_0068", Text = "Had enough?" },
				{ Cue = "/VO/MelinoeField_0069", Text = "Like that?" },
				{ Cue = "/VO/MelinoeField_0070", Text = "Happy?" },
				{ Cue = "/VO/MelinoeField_0071", Text = "I aim to please.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift06" },
						},
					},
				},
			},
		},
		PlayerLostDamageContestVoiceLines =
		{
			[1] = GlobalVoiceLines.NegativeReactionVoiceLines,
			[2] =
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				TriggerCooldowns = { "LostToNemesisSpeech" },
				
				{ Cue = "/VO/NemesisField_0186", Text = "{#Emph}Tsch. {#Prev}Too weak." },
				{ Cue = "/VO/NemesisField_0187", Text = "Barely felt that at all." },
				{ Cue = "/VO/NemesisField_0188", Text = "That's it...?" },
				{ Cue = "/VO/NemesisField_0189", Text = "That's really all you got?" },
				{ Cue = "/VO/NemesisField_0190", Text = "What a joke." },
				{ Cue = "/VO/NemesisField_0191", Text = "Try again when you're strong." },
				{ Cue = "/VO/NemesisField_0192", Text = "That was pathetic." },
				{ Cue = "/VO/NemesisField_0193", Text = "Oh come on, that was bad." },
				{ Cue = "/VO/NemesisField_0194", Text = "That the best you can do?" },
				{ Cue = "/VO/NemesisField_0195", Text = "That was embarrassing..." },
			},
		},

		BrowsingVoiceLines =
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.75,
			PreLineWait = 0.0,
			ObjectType = "NPC_Nemesis_01",
			GameStateRequirements =
			{
				--
			},
			Cooldowns =
			{
				{ Name = "NemesisBrowsingSpeech", Time = 200 },
			},

			{ Cue = "/VO/NemesisField_0384", Text = "{#Emph}Hmm..." },
			{ Cue = "/VO/NemesisField_0385", Text = "This one...?" },
			{ Cue = "/VO/NemesisField_0386", Text = "Should have enough..." },
			{ Cue = "/VO/NemesisField_0387", Text = "How about..." },
			{ Cue = "/VO/NemesisField_0388", Text = "Which one..." },
			{ Cue = "/VO/NemesisField_0389", Text = "Tough call..." },
		},
		PurchasedVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Nemesis_01",
			GameStateRequirements =
			{
				--
			},

			{ Cue = "/VO/NemesisField_0390", Text = "Sure." },
			{ Cue = "/VO/NemesisField_0391", Text = "Bought." },
			{ Cue = "/VO/NemesisField_0392", Text = "Paid up." },
			{ Cue = "/VO/NemesisField_0393", Text = "It's a deal." },
			{ Cue = "/VO/NemesisField_0394", Text = "Here's the Gold." },
			{ Cue = "/VO/NemesisField_0395", Text = "All right." },
			{ Cue = "/VO/NemesisField_0396", Text = "Deal, Charon." },
		},
		PurchaseStolenVoiceLines =
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			PreLineWait = 0.4,
			ObjectType = "NPC_Nemesis_01",
			GameStateRequirements =
			{
				--
			},

			{ Cue = "/VO/NemesisField_0397", Text = "But I was..." },
			{ Cue = "/VO/NemesisField_0398", Text = "...Damn." },
			{ Cue = "/VO/NemesisField_0399", Text = "Oh you little..." },
			{ Cue = "/VO/NemesisField_0400", Text = "Really now?" },
			{ Cue = "/VO/NemesisField_0401", Text = "Come on." },
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.9,
				PreLineWait = 0.75,
				ObjectType = "NPC_Nemesis_01",
				Source = { LineHistoryName = "NPC_Nemesis_01", SubtitleColor = Color.NemesisVoice },
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "NemesisAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Nemesis_0152", Text = "Later." },
				{ Cue = "/VO/Nemesis_0153", Text = "Going." },
				{ Cue = "/VO/Nemesis_0154", Text = "I'm out." },
				{ Cue = "/VO/Nemesis_0155", Text = "'Night." },
				{ Cue = "/VO/Nemesis_0156", Text = "Should go." },
				{ Cue = "/VO/Nemesis_0157", Text = "Better go." },
				{ Cue = "/VO/Nemesis_0158", Text = "Enough." },
				{ Cue = "/VO/Nemesis_0159", Text = "Bye." },
				{ Cue = "/VO/Nemesis_0160", Text = "See you soon." },
				{ Cue = "/VO/Nemesis_0161", Text = "Don't mess this up." },
				{ Cue = "/VO/Nemesis_0162", Text = "Go on." },
				{ Cue = "/VO/Nemesis_0163", Text = "{#Emph}Ugh." },
				{ Cue = "/VO/Nemesis_0164", Text = "Get lost." },
				{ Cue = "/VO/Nemesis_0165", Text = "Go." },
			},
			{
				UsePlayerSource = true,
				PreLineWait = 0.3,
				PlayOnce = true,
				PlayOnceContext = "NemesisFirstExit",
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Melinoe_2253", Text = "Did she just...?" },
			},
			{
				UsePlayerSource = true,
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "NemesisTakeExitRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1480", Text = "She used the Chaos Gate...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1481", Text = "She went in..." },
				{ Cue = "/VO/MelinoeField_1482", Text = "She went to Chaos?" },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2244", Text = "{#Emph}<Scoff>" },
				{ Cue = "/VO/Melinoe_2245", Text = "Gone." },
				{ Cue = "/VO/Melinoe_2246", Text = "'Night...",
					PlayFirst = true,
					PreLineWait = 0.5,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Nemesis_0155" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2247", Text = "Bye...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Nemesis_0159" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2248", Text = "And you.",
					PlayFirst = true,
					PreLineWait = 0.5,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Nemesis_0160" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2249", Text = "Take care.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2250", Text = "Bye, Nem...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2251", Text = "She's off." },
				{ Cue = "/VO/Melinoe_2252", Text = "Well...!" },
			},
		},

	},

}

VariantSetData.NPC_Nemesis_01 =
{
	-- Nemesis for random events
	NemesisRandomEvent =
	{
		-- LastStandReactionVoiceLines = "nil",
		-- PlayerInjuredReactionVoiceLines = "nil",
		EncounterEndVoiceLines = "nil",
		NarrativeDataName = "NPC_Nemesis_01",
		InteractTextLinePriorities = "RandomEventsPriorities",
		AggroedEnemyUseText = "NPCUseTextTalkLocked",
		
		InteractTextLineSets =
		{
			NemesisGetFreeItemIntro01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0002",
					AngleTowardHero = true,
					Text = "Missed all the fun. But least you won't have to get your hands dirty this time." },
				{ Cue = "/VO/Melinoe_2140", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nemesis, what are you doing here? Who's standing watch at the Crossroads?" },
				{ Cue = "/VO/NemesisField_0422",
					Text = "They'll manage, I'm on break. Tell Hecate you saw me, you'll regret it. And, {#Emph}you're welcome here and safe{#Prev}, seeing as I cleared the path for you." },
				{ Cue = "/VO/Melinoe_2141", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't need your aid in this, other than the responsibilities you've already been assigned." },
				{ Cue = "/VO/NemesisField_0004",
					Text = "Really? Look like you could use all the {#Emph}aid {#Prev}you can get. Here's something for your trouble, then I suggest you move along.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItemIntro02 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0039",
					Text = "You're late. Already took care of things here, though you'll still get your share, I'm sure." },
				{ Cue = "/VO/MelinoeField_0023", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you insist on trying to hunt Chronos down, why don't we work at it together, at least?" },
				{ Cue = "/VO/NemesisField_0040",
					Text = "Can't be seen with you, and don't need your help, besides. But I get you need mine, so here. Take this, and you never saw me. Got it?",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},

			NemesisGetFreeItem01 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0045",
					Text = "You need all the help you can get, so here! Don't need this anyway.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem02 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0046",
					Text = "So much useless junk lying around. Here, ought to be {#Emph}you {#Prev}cleaning it up, not me.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem03 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0047",
					Text = "Won't be needing this at all, but you look like you will.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem04 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0048",
					Text = "Pretend you never saw me, and I didn't make things easier for you.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem05 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0049",
					Text = "Wow, you really showed them, didn't you. And earned a handsome prize.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem06 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0050",
					Text = "Best keep your mouth shut about this next time you and Hecate catch up.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem07 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0051",
					Text = "We'll see who gets there first. Here, I'll even give you a boost.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem08 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0052",
					Text = "You travel lighter than me, so here, why don't we balance out the load.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem09 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0053",
					Text = "Was just about to throw this out when you came along...",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItem10 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0054",
					Text = "No way you'll get there first. Even give you a head start.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},

			NemesisGetFreeItemIntroBridge01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Echo_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0435",
					Text = "Expecting someone else? Taking a moment to get my bearings. Was nice and quiet here till you showed up." },
				{ Cue = "/VO/MelinoeField_1972", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You haven't seen a gentle-looking Nymph nearby, have you? She's often here on this bridge." },
				{ Cue = "/VO/NemesisField_0436",
					Text = "Might be I scared her off. Got more important things to do than chasing Nymphs. Anyway, go on. The spirits in this place won't like us making nice.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge01 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0045",
					Text = "You need all the help you can get, so here! Don't need this anyway.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge02 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0046",
					Text = "So much useless junk lying around. Here, ought to be {#Emph}you {#Prev}cleaning it up, not me.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge03 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,

				{ Cue = "/VO/NemesisField_0047",
					Text = "Won't be needing this at all, but you look like you will.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,
				},
			},
			NemesisGetFreeItemBridge04 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0048",
					Text = "Pretend you never saw me, and I didn't make things easier for you.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge05 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0049",
					Text = "Wow, you really showed them, didn't you. And earned a handsome prize.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge06 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0050",
					Text = "Best keep your mouth shut about this next time you and Hecate catch up.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge07 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0051",
					Text = "We'll see who gets there first. Here, I'll even give you a boost.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge08 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0052",
					Text = "You travel lighter than me, so here, why don't we balance out the load.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge09 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0053",
					Text = "Was just about to throw this out when you came along...",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},
			NemesisGetFreeItemBridge10 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0054",
					Text = "No way you'll get there first. Even give you a head start.",
					PreLineFunctionName = "NPCRewardDropPreProcess",
					PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemPremiumArgs,
				},
			},

			NemesisBuyItemIntro01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0068",
					Text = "Always used to be Gold in the Underworld, right in its veins. But Chronos turned it into little coins! All over the damn place now." },
				{ Cue = "/VO/MelinoeField_0024", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Charon's going to take care of it, soon enough. I give him all the Gold I find. Trade for his wares." },
				{ Cue = "/VO/NemesisField_0069",
					Text = "Think I can do the same, if you want to make a deal. Don't worry, any Gold I get from you, Charon gets from me.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},

			NemesisBuyItemFields01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFieldsRewardFinder" }
					},
					{
						Path = { "GameState", "FieldsRewardFindersActivated" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0431",
					Text = "Well, look who! Also lost here in these Fields I guess? Trade you a map or something if I had one, but you wouldn't have been able to afford it, so I'd use it to get out of here myself." },
				{ Cue = "/VO/MelinoeField_1970", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I doubt a map would be of any use, as these pathways seem to shift from night to night. I've been able to make use of the Golden Boughs scattered about at least. What about you?" },
				{ Cue = "/VO/NemesisField_0432",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "The Golden Boughs. Had no idea those did anything but look all sad. Guess I should have paid better attention when the Headmistress was droning on and on over that Cauldron." },
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},

			NemesisBuyItem01 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0070",
					Text = "Trade you something for some Gold. Got to keep Charon fed and all.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem02 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0071",
					Text = "Need some Gold and won't be fair if I just beat it out of you, so how about a trade.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem03 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0072",
					Text = "What say we make a little deal if you've got the coin.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem04 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0073",
					Text = "Got something you could use though you're not getting it for free.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem05 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0074",
					Text = "Can help you go farther than this, but it's not gonna come cheap.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem06 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0075",
					Text = "Want to be the best, it's not gonna come cheap.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem07 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0076",
					Text = "Make you a deal, but only if you've got the coin for it.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem08 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0077",
					Text = "You're a princess, you must have some coin to spare, don't you?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem09 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0078",
					Text = "How much Gold you get out there? Can make it worth your while.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},
			NemesisBuyItem10 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0079",
					Text = "Could shake you down for all your Gold, but wouldn't be fair.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisBuyItemChoices,
			},

			NemesisTakeDamageForItemIntro01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0100",
					Text = "These wretches were nothing. Back when we used to spar... almost never got a clean hit in on you. You'd always slip out of the way." },
				{ Cue = "/VO/MelinoeField_0025", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What choice did I have? One clean hit from you was more than I could take back then. But I've been practicing!" },
				{ Cue = "/VO/NemesisField_0101",
					Text = "You're tougher, yeah. Though by how much? How about I hit you right now, and if you can take it, you'll get this nice reward I found. Deal?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},

			NemesisTakeDamageForItemRepeatSightings01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisTakeDamageForItemIntro01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone =
						{
							"NemesisTakeDamageForItemIntro01",
							"NemesisTakeDamageForItem01",
							"NemesisTakeDamageForItem02",
							"NemesisTakeDamageForItem03",
							"NemesisTakeDamageForItem04",
							"NemesisTakeDamageForItem05",
							"NemesisTakeDamageForItem06",
							"NemesisTakeDamageForItem07",
							"NemesisTakeDamageForItem08",
							"NemesisTakeDamageForItem09",
							"NemesisTakeDamageForItem10",
						},
					},
					{
						Path = { "CurrentRun", "EncountersCompletedCache" },
						HasAny = { "NemesisRandomEvent", "BridgeNemesisRandomEvent", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0433",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "You following me or something? Not used to running into you this many times per night. Find your own path." },
				{ Cue = "/VO/MelinoeField_1971", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Find my {#Emph}own {#Prev}path? You mean {#Emph}besides {#Prev}the one our Headmistress and Master Tactician endlessly toiled to refine to maximize my chances of success?" },
				{ Cue = "/VO/NemesisField_0434",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Just stay out of my way. But first, how about you let me take a good clean swing at you, since you've been mouthing off?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},

			NemesisTakeDamageForItem01 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0102",
					Text = "{#Emph}Urgh{#Prev}, got to hit something sometimes. You know how it is. Could make it worth your while...",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem02 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0103",
					Text = "Blood's boiling still... got to get it out of my system. Just one clean hit, that's all.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem03 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0104",
					Text = "Spilled some blood getting my hands on this. Spill some of yours if you want it.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem04 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0105",
					Text = "You're tough. Can take a hit, can't you. Worth it for both of us...",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem05 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0106",
					Text = "You'd have taken more than one hit getting through this mess...",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem06 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0107",
					Text = "Took a hard hit getting here, how about you take one too.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem07 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0108",
					Text = "Want something from me, you'll pay with blood.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem08 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0109",
					Text = "Want to see this through, better be ready to bleed.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem09 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0110",
					Text = "Doubt you could even handle just a single hit from me.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},
			NemesisTakeDamageForItem10 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					NamedRequirements = { "NoHitShieldAvailable", },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0111",
					Text = "Thinking if you can't take a hit from me, you don't have a chance.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisTakeDamageForItemChoices,
			},

			NemesisGiveTraitForItemIntro01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				
				GameStateRequirements =
				{
					RequiredSellableGodTraits = true,
				},
				{ Cue = "/VO/NemesisField_0132",
					Text = "Sometimes I get a little boost from Artemis, but {#Emph}you? {#Prev}Just about all Olympus backs you up, and {#Emph}even still{#Prev}, it's not enough. Some help {#Emph}they {#Prev}are." },
				{ Cue = "/VO/MelinoeField_0026", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Direct your criticism to the gods themselves. Now what is it you want with me?" },
				{ Cue = "/VO/NemesisField_0133",
					Text = "Want a little taste of all that power for myself. Come on, I'll trade you...",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem01 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				
				{ Cue = "/VO/NemesisField_0134",
					Text = "All these hand-outs from your relatives... surely you don't need them {#Emph}all?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem02 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				
				{ Cue = "/VO/NemesisField_0135",
					Text = "Got something here you need, but it'll cost you some of your false power from Olympus.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem03 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0136",
					Text = "Give me some of your borrowed strength, and you'll get some of mine.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem04 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0137",
					Text = "Don't need Olympus handing everything to you.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem05 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				
				{ Cue = "/VO/NemesisField_0138",
					Text = "Want what I've got, got to give something up.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem06 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				
				{ Cue = "/VO/NemesisField_0139",
					Text = "Don't have Olympus helping me, only fair neither should you.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem07 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0140",
					Text = "The mountain gods don't offer {#Emph}me {#Prev}their aid, though what about you?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem08 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0141",
					Text = "Olympus isn't gonna care if you give up one little blessing, will they?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem09 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0142",
					Text = "What would it take for you to give up some of your Olympian muscle?",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},
			NemesisGiveTraitForItem10 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					RequiredSellableGodTraits = true,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

				{ Cue = "/VO/NemesisField_0143",
					Text = "Always depending on your relatives for help. How about you give it up.",
				},
				PrePortraitExitFunctionName = "NemesisTradeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NemesisGiveTraitForItemChoices,
			},

			NemesisDamageContestIntro01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0144",
					Text = "Got here well before you did. Cleaned up, too. Makes you mad, I know. Don't hold back... let's see how strong you really are." },
				{ Cue = "/VO/MelinoeField_0027", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't want to fight you, Nemesis. I don't even want to speak with you right now." },
				{ Cue = "/VO/NemesisField_0145",
					Text = "Not asking you to fight me. Asking you to {#Emph}hit {#Prev}me. See if you can even make me budge. It'll be worth your while.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest01 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0146",
					Text = "All that pent-up anger. Let it out, then. I feel anything, I'll make it worth your while.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest02 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0147",
					Text = "Wretches couldn't even hit me. Wasn't fair. How about you make it up to them.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest03 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0148",
					Text = "Look at you acting tough. Go on, hit me hard as you can. Free shot.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest04 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0149",
					Text = "Let's see how strong you really are. Hit me, and don't hold back.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest05 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0150",
					Text = "Can tell you're angry. Then let it out and show me what you're made of.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest06 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0151",
					Text = "Look at you, all tough and fierce. Show me how strong you really are.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest07 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0152",
					Text = "To the victor go the spoils. So come show me what you've got.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest08 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0153",
					Text = "None of these wretches could touch me. But you're stronger than them, right?",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest09 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0154",
					Text = "Don't think you have what it takes, though go on and try to prove me wrong.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
			NemesisDamageContest10 =
			{
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "ObjectivesCompleted", "NemesisBet" },
						Comparison = ">=",
						Value = 8,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,
				SkipClearRoomRequiredObject = true,

				{ Cue = "/VO/NemesisField_0155",
					Text = "Getting stronger, but you'll never be at my level. Go on, try me.",
					PostLineFunctionName = "StartNemesisDamageContest",
					PostLineFunctionArgs = PresetEventArgs.NemesisDamageContestArgs,
				},
			},
		},
	},

	NemesisPostRandomEventCombat =
	{
		DefaultAIData =
		{
			TargetRequiredKillEnemy = true,
			TargetClosestToPlayer = true,
			IgnoreInvulnerable = true,
			AIWanderDistance = 200,
		},
		AIOptions = { "AttackerAI" },

		WeaponOptions = { "NemesisAttack1", "NemesisSpecial", "NemesisDash" },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			},
			{
				NonPlayerMultiplier = 1.0,
			},
		},
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.0,
			}
		},
	},

	NemesisFieldsPreRandomEventCombat =
	{
		DefaultAIData =
		{
			SentryActivateDistance = 400,
			SentryTetherDistance = 800,
			TargetMaxDistance = 600,
			TargetClosest = true,
			SentryActivateAnimation = "Nemesis_Hub_Equip",
			SentryActivateDelay = 1.05,
			SentryResetAnimation = "Nemesis_Combat_Unequip",
			SentryResetDelay = 1.1,
			SentryResetWithNoTarget = true,
			TargetGroups = { "GroundEnemies", "FlyingEnemies", },
		},
		AIOptions = { "SentryAI" },

		WeaponOptions = { "NemesisAttack1", "NemesisSpecial" },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			},
			{
				NonPlayerMultiplier = 1.0,
			},
		},
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.0,
			}
		},
	},

	-- Nemesis Combat / -- NemesisCombat
	NemesisCombat =
	{
		RequiredSpawnPoint = "EnemyPoint",

		HealthBarTextId = "Chronos_Full",
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		DefaultAIData =
		{
			TargetRequiredKillEnemy = true,
			TargetClosestToPlayer = true,
			IgnoreInvulnerable = true,
			AIWanderDistance = 0,
			AIWanderDistanceDuration = 0,
		},
		-- AIWakeDelay = 0.25,
		SkipAISetupOnActivate = true,
		AIOptions = { "AttackerAI" },
		MaxBetAmount = 100,

		--NoTargetMoveTowardsPlayer = true,
		NoTargetWanderDuration = 1.0,

		-- WeaponOptions = { "NemesisAttack", "NemesisSpecial", "NemesisDash" },
		WeaponOptions = { "NemesisAttack1", "NemesisSpecial" },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			},
			{
				NonPlayerMultiplier = 1.0,
			},
		},
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.0,
			}
		},
		--[[OutgoingCritModifiers =
		{
			{
				Chance = 1.0,
			}
		},]]

		PostTextLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "NemesisPostFieldsCombatCheckExits",
				Args =
				{
					RandomWaitMin = 1.0,
					RandomWaitMax = 3.0,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H", },
					},
				},
			},
		},

		SkipNextTextLinesCheck = true,

		CombatIntroTextLineSets =
		{
			NemesisCombatFirstIntro =
			{
				PlayFirst = true,
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/NemesisField_0005",
					Text = "One word of this to Hecate, and you're meat, got it? Now go on while I take care of things." },
				{ Cue = "/VO/MelinoeField_0014", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is my task, not yours. And I'm disappointed with your dereliction of duty. Are you so desperate to prove you're superior to me?" },
				{ Cue = "/VO/NemesisField_0006",
					Text = "You know, maybe I am. So how about this: Got some Gold on you, right? Those wretches ought to swarm in any moment. Whoever takes more of them gets the other's coin. What do you say?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0015", Text = "Must it always be a wager with you?" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/NemesisField_0007", Text = "Fair odds of winning if you shut up and fight!" },
					},
				},
			},

			-- Repeatable
			NemesisCombatMiscStart01 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0027",
					Text = "Going to take care of Chronos myself if you can't do it. But first things first." },
			},
			NemesisCombatMiscStart02 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0028",
					Text = "Once we're done here, one of us gets richer, and one of us gets poorer." },
			},
			NemesisCombatMiscStart03 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0029",
					Text = "How did you get here already? {#Emph}Ungh{#Prev}, anyway. It's your Gold against mine." },
			},
			NemesisCombatMiscStart04 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G", },
					},
				},
				{ Cue = "/VO/NemesisField_0030",
					Text = "Can hardly stand all this water and the singing, but this has to be done." },
			},
			NemesisCombatMiscStart05 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0031",
					Text = "Was just about to clear the way, so why don't you pitch in." },
			},
			NemesisCombatMiscStart06 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0032",
					Text = "Fates must be smiling on you, as I'm about to do {#Emph}all {#Prev}the work." },
			},
			NemesisCombatMiscStart07 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0033",
					Text = "Should be more than enough wretches for the both of us here, any moment now." },
			},
			NemesisCombatMiscStart08 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0034",
					Text = "Don't need assistance from you here, but how about we make things interesting..." },
			},
			NemesisCombatMiscStart09 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0035",
					Text = "I'll handle this, and once I'm finished with the work, I'm getting paid." },
			},
			NemesisCombatMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0036",
					Text = "Let's see whether the Fates are on your side or mine this time around." },
			},
			NemesisCombatMiscStart11 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0037",
					Text = "To think I could be standing there on guard duty right now." },
			},
			NemesisCombatMiscStart12 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord "},
						HasNone =
						{
							"NemesisField_0243",
							"NemesisField_0244",
							"NemesisField_0246",
						}
					},
				},
				{ Cue = "/VO/NemesisField_0038",
					Text = "Remember to be extra reckless since your Gold is on the line." },
			},
			NemesisCombatMiscStart13 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord "},
						HasNone =
						{
							"NemesisField_0243",
							"NemesisField_0244",
							"NemesisField_0246",
						}
					},
				},
				{ Cue = "/VO/NemesisField_0437",
					Text = "Could use more coin. How about I take yours, soon as we're finished around here." },
			},
			NemesisCombatMiscStart14 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0438",
					Text = "Get set to fight as though there's something you could buy from Charon on the line." },
			},
			NemesisCombatMiscStart15 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0439",
					Text = "Showed up just as I was about to settle up all by myself. Well you can have your share." },
			},
			NemesisCombatMiscStart16 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord "},
						HasNone =
						{
							"NemesisField_0243",
							"NemesisField_0244",
							"NemesisField_0246",
						}
					},
				},
				{ Cue = "/VO/NemesisField_0440",
					Text = "Let's split the killing down the middle, give or take. As in, {#Emph}I'll {#Prev}take your Gold." },
			},
			NemesisCombatMiscStart17 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord "},
						HasNone =
						{
							"NemesisField_0243",
							"NemesisField_0244",
							"NemesisField_0246",
						}
					},
				},
				{ Cue = "/VO/NemesisField_0441",
					Text = "Don't pull your weight, I'll take your Gold soon as I wrap this up." },
			},
			NemesisCombatMiscStart18 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0442",
					Text = "Got the Blade of the Underworld. Won't be needing your help here, thanks." },
			},
			NemesisCombatMiscStart19 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord "},
						HasNone =
						{
							"NemesisField_0243",
							"NemesisField_0244",
							"NemesisField_0246",
						}
					},
				},
				{ Cue = "/VO/NemesisField_0443",
					Text = "Want a bit of extra Gold, then earn it. Now heads up, they're coming." },
			},
			NemesisCombatMiscStart20 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					}
				},
				{ Cue = "/VO/NemesisField_0444",
					Text = "How about a little friendly competition there, Princess? Come on, let's see it." },
			},

		},

		NarrativeDataName = "NPC_Nemesis_01",
		InteractTextLinePriorities = "PostCombatEventsPriorities",
		InteractTextLineSets =
		{
			NemesisPostCombatFirstMeeting =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
				},
				{ Cue = "/VO/NemesisField_0008",
					Text = "Surprised you didn't bail out with that return trick of yours." },
				{ Cue = "/VO/MelinoeField_0016", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You don't know anything about me. What are you thinking, being this far from your post, in violation of Headmistress Hecate's direct orders?" },
				{ Cue = "/VO/NemesisField_0009",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "I'm {#Emph}thinking {#Prev}you don't have what it takes to take the Titan down. {#Emph}I {#Prev}do. Now, get out of here." },
			},

			NemesisPostCombatAboutProgress01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H", },
					},
				},
				{ Cue = "/VO/NemesisField_0010",
					AngleTowardHero = true,
					Text = "Thought for sure when first you saw me out here, you'd go telling Hecate soon as you could. But you didn't." },
				{ Cue = "/VO/MelinoeField_0017", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's fortunate for you Headmistress doesn't ask me to make reports. You're probably drawing some of our enemy's attention off of me, at least." },
				{ Cue = "/VO/NemesisField_0011",
					Text = "Very least I could do. Wasn't going to back down no matter what you did, but {#Emph}this {#Prev}way... can stay focused. On the task at hand." },
			},

			NemesisPostCombatAboutKeepsake01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DeathVengeanceKeepsake" },
					},
				},
				{ Cue = "/VO/NemesisField_0012",
					AngleTowardHero = true,
					Text = "{#Emph}Aw{#Prev}, you brought the Evil Eye I gave to you, how sweet. Make your enemies regret messing with you." },
				{ Cue = "/VO/MelinoeField_0018", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm certain our foes will get what's coming. This Eye, though; it almost looks alive. Not using it to spy on me, are you?" },
				{ Cue = "/VO/NemesisField_0013",
					Text = "Nah. See enough of you as it is. Now get out of here before that Eye does anything to me." },
			},

			NemesisPostCombatAboutHecate01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G", },
					},
				},
				{ Cue = "/VO/MelinoeField_0019", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Say, how do you get past Headmistress on your way down? She's always waiting for me at the edge of Erebus." },
				{ Cue = "/VO/NemesisField_0016",
					Text = "Just answered your own question. She's waiting for {#Emph}you{#Prev}, not me. I'm not the one still being tested and trained. And I'm good at avoiding her." },
			},

			NemesisPostCombatAboutOceanus01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				{ Cue = "/VO/MelinoeField_1968", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All of this water must be quite a nuisance in your suit. Not found another pathway down, have you?" },
				{ Cue = "/VO/NemesisField_0429",
					Text = "Only other path is through Elysium, and that's not happening for you or me. What better way for Chronos to show he's in charge than to seal off the Underworld for good?" },
				{ Cue = "/VO/MelinoeField_1969", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Good thing he missed a spot. Although he realizes now that we're using this path. That I am using it, at least." },
				{ Cue = "/VO/NemesisField_0430",
					Text = "Thanks for the tip! No wonder the fish are biting. Anyway, I'm off. This suit isn't supposed to rust, but just in case." },
			},

			NemesisPostCombatAboutScylla01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "G_Boss01" },
					},
					{
						PathFalse = { "GameState", "EncountersCompletedCache", "NemesisCombatH" },
					},
				},
				{ Cue = "/VO/MelinoeField_0020", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you been able to get past Scylla and her Siren friends? Just once I'd like to pass through and not have to hear their song..." },
				{ Cue = "/VO/NemesisField_0019",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "They know better than to mess with me. Wait, you've been {#Emph}fighting {#Prev}them? How'd you make enemies with a musical act?" },
				{ Cue = "/VO/MelinoeField_0021", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... can't entirely be sure. But they've been very hostile to me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/NemesisField_0020", Text = "Can't imagine why." },
					},
				},
			},

			NemesisPostCombatAboutCerberus01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						Path = { "GameState", "EncountersOccurredCache" },
						HasAny = { "BridgeNemesisRandomEvent", "NemesisCombatH" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
				},

				{ Cue = "/VO/MelinoeField_0760", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Across the Fields of Mourning, where the path descends to Tartarus... the monstrous creature there... do you know what it is?" },
				{ Cue = "/VO/NemesisField_0021",
					Text = "It's a problem. Can't always find my way to it, and even when I do, that thing forces me back. But don't worry; got my eye on it." },
			},

			NemesisPostCombatAboutTartarus01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatAboutChronos01", "NemesisPostCombatAboutCerberus01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Intro" },
					},
					{
						Path = { "GameState", "EncountersOccurredCache", "NemesisCombatH" },
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/NemesisField_0425",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Tell me something, and don't you dare mock me or you'll regret it: How do I... get into Tartarus. Managed to make it through the Fields, then hit a dead end. Kept hitting it." },
				{ Cue = "/VO/MelinoeField_1966", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Tartarus is sealed off. The only reason I'm able to get in is because not even Chronos can take away my birthright and divine authority over the place. Although if not for Headmistress, I wouldn't have known how to use it." },
				{ Cue = "/VO/NemesisField_0426",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "No help at all, forget I even asked. Got to be some other way inside, and if not, just have to make one I guess. For now, enjoy the lack of competition while you can." },
			},

			NemesisPostCombatAboutChronos01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomCountCache", "H_Intro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H", },
					},
				},

				{ Cue = "/VO/MelinoeField_0761", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must have thought you would have taken Chronos down by now. Have you even seen him? Gotten anywhere near my father's House?" },
				{ Cue = "/VO/NemesisField_0017",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Keep hitting snags along the way. The pathways down to Tartarus have changed a lot. Especially once you get to the Fields." },
				{ Cue = "/VO/MelinoeField_0762", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have a sense for where we need to go. I'd suggest we proceed together had Headmistress not strictly forbidden it." },
				{ Cue = "/VO/NemesisField_0018",
					Text = "Not happening, no matter what she says. Doing this alone. Better odds that way anyway." },
			},

			NemesisPostCombatAboutArmor01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
				},

				{ Cue = "/VO/MelinoeField_1211", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Doesn't all that heavy armor slow you down? Can't be too comfortable, especially around the waist." },
				{ Cue = "/VO/NemesisField_0014",
					Text = "Can't be too comfortable is right. Besides, not everybody wants to run half-naked into battle." },
				{ Cue = "/VO/MelinoeField_1212", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You really ought to try running half-naked into battle. You might like it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/NemesisField_0015", Text = "Rather be invulnerable, thanks." },
					},
				},
			},

			NemesisPostCombatAboutLosing01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					{
						Path = { "GameState", "ObjectivesCompleted", "NemesisBet" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "CurrentRun", "ObjectivesCompleted", "NemesisBet" },
					},
					{
						PathFalse = { "CurrentRun", "ObjectivesFailed", "NemesisBet" },
					},
				},

				{ Cue = "/VO/NemesisField_0427",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "{#Emph}Damn {#Prev}it! How many times you going to take my Gold? Rules of this wager might be too much in your favor after all." },
				{ Cue = "/VO/MelinoeField_1967", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You set the rules of this wager yourself. You'd never go easy on me, would you, Nem? Though you can't bring yourself to make things overly unfair for me, either." },
				{ Cue = "/VO/NemesisField_0428",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Beginning to think it might be a weakness of mine. Well, go buy yourself something nice, Princess. Don't need to hear more metal clinking around every step I take anyway." },
			},

			NemesisPostCombatAboutSurface01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Boss01" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H", },
					},
				},

				{ Cue = "/VO/NemesisField_0022",
					Text = "First wager in a while. Been busy up top, breathing surface air? Thought maybe you came to your senses and left things to me." },
				{ Cue = "/VO/MelinoeField_1213", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, I'm not finished here by any means. And evidently neither are you. Still at it like before? Quite difficult, I know." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/NemesisField_0023", Text = "Oh, shut up." },
					},
				},
			},

			NemesisPostCombatAboutFailure01 =
			{
				PlayOnce = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
				},

				{ Cue = "/VO/NemesisField_0196",
					Text = "Quit stalling. Sooner you fail, sooner I'll get to show you how it's done.",
				},
			},

		},
	},

	NemesisCombat_G =
	{
		InheritFrom = { "NemesisCombat" },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			},
			{
				NonPlayerMultiplier = 1.0,
			},
		},
		SpeedMultiplier = 1.5,
	},

	NemesisShopping =
	{
		NarrativeDataName = "NPC_Nemesis_01",
		InteractTextLinePriorities = "ShoppingPriorities",
		InteractTextLineSets =
		{
			NemesisShopping01 =
			{
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/NemesisField_0041",
					Text = "Look at all this business you drummed up, Charon.",
				},
			},
			NemesisShopping02 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/NemesisField_0042",
					Text = "Can't you see my brother and I are in the middle of something?",
				},
			},
			NemesisShopping03 =
			{
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/NemesisField_0043",
					Text = "Leave me alone, trying to make a trade.",
				},
			},
			NemesisShopping04 =
			{
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/NemesisField_0044",
					Text = "Get in line. I was here first.",
				},
			},

		}
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Nemesis )
OverwriteTableKeys( NPCVariantData, VariantSetData.NPC_Nemesis_01 )