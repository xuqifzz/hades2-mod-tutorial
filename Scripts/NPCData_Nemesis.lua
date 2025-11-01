 UnitSetData.NPC_Nemesis =
{
	-- Nemesis, Hub_Main Id = 557113
	NPC_Nemesis_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Nemesis_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.NemesisVoice,
		EmoteOffsetY = -350,
		EmoteOffsetX = 80,
		SpeakerName = "Nemesis",
		FieldSpeakerName = "NemesisField",
		LoadPackages = { "Nemesis" },
		InvincibubbleScale = 1.2,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		ThemeMusic = "/Music/IrisMusicNemesisTheme_MC",
		TurnInPlaceAnimation = "Nemesis_Turn",
		DoorTakenText = "CannotUseObject",
		ExitSpeed = 500,
		HideHealthBar = true,
		Icon = "NemesisRewardFinderIcon",
		ExcludeFromDamageDealtRecord = true,
		BecomingCloserFunctionName = "BecomingCloserNemesisPresentation",

		BathEnterSound1 = "/SFX/ArmorIdleSFX",
		BathEnterSound2 = "/SFX/ArmorIdleSFX2",
		
		EffectBlocks = { "RavenFamiliarMark" },
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetal",
			Rapid = "HitSparkEnemyDamagedMetal",
		},

		PreferredSpawnPoint = "EnemyPoint",

		ShopEventData = 
		{
			TimerStartDistance = 1000,
			DelayMin = 10,
			DelayMax = 18,
			InstantChance = 0.1, -- Chance she will buy it without a chance for the player to interact
			-- NeverChance = 0.1, -- Chance she will dither indefinitely
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
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
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
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				PreLineWait = 0.31,
				RandomRemaining = true,
				ObjectType = "NPC_Nemesis_01",
				Cooldowns =
				{
					{ Name = "NemesisSaluteSpeech", Time = 30 },
				},

				{ Cue = "/VO/Nemesis_0123", Text = "Right." },
				{ Cue = "/VO/Nemesis_0180", Text = "Come on..." },
				{ Cue = "/VO/Nemesis_0198", Text = "Keep practicing." },
				{ Cue = "/VO/Nemesis_0199", Text = "Nice try." },
				{ Cue = "/VO/Nemesis_0292", Text = "Sure." },
				{ Cue = "/VO/Nemesis_0470", Text = "Oh, come on." },
				{ Cue = "/VO/Nemesis_0122", Text = "Fine.",
					PreLineAnim = "Nemesis_Hub_Salute" },
				{ Cue = "/VO/Nemesis_0124", Text = "{#Emph}<Sigh>",
					PreLineAnim = "Nemesis_Hub_Salute" },
				{ Cue = "/VO/Nemesis_0125", Text = "{#Emph}Hrm.",
					PreLineAnim = "Nemesis_Hub_Salute" },
				{ Cue = "/VO/Nemesis_0120", Text = "Whatever.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "NemesisGift07" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0164", Text = "Get lost.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "NemesisGift05" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0471", Text = "He's gone.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift08" },
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1712" },
						},
					},
				},
				{ Cue = "/VO/Nemesis_0472", Text = "Yeah, you too.",
					PreLineAnim = "Nemesis_Hub_Salute",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift08" },
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
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
							PathFalse = { "GameState", "TextLinesRecord", "NemesisGift06" },
						},
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
				{ Cue = "/VO/Nemesis_0473", Text = "Might as well.",
					PreLineAnim = "Nemesis_Hub_Salute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
			},
		},

		ActivateRequirements =
		{
			NamedRequirementsFalse = { "NemesisKnowsHecateMissing" },
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
				BreakIfPlayed = true,
				PreLineWait = 0.95,
				PlayOnce = true,
				PlayOnceContext = "NemesisTartarusIntroVO",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},

				{ Cue = "/VO/MelinoeField_0036", Text = "Nemesis!" },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.95,
				SuccessiveChanceToPlay = 0.25,
				SuccessiveChanceToPlayAll = 0.05,
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
				PreLineWait = 0.75,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "GeneratedH_PassiveSmall", "GeneratedH_Passive" }, 
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
				{ Cue = "/VO/NemesisField_0245", Text = "Get set to fight, or get out of the way." },
				{ Cue = "/VO/NemesisField_0246", Text = "Good, could use more Gold." },
				{ Cue = "/VO/NemesisField_0247", Text = "Had a feeling you'd show up." },
				{ Cue = "/VO/NemesisField_0537", Text = "Surprise.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "I" },
						},
					},
				},
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
				PreLineWait = 0.15,
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0002",
					-- Portrait = "Portrait_Nemesis_Averted_01",

					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					-- PreLineAnim = "Nemesis_Hub_Greet",
					-- PreLineAnim = "Nemesis_Hub_Salute",
					-- PreLineAnim = "Nemesis_Hub_Toss",
					-- PreLineAnim = "Nemesis_Hub_Interact",
					Text = "Already hit a wall! Knocked your scrawny ass all the way back here. It's insane that she's sending you out on foot, all on your own." },

				{ Cue = "/VO/Melinoe_0077", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're fortunate you have even {#Emph}this {#Prev}responsibility, for all your questioning of orders and complaining." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0458", Text = "Oh, shut up." },
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
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosSecondAppearance" }, Max = 4 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0036",
					Text = "Can't believe sucking up to the Fates actually worked. That big scroll over there... that's really from them?" },
				{ Cue = "/VO/Melinoe_1543", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Personally delivered by Lord Moros, no less. He seemed a little pressed for time, so we didn't get to talk much. Are the two of you close?" },
				{ Cue = "/VO/Nemesis_0037",
					Portrait = "Portrait_Nemesis_Averted_01",
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 560612 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0038",
					Text = "Never thought I'd see Moros here of all places. But then again, it only makes sense Doom would come to the Crossroads sooner or later." },
				{ Cue = "/VO/Melinoe_1545", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You make it sound like it's a {#Emph}bad {#Prev}thing. All Nyx's kin are welcome here. Headmistress gave her word." },
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 557743 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_2234", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Strictly business between you and Lord Charon, isn't it? Never seen you speak except about his wares. At least you're providing him with Gold." },
				{ Cue = "/VO/Nemesis_0133",
					Text = "You might technically have a brother, but you don't know what it's like having one around. Charon doesn't like to talk; I respect that." },
				{ Cue = "/VO/Melinoe_2235", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sounds like you've been chatting it up yourself! I saw you plunge into a Chaos Gate, as though you knew exactly where it led. Not your first time?" },
				{ Cue = "/VO/Nemesis_0259",
					Portrait = "Portrait_Nemesis_Averted_01",
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
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Max = 8 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0042",
					Text = "Let me guess. The Fates have nothing but a bunch of busywork laid out for you. No grand revelations, just odd jobs." },
				{ Cue = "/VO/Melinoe_1546", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" }
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
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "F_Boss01", "F_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0048",
					Text = "You don't deserve this. Any of this. It's unfair. But you're stuck with it. So the only question is, what are you going to do about it now?" },
				{ Cue = "/VO/Melinoe_3930", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You'll soon find out! Though, how can you be so sure I don't deserve what's happening or that it isn't fair?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
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
					{
						-- PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisGift08" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0050",
					Text = "Don't worry, you didn't miss much while you were out. Lot of standing around, chanting prayers for your victory and protection. How'd those work out for you, by the way?" },
				{ Cue = "/VO/Melinoe_1549", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 10,
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
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0046",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "I always thought... if I could just train harder than you, she'd reconsider. And give the task to me. Worked my ass off. But it didn't matter." },
				{ Cue = "/VO/Melinoe_1547", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					Text = "The hell are you doing talking to me? You get your scrawny ass back {#Emph}out {#Prev}there, and get that Titan! What are you waiting for?" },
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
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0052",
					Text = "Another failed attempt. About ready to give in? You don't have the fire. This isn't personal enough for you." },
				{ Cue = "/VO/Melinoe_1550", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What you said to me before, about my mother. That was very cruel." },
				{ Cue = "/VO/Nemesis_0054",
					Portrait = "Portrait_Nemesis_Averted_01",
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
			NemesisAboutFamily03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift07", "HadesWithPersephoneGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0412",
					Text = "How were they, anyway? Your family. Persephone the Queen, Prince Zagreus, whoever else. He doesn't want this blade back yet, does he?" },

				{ Cue = "/VO/Melinoe_5251", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He hasn't mentioned it, he's... I don't know, I like him quite a bit. Perhaps since I haven't been around him for aeons as with siblings from certain other families I've met. And my mother and father, they're... all that I imagined, I suppose." },

				{ Cue = "/VO/Nemesis_0413",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Right. Probably because your imagination's filling in a lot of blanks. But, least you found them, and it's off to a good start. Not to be taken for granted." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_5252", Text = "Not at all." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If you're referring to the House of Hades, then yes, I did make it there. Though you could best describe it as the House of {#Emph}Chronos{#Prev}, at this point. He was waiting within, just as expected, and... was strong, just as expected, too." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0226",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Come here to gloat, {#Emph}huh. I beat him! I beat the Titan! {#Prev}Well, hardly matters. He's still alive, you realize, don't you?" },
				{ Cue = "/VO/Melinoe_2965", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0252",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Ought to admit it when I'm wrong. Never thought you'd get to Chronos in the first place, before I did anyway. Much less beat him down, repeatedly. So — I was wrong. Sorry." },
				{ Cue = "/VO/Melinoe_3225", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nemesis, I want you to know it was astonishing to hear those words coming from you just now. It seems we're each more than capable of surprising the other. But mainly... thank you." },
				{ Cue = "/VO/Nemesis_0253",
					PreLineAnim = "Nemesis_Hub_Salute",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "No need. Fair is fair. Had my chances to catch up with you, but couldn't get through all the pitfalls in the way. Might be I could have taken Chronos, too. But now I'm not so sure." },
				{ Cue = "/VO/Melinoe_3226", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			NemesisAboutUltimateProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Intro", "I_Intro" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutStormStop01", "HecateAboutStormStop01_B", "HecateAboutChronosBossW04" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0308",
					Text = "Can't kill Chronos, can't kill Typhon, so what now? Keep doing this till somebody gives up? Thought we had a better plan." },
				{ Cue = "/VO/Melinoe_4428", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "The Titan thinks he took the upper hand by awakening that monster. But we'll turn that setback into our gain. Typhon is immensely powerful; a power we can use." },
				{ Cue = "/VO/Nemesis_0309",
					PreLineAnim = "Nemesis_Hub_Salute",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "You really think the Titan would just offer up the key to his own undoing like that? Doesn't sound particularly smart." },
				{ Cue = "/VO/Melinoe_4429", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "The plan was always to exploit what he doesn't know." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0310", Text = "Think he knows a lot more than you." },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Had one of my dreams, Nem. Your mother was there, and my father. He showed concern for her, she... was under the Titan's spell." },

				{ Cue = "/VO/Nemesis_0090",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Mother Nyx made a mistake entrusting Hades with so much of the Underworld. This realm was never his by right, not till the Fates decided otherwise. Mother worked hard. They were probably just trying to send her help." },

				{ Cue = "/VO/Melinoe_0621", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
			-- alt below
			NemesisAboutChronosNightmare02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutChronosNightmare01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutChronosNightmare02_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_0623", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Nemesis, about the dream I had... Chronos, he... demanded that my father tell him where the Fates reside." },
				{ Cue = "/VO/Nemesis_0092",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Smart. Mother Nyx never would have told him. The Fates may be my sisters but even I have no idea where they are. Long as they're hidden, no one can mess with their designs." },
				{ Cue = "/VO/Melinoe_1571", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You don't sound especially concerned that Chronos apparently found the three weavers of destiny and may be forcing their plans for the future." },
				{ Cue = "/VO/Nemesis_0093",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "{#Emph}Really? {#Prev}I ever give you the impression I had any hope this would end well?" },
				{ Cue = "/VO/Melinoe_1572", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How could he have found them? Wouldn't the Fates see the threat coming?" },
				{ Cue = "/VO/Nemesis_0094",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "They're always weaving. That means even they know only so much in advance. Chronos is Time. {#Emph}Time {#Prev}moves faster than expected." },
			},
			NemesisAboutChronosNightmare02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutChronosNightmare01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutChronosNightmare02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_0623", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Nemesis, about the dream I had... Chronos, he... demanded that my father tell him where the Fates reside." },
				{ Cue = "/VO/Nemesis_0092",
					Text = "Smart. Mother Nyx never would have told him. The Fates may be my sisters but even I have no idea where they are. Long as they're hidden, no one can mess with their designs." },
				{ Cue = "/VO/Melinoe_5278", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You don't sound especially concerned that Chronos somehow found the three weavers of destiny and cast them into exile. And can no longer find them." },
				{ Cue = "/VO/Nemesis_0093",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "{#Emph}Really? {#Prev}I ever give you the impression I had any hope this would end well?" },
				{ Cue = "/VO/Melinoe_5279", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How did he do it...? Wouldn't the Fates see the threat coming?" },
				{ Cue = "/VO/Nemesis_0094",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "They're always weaving. That means even they know only so much in advance. Chronos is Time. {#Emph}Time {#Prev}moves faster than expected." },
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift01", "NemesisAboutEvil01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_0613", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nem. You care so much for mortal justice. Where's your passion for ours? Chronos took {#Emph}everything {#Prev}from us! You said we all should get what we deserve, right?" },
				{ Cue = "/VO/Nemesis_0083",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "{#Emph}Khh. {#Prev}Well, that's the thing. If you knew anything about mortals, they had it better once. When Chronos ruled. Called it the {#Emph}Golden Age." },
				{ Cue = "/VO/Melinoe_2749", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "How splendid that must have been for them! If only Chronos could have been so generous with his sons and foster-children. You think him being somewhat nice to some mortals makes up for what he did?" },
				{ Cue = "/VO/Nemesis_0084",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "No. Look. What if... what if this {#Emph}is {#Prev}what we deserve?" },
				{ Cue = "/VO/Melinoe_0615", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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
					Portrait = "Portrait_Nemesis_Averted_01",
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
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "N_Boss01", "N_Boss02" },
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
					Portrait = "Portrait_Nemesis_Averted_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisAboutSurface03" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "N_Boss01", "N_Boss02" },
						Comparison = "<=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0166",
					Text = "You really went up there. They could have called for somebody with experience, but I guess I don't deserve it as much as I thought." },
				{ Cue = "/VO/Melinoe_1575", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm needed there as part of my task. Though, they must miss you on the surface. So much suffering..." },
				{ Cue = "/VO/Nemesis_0167",
					Portrait = "Portrait_Nemesis_Averted_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 8,
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Opening01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Nemesis_0168",
					Text = "You keep heading up when you ought to be heading down, toward your objective. Forget about the mountain. Not your fight." },
				{ Cue = "/VO/Melinoe_0618", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
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
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0619", Text = "Sure I don't." },
					},
				},
			},

			NemesisAboutSurface04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutTyphon01" },
							},
						},
						{
							{
								Path = { "GameState", "RoomsEntered", "Q_Boss01" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_4424", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Why don't I ever see you on the surface, Nem? Surely we have foes deserving your attention there." },
				{ Cue = "/VO/Nemesis_0303",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Death to Chronos is the only task. Won't get caught up in the details like you. Each night you spend up in the mountains, the Titan secures his foothold below." },
				{ Cue = "/VO/Melinoe_4425", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You don't see how Typhon's reemergence complicates matters? He's not exactly the sort of problem one can ignore for long." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0304", Text = "Really? Watch me." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 585573 } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0228",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Eris is back. What did you do? Did you summon her? I saw you talking." },
				{ Cue = "/VO/Melinoe_3099", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're not remotely pleased to see your sister again? I don't have any more control over her than you do. Headmistress still is giving her the silent treatment, though." },
				{ Cue = "/VO/Nemesis_0229",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Ideally, Eris should be somewhere very far from here. Good thing this place is impossible to find, otherwise I'd half expect she would have led Chronos straight to us by now." },
				{ Cue = "/VO/Melinoe_3100", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3102", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3220", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Isn't there something you can do to talk some sense into Eris? Get her out of my blasted way to Olympus. Or failing that, pin her in an arm bar or leg lock, perhaps?" },
				{ Cue = "/VO/Nemesis_0247",
					Text = "Won't waste my time with her at all, though the arm bar or leg lock do have a certain appeal. Not seen her flying through the Underworld lately, have you." },
				{ Cue = "/VO/Melinoe_3221", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 585573 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0244",
					Text = "Showed Eris didn't you. Could hear her crying practically from here. Been far too long since last I kicked her ass myself. At least {#Emph}somebody{#Prev}'s picked up the slack." },
				{ Cue = "/VO/Melinoe_3218", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			NemesisAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisBathHouse03", "DemeterFirstPickUp" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_5260", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Has anyone ever told you you look a bit like your mother, Nemesis? Having met her I can see the resemblance. In fact, when I first saw her, I... well, anyway." },

				{ Cue = "/VO/Nemesis_0425",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "No, finish that thought. When you first saw her, you what?" },

				{ Cue = "/VO/Melinoe_5261", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm{#Prev}, when I first saw her, I... look, I was taken aback by her appearance! In a positive way. She was like if you wore an elegant gown, and gave your brow muscles a rest." },

				{ Cue = "/VO/Nemesis_0426",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Was your idea of a compliment. Nobody wants to look like their mother. Don't look anything like mine anyway. Except maybe the hair." },

				{ Cue = "/VO/Melinoe_5262", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lady Demeter said I look just like my mother, which I thought was very kind of her! Queen Persephone is striking." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0427", Text = "Think she and Nyx get on as well as we do?" },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5263", Text = "They couldn't possibly." },
					},
				},
			},
			NemesisAboutNyx02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Nyx_Story_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0423",
					Text = "Ran into Nyx last night. So whenever she's had her fill of being around Hades and Persephone, she goes off to Chaos for a little quiet time. I can see the appeal." },

				{ Cue = "/VO/Melinoe_5258", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She's not doing it to get away from my parents! With all that the Underworld's gone through, don't you think Night and Chaos might have a lot to discuss?" },

				{ Cue = "/VO/Nemesis_0424",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Sure. Trying to imagine what they even talk about. {#Emph}It continues to be very dark here, Chaos. Yes, it does, Nyx." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5259", Text = "{#Emph}<Laugh> {#Prev}Sorry." },
					},
				},
			},

			NemesisAboutNyxRescue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift06", "NyxWithNemesis01", "HadesWithPersephoneGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_5255", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How has it been having your mother back? I'm still growing accustomed to the part where my own birthmother is in my life, even if I may not see her every night." },

				{ Cue = "/VO/Nemesis_0421",
					Text = "Doubt Mother Nyx will be coming around much either. Never did. But she was never really gone. Night's been around since before Time. Nobody messes with her." },

				{ Cue = "/VO/Melinoe_5256", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Speaking of that, sounds like you have free rein to dole out Retribution once again, not that you weren't doling it out before. No need to keep pursuing Chronos now!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0422", Text = "Oh I'm not finished there." },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5257", Text = "Somehow I'm not surprised!" },
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithHecate02" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Melinoe_1552", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So, just how much trouble are you in for mouthing off to Headmistress, Nem? That was utterly disrespectful, even for you." },
				{ Cue = "/VO/Nemesis_0057",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "{#Emph}Heh! {#Prev}Well, looks like I've got a lot more guard duty ahead of me. But it was worth it. Help balance out you sucking up to her all the time." },
				{ Cue = "/VO/Melinoe_1553", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithHecate02" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Melinoe_1554", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Was it always like this, between you and Headmistress? I used to think it was {#Emph}me {#Prev}you hated most of all." },
				{ Cue = "/VO/Nemesis_0059",
					Text = "You've always been naive, Princess. As for Hecate, I liked her better before she decided {#Emph}this {#Prev}right here was the best use of my talents." },
				{ Cue = "/VO/Melinoe_1555", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She made that decision long ago. So you're going to resent her forever? Or are you going to do something about it?" },
				{ Cue = "/VO/Nemesis_0060",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					-- Portrait = "Portrait_Nemesis_Averted_01",
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
						IsAny = { "F_Boss01", "F_Boss02" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Boss01" },
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
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithHecate02" },
					},
				},
				{ Cue = "/VO/Nemesis_0137",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Next time you got something to say about me, you come say it to my face. Know you witches would much rather sneak around, though." },
				{ Cue = "/VO/Melinoe_2236", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What are you even talking about? I think you're being accusatory and abrasive. There! I said {#Emph}that {#Prev}to your face." },
				{ Cue = "/VO/Nemesis_0138",
					-- Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Odysseus tried giving me one of his talks. Telling me you didn't go complaining to him?" },
				{ Cue = "/VO/Melinoe_2237", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 561502 }, Alive = false },
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
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "NemesisGift08", "ArtemisGift08" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,
				{ Cue = "/VO/Melinoe_2242", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Have you met Artemis out there? I suppose it may be worth repeatedly disobeying orders for the chance to see her." },
				{ Cue = "/VO/Nemesis_0143",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "What would you know of it. You really think I'm sneaking out into those woods just to fool around?" },
				{ Cue = "/VO/Melinoe_2243", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			NemesisAboutArtemisSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0342",
					Text = "Singing, {#Emph}eugh. {#Prev}The goddess of the hunt apparently is looking for her brother's job. Surprised you're not still over there yourself. Something else you could be practicing." },
				{ Cue = "/VO/Melinoe_4460", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It may seem frivolous though we don't sing merely for lack of things to do here, Nemesis. It has a cleansing quality." },
				{ Cue = "/VO/Nemesis_0343",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Oh, right. Artemis told me all about what you mean when you talk about cleansing. Least I'm just about out of earshot over here." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4461", Text = "We'll have to sing louder for you." },
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
						PathTrue = { "GameState", "TextLinesRecord", "HypnosGift01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0065",
					Text = "Been talking to Hypnos again? He can't hear you, you know. Kind of what happens when somebody's fast asleep." },
				{ Cue = "/VO/Melinoe_0686", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sleep is not as simple as you make it out to be. I think he can sense my words and intentions." },
				{ Cue = "/VO/Nemesis_0066",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Sensing words and intentions, yeah... sounds exactly like the Hypnos I knew." },
			},
			NemesisAboutHypnosWakeUp01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0455",
					Text = "Can't believe it! You finally woke Hypnos up, and {#Emph}I {#Prev}slept through the whole thing? He everything you dreamed of?" },
				{ Cue = "/VO/Melinoe_5276", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, {#Emph}erm... {#Prev}his manner wasn't what I expected, and he was not especially appreciative. Although I too am prone to moodiness after sleeping in. Then, he left in a hurry..." },
				{ Cue = "/VO/Nemesis_0456",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Tough break I guess! Always thought he really was your type. Well if you do end up working in your father's House, you'll meet again. For now, least we don't have to listen to him snoring {#Emph}every single night." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5277", Text = "I do suppose there's that..." },
					},
				},
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
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Narcissus_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_2238", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Why all the rancor toward Narcissus, by the way? I see how he could be a little irritating, but he doesn't seem all that bad." },
				{ Cue = "/VO/Nemesis_0140",
					Text = "Should have seen what he did to this poor Nymph. Absolutely broke her heart. Didn't even notice, or care." },
				{ Cue = "/VO/Melinoe_2239", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Didn't take you for the sentimental type. I thought you concerned yourself with worse than lovers' quarrels." },
				{ Cue = "/VO/Nemesis_0141",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Narcissus cared only for himself, not for anyone around him. Had to make an example of him. He wound up madly in love. With his own reflection. Till the day he died." },
				{ Cue = "/VO/Melinoe_2240", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So now he's a Shade in the Underworld. And still staring longingly into his own eyes." },
				{ Cue = "/VO/Nemesis_0142",
					Text = "Hey, you're the witch, not me. You know how it is with curses." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisAboutNarcissus01", "NarcissusWithEcho01" },
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

			NemesisAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutPrometheus01", "MorosAboutPrometheus01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0262",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Got yet another Titan up against us, huh? {#Emph}Prometheus! {#Prev}One of the smart ones, so they say. And now, an enemy. Could have been on our side had your family not... you know." },
				{ Cue = "/VO/Melinoe_3604", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Yes, the whole {#Emph}chain-him-to-a-mountain-so-an-eagle-could- eat-his-regenerating-liver-for-aeons {#Prev}thing. Not one of the proudest moments on Olympus, I have to imagine." },
				{ Cue = "/VO/Nemesis_0263",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Come ask me whether he deserves his vengeance if ever you want to feel any worse about that whole mess." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3605", Text = "Watch with the treason, Nem." },
					},
				},
			},
			NemesisAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0264",
					Text = "So now Olympus has to deal with Typhon, huh? Wonder if Chronos made a deal with him or just revived and set him loose. Either way, plan like that takes a lot of guts." },
				{ Cue = "/VO/Melinoe_3927", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You sound rather impressed! I'm certain Chronos would welcome you into his ranks as well if you just tell him how you really feel." },
				{ Cue = "/VO/Nemesis_0265",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Hit a nerve? Fine. Doesn't change the fact our enemy outsmarted us. So, no need to keep wasting your time up top... wait, you're not going to try and {#Emph}fight {#Prev}that thing, are you?" },
				{ Cue = "/VO/Melinoe_3928", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You really think I'm going to leave my family on Olympus to face that monster on their own? You don't know me at all." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0266", Text = "Nice knowing you, anyway." },
					},
					{
						PreLineWait = 0.1,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3929", Text = "A real pleasure." },
					},
				},
			},

			NemesisAboutTyphonW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0300",
					Text = "Must have got a lot of help, knocking Typhon from his perch. Oh, we all heard. You got a dozen family members all up there, some of them strong. So what do they need you for?" },
				{ Cue = "/VO/Melinoe_4422", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They certainly are capable, but they're backed into a corner on Olympus. What matters is our latest battle was victorious, and I did what I could to see it through." },
				{ Cue = "/VO/Nemesis_0301",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Sharing in your success, or just trying to appease me? Main reason you won is that monster had it coming anyway. But, it'll all even out." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4423", Text = "What's that supposed to mean?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0302", Text = "You'll see." },
					},

				},
			},
			NemesisAboutTyphonW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0305",
					Text = "Really must be making Typhon mad. What's the plan there besides that? Get so caught up in all the glory that you lose sight of our real enemy?" },
				{ Cue = "/VO/Melinoe_4426", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The Father of All Monsters represents an urgent threat; you'd know it if you saw him for yourself. If Olympus is laid to ruin, Chronos prevails. We wouldn't be able to stop him." },
				{ Cue = "/VO/Nemesis_0306",
					Portrait = "Portrait_Nemesis_Averted_01",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Speak for yourself. The Underworld never needed any of those gods. Chronos wouldn't even be here if not for them." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4427", Text = "Thank the Fates we have you to deal with him." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0307", Text = "Thank the Fates." },
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						-- it's ok
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_1564", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nemesis, for all the time you used to spend on the surface... surely there was something there that made it worth your while?" },

				{ Cue = "/VO/Nemesis_0072",
					Text = "Oh, {#Emph}there was. {#Prev}Mortals like to reach beyond their means, thinking they're just like us. I'd sniff them out, and put them back in their place." },

				{ Cue = "/VO/Melinoe_1565", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Put them back in their place... by punishing them in some inventive fashion, I suppose?" },

				{ Cue = "/VO/Nemesis_0073",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "That's right. We all should get what we deserve, no more, no less." },

				{ Cue = "/VO/Melinoe_0608", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
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
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_0680", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey. You miss being up there, don't you? Among the mortals and all that." },

				{ Cue = "/VO/Nemesis_0075",
					Text = "You know, mortals have a word for deliberate cruelty or callous negligence: They call it evil. I could always catch wind of it. I'd go to the source. And whoever it was, I'd make them pay." },
					
				{ Cue = "/VO/Melinoe_1566", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
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
						CountOf =
						{
							"HecateGift01",
							"DoraGift01",
							"OdysseusGift01",
							"MorosGift01",
							"ErisGift01",
							"SkellyGift01",
						},
						Comparison = ">=",
						Value = 2,
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
					Text = "{#Emph}Deserves? {#Prev}And I suppose you think {#Emph}you're {#Prev}fit to be the judge of that?" },
				{ Cue = "/VO/Nemesis_0079",
					Emote = "PortraitEmoteFiredUp",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Yeah. Who do you think I {#Emph}am? {#Prev}If everybody just magickally got what they deserved, I'd have no reason to exist." },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I didn't mean to make you uncomfortable, with the Nectar from before. It's just, I've always looked up to you, and... I'm doing the best I can." },
				{ Cue = "/VO/Nemesis_0100",
					PreLineWait = 0.35,
					Portrait = "Portrait_Nemesis_Averted_01",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Don't sweat it. Had myself a little drink the other night, and it didn't poison me as far as I know. So we're clear." },
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 3.5 },

					Text = "It's fortunate we have you vigilantly keeping watch here, Nemesis...! Oh come on, drop the act. What happened, when did you return?" },

				{ Cue = "/VO/Nemesis_0127",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Don't know what you're talking about, and it's not your business anyway. Fates help you on your {#Emph}task." },

				{ Cue = "/VO/Melinoe_2230", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_2231", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Does Headmistress know yet of your little excursions? Not much escapes her notice, last I checked." },
				{ Cue = "/VO/Nemesis_0129",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Strongly advise you mind your own responsibilities. Hecate doesn't control me, and {#Emph}you {#Prev}should show a little gratitude." },
				{ Cue = "/VO/Melinoe_2232", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithHecate02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_3230", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The first few times I saw you out there, I figured you were just venting your anger. But you keep heading out night after night. You're determined, but you're going to get caught." },

				{ Cue = "/VO/Nemesis_0260",
					Text = "Not if no one says anything. Besides, Hecate likely already knows. She isn't dense. Just letting me learn whatever she thinks I stand to learn the hard way. Works out for both of us." },

				{ Cue = "/VO/Melinoe_3231", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",

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
						IsAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" }, 
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0131",
					Text = "Got careless. All because of a little wager. You want to show me up that bad?" },
				{ Cue = "/VO/Melinoe_2233", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			NemesisAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TraitRarityCache", "DeathVengeanceKeepsake" },
						IsAny = { "Epic", "Heroic" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0344",
					Text = "Getting some use out of that Evil Eye. Anything or anyone out there force you to call it a night early, next night you go do the same to them. Old tradition, but it works." },
				{ Cue = "/VO/Melinoe_4462", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Appreciate the gift. The Eye has certainly been instrumental in some cases where I got the better of my foes. Though whether I'm delivering retribution or merely taking vengeance, I'm not always sure." },
				{ Cue = "/VO/Nemesis_0345",
					Text = "Sorting out each act of vengeance does take a while. But don't sweat the technicalities too much. You're clear." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4463", Text = "Every act of vengeance gets sorted out?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0346", Text = "They're supposed to be." },
					},

				},
			},

			NemesisAboutTrophyQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0347",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "You're more conceited than Narcissus. Saw those statues of you in the Training Grounds. You'll have to work a whole lot harder to look like that." },
				{ Cue = "/VO/Melinoe_4464", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, I... I had nothing to do with those. Well, I did earn them, they're the Gifts of the Veil bestowed upon Night's Champion...! Oh, that does sound quite conceited..." },
				{ Cue = "/VO/Nemesis_0348",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Don't sweat it. They're something all right. Always said you'd never be bigger than me. That's what I get." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4465", Text = "Retribution..." },
					},
				},
			},

			NemesisAboutThrone01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_NemesisChair" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0339",
					Text = "What's with that throne conspicuously near my post. Just a temptation. Never once seen {#Emph}you {#Prev}sit down on the job; you ever seen me?" },
				{ Cue = "/VO/Melinoe_4458", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, it's just... I thought perhaps you'd like the option there at least. Nothing in excess, right? And you {#Emph}do {#Prev}have to stand an awful lot." },
				{ Cue = "/VO/Nemesis_0340",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "My rules, not yours. I start sitting down, won't want to get back up. Especially wearing all {#Emph}this. {#Prev}Besides, half the point of guard duty is having to stay standing {#Emph}the whole time." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4459", Text = "The throne could go away if you prefer." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0341", Text = "Just leave it there for now." },
					},
				},
			},

			NemesisAboutRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "NemesisPostCombatBecomingCloser01", },
						IsAny = { "Choice_NemesisAccept" },
					},
					{
						SumPrevRuns = 6,
						Path = { "TextLinesRecord", "NemesisPostCombatBecomingCloser01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_4447", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "When we were together out there, it seems almost like a dream. Especially since it was rather unlike either one of us to have set all our responsibilities aside that way..." },

				{ Cue = "/VO/Nemesis_0327",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "You're saying you regret it, fine; I don't. Not like we've made a habit of it, and besides... got you out of my head, just as I wanted." },

				{ Cue = "/VO/Melinoe_4448", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You did? That isn't how it worked for me at all. I've only thought about you {#Emph}more {#Prev}since then. And I do {#Emph}not {#Prev}regret it!" },

				{ Cue = "/VO/Nemesis_0328",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "No? Well, that's Retribution for you. Some win, some lose, nobody gets it all. Though maybe over time, we can... even things out. Shouldn't be one-sided between us." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4449", Text = "I'll hold you to that." },
					},
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0329", Text = "Same." },
					},
				},
			},
			NemesisAboutRelationship01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "NemesisPostCombatBecomingCloser01", },
						IsAny = { "Choice_NemesisDecline" },
					},
					{
						SumPrevRuns = 6,
						Path = { "TextLinesRecord", "NemesisPostCombatBecomingCloser01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_4450", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "When we were together out there, Nem... I wanted to make sure you weren't angry with me. No more than usual at least. You said I was distracting you and that's not what I want." },

				{ Cue = "/VO/Nemesis_0330",
					PreLineWait = 0.35,
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "I know, it's fine, we're good. Unless you keep making too big a deal. I think we get each other now, and we both like it when we're sure. Anyway, be seeing you out there." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4451", Text = "Be seeing you." },
					},
				},
			},

			NemesisAboutRelationship02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord" },
						HasAny = { "NemesisPostCombatBecomingCloser01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisAboutRelationship01", "NemesisAboutRelationship01_B", "NemesisPostCombatBecomingCloser01" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0331",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "When did it start. You couldn't even stand looking at me. Couldn't stand your scrawny ass either. Then something happened. Trying to pinpoint it." },

				{ Cue = "/VO/Melinoe_4452", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My feelings for you gradually strengthened over time. The anger you brought out in me... I started to like it. I just never thought you would reciprocate." },

				{ Cue = "/VO/Nemesis_0332",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Took you for a showoff. Never realized how strong you are, and not just physically. And you don't overdo it anymore." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4453", Text = "That was a compliment." },
					},
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0333", Text = "Yeah." },
					},
				},
			},

			NemesisAboutRelationship03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutRelationship02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisAboutRelationship02" }, Min = 5 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_4471", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know I can read you sometimes, Nem, and something's wrong, so what is it? If you don't mind telling me..." },

				{ Cue = "/VO/Nemesis_0397",
					PreLineAnim = "Nemesis_Hub_Greet",
					PreLineWait = 0.35,
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "{#Emph}Eugh{#Prev}, it's... look, I've not been close with anyone for very long. Just how it goes. So, been wondering where things are going with us, and not liking where it leads." },

				{ Cue = "/VO/Melinoe_4472", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You truly think we're on some fixed path? The Fates may be your sisters but you needn't {#Emph}all {#Prev}be caught up in self-fulfilling prophecies." },

				{ Cue = "/VO/Nemesis_0398",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "No, but... problem I'm having is I'm starting to like being around you more than not. If it keeps on that way, I'll be..." },

				{ Cue = "/VO/Melinoe_4473", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...I know. Too much of a good thing. But, must we concern ourselves about the future constantly? We could just appreciate being together when we can. No pressure." },

				{ Cue = "/VO/Nemesis_0399",
					PreLineWait = 0.4,
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "...No pressure, huh... maybe you're right. Could always find a way to balance it out without messing it up." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4474", Text = "A worthwhile pursuit." },
					},
				},
			},

			NemesisAboutErisRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAll = { "ErisAboutRelationship03", "NemesisAboutRelationship01", },
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "ErisAboutRelationship03", "NemesisAboutRelationship01" }, Min = 2 },
							},
						},
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAll = { "ErisAboutRelationship03_B", "NemesisAboutRelationship01_B", },
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "ErisAboutRelationship03_B", "NemesisAboutRelationship01_B" }, Min = 2 },
							},
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0334",
					Text = "What's with you and Eris, anyway? Thought you'd have the sense to stay away from her, least when you have a choice." },

				{ Cue = "/VO/Melinoe_4454", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I may lack proper judgment when it comes to choosing comrades, Nemesis. She and I have little in common, but... she makes it difficult to be completely rational." },

				{ Cue = "/VO/Nemesis_0335",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Well, you'll get what's coming to you when it comes to her. Or me, for that matter but in a different way. Maybe that's the appeal. Anyway, just don't go bringing her around." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4455", Text = "Wasn't planning on it." },
					},
				},
			},

			NemesisAboutMorosRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisBathHouse03", "MorosTaverna02", },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisBathHouse03", "MorosTaverna02" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0336",
					Text = "Makes sense you and Doom would get along. First I figured he'd put you off like everybody else, but you both like following orders so much. Means you have a lot in common." },

				{ Cue = "/VO/Melinoe_4456", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I don't believe we've had a single conversation about how much we love following orders, though we do get on, I think. It doesn't trouble you, does it? You'd tell me if it did." },

				{ Cue = "/VO/Nemesis_0337",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "I'd tell you if it did. Moros never was a happy sort, not that any of us really are; but when he's better off, it probably bodes well for everyone else. Given his connections and all." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4457", Text = "Has he seemed happier to you?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0338", Text = "Maybe just me." },
					},
				},
			},

			NemesisAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0400",
					Text = "They're saying you got rid of Typhon for good. Don't believe a word of it. What really happened up there?" },

				{ Cue = "/VO/Melinoe_5006", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Got rid of Typhon for good is a concise way to put it. Involved a rather complex incantation called {#Emph}Disintegration of Monstrosity {#Prev}and some other details best left unspoken. But yes, I do believe he's gone." },

				{ Cue = "/VO/Nemesis_0401",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "He's immortal... he can't just {#Emph}be {#Prev}gone, and if he is, why not just do the same to Chronos? Or to anybody who stays on your bad side long enough?" },

				{ Cue = "/VO/Melinoe_5007", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We've something else in store for Chronos. As for everybody else, they haven't crossed me quite as much just yet." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0402", Text = "Yet? {#Emph}Huh." },
					},
				},
			},
			NemesisAboutHecateKidnapped01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_5008", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Do you know Headmistress is gone? Chronos took her right before my eyes! If you were on watch like you ought have been, she... {#Emph}augh!" },

				{ Cue = "/VO/Nemesis_0403",
					Text = "What are you talking about, {#Emph}Chronos took her. {#Prev}Saw her just the other night. Though, where is she...?" },

				{ Cue = "/VO/Melinoe_5009", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01", PostLineAnimTarget = "Hero",
					Text = "{#Emph}I just said! {#Prev}She's probably there in the House somewhere with the rest, but I... I've not been able to locate her yet. How could this happen, what could we have done?" },

				{ Cue = "/VO/Nemesis_0404",
					AngleTowardHero = true,
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "You're serious. Wait, why didn't you {#Emph}do {#Prev}something about it if you saw the whole thing? {#Emph}I {#Prev}wasn't even there!" },

				{ Cue = "/VO/Melinoe_5010", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I was too late! What's your excuse? You could have at least identified the possibility of such a threat!" },

				{ Cue = "/VO/Nemesis_0405",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Not even all-seeing Selene saw it coming, how could {#Emph}I? {#Prev}Although... keep this quiet. Get her back, or I will." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_5011", Text = "{#Emph}I {#Prev}will." },
				},
			},

			NemesisPostTrueEnding01 =
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
						PathTrue = { "CurrentRun", "TextLinesRecord", "TrueEndingFinale01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0407",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Finally back from your father's House. Was Hecate all right? After the Titan got her, I... ought to have taken guard duty more seriously, and... won't soon forgive myself, is all." },

				{ Cue = "/VO/Melinoe_5012", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress would only want for you to learn from it. I half-wonder if she let herself be taken just to get closer to our mark. Perhaps go speak with her...?" },

				{ Cue = "/VO/Nemesis_0408",
					Text = "Yeah. And what of Chronos, heard he isn't really dead and gone. How come everybody's cheering for you then?" },

				{ Cue = "/VO/Melinoe_5013", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He's dead and gone in the sense that we have neutralized the threat he posed. I now shall have to grow accustomed to having him as a grandfather, rather than a hated foe." },

				{ Cue = "/VO/Nemesis_0409",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Don't see why he can't be both. This was never part of the task, and not like you to stray from the objective. We sure this supposedly-neutralized Titan of Time is to be trusted?" },

				{ Cue = "/VO/Melinoe_5763", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 2.6 },
					Text = "Headmistress sealed his strongest powers just in case. At any rate... we did it, Nem!" },

				{ Cue = "/VO/Nemesis_0410",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Then how come you look like you're headed out again? Heard there's still more Time-related business to sort out." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5015", Text = "Well, yes, but..." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0411", Text = "Then we're {#Emph}not {#Prev}done." },
					},
				},
			},
			NemesisPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {
							"NeoChronosAboutTartarus01",
							"NeoChronosAboutTartarus01_B",
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {
							"NeoChronosAboutOlympus01",
							"NeoChronosAboutOlympus01_B",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0414",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "So you're still fighting Chronos, and you're still fighting Typhon... though, not just a matter of where, but a matter of {#Emph}when{#Prev}. Something like that?" },

				{ Cue = "/VO/Melinoe_5253", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Something like that. {#Emph}Our {#Prev}Chronos, who had let's say a spiritual awakening of sorts, is seeing to it that {#Emph}time flows freely forth{#Prev}, to use his expression. We wish to prevent even the possibility of what happened before." },

				{ Cue = "/VO/Nemesis_0415",
					PreLineWait = 0.35,
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "...I don't get it. What happened before happened {#Emph}already. {#Prev}Time is a simple concept; keeps everything moving forward for {#Emph}everybody {#Prev}at the {#Emph}same exact rate." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5254", Text = "There may be more to it than that, apparently." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						PreLineAnim = "Nemesis_Hub_Greet",
						{ Cue = "/VO/Nemesis_0416", Text = "Everything's gotten so complicated..." },
					},
				},
			},
			NemesisPostTrueEnding03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisWithHecate02" },
					},
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = {
							"NemesisCombatF",
							"NemesisCombatG",
							"NemesisCombatH",
							"NemesisCombatI",
							"NemesisRandomEvent",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_5273", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Still sticking to the Underworld even with the task complete? There must be lots of catching up to do on the surface." },

				{ Cue = "/VO/Nemesis_0453",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Hecate says conditions have to be {#Emph}just right {#Prev}for whatever it is you're trying to do now. Wouldn't want to throw anything off." },

				{ Cue = "/VO/Melinoe_5274", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Appreciate the help. It's just I thought you missed being up there, and mortalkind must miss you, too. A lot of undeservedness to be addressed." },

				{ Cue = "/VO/Nemesis_0454",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Keenly aware, thanks. I'll get back to it after the Underworld's in a better spot. Besides, I think your family's paying close attention to what's going on up there." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5275", Text = "They probably are." },
					},
				},
			},

			NemesisPostTrueEndingTimeStopped01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {
							"ZeusPalacePostTrueEnding01",
							"NeoChronosAboutOlympus02",
							"NemesisPostTrueEnding02",
							"NemesisPostCombatPostTrueEnding01",
							"NemesisPostCombatAboutTartarus03",
							"NemesisWithHecate02",
							"NeoChronosWithNemesis01",
							-- "NemesisBathHouse03",
						},
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisPostCombatPostTrueEnding01" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0444",
					Text = "Heard you snuffed another Typhon out last night. Well done, Princess. Things are handled in the Underworld, too, when it comes to {#Emph}time flowing freely forth {#Prev}and all that." },

				{ Cue = "/VO/Melinoe_5445", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Things are handled in the Underworld, {#Emph}how? {#Prev}Wait, you've been speaking with Grandfather Chronos, haven't you? Which means... no..." },

				{ Cue = "/VO/Nemesis_0445",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Your grandfather did what you never could, and got me in the House of Hades. A remnant one of them, containing the old Chronos we were after all along. And I got him." },

				{ Cue = "/VO/Melinoe_5265", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You {#Emph}got {#Prev}him? Vanquished Chronos on your very first attempt? Impossible... even if you did prevail you'd most likely end up trapped for all eternity in a temporal rift..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.39,
						ObjectType = "NPC_Nemesis_01",
						PreLineAnim = "Nemesis_Hub_Greet",
						{ Cue = "/VO/Nemesis_0446", Text = "Go ask your grandfather yourself sometime." },
					},
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5266", Text = "You're serious...!" },
					},
				},
			},
			NemesisPostTrueEndingTimeStopped02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {
							"NemesisPostTrueEndingTimeStopped01",
							"NeoChronosAboutNemesis01",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Melinoe_5267", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You really did eliminate one of the Chronos remnants, Grandfather confirmed. That's... {#Emph}amazing{#Prev}, Nemesis. So then, if I focus my efforts on the Typhon remnants on Olympus..." },

				{ Cue = "/VO/Nemesis_0447",
					Text = "...I can deal with the Chronos remnants in the Underworld. Was planning on keeping that up no matter what. Hecate even gave me the all-clear." },

				{ Cue = "/VO/Melinoe_5268", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Just, unbelievable. Though I still do reserve the right to deal with Chronos remnants on my own. If nothing else, that route gives me an opportunity to see my family." },

				{ Cue = "/VO/Nemesis_0448",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Knock yourself out. I get the impression there are more than enough of those {#Emph}potential Chronos remnants {#Prev}out there for the both of us." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5269", Text = "Well let's go get them." },
					},
					{
						PreLineWait = 0.36,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0449", Text = "Let's." },
					},
				},
			},

			NemesisPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0450",
					Text = "Heard you found the Three Fates. Don't believe that's how it happened. Probably weren't even looking. They found {#Emph}you." },

				{ Cue = "/VO/Melinoe_5270", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That is a distinct possibility. Perhaps when Chronos thought he sent them into exile, they merely played along. And now decided to check in after the troubles with him passed." },

				{ Cue = "/VO/Nemesis_0451",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Sure sounds like something they'd do. But no use speculating, right? And what now, we're all back to having no will of our own? Maybe we never did." },

				{ Cue = "/VO/Melinoe_5271", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps they don't want us to be certain either way. Nor do they seem to desire all the credit for the actions we take." },

				{ Cue = "/VO/Nemesis_0452",
					Text = "Guess we'd better act like we have everything under control." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_5272", Text = "What else can we do?" },
					},
				},
			},

			-- partner conversations
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

			NyxWithNemesis01 =
			{
				Partner = "NPC_Nyx_Story_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
			},

			NeoChronosWithNemesis01 =
			{
				PlayOnce = true,
				Partner = "NPC_Chronos_02",
				StatusAnimation = false,
				CopyDataFromPartner = true,
			},

			NemesisWithHypnos01 =
			{
				Partner = "NPC_Hypnos_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift01", "HypnosGift01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},

					-- @ true ending
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
				{ Cue = "/VO/Hypnos_0006_C", Portrait = "Portrait_Hypnos_Sleeping_01", Speaker = "NPC_Hypnos_01",
					-- Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Zzzzz, zzzz{#Prev}..." },
				{ Cue = "/VO/Nemesis_0067",
					PreLineWait = 0.35,
					Text = "Look at him, all peaceful. Not a care in the world. Could you imagine?" },
				{ Cue = "/VO/Melinoe_0681", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He's beautiful. He has this wisdom about him, even asleep. Nyx must have taught you all so much." },
				{ Cue = "/VO/Nemesis_0068",
					Text = "Not really. Hypnos served in the House of Hades under Mother's care. Ran into him now and then, though. He ever wakes up, hope I can be there when you finally meet." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0682_B", Text = "Thank you, Nem..." },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					PreLineAnim = "Hecate_Hub_Stern_Start", PreLineAnimTarget = 556921,
					PostLineAnim = "Hecate_Hub_Stern_End", PostLineAnimTarget = 556921,
					Text = "Best watch your mouth or I shall seal it shut! You may continue dwelling on a past you were not witness to, or you may do what is expected of Nyx's daughters. Or whatever Eris is up to! Your choice." },

				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Nemesis_01",
					{ Cue = "/VO/Nemesis_0056", Text = "{#Emph}<Sigh>", PreLineAnim = "Nemesis_Hub_Glare_End",
					},
				},
			},
			NemesisWithHecate02 =
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisAboutFieldMeeting03", "NemesisPostCombatPostTrueEnding01" }
					},
				},
				StatusAnimation = false,
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 556921,
				InteractDistance = 450,

				{ Cue = "/VO/Hecate_0868",
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "...Insubordination, dereliction of duty, falsehood, intimidation, obstinance, simply setting a negative example for the Shades... anything else, would you say?" },

				{ Cue = "/VO/Nemesis_0417",
					PreLineWait = 0.35,
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "...Indulgence, callousness, negligence. Hecate, I... Headmistress, I accept your judgment, and I have no excuses for my deeds." },

				{ Cue = "/VO/Hecate_0869",
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "Hecate_Hub_Scoff", PreLineAnimTarget = 556921,
					Text = "Well thank the Fates that you would spare me that, at least. Now then, with Nyx returned I ought petition her to take you back. Surely the House of Hades could use another hand?" },

				{ Cue = "/VO/Nemesis_0418",
					Portrait = "Portrait_Nemesis_Averted_01",
					PreLineWait = 0.35,
					Text = "...Don't. You know as well as I my place is here. But I'm Retribution Incarnate... I'm not here only to stand guard." },

				{ Cue = "/VO/Hecate_0870",
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "HecateHubGreet", PreLineAnimTarget = 556921,
					Text = "Clearly. Much retribution is to come, both above and below in these changing times... and you shall administer it in accordance with Night's will, when and wheresoever you see fit." },

				{ Cue = "/VO/Nemesis_0419",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Retribution whenever and wherever I see fit... you're letting me proceed? What have I done to deserve that?" },

				{ Cue = "/VO/Hecate_0871",
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "Hecate_Hub_Stern_Start", PreLineAnimTarget = 556921,
					PostLineAnim = "Hecate_Hub_Stern_End", PostLineAnimTarget = 556921,
					Text = "Nemesis, you hold such answers, not I. Now go, and see to our collective charge that time flows freely forth." },

				EndVoiceLines =
				{
					PreLineWait = 0.46,
					ObjectType = "NPC_Nemesis_01",
					{ Cue = "/VO/Nemesis_0420", Text = "...Consider it done, Headmistress." },
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisWithMoros01" }, Min = 6 },
					},
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
						HasAll = { "NemesisGift08", "MorosGift08" }
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
					Portrait = "Portrait_Nemesis_Averted_01",
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
					Portrait = "Portrait_Nemesis_Averted_01",
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
					Text = "...No. One last thing, Eris. Hecate might have promised Mother she'd look after you, but I did no such thing. So get out of here before I get upset." },
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisWithEris01" }, Min = 5 },
					},
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

			NemesisWithIcarus01 =
			{
				Partner = "NPC_Icarus_01",
				PartnerVariant = "IcarusHome",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- StatusAnimation = false,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift09", "NemesisGift09" }
					},
				},
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 743557,
				TeleportOffsetY = 50,
				InteractDistance = 450,

				{ Cue = "/VO/Nemesis_0437",
					PreLineWait = 0.35,
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "...I know these things, kid. As mortal lives go, yours was in one of the bottom categories. A lot shorter and more miserable than average. So you're making up for it a bit." },

				{ Cue = "/VO/Icarus_0478",
					PreLineWait = 0.15,
					Portrait = "Portrait_Icarus_Unsure_01", Speaker = "NPC_Icarus_01",
					PreLineAnim = "Icarus_Pensive_Start", PreLineAnimTarget = 800098,
					PostLineAnim = "Icarus_Pensive_End", PostLineAnimTarget = 800098,
					Text = "{#Emph}Erm{#Prev}, so you're saying, Goddess, that I'm to have a better life after death because my life {#Emph}before {#Prev}death was in {#Emph}one of the bottom categories {#Prev}according to some ranking system that you have... hey?" },

				{ Cue = "/VO/Nemesis_0438",
					-- PreLineAnim = "Moros_Perplexed_End",
					Text = "That's right. Don't waste it, don't get greedy, you'll be fine. Just keep doing what you're doing." },

				{ Cue = "/VO/Icarus_0479",
					Portrait = "Portrait_Icarus_Default_01", Speaker = "NPC_Icarus_01",
					PreLineAnim = "Icarus_Flustered_Start", PreLineAnimTarget = 800098,
					PostLineAnim = "Icarus_Flustered_End", PostLineAnimTarget = 800098,
					Text = "But... I'm so fortunate to be here with you all. A short life in exchange for a good eternity, by your reasoning that isn't a fair trade. What have I done to deserve {#Emph}this...?" },

				{ Cue = "/VO/Nemesis_0439",
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "You haven't asked too many questions, for one thing. And don't take eternity for granted." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Icarus_01",

						{ Cue = "/VO/Icarus_0480", Text = "I won't. I swear." },
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
						PathFalse = { "GameState", "TextLinesRecord", "NemesisBathHouse03" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 556921 }, },
					},
				},
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nemesis",
				{ Cue = "/VO/Nemesis_0020",
					Text = "Go cry to your Headmistress Hecate. She's right there." },
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
						Path = { "CurrentRun", "RoomCountCache" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
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
						HasAny = { "I_Intro", "Q_Intro" },
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
					--
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
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift07" },
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
							},
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisGreeting,

				{ Cue = "/VO/Nemesis_0033",
					PreLineAnim = "Nemesis_Hub_Salute",
					Text = "Death to Chronos, Princess." },
				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.3,
						{ Cue = "/VO/Melinoe_1211", Text = "Death to Chronos." },
					},
				},
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
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
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
				PostBlockSpecialInteract = true,
				Cost =
				{
					GiftPoints = 1,
				},
				SkipGiftPresentationPost = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0096",
					Emote = "PortraitEmoteSurprise",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "You trying to get me in trouble with Hecate or something? Why don't you take your bottle before I smash it, and get your scrawny ass out of here." },
				{ Cue = "/VO/Melinoe_0627", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
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
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift02" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0097",
					Text = "Oh, for me? Can't find another way to test one of your poisons, I guess. You witches aren't as subtle as you think." },
				{ Cue = "/VO/Melinoe_0628", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's exactly what someone who was unknowingly poisoned by a witch might say, you know." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						{ Cue = "/VO/Nemesis_0163", Text = "{#Emph}Ugh." },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0145",
					Text = "Oh no, not this again. Look, I forgave you for last time. Didn't mean it as an invitation to get me more of this stuff. Don't like owing anybody any favors." },
				{ Cue = "/VO/Melinoe_2097", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
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
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift04" },
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
					Portrait = "Portrait_Nemesis_Averted_01",
					PreLineWait = 0.35,
					Text = "...You're not my enemy, Melinoë. I just... Just go." },
				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.45,
						{ Cue = "/VO/Melinoe_2250", Text = "Bye, Nem..." },
					},
				},
			},

			NemesisGift06 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "NemesisGift04" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0311",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "Suggest you quit it with these Nectars soon. Can't have too much of a good thing. Should know that about me by now." },
				{ Cue = "/VO/Melinoe_4430", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sure, you can't have too much of a good thing anymore than anybody else. Though, what would happen if you did? You'd need to punish yourself?" },
				{ Cue = "/VO/Nemesis_0312",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Yeah. And don't you dare act like you wouldn't do the same. One thing I'll grant Hecate is she does value discipline. Sometimes we have to discipline ourselves." },
				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.45,
						{ Cue = "/VO/Melinoe_4431", Text = "We have to take care of ourselves, too." },
					},
				},
			},

			NemesisGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_NemesisGiftHint01",
				LockedHintId = "Codex_NemesisUnlockHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatAboutRelationship01", "NemesisGift06" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Melinoe_4432", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I know you dislike excesses of any kind, though I don't think one more Ambrosia bottle's going to tip the scales for you, is it, Nem?" },

				{ Cue = "/VO/Nemesis_0313",
					Portrait = "Portrait_Nemesis_Averted_01",
					PreLineAnim = "Nemesis_Hub_Greet",
					Text = "It might. Won't go to the taverna to find out, so why don't you take it back. Not really the time for luxuries." },

				{ Cue = "/VO/Melinoe_4433", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about you hold onto it until whenever you feel it's deserved. If you're not indulging, you don't need to be concerned about it, right?" },

				{ Cue = "/VO/Nemesis_0314",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Want to waste something like this, fine. But it's just going in a stash, and probably will never see what little light we get. Long as you're good with that." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4434", Text = "I am." },
					},
				},
			},

			NemesisGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				StartBecomingCloserTrack = true,
				HintId = "Codex_GrowingCloser01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift07" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Melinoe_4435", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Thought I'd bring you something extra for your never-to-be-used stash, Nemesis. Because you might deserve it at some point, you never know." },

				{ Cue = "/VO/Nemesis_0315",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "{#Emph}You {#Prev}never know. What makes you even think I might deserve something like this? Not exactly been at the top of my field lately." },

				{ Cue = "/VO/Melinoe_4436", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well I am not the arbiter of such matters of course, but I think you {#Emph}do {#Prev}deserve it. You must be harder on yourself than anyone. If only you could see yourself as I do sometime." },

				{ Cue = "/VO/Nemesis_0316",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Don't know what {#Emph}that's {#Prev}supposed to mean. We were going for the same result, and both pushed hard. So what. But anyway, into the stash this goes." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4437", Text = "Where it belongs." },
					},
				},
			},

			NemesisGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_GrowingCloser01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift08", "NemesisFishing01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/Nemesis_0317",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Ambrosia. Look, you should know my never-to-be-used stash is just about full. Wouldn't want for it to overflow." },

				{ Cue = "/VO/Melinoe_4438", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You could always invite me to the taverna where we might cut into that stash of yours a bit. Why hoard it forever? Besides the reasons that you previously said." },

				{ Cue = "/VO/Nemesis_0318",
					PreLineAnim = "Nemesis_Hub_Greet",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Not going to invite you anywhere long as you keep this up. And I don't appreciate you making light of the subject of avoiding excess. My area of expertise. Not yours." },

				{ Cue = "/VO/Melinoe_4439", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm sorry, Nemesis, I wasn't aiming to be rude; words I cannot entirely believe I'm saying, much less feeling, since we used to trade barbs all the time." },

				{ Cue = "/VO/Nemesis_0319",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Things sure were nice and simple then, weren't they. But now we're stuck in whatever pattern this is, till we break free, and we're doing that now. No more Ambrosia. Ever." },

				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4440", Text = "Ever? What about Bath Salts?" },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Nemesis_01",

						{ Cue = "/VO/Nemesis_0320", Text = "{#Emph}<Chuckle>" },
					},
				},
			},

			-- taverna
			NemesisTaverna01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
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
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3354", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, I know there's an extraordinary likelihood you're going to say {#Emph}no{#Prev}, but... I've an extra-special poison bottle here, and thought maybe we could split it at the taverna, you and I?" },

				{ Cue = "/VO/Nemesis_0146",
					PostLineRemoveContextArt = true,
					PreLineAnim = "Nemesis_Hub_Greet",
					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					Text = "So damn polite! Well, it's less excessive if we split the bottle, I guess... {#Emph}ungh{#Prev}, you know what? Whatever, sure." },

				{ Cue = "/VO/Nemesis_0147",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					Text = "...Come on, say it: Got your ass kicked. By me. Think that was when I first thought I had a chance. That Hecate would pick me. If I could take you just like that a few more times." },

				{ Cue = "/VO/Melinoe_2099", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're a monster, Nem! I practically started to fear having to spar with you. But, the best way to get stronger is to train against a stronger opponent." },

				{ Cue = "/VO/Nemesis_0148",
					SkipContextArt = true,
					Portrait = "Portrait_Nemesis_Averted_01",
					PreLineAnim = "Nemesis_Hub_Salute",
					Text = "Maybe that's why I've been stagnating. We don't get to fight like we used to. Makes me sick even thinking about it." },

				{ Cue = "/VO/Melinoe_2100", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait... you stand around thinking about how we used to spar? Should I be flattered or afraid?" },

				{ Cue = "/VO/Nemesis_0149",
					SkipContextArt = true,
					PreLineAnim = "Nemesis_Hub_Toss",
					Text = "Finish your half of the damn poison already! Don't have all night to sit around and stroke your ego. I swear, mortals take after our worst qualities." },

				{ Cue = "/VO/Melinoe_2101", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wasn't being serious. Though, maybe I'm more self-centered than I realize. I {#Emph}am {#Prev}part-mortal on my mother's side..." },

				{ Cue = "/VO/Nemesis_0150",
					SkipContextArt = true,

					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "Makes you different, I will give you that. Now come on, I got to get back. Else Hecate might catch us making nice and then neither one of us will hear the end of it." },

				{ Cue = "/VO/Nemesis_0151",
					Portrait = "Portrait_Nemesis_Averted_01",
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
				PauseMusicPlayerMusic = true,
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
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
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
					Text = "A while. Not been much incentive. You saw how much of a pain it is to undo the lacing, and the straps. Feels strange without, like I'm... I... I don't know." },

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
				PauseMusicPlayerMusic = true,
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
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift04" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
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

			-- bond forged
			NemesisBathHouse03 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_NemesisHotSpringsGiftHintAlt",
				LockedHintId = "Codex_LockedActivityHint",
				CompletedHintId = "Codex_BondForgedNemesis",
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
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift09" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4441", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "You never did say no to Bath Salts, Nemesis, so how about it? As long as you feel we've earned at least a short break." },

				{ Cue = "/VO/Nemesis_0321",
					Portrait = "Portrait_Nemesis_Averted_01",
					PortraitExitAnimation = "Portrait_Nemesis_Averted_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Don't know that we have. Though I've accumulated enough knots in my muscles that it's gotten in the way. So why not." }, 

				{ Cue = "/VO/Nemesis_0322",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "Can't believe I'm sitting here with you. Couldn't stand the sight of you for the longest time. Wanted to snap you like a twig. Now I got you helping me unstrap my suit." },

				{ Cue = "/VO/Melinoe_4442", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "We're capable of change, aren't we? You must believe that yourself, otherwise what's the use of all the retribution you dole out? It can't be for the sake of punishment entirely." },

				{ Cue = "/VO/Nemesis_0323", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "The punishment is half of it. But yeah. Important to learn, if not from our own failures then those occurring constantly around us. Still I don't think I've changed at all; you have." },

				{ Cue = "/VO/Melinoe_4443", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I have? I'm still hell-bent on all my responsibilities. Counting the moments before I can get back to what I'm meant to be doing... rather than enjoying being here with you." },

				{ Cue = "/VO/Nemesis_0324", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					Text = "Except we're only here because you worked up the guts to ask. But fine, maybe you haven't changed a lot. Maybe I just like who you are more than I used to for some reason." },

				{ Cue = "/VO/Melinoe_4444", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I feel much the same. Though, I've admired you since training. It gladdens me to be with you like this... and how we've been fighting on the same side, recently." },

				{ Cue = "/VO/Nemesis_0325", Portrait = "Portrait_Nemesis_Bath_01",
					PortraitExitAnimation = "Portrait_Nemesis_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "Always wanted the same thing, just didn't think there was enough to go around. Now, enough talk. Going to get these knots out of my back or what?" },

				{ Cue = "/VO/Nemesis_0326",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Nemesis_01", Icon = "Keepsake_Nemesis", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostBathHouseArgs },

					Emote = "PortraitEmoteSparkly",
					-- Portrait = "Portrait_Nemesis_Averted_01",
					Text = "...Feels better than before, I'll give you that. Though don't go thinking I'll let up on you out there. We're calling this even." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4446", Text = "As it should be." },
					},
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
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
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
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
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
				PauseMusicPlayerMusic = true,
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
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},					
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "Shop" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Nemesis_01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
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
					PostLineFunctionArgs = { FishingPointId = 585640 },
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 16, IncludeFishingSFX = true }, },

				{ Cue = "/VO/Nemesis_0202",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Nemesis_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

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
					-- { FunctionName = "RequiredAlive", FunctionArgs = { Ids = { 557112 }, Alive = false }, },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					PlayOnceFromTableThisRun = true,
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							Path = { "PreviousDeathAreaRoom", "Name" },
							IsNone = { "Hub_PreRun" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},
					{ Cue = "/VO/Melinoe_2308", Text = "Nemesis must have a head start...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
							},
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
				{
					FunctionName = "RequiredDistanceFromHero",
					FunctionArgs = { MaxDistance = 3000, },
				},
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
				{
					FunctionName = "RequiredDistanceFromHero",
					FunctionArgs = { MaxDistance = 3000, },
				},
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

			{ Cue = "/VO/NemesisField_0372", Text = "We tied, so keep your coin.", PlayFirst = true },
			{ Cue = "/VO/NemesisField_0373", Text = "We'll call this one a draw." },
			{ Cue = "/VO/NemesisField_0374", Text = "We broke even I guess." },
			{ Cue = "/VO/NemesisField_0375", Text = "Nobody wins this time." },
			{ Cue = "/VO/NemesisField_0376", Text = "Another draw I guess." },
			{ Cue = "/VO/NemesisField_0377", Text = "Dead even huh?" },
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
				{ Cue = "/VO/NemesisField_0307", Text = "Warned you." },
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "NemesisAnyQuipSpeech", Time = 10 },
				{ Name = "NemesisHitRecentlySpeech", Time = 25 },
			},
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
						PathFalse = { "ScreenState", "ActiveObjectives", "NemesisDamageContest" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
					},
					{
						FunctionName = "RequiredDistanceFromHero",
						FunctionArgs = { MaxDistance = 2000, },
					},
					ChanceToPlay = 0.5,
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
				{ Cue = "/VO/Nemesis_0085", Text = "{#Emph}Hah." },
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
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
					},
					{
						FunctionName = "RequiredDistanceFromHero",
						FunctionArgs = { MaxDistance = 1000, },
					},
					ChanceToPlay = 0.2,
				},

				{ Cue = "/VO/NemesisField_0224", Text = "Watch it!", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0225", Text = "Watch your spacing." },
				{ Cue = "/VO/NemesisField_0226", Text = "Check your aim." },
				{ Cue = "/VO/NemesisField_0227", Text = "Step back!" },
				{ Cue = "/VO/NemesisField_0228", Text = "What are you..." },
				{ Cue = "/VO/NemesisField_0229", Text = "Want to go?" },
				{ Cue = "/VO/NemesisField_0230", Text = "Cut it out!" },
				{ Cue = "/VO/NemesisField_0231", Text = "Fight {#Emph}them!" },
				{ Cue = "/VO/NemesisField_0302", Text = "Step aside." },
				{ Cue = "/VO/NemesisField_0303", Text = "Stand back." },
				{ Cue = "/VO/NemesisField_0304", Text = "Watch it." },
				{ Cue = "/VO/NemesisField_0305", Text = "I have this." },
				{ Cue = "/VO/NemesisField_0306", Text = "Get back." },
			},
		},

		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { "NemesisAnyQuipSpeech" },
			Cooldowns =
			{
				{ Name = "NemesisHitRecentlySpeech", Time = 25 },
			},

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
						HasNone = { "NemesisGetFreeItemIntro01", "NemesisGetFreeItemIntro02", "NemesisPostCombatBecomingCloser01" },
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
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.1,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/Melinoe_2144", Text = "...I'll take it..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				AllowTalkOverTextLines = true,
				ObjectType = "NPC_Nemesis_01",

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
			{ GlobalVoiceLines = "NemesisDealDeclineVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
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
				PreLineWait = 0.8,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/MelinoeField_1394", Text = "...Cheers." },
				{ Cue = "/VO/MelinoeField_1395", Text = "...What, that's it?" },
				{ Cue = "/VO/MelinoeField_1396", Text = "...Not bad." },
				{ Cue = "/VO/MelinoeField_1397", Text = "...{#Emph}Ow!" },
				{ Cue = "/VO/MelinoeField_1398", Text = "...{#Emph}Guh, heh.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1399", Text = "...{#Emph}Urgh! Tsk." },
			}
		},
		HitDeclinedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "NemesisDealDeclineVoiceLines" },
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
							PathTrue = { "GameState", "TextLinesRecord", "NemesisTaverna01" },
						},
					},
				},
			},
		},
		PlayerLostDamageContestVoiceLines =
		{
			[1] = { GlobalVoiceLines = "NegativeReactionVoiceLines" },
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
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasNone = { "NemesisPostCombatBecomingCloser01" },
				},
			},
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
						PathTrue = { "CurrentRun", "CurrentRoom", "NemesisTakeExitRecord", "I_Story01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3308", Text = "{#Emph}Hey!" },
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
				PreLineWait = 0.75,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2244", Text = "{#Emph}<Scoff>" },
				{ Cue = "/VO/Melinoe_2245", Text = "Gone." },
				{ Cue = "/VO/Melinoe_2251", Text = "She's off." },
				{ Cue = "/VO/Melinoe_2252", Text = "Well...!" },
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
			},
		},

		Using =
		{
			Animation =
			{
				"DeathPortraitOverlayFx",
				"NemesisExitStreak",
			},
			Sounds =
			{
			  	"/Leftovers/SFX/RobeFlutter",
				"/Leftovers/World Sounds/MaskUnlatch1",
				"/Leftovers/World Sounds/MaskUnlatch2",
				"/SFX/ArmorIdleSFX",
				"/Leftovers/World Sounds/Unmask",
				"/Leftovers/World Sounds/LeavesRustle",
				"/Leftovers/SFX/RobeFlutter",
				"/Leftovers/World Sounds/LeavesRustleLimited",
				"/SFX/ArmorIdleSFX2",
				"/Leftovers/World Sounds/LeavesRustleSoft",
				"/Leftovers/World Sounds/LeavesRustleMedium",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithHecate02" },
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
				PreEventFunctionName = "AngleNPCToHero",
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
				-- PreEventFunctionName = "AngleNPCToHero",
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
						HasAny = { "NemesisRandomEvent", "BridgeNemesisRandomEvent", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" }
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NemesisRandomEventGreeting,

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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
					{
						FunctionName = "RequiredSellableGodTraits",
					},
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
				PreEventFunctionName = "AngleNPCToHero",
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
		PreferredSpawnPoint = "EnemyPoint",

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

			NemesisPreCombatBecomingCloser01 =
			{
				PlayFirst = true,
				PlayOnce = true,
				GameStateRequirements =
				{
					-- Force = true,
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisPostCombatAboutRelationship02" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatAboutRelationship02" },
					},
					NamedRequirements = { "NoRecentBecomingCloserEvent" },
					NamedRequirementsFalse = { "NearTrueEnding" },
				},
				{ Cue = "/VO/MelinoeField_4082", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "Well, you ready to break a sweat again, Nem?" },
				{ Cue = "/VO/NemesisField_0479",
					Text = "Don't insult me else I'll take more than your Gold after this. Now come on." },
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
							"/VO/NemesisField_0243",
							"/VO/NemesisField_0244",
							"/VO/NemesisField_0246",
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
							"/VO/NemesisField_0243",
							"/VO/NemesisField_0244",
							"/VO/NemesisField_0246",
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
							"/VO/NemesisField_0243",
							"/VO/NemesisField_0244",
							"/VO/NemesisField_0246",
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
							"/VO/NemesisField_0243",
							"/VO/NemesisField_0244",
							"/VO/NemesisField_0246",
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
							"/VO/NemesisField_0243",
							"/VO/NemesisField_0244",
							"/VO/NemesisField_0246",
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
			NemesisCombatMiscStart21 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisPostCombatAboutTartarus02" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},
				{ Cue = "/VO/NemesisField_0499",
					Text = "They say Chronos likes Gold, so he won't mind our little contest here." },
			},
			NemesisCombatMiscStart22 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisPostCombatAboutTartarus02" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},
				{ Cue = "/VO/NemesisField_0480",
					Text = "So this is where the {#Emph}real {#Prev}magick happens, huh. Let's see what the best of the Titan's armies have to offer." },
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
					-- Portrait = "Portrait_Mel_Intense_01",
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
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Say, how do you get past Headmistress on your way down? She's always waiting for me at the edge of Erebus." },
				{ Cue = "/VO/NemesisField_0016",
					Text = "Just answered your own question. She's waiting for {#Emph}you{#Prev}, not me. I'm not the one still being tested and trained. And I'm good at avoiding her." },
			},

			NemesisPostCombatAboutArtemis01 =
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
						PathTrue = { "CurrentRun", "SpawnRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift04", "ArtemisGift02" },
					},
				},
				{ Cue = "/VO/NemesisField_0475",
					Text = "Ran into Artemis back there. Between her and now me, we must have done half the heavy lifting for you tonight." },

				{ Cue = "/VO/MelinoeField_3632", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Must be what I deserve, though, right? And don't worry, there should be plenty of foes ahead whom I shall have to deal with on my own. How is the goddess of the hunt this eve?" },

				{ Cue = "/VO/NemesisField_0476",
					Text = "Seems well enough, we had a decent chat. Was beginning to think she's been avoiding me a while, though I can't imagine why she'd want to do a thing like that." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/MelinoeField_3633", Text = "Nor I." },
					},
				},
			},

			NemesisPostCombatAboutRelationship01 =
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
						HasAll = { "NemesisTaverna01", "NemesisGift06" },
					},
				},
				{ Cue = "/VO/NemesisField_0472",
					Text = "Who needs to sip Ambrosia in the Crossroads when we could be out here doing this together, right?" },

				{ Cue = "/VO/MelinoeField_3629", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Vanquishing our foes with impunity is your idea of a good time? Although that's not to say I don't take satisfaction in a job well done either. Wait what did you mean by {#Emph}together?" },

				{ Cue = "/VO/NemesisField_0473",
					PreLineWait = 0.2,
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Oh shut up. We used to spar, this is the closest thing. Don't know anybody else who can keep up, let alone get ahead." },

				{ Cue = "/VO/MelinoeField_3630", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A healthy competitive rivalry is all we have between us then?" },

				{ Cue = "/VO/NemesisField_0474",
					PreLineAnim = "Nemesis_Hub_Greet",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 2.0 },

					Text = "I said shut up. What else do you want it to be." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3631", Text = "...I'll get back to you." },
					},
				},
			},

			NemesisPostCombatAboutRelationship02 =
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
						HasAll = { "NemesisBathHouse03", "NemesisPostCombatAboutRelationship01" },
					},
				},
				{ Cue = "/VO/NemesisField_0445",
					Emote = "PortraitEmoteSurprise",
					Text = "...I broke a sweat? I broke a sweat. That never happens, those were weaklings, I... {#Emph}oh damn..." },

				{ Cue = "/VO/MelinoeField_3620", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What's the matter, Nem, are you all right? Our foes may have resorted to using poisons and such, if I could look at any superficial wounds..." },

				{ Cue = "/VO/NemesisField_0446",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Don't touch me! It's not that. Now get on with it." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3621", Text = "Hey..." },
					},
				},
			},

			-- relationship
			NemesisPostCombatBecomingCloser01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisPostCombatAboutRelationship02" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatAboutRelationship02" },
					},
					NamedRequirements = { "NoRecentBecomingCloserEvent" },
					NamedRequirementsFalse = { "NearTrueEnding" },
				},

				{ Cue = "/VO/NemesisField_0447",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Not quite as comfortable as being in the springs, is it, Princess? And can be solitary work at that." },

				{ Cue = "/VO/MelinoeField_3622", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It needn't be, but you refused back when I suggested we could go together through these depths. Now having second thoughts?" },

				{ Cue = "/VO/NemesisField_0448",
					PreLineWait = 0.35,
					PreLineAnim = "Nemesis_Hub_Salute",
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Been having thoughts, but of a different kind. You got into my head. I want you out. You always tried distracting me back when we sparred and now, you made it worse." },

				{ Cue = "/VO/MelinoeField_3623", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What are you talking about, what did {#Emph}I {#Prev}do...? ...Oh. By having thoughts you mean... feelings. So what now...?" },

				{ Cue = "/VO/NemesisField_0449",
					SecretMusic = "/Music/NarcissusTheme",
					PreLineWait = 0.5,
					Portrait = "Portrait_Nemesis_Averted_01",
					Text = "Don't know yet, but... well we could stay here a bit, till enough is enough. Since it's quiet. Not binding you, just... too much solitude lately, and want to even it all out." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/NemesisField_0453", Text = "Oh, didn't need this but maybe you do." },
					},
					{
						PreLineWait = 0.6,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3627", Text = "Bye, Nem..." },
					},
				},
				{
					Text = "Choice_NemesisBecomingCloser01",
					Portrait = "Portrait_Nemesis_Averted_01",
					IgnoreRawText = true,
					IsNarration = true,
					IgnoreContinueArrow = true,
					BoxAnimation = "NarrationBubbleRomance",
					BoxExitAnimation = "NarrationBubbleRomanceOut",
					DisableCharacterFadeColorLag = true,
					KeepContextArt = true,
					TextOffsetY = 0,
					PreContentSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					Choices =
					{
						{
							ChoiceText = "Choice_NemesisDecline",
							{ Cue = "/VO/MelinoeField_3628",
								UsePlayerSource = true,
								PreLineWait = 1.0,
								Portrait = "Portrait_Mel_Vulnerable_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "...I'm much like you in not desiring too much of a good thing. I'm supposed to be on task, you're supposed to be on duty; I just don't think my mind would be at ease. Tell me you understand?" },

							{ Cue = "/VO/NemesisField_0454",

								EndSecretMusic = true,

								PreLineWait = 1.0,
								Portrait = "Portrait_Nemesis_Averted_01",

								PreLineFunctionName = "NPCRewardDropPreProcess",
								PostLineFunctionName = "NPCRewardDrop",
								PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,

								Text = "I do. Forget I asked. Least we got to talk like this. Should get going, but... be seeing you around." },
						},
						{
							ChoiceText = "Choice_NemesisAccept",
							{ Cue = "/VO/MelinoeField_3624",
								UsePlayerSource = true,
								PreLineWait = 1.0,
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Portrait = "Portrait_Mel_Pleased_01",
								PortraitExitAnimation = "Portrait_Mel_Pleased_01_Exit",

								PostLineFunctionName = "BecomingCloserPresentation",
								PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", Partner = "Nemesis", TimeTicks = 10, ExtraWaitTime = 0.25 },

								Text = "...Even it all out... well if we're to make ourselves comfortable and stay quiet, then your armor {#Emph}has {#Prev}to go. Why don't I lend a hand with that, and then we'll go from there?" },

							-- INTERMISSION PRESENTATION

							{ Cue = "/VO/MelinoeField_3625", UsePlayerSource = true,
								Portrait = "Portrait_Mel_PleasedFlushed_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "...Well your armor's definitely harder to put back on, but we got there. You all right, Nem? The distraction gone away at least...?" },

							{ Cue = "/VO/NemesisField_0451",
								PreLineWait = 1.0,
								Portrait = "Portrait_Nemesis_Flushed_01",

								Text = "Think so, and yeah, I'm better now. I'm good. What about you, are you... I mean..." },

							{ Cue = "/VO/MelinoeField_3626", UsePlayerSource = true,
								Portrait = "Portrait_Mel_PleasedFlushed_01",
								PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "I'm also good! This was a thrill...! We ought be on assignment, not alleviating solitude, but... you'd know better than anyone whether this was too much." },

							{ Cue = "/VO/NemesisField_0452",

								EndSecretMusic = true,

								PreLineWait = 0.5,
								Portrait = "Portrait_Nemesis_Flushed_01",

								PreLineFunctionName = "NPCRewardDropPreProcess",
								PostLineFunctionName = "NPCRewardDrop",
								PostLineFunctionArgs = PresetEventArgs.NemesisGetFreeItemArgs,

								PostLineThreadedFunctionName = "InCombatTextEvent",
								PostLineThreadedFunctionArgs = GameData.PostIntermissionArgs,

								Text = "Was just enough for now. Should get going, though could always do this again should the need arise." },
						},
					},
				},
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
						PathFalse = { "GameState", "TextLinesRecord", "NemesisGift08" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisPostCombatAboutTartarus01" }
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
						HasAll = { "NemesisPostCombatAboutChronos01" },
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

			NemesisPostCombatAboutTartarus02 =
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
						HasAll = { "NemesisPostCombatAboutTartarus01" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
				},

				{ Cue = "/VO/MelinoeField_3676", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Any progress locating a means to enter Tartarus? I'd transfer you my birthright if I could under the circumstances, though I'm reasonably certain that's not possible." },

				{ Cue = "/VO/NemesisField_0455",
					Text = "Got my own birthright, thanks. And yeah, been making progress. Three-headed monster near the maintenance access point to Tartarus... it digs up through the ground." },

				{ Cue = "/VO/MelinoeField_3677", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You plan to get into the lowest reaches of the Underworld through the hell-hole that beast leaves behind? You know that's Cerberus, my father's dog, don't you?" },

				{ Cue = "/VO/NemesisField_0456",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PostLineAnim = "Nemesis_Hub_Glare_End",
					Text = "All the more reason that tunnel's going to lead me right where I need to be, one of these nights. Mark my words." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3678", Text = "Consider them marked..." },
					},
				},
			},

			NemesisPostCombatAboutTartarus03 =
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
						HasAll = { "NemesisPostCombatAboutTartarus02" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},

				{ Cue = "/VO/NemesisField_0457",
					AngleTowardHero = true,
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					Text = "Told you I'd make it all this way. Nice place your father's got. Though I guess Chronos since refurbished everything." },

				{ Cue = "/VO/MelinoeField_3679", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Congratulations on infiltrating the lowest reaches, Nemesis. And if you've been drawing out some of our enemy's forces, all the better; plenty to go around. Reached Chronos yet?" },

				{ Cue = "/VO/NemesisField_0458",
					PreLineAnim = "Nemesis_Hub_Glare_End",
					Text = "Got to what has to be the House of Hades, but you know what? They wouldn't let me in. Tried knocking, tried smashing down the door, no good. So Charon took me back." },

				{ Cue = "/VO/MelinoeField_3680", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You got Charon to take you on his boat? He's never once permitted me!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/NemesisField_0459", Text = "Guess you just don't have the birthright for it, Princess." },
					},
					{
						PreLineWait = 0.33,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3681", Text = "{#Emph}...Ah." },
					},
				},
			},

			NemesisPostCombatPostTrueEnding01 =
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/NemesisField_0477",
					Text = "Knew you weren't finished, and you know what? Neither am I. Whatever it is you're doing now, I'm not being left out." },

				{ Cue = "/VO/MelinoeField_4081", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sure! Just have a chat with Headmistress or Grandfather Chronos and they'll fill you in on everything we're up to now." },

				{ Cue = "/VO/NemesisField_0478",
					Text = "Right. Meantime, anybody asks, I'm just out to stretch my legs and keep my sword arm in top form." },
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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "N_Boss01", "N_Boss02" },
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

-- Global Nemesis Lines
GlobalVoiceLines.NemesisDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Nemesis_01", SubtitleColor = Color.NemesisVoice },

	{ Cue = "/VO/NemesisField_0326", Text = "Go home to Hecate, I'll handle it from here." },
	{ Cue = "/VO/NemesisField_0327", Text = "Always said you don't have what it takes." },
	{ Cue = "/VO/NemesisField_0328", Text = "Don't let me hear you blame the Fates for this." },
	{ Cue = "/VO/NemesisField_0329", Text = "Thought you'd take more punishment than that." },
	{ Cue = "/VO/NemesisField_0330", Text = "Got what was coming to you; I should know." },
	{ Cue = "/VO/NemesisField_0331", Text = "Was all a bit too much for you, poor thing." },
	{ Cue = "/VO/NemesisField_0332", Text = "We're all supposed to be counting on you?" },
	{ Cue = "/VO/NemesisField_0333", Text = "Come on, you could have done better than that." },
	{ Cue = "/VO/NemesisField_0334", Text = "Go, get your scrawny ass out of here." },
	{ Cue = "/VO/NemesisField_0335", Text = "You never could handle the pressure you know." },
}

GlobalVoiceLines.NemesisGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},		
		Cooldowns =
		{
			{ Name = "NemesisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/NemesisField_0402", Text = "Good for you." },
		{ Cue = "/VO/NemesisField_0403", Text = "Thank the Fates." },
		{ Cue = "/VO/NemesisField_0404", Text = "How fortunate for you." },
		{ Cue = "/VO/NemesisField_0405", Text = "Well deserved." },
		{ Cue = "/VO/NemesisField_0406", Text = "So what." },
		{ Cue = "/VO/NemesisField_0407", Text = "What you need that for?" },
		{ Cue = "/VO/NemesisField_0418", Text = "Lucky you." },
		{ Cue = "/VO/NemesisField_0419", Text = "Great." },
		{ Cue = "/VO/NemesisField_0420", Text = "Wow." },
		{ Cue = "/VO/NemesisField_0421", Text = "So what." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
		},		
		Cooldowns =
		{
			{ Name = "NemesisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/NemesisField_0414", Text = "Kidding me?" },
		{ Cue = "/VO/NemesisField_0415", Text = "Get in the fight!" },
		{ Cue = "/VO/NemesisField_0416", Text = "What are you doing?" },
		{ Cue = "/VO/NemesisField_0417", Text = "Fight back!" },
	},
}

GlobalVoiceLines.NemesisExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Nemesis_01",
	Cooldowns =
	{
		{ Name = "NemesisAnyQuipSpeech", Time = 10 },
	},

	{ Cue = "/VO/NemesisField_0408", Text = "Why bother." },
	{ Cue = "/VO/NemesisField_0409", Text = "Another Shade to watch." },
	{ Cue = "/VO/NemesisField_0410", Text = "What did you do." },
	{ Cue = "/VO/NemesisField_0411", Text = "How touching." },
	{ Cue = "/VO/NemesisField_0412", Text = "What's the use." },
	{ Cue = "/VO/NemesisField_0413", Text = "Dead weight." },
}

GlobalVoiceLines.NemesisScoffingVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Nemesis_01",
	PreLineAnim = "Nemesis_Hub_Greet",

	{ Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
	{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Hmph." },
}