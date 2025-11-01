 UnitSetData.NPC_Skelly =
{
	-- Schelemeus, -- Skelly, Id = 420928
	NPC_Skelly_01 =
	{
		InheritFrom = { "BaseVulnerableEnemy", "NPC_Neutral", "NPC_Giftable" },
		SubtitleColor = Color.SkellyVoice,
		EmoteOffsetY = -260,
		EmoteOffsetX = 80,
		DisableCharacterFadeColorLag = true,
		RequiredKill = false,
		UseShrineUpgrades = false,
		SkipDamagePresentation = false,
		SpeakerName = "Skelly",
		LoadPackages = { "Skelly", },
		ActivateAnimation = "Skelly_Spawn",
		ActivateFx = "EnemySummonRune",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateDuration = 2.0,
		DeathAnimation = "Skelly_Death",
		DestroyDelay = 5.67,
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		StunAnimations = 
		{
			Default = "Skelly_OnHit",
		},
		MaxHealth = 1320,
		HealthBarOffsetY = -235,
		HealthBarType = "MediumLarge",
		SkipDamageText = false,
		AnimOffsetX = -10,
		AnimOffsetZ = 0,
		UnuseableWhenDead = true,
		SpeechCooldownTime = 9,
		IgnoreAutoLock = false,
		TrainingTarget = true,
		FamiliarTarget = true,

		Groups = { "NPCs", "GroundEnemies", "TrainingEnemies" },

		Material = "Bone",

		--AITurnDelayMin = 0.5,
		--AITurnDelayMax = 0.5,

		MeterMultiplier = 0,
		RespawnDelay = 5.85,

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				PlayOnceThisRun = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 8 },
				},
				-- PreLineAnim = "MelTalkBrooding01",

				{ Cue = "/VO/Melinoe_1708", Text = "Death to Chronos, Commander.",
					GameStateRequirements =
					{
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
				},
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.2,
				PreLineAnim = "Skelly_Salute",
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Skelly_01",

				{ Cue = "/VO/Skelly_0155", Text = "Heya.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0156", Text = "Good evening, young one.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0157", Text = "Yeah!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0158", Text = "Same to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0160", Text = "It better!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0161", Text = "Seriously.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0162", Text = "Moonlight, yeah.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0163", Text = "Knock 'im dead, kiddo.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700", "/VO/Melinoe_1708" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0164", Text = "Yeah, kill 'im!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700", "/VO/Melinoe_1708" },
						},
					},
				},
			},
		},
		GiftGameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "ManageThreads",
				Args =
				{
					KillWaitUntilThread = "SkellyMissing",
				},
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSkellyHealth" },
					},
				},
				FunctionName = "OverwriteSelf",
				Args =
				{
					MaxHealth = 5000,
				},
			},
		},

		ActivateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SkellyAboutHealthQuest03" }
			},
		},

		AIOptions =
		{
			"EmptyAI",
		},
		AITetherToSpawnLocation = true,
		AITetherDistance = 0,

		Portrait = "Portrait_Skelly_Default_01",

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		TrophyUnlockedVoiceLines =
		{
			Queue = "Interrupt",
			PlayOnce = true,
			PlayOnceContext = "SkellyStatueUnveilVO",
			AllowTalkOverTextLines = true,
			{
				-- statue 1
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
					},
				},
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,

					{ Cue = "/VO/Melinoe_3273", Text = "The deed is done...!" },
				},
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",

					{ Cue = "/VO/Skelly_0309", Text = "And now... unto the Champion of Night, {#Emph}the spoils..." },
				},
				{
					UsePlayerSource = true,
					PreLineWait = 1.2,

					{ Cue = "/VO/Melinoe_3274", Text = "Oh..." },
				},
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				-- statue 2
				{
					PreLineWait = 0.5,
					ObjectType = "NPC_Skelly_01",

					{ Cue = "/VO/Skelly_0314", Text = "Now, young one: Avert your eyes, lest you be smitten by the {#Emph}glory {#Prev}over here!" },
				},
				{
					UsePlayerSource = true,
					PreLineWait = 1.8,

					{ Cue = "/VO/Melinoe_3279", Text = "Wow..." },
				},
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				-- statue 3
				{
					PreLineWait = 0.73,
					ObjectType = "NPC_Skelly_01",

					{ Cue = "/VO/Skelly_0319", Text = "For your {#Emph}extraordinary {#Prev}feat, the most {#Emph}extraordinary Gift of all!" },

				},
				{
					UsePlayerSource = true,
					PreLineWait = 2.53,

					{ Cue = "/VO/Melinoe_3284", Text = "{#Emph}Huh..." },
				},
			},

		},

		InteractTextLineSets =
		{
			SkellyFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				{ Cue = "/VO/Skelly_0229",
					PreLineAnim = "Skelly_Explaining",
					-- PreLineAnim = "Skelly_Babbling",
					-- PreLineAnim = "Skelly_Salute",
					-- PreLineAnim = "Skelly_Greeting",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 9.65 },
					Text = "A battle lost. But this is {#Emph}war{#Prev}, young one, and you have many battles yet to come! The only question is, are you prepared to {#Emph}win? {#Prev}I'm not so sure here, so let's see you {#DialogLegendaryFormat}give me {#Prev}{#EmphLegendary}twenty!" },
				{ Cue = "/VO/Melinoe_0018", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander Schelemeus, sir. You're certain it's acceptable for me to strike you twenty times in front of all your students?",
					PostLineThreadedFunctionName = "StartSkellyHitQuest" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.1,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Babbling",
						{ Cue = "/VO/Skelly_0452", Text = "{#Emph}Dead certain. {#Prev}Now hit me with everything you got!" },
						-- { Cue = "/VO/Skelly_0071", Text = "Oh they have much to learn, as well do you, young one. Now give me your best shots!" },
					},
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0019_V3", Text = "As you will, sir!" },
					},
				},
			},

			SkellyAboutEarlyRunClear01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 6,
					},
				},
				{ Cue = "/VO/Skelly_0470",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh hey, young one, just minding my own business over here... for what knowledge could I possibly impart to she who vanquished the {#DialogLegendaryFormat}Titan of Time {#Prev}like it was nothin'?" },
				{ Cue = "/VO/Melinoe_4159", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, I merely wished to thank you. Were it not for all your teachings in the past, I wouldn't have prevailed." },
				{ Cue = "/VO/Skelly_0471",
					PreLineAnim = "Skelly_Explaining",
					-- PreLineAnim = "Skelly_Babbling",
					-- PreLineAnim = "Skelly_Salute",
					-- PreLineAnim = "Skelly_Greeting",
					Emote = "PortraitEmoteSurprise",
					Text = "Ah, yes! I almost forgot my teachings in the past! In turn, I congratulate you on achieving that which I wagered was impossible to my disciples here..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4160", Text = "Wait you {#Emph}wagered...?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0472", Text = "{#Emph}No!" },
					},
				},
			},

			SkellyAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0072",
					Text = "Your path is fraught, young one. Know that I'm {#Emph}always {#Prev}here to let you vent {#Emph}all {#Prev}your anger and frustrations upon, as well as to train with." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0072", Text = "The greatest teacher is out there..." },
				},
			},

			SkellyAboutBeatings01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "NPC_Skelly_01" },
					},
					{
						SumPrevRuns = 4,
						Path = { "EnemyKills", "NPC_Skelly_01" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
				},
				{ Cue = "/VO/Skelly_0441",
					PreLineAnim = "Skelly_Explaining",
					Text = "While I do not wish to insinuate you're some kind of {#DialogLegendaryFormat}slacker{#Prev}, nonetheless I can't help but observe it's been more than a few nights since last you vanquished me, young one." },
				{ Cue = "/VO/Melinoe_4052", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I thought my training here was more or less complete, Commander. All the Nocturnal Arms are at my disposal, and I know them well. Am I to keep reducing you to dust?" },
				{ Cue = "/VO/Skelly_0442",
					PreLineAnim = "Skelly_Salute",
					Text = "Well, the choice {#Emph}is {#Prev}ultimately yours, of course, but lest you forget: There's always more for you to learn, and only one way to learn it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4053", Text = "By hitting you repeatedly." },
					},
					{
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0443", Text = "And often, now come {#Emph}on!" },
					},
				},
			},

			SkellyAboutEmotions01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Skelly_0073",
					Text = "One must at times hold fast to one's emotions, and at others, know to let 'em loose. And when you want to let 'em loose, or try out one of them {#DialogLegendaryFormat}Nocturnal Arms{#Prev}, know that I'm here." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0075", Text = "This anger is for Chronos, sir." },
				},
			},

			SkellyAboutTraining01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						--
					}
				},
				{ Cue = "/VO/Skelly_0153",
					Text = "Observe how patient my disciples are, studying your every move! If ever you're inclined to give them a demonstration of your prowess, or just want to blow off some steam, do not hesitate to {#DialogLegendaryFormat}whale upon me{#Prev}.",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2256", Text = "{#Emph}Whale upon{#Prev}, sir...?" },
				},
			},
			SkellyAboutTraining02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},				
				{ Cue = "/VO/Skelly_0044",
					Text = "Remember you are training with an unarmed opponent here, young one. Out there, the skeletons can {#Emph}move{#Prev}... and they'd cut you to ribbons, given half a chance! You won't learn to handle that kind of pressure sparring with me." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_0053", Text = "I understand." },
				},
			},

			SkellyAboutStaff01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf =
						{
							"WeaponDagger",
							"WeaponTorch",
							"WeaponAxe",
						},
						Comparison = "<=",
						Value = 2,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "ToolPickaxe" },
					},
				},
				{ Cue = "/VO/Skelly_0154",
					Text = "You getting a handle on that walking stick of yours? There's other stuff you might like better in the {#DialogLegendaryFormat}Puddle {#Prev}back there, if you've got the {#DialogLegendaryFormat}Silver {#Prev}for it. Just be sure to try it all out on me!",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2257", Text = "You mustn't speak ill of Descura, sir." },
				},
			},

			SkellyAboutChatting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 15,
					},
				},
				{ Cue = "/VO/Skelly_0393",
					Text = "You're eager to get out there and start dishing out some good old fashioned punishment, young one! Well then you need not stop for me. {#DialogLegendaryFormat}Just go!" },
				{ Cue = "/VO/Melinoe_3803", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It doesn't feel right to rush through these Crossroads without so much as a word. Besides, you surely have some vital wisdom to impart." },
				{ Cue = "/VO/Skelly_0394",
					PreLineAnim = "Skelly_Explaining",
					Text = "That I do, and it is this: Even if you see a sign over my head or anybody's that's like {#Emph}c'mere talk to me{#Prev}, remember... no need to chat if you're not in a conversating mood, OK?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3804", Text = "Just ignore anybody I don't want to talk to, then." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0395", Text = "Yeah, who needs 'em!" },
					},
				},
			},

			SkellyAboutDying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift03" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
						Comparison = ">=",
						Value = 4,
					},
					{
						-- ignoring the current run, spawned no more than 3 times in the 4 previous runs
						SumPrevRuns = 5,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Skelly_01" },
						Comparison = "<=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Skelly_0288" }
					},
				},
				{ Cue = "/VO/Melinoe_4161", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've always wondered something, Commander. Where do you go when you're not here? I mean, sometimes you only arrive after I switch between Nocturnal Arms..." },
				{ Cue = "/VO/Skelly_0473",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "That isn't anybody's business but mine own, young one! Do we not, each of us, require solitude? A locale where we might collect our bearings and our thoughts?" },
				{ Cue = "/VO/Melinoe_4162", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course, sir... I apologize for overstepping. We are the Unseen; we dwell in obscurity and guard our secrets." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0474", Text = "And we don't go pryin' in each other's personal affairs." },
					},
				},
			},

			SkellyAboutCardUpgradeSystem01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "Resources", "CardUpgradePoints" },
						Comparison = "<=",
						Value = 6,
					},
					{
						Path = { "GameState", "Resources", "MetaCurrency" },
						Comparison = ">=",
						Value = 150,
					},
				},
				{ Cue = "/VO/Skelly_0361",
					Text = "Something's changed about that {#DialogLegendaryFormat}Altar {#Prev}of yours recently, and you have been at it more and {#Emph}more{#Prev}, young one! Mayhaps awakened newfound power there, or what?" },
				{ Cue = "/VO/Melinoe_3364", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've consecrated the Ashes and gained insight into the potential of the Arcana, Commander. Requires a little Moon Dust, and a lot of focus... perhaps the other way around." },
				{ Cue = "/VO/Skelly_0362",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#DialogLegendaryFormat}Moon Dust? {#Prev}Think the old {#DialogLegendaryFormat}Broker {#Prev}started pawning off that stuff, though I {#Emph}have {#Prev}heard it's possible a witch like you could brew it up herself. Sounds like you better stock up!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3365", Text = "I probably should..." },
				},
			},

			SkellyAboutAspects01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
					{
						SumPrevRuns = 4,
						Path = { "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0185",
					Text = "Something transpired with the {#DialogLegendaryFormat}Silver Puddle {#Prev}back there, I could tell, young one! Your doing, or perchance that of the Fates themselves?" },
				{ Cue = "/VO/Melinoe_2529", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've revealed in the Pool the Aspects of the Nocturnal Arms. Not their true forms, exactly... but different ones, with their own great power." },
				{ Cue = "/VO/Skelly_0186",
					PreLineAnim = "Skelly_Explaining",
					Text = "Ah, the {#DialogLegendaryFormat}Nocturnal Arms{#Prev}! Your brother, he once used their counterparts, and those ones too turned into other stuff. Well if you need to test your newfound strength, I'm here." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2530", Text = "I know it, Commander." },
				},
			},

			SkellyAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- distinct from CurrentRun.Hero.TraitDictionary
					{
						PathTrue = { "CurrentRun", "TraitCache", "ReincarnationKeepsake" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "H_Boss01", "P_Boss01" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				{ Cue = "/VO/Skelly_0189",
					Text = "I trust that the enchanted {#DialogLegendaryFormat}Tooth {#Prev}I proffered you has proved invaluable? Although, since you're already back, perhaps it wasn't quite invaluable enough..." },
				{ Cue = "/VO/Melinoe_2586", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'd surely not have gone as far without your Keepsake, Commander. Though, why is it known as the {#Emph}Luckier {#Prev}Tooth? Was there another of its kind?" },
				{ Cue = "/VO/Skelly_0190",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "Oh, no! It is truly a unique artifact procured in my travails. An artifact with which you'll cling to life as might a sailor on a sinking ship." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2587", Text = "That's very vivid..." },
				},
			},

			SkellyAboutZagreus01 =
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
						HasAll = { "SkellyGift01", "ZagreusPastFirstMeeting" },
					},
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				{ Cue = "/VO/Melinoe_0073", UsePlayerSource = true,
					Text = "Commander... there must be something you could tell me of my brother. The stronger my connection, the better our chances. You knew him, didn't you?" },
				{ Cue = "/VO/Skelly_0007",
					Text = "I knew your brother, yeah. Good kid, most of the time. He wouldn't want you to be so hung up about him. What he'd want... more than anything, I think... is for you... to {#DialogLegendaryFormat}hit me{#Prev}. As hard as you can, repeatedly and often, and {#Emph}that's {#Prev}what I would want for you as well!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0074", Text = "{#Emph}Ungh{#Prev}, very well." },
				},
			},
			SkellyAboutZagreus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Story01" },
					},
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift02" },
					},
				},
				{ Cue = "/VO/Melinoe_4171", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My brother must have been immensely strong, if he could sometimes even take my father when they sparred. Is there some favorite technique of his that you could pass along?" },
				{ Cue = "/VO/Skelly_0487",
					PreLineAnim = "Skelly_Greeting",
					Text = "No there is {#Emph}not! {#Prev}My disciples must each follow their own path. Keep following yours, and mayhaps you {#Emph}too {#Prev}shall become powerful enough to beat your papa up." },
				EndVoiceLines =
				{
					{
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							PreLineWait = 0.31,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_4172", Text = "Commander! My father is bound in chains in Tartarus!" },
						},
						{
							PreLineWait = 0.28,
							ObjectType = "NPC_Skelly_01",
							{ Cue = "/VO/Skelly_0488", Text = "Then it ought to be easy!" },
						},
					},
					{
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							PreLineWait = 0.31,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_4946", Text = "Commander, we have no reason to fight!" },
						},
						{
							PreLineWait = 0.28,
							ObjectType = "NPC_Skelly_01",
							{ Cue = "/VO/Skelly_0582", Text = "Mayhaps not {#Emph}yet!" },
						},
					},
				},
			},

			SkellyAboutZagreusFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "C_Boss01" },
					},
				},
				{ Cue = "/VO/Skelly_0749",
					PreLineAnim = "Skelly_Explaining",
					Text = "My disciples here claim that you clashed with none other than the {#DialogLegendaryFormat}Prince of the Underworld {#Prev}himself, and you fought with the fury of a daemon, to which I said, {#Emph}c'mon." },
				{ Cue = "/VO/Melinoe_5673", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's true, sir! I found myself in some competition-chamber in what looked to be Elysium. There Zagreus and I engaged in a full-contact battle for the hearts of our spectators!" },
				{ Cue = "/VO/Skelly_0750",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well that seems pretty pointless to me, kiddo, seeing as I trained you both! You are {#Emph}equally matched! {#Prev}I don't see what comparisons are even to be drawn!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5674", Text = "Commander, we're nothing alike." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0751", Text = "That's exactly what he'd say." },
					},
				},
			},

			SkellyAboutHades01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutNyx01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Story01" },
					},
				},
				{ Cue = "/VO/Melinoe_4156", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "I saw my father recently, Commander... bound in chains in deepest Tartarus, a prisoner of Time. After all he's been through, though... he couldn't even remember you by name!" },
				{ Cue = "/VO/Skelly_0468",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "How, {#Emph}uh{#Prev}, how terrible that is, young one! Your papa and I, we couldn't have been closer. Perchance he merely has forgotten 'cause of everything he's going through." },
				{ Cue = "/VO/Melinoe_4157", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I can't believe he'd just entirely forget one of his most trusted advisors. There must be some way to help him recall." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0469", Text = "{#Emph}No! {#Prev}You gotta let him come around on his own." },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4158", Text = "You're probably right..." },
					},
				},
			},
			SkellyAboutHouse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift01" },
					},
				},
				{ Cue = "/VO/Melinoe_4169", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Do you ever miss it, Commander? Your time in service to the House of Hades. Training my brother. Holding a position of high honor there." },
				{ Cue = "/VO/Skelly_0485",
					PreLineAnim = "Skelly_Explaining",
					Text = "Oh, 'twas a glorious time for sure. But, I would not have earned my post if I kept crying about the past like a {#DialogLegendaryFormat}little baby{#Prev}. I'm all about the here-and-now!" },
				{ Cue = "/VO/Melinoe_4170", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But all of what you used to have is gone. The other servants of the House... you must have some concern for {#Emph}them {#Prev}at least?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Greeting",
						{ Cue = "/VO/Skelly_0486", Text = "C'mon, they're {#Emph}gods! {#Prev}They'll probably be fine!" },
					},
				},
			},

			SkellyAboutPast01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift03" },
					},
				},
				{ Cue = "/VO/Melinoe_4173", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know I've always wondered about all those commendations that you wear... which was the first you earned? Which means the most?" },
				{ Cue = "/VO/Skelly_0489",
					PreLineAnim = "Skelly_Salute",
					Text = "Oh you mean these little numbers here? One of these I've had since, {#Emph}um{#Prev}, the {#DialogLegendaryFormat}Siege of Ilium{#Prev}! Speared many a guy for {#Emph}that {#Prev}one! The others are from campaigns 'cross the land." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4174", Text = "Which sorts of campaigns?" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0490", Text = "'Cross the land, I said!" },
					},
				},
			},

			SkellyAboutPast02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SkellyAboutPast01", "SkellyGift06" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "SkellyGift06" },
					},
				},
				{ Cue = "/VO/Skelly_0497",
					PreLineAnim = "Skelly_Salute",
					Text = "Why are you looking at me with that consternated face, young one? Mayhaps in search of wisdom you would like me to impart?" },
				{ Cue = "/VO/Melinoe_4178", UsePlayerSource = true,
					PreLineWait = 0.2,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "...It's just, even now, I know so little of your past. I have to admit, Commander... there are such times when I begin to feel as though you're not being candid with me." },
				{ Cue = "/VO/Skelly_0498",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Salute",
					Text = "What?! No. Look, I'm here to focus on your martial expertise, rather than prattle on about the way things used to be! But fine. What is it you really wish to know?" },
				{ Cue = "/VO/Melinoe_4179", UsePlayerSource = true,
					PreLineWait = 0.4,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "...I wish to know exactly who you truly are." },
				{ Cue = "/VO/Skelly_0499",
					PreLineWait = 1.0,
					PreLineAnim = "Skelly_Greeting",
					Text = "...Well I'm not telling you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4180", Text = "...Fine." },
					},
				},
			},
			SkellyAboutPast03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutPast02" },
					},
				},
				{ Cue = "/VO/Skelly_0500",
					PreLineAnim = "Skelly_Salute",
					Text = "Hey look, I know we kinda had a little spat last time, and I don't want things going sideways with you here, so let me give it to you straight." },
				{ Cue = "/VO/Melinoe_4181", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Very well, Commander. You always have my full attention." },
				{ Cue = "/VO/Skelly_0501",
					PreLineAnim = "Skelly_Babbling",
					Text = "The thing is, kiddo, and it's something that could get me into lots of trouble: Not only do I not want to, but I'm not even {#Emph}supposed {#Prev}to tell you what you want to know." },
				{ Cue = "/VO/Melinoe_4182", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And I suppose you can't tell me why not. Is somebody coercing you to keep me ignorant?" },
				{ Cue = "/VO/Skelly_0502",
					PreLineWait = 0.35,
					PreLineAnim = "Skelly_Greeting",
					Text = "Look, just trust me on this one, OK? You've got your part to play, and I got mine." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4183", Text = "...This isn't over." },
					},
				},
			},

			SkellyAboutPast04 =
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
						HasAll = { "SkellyAboutPast03", "SkellyGift09" },
					},
				},
				{ Cue = "/VO/Melinoe_4997", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, if I'm to trust you as I always have, then I need to know that you are not concealing anything from me. If you fear reprisal, I swear to vouch for you and protect you." },

				{ Cue = "/VO/Skelly_0638",
					PreLineAnim = "Skelly_Explaining",
					Text = "My fear, young one, is that if I share the knowledge you desire, you shall never again look upon me in the same way! Which may not be so good for either one of us." },

				{ Cue = "/VO/Melinoe_4998", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PortraitExitAnimation = "Portrait_Mel_Empathetic_01_Exit",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineRemoveContextArt = true,
					Text = "I would rather look upon you knowing you are honest with me. And for my part, I shall not betray your confidentiality." },

				{ Cue = "/VO/Skelly_0639",
					PreLineWait = 2.8,
					Speaker = "NPC_Skelly_TrueMythologicalOrigin_01",
					PreLineThreadedFunctionName = "SkellyBackstoryPresentationStart",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					NarrativeContextArt = "DialogueBackground_MountOlympus",
					PostLineRemoveContextArt = true,

					Text = "...Well all right... I am not exactly the Commander whom you take me for, {#Emph}nay! {#Prev}I was much {#Emph}more {#Prev}than that... {#Emph}King Schelememnon{#Prev}, I was called! But I was even more than {#Emph}that, as well! {#Prev}For your own papa hand-selected me as one of his {#DialogLegendaryFormat}Three Judges of the Dead{#Prev}!" },

				{ Cue = "/VO/Melinoe_4999", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "SkellyBackstoryPresentationEnd",
					Text = "Commander, that's... that's incredible! So then... after the Underworld fell, you went into hiding here?" },

				{ Cue = "/VO/Skelly_0640",
					PreLineWait = 0.35,
					PreLineAnim = "Skelly_Explaining",
					Text = "I, {#Emph}uh, heheh. {#Prev}Yes, that is correct. And our enemies, they have pursued me ever since! No one must know my whereabouts! Not your father, your brother... {#Emph}nobody." },

				{ Cue = "/VO/Melinoe_5000", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why can't my father or my brother know? Surely they'd want to hear you're safe!" },

				{ Cue = "/VO/Skelly_0641",
					PreLineWait = 0.2,
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Greeting",
					Text = "{#Emph}No! {#Prev}Leave the clandestine communications to me." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5001", Text = "...I always thought my father did the judging on his own." },
					},
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Greeting",
						{ Cue = "/VO/Skelly_0642", Text = "He did a good amount." },
					},
				},
			},

			SkellyAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Charon_01" },
					},
					{
						PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
					NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
				},
				{ Cue = "/VO/Melinoe_2924", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you seen, Commander? Lord Charon's come to visit us! At last our supply lines are secure, and our counter-assault begins." },

				{ Cue = "/VO/Skelly_0244",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "Uh, {#Emph}yeah! {#Prev}It's been quite some time since good Lord Charon visited us last. We'd better all be on our best behavior around him! But, {#Emph}uh... {#Prev}where'd you get all that supply-lines stuff?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2925", Text = "Why, he told me himself, sir! In his way." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0245", Text = "Oh..." },
					},
				},
			},
			SkellyAboutCharon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutCharon01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SkellyGift02", "CharonGift02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SkellyAboutCharon01" }, Min = 3 },
					},
				},
				{ Cue = "/VO/Skelly_0246",
					PreLineAnim = "Skelly_Explaining",
					Text = "Say, young one? I'd ask of you a question that pertains to good Lord Charon, if you please. Seems like you understand him pretty good! Has he, {#Emph}uh{#Prev}, said anything of late regarding {#Emph}me...?" },

				{ Cue = "/VO/Melinoe_2926", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, I... I'm sorry, no. But I'll be certain to put in a good word! You've been indispensable, and Lord Charon ought to be aware." },

				{ Cue = "/VO/Skelly_0247",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}No! {#Prev}I mean, {#Emph}um, no{#Prev}, just... don't go doing anything like that! You need not burden more the Boatman with such trivialities, amid such turbulent times...! Don't bother him, OK?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2927", Text = "{#Emph}Erm{#Prev}, OK!" },
					},
				},
			},

			-- if you didn't vanquish Cerberus
			SkellyAboutCerberus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutCerberus01B" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" },
					},
				},
				{ Cue = "/VO/Melinoe_2996", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander. You once held a place of honor in my father's House, so you must know Cerberus? I think I found him in the Mourning Fields, coated in Miasma, heads to paws. Was he always prone to uncontrolled fits of rage?" },
				{ Cue = "/VO/Skelly_0240",
					PreLineAnim = "Skelly_Explaining",
					Text = "Oh, no, he mostly sat around. We go way back, it's just... I kept strategically afar, seeing as he's kind of like a {#Emph}dog{#Prev}, and I'm kind of like a {#Emph}bone. {#Prev}So now he's giving you some trouble, huh?" },
				{ Cue = "/VO/Melinoe_2795", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's not his fault. Chronos must have cast him from the House and put him out to pasture. But if I can just break through all that grime, I'm certain I can calm him down." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0241", Text = "He never did like baths, just so you know..." },
				},
			},
			-- if you vanquished Cerberus
			SkellyAboutCerberus01B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutCerberus01" },
					},
					{
						Path = { "GameState", "EnemyKills", "InfestedCerberus" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Melinoe_2995", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, you once held a place of honor in my father's House. So, you must know Cerberus, right? I found him in the Mourning Fields, coated in Miasma, heads to paws. Was he always prone to uncontrolled fits of rage?" },
				{ Cue = "/VO/Skelly_0240",
					PreLineAnim = "Skelly_Explaining",
					Text = "Oh, no, he mostly sat around. We go way back, it's just... I kept strategically afar, seeing as he's kind of like a {#Emph}dog{#Prev}, and I'm kind of like a {#Emph}bone. {#Prev}So now he's giving you some trouble, huh?" },
				{ Cue = "/VO/Melinoe_2997", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's not his fault. Chronos must have cast him from the House, put him out to pasture. I broke through all the grime, and calmed him down. But he may need another cleansing soon." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0241", Text = "He never did like baths, just so you know..." },
				},
			},

			SkellyAboutCerberus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "H_Boss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "SkellyAboutCerberus01", "SkellyAboutCerberus01B" },
					},
					{
						Path = { "GameState", "EnemyKills", "InfestedCerberus" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Skelly_0626",
					PreLineAnim = "Skelly_Explaining",
					Text = "So how's it going with that giant mutt? Still up to no good in the Mourning Fields? He's probably just {#Emph}bored." },

				{ Cue = "/VO/Melinoe_4987", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've been able to break him free of whatever's taken hold of him there, though the affliction seems to keep coming back." },

				{ Cue = "/VO/Skelly_0627",
					PreLineAnim = "Skelly_Babbling",
					Text = "That figures. He was the dreaded {#DialogLegendaryFormat}Guardian of the Gates{#Prev}! What, you think he'd let you pass just the one time, then never try to block you again?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4988", Text = "I was hoping he would, yes." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0628", Text = "Well, too bad." },
					},
				},
			},

			SkellyAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZagreusPastMeeting04_3", "ZagreusPastMeeting05" },
					},
				},

				{ Cue = "/VO/Skelly_0238",
					PreLineAnim = "Skelly_Explaining",
					Text = "Hey, by the way, I meant to say {#Emph}nice going{#Prev}, on occasion of achieving your objective and all that! You did achieve it, right...? Showed {#DialogLegendaryFormat}Chronos {#Prev}the what-for?" },
				{ Cue = "/VO/Melinoe_2920", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was able to defeat him, yes, Commander. But, my ultimate objective is far from complete." },
				{ Cue = "/VO/Skelly_0239",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Ah, well{#Prev}, that's objectives for you! Soon as one's complete, along comes another... but you are gonna {#Emph}keep {#Prev}knocking 'em dead!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2921", Text = "By your leave." },
				},
			},

			SkellyAboutChronosBossW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},

				{ Cue = "/VO/Skelly_0369",
					PreLineAnim = "Skelly_Explaining",
					Text = "Word reached me that this past night, you achieved what you set out to do, young one! Major congrats on that, all my disciples and myself salute you on a job well done." },
				{ Cue = "/VO/Melinoe_3371", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you, Commander! Though, this was a step toward victory I never could have achieved if not for all the training and counsel from Headmistress, Odysseus, and yourself." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Explaining",
					{ Cue = "/VO/Skelly_0370", Text = "And she even gives credit where credit is due!", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy" }, ReactionChance = 0.2 }, },
				},
			},

			SkellyAboutChronosBossW03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZagreusPastMeeting02_2" },
					},
				},

				{ Cue = "/VO/Skelly_0543",
					PreLineAnim = "Skelly_Explaining",
					Text = "So you smacked Chronos good a couple of times now! Remind these Shades and me what is to happen next: How are you gonna kill that which continues coming back?" },
				{ Cue = "/VO/Melinoe_4353", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, though it's tempting to share all my latest progress, we both know I'm never to divulge the details of my task. Not even to you." },
				{ Cue = "/VO/Skelly_0544",
					PreLineAnim = "Skelly_Salute",
					Text = "{#Emph}Not even to me. {#Prev}But can you say at least, your brother, is he gonna be all right? Been worrying about the guy is all..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_4354", Text = "Nice try, sir." },
				},
			},

			SkellyAboutChronosBossL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = "<=",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},

				{ Cue = "/VO/Skelly_0629",
					PreLineAnim = "Skelly_Explaining",
					Text = "My disciples indicate you reached your destination but you choked a little right there at the end. Well, that's rough. To have come {#Emph}that {#Prev}far only to wind up {#Emph}all {#Prev}the way back here..." },
				{ Cue = "/VO/Melinoe_4989", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, this is not the type of encouragement that's of benefit right now. I had Chronos cornered, but he overpowered me. And now I've lost the element of surprise!" },
				{ Cue = "/VO/Skelly_0630",
					PreLineAnim = "Skelly_Babbling",
					Text = "Ooh, {#Emph}yeah{#Prev}, that's bad. Look, I hate to say this but I'd probably {#DialogLegendaryFormat}hang it up {#Prev}if I was you. Blowin' a chance like that?" },
				EndVoiceLines =
				{
					PreLineWait = 0.33,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_4990", Text = "Commander...!" },
				},
			},

			SkellyAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/Melinoe_3807", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, what is the consensus here about Prometheus? If some mortals venerated him, perhaps you and your disciples feel conflicted that he now opposes us." },
				{ Cue = "/VO/Skelly_0399",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 8.4 },
					Text = "The Titan who brought fire, reason, good eats, and the arts and stuff to mortalkind... then faced the vengeance of the gods for all of that. Can't stand the guy! Let him have it!" },
				{ Cue = "/VO/Melinoe_3808", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, you can't stand him even though he did so much for you? Though mortals can be difficult to please..." },
				{ Cue = "/VO/Skelly_0400",
					PreLineAnim = "Skelly_Salute",
					Text = "Well let's see, has he been nice to you, or has he tried to kill you? So what if he buttered us up way back when! Not like he's done much for us lately." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3809", Text = "He {#Emph}has {#Prev}tried to kill me..." },
				},
			},

			SkellyAboutTyphon01 =
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
				},

				{ Cue = "/VO/Skelly_0454",
					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteSparkly",
					Text = "Mind telling all these Shades that {#Emph}no{#Prev}, the {#DialogLegendaryFormat}Father of All Monsters {#Prev}{#Emph}isn't {#Prev}back? Because they're so caught up with this outrageous rumor, they don't buy it when {#Emph}I {#Prev}tell 'em!" },
				{ Cue = "/VO/Melinoe_4059", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, the thing is... I confronted Typhon himself just last night. While Chronos schemes from the Underworld, that monstrosity attacks Olympus." },
				{ Cue = "/VO/Skelly_0455",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Salute",
					PreLineWait = 0.3,
					Text = "Oh! I, {#Emph}uh{#Prev}, I... {#Emph}knew {#Prev}all that, it's just... I was checking to see if my disciples had the nerve to stand up for that which they truly believed! And they did. Nice going, everyone!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4060", Text = "So you knew of Typhon's return?" },
					},
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0456", Text = "Yeah! Yeah..." },
					},
				},
			},
			SkellyAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},

				{ Cue = "/VO/Skelly_0457",
					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteSparkly",
					Text = "Hey, {#Emph}uh{#Prev}, would you attest to my disciples that I've taught you a great deal when it comes to fighting {#DialogLegendaryFormat}Typhon{#Prev}? They've been getting a little unruly and, {#Emph}uh{#Prev}, you'd be doing me a favor!" },
				{ Cue = "/VO/Melinoe_4061", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Pleased_01", WaitTime = 3.2 },
					Text = "But Commander, you've not told me anything about him... {#Emph}ah{#Prev}, I know what this is. You wish to see if I would stoop to speaking falsehoods merely because I was asked!" },
				{ Cue = "/VO/Skelly_0458",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Salute",
					Text = "Um, {#Emph}yeah! {#Prev}Yeah that's right. And I'm asking real nicely, c—come on, young one, would you just do this for me here...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4062", Text = "I'll not bring shame upon us both.", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconDetermined" }, ReactionChance = 0.2 }, },
					},
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0459", Text = "{#Emph}...Dammit." },
					},
				},
			},
			SkellyAboutTyphon03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "TyphonHead" }
					},
				},

				{ Cue = "/VO/Melinoe_4228", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, how am I to overcome a foe whose life-force is completely undetectable? Typhon the Bringer of Storms conceals his strength from me... but it must have its limits." },
				{ Cue = "/VO/Skelly_0541",
					PreLineAnim = "Skelly_Explaining",
					Emote = "PortraitEmoteSparkly",
					Text = "You know, young one, most of us can't sense another's life-force quite like you. We just hit each other till somebody ends up dead! Maybe there's signs, like {#DialogLegendaryFormat}cuts {#Prev}and {#DialogLegendaryFormat}bruises {#Prev}and whatnot?" },
				{ Cue = "/VO/Melinoe_4229", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's not impervious. The gods have vanquished him before using sheer force..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Salute",
						{ Cue = "/VO/Skelly_0542", Text = "Just let him have it! Works with everybody {#Emph}else!" },
					},
				},
			},
			SkellyAboutTyphonW01 =
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
						PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},

				{ Cue = "/VO/Skelly_0460",
					PreLineAnim = "Skelly_Explaining",
					Text = "Settle a little wager here, young one. These Shades are making claims {#Emph}you {#Prev}felled the {#DialogLegendaryFormat}Father of All Monsters{#Prev}! I, however, am the voice of reason, and I say {#Emph}come onnn." },
				{ Cue = "/VO/Melinoe_4063", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Typhon's recent defeat certainly wasn't my doing alone, Commander. We have Olympus on our side, and more!" },
				{ Cue = "/VO/Skelly_0461",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Salute",
					Text = "Oh! Right, {#Emph}um{#Prev}, yeah, that's what I said: Technically, it wasn't just {#Emph}you{#Prev}. Hear that, disciples?! She had a bunch of those fancy {#DialogLegendaryFormat}Boons {#Prev}and who only knows what else!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4064", Text = "Then you win the wager?" },
					},
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0462", Text = "Damn right!", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconGrief" }, ReactionChance = 0.2 }, },
					},
				},
			},
			SkellyAboutTyphonW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "CurrentRun", "BountyCleared" }
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTyphonW01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
					},
					{
						SumPrevRuns = 3,
						Path = { "Cleared" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Skelly_0478",
					PreLineAnim = "Skelly_Explaining",
					Text = "You have repeatedly knocked {#DialogLegendaryFormat}Typhon {#Prev}from his perch! Mayhaps {#Emph}the bigger they are... the harder they fall." },
				{ Cue = "/VO/Melinoe_4165", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've never thought of it that way before, Commander, but you're right! The Cyclops Polyphemus also falls quite hard." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Greeting",
						{ Cue = "/VO/Skelly_0479", Text = "Because of his size, you see!" },
					},
				},
			},

			SkellyAboutCatastrophe01 =
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
				},

				{ Cue = "/VO/Melinoe_4065", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How is the morale amongst all your disciples recently, Commander? Prometheus and Typhon present imposing threats that may shake even the greatest resolve." },
				{ Cue = "/VO/Skelly_0463",
					PreLineAnim = "Skelly_Explaining",
					Text = "{#Emph}Eh {#Prev}they're {#Emph}fine! {#Prev}Just look at 'em, brave as you're gonna get. No matter what catastrophe should come to pass, it's just another night to us here!" },
				{ Cue = "/VO/Melinoe_4066", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're trying to {#Emph}prevent {#Prev}catastrophe, not let it become the norm. Well, please let me know if anything changes. We need you all at your best." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Babbling",
						{ Cue = "/VO/Skelly_0464", Text = "Hear that, you slackers? Better bring your best, or {#Emph}else!", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconGrief" }, ReactionChance = 0.2 }, },
					},
				},
			},

			SkellyAboutRouteChoice01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					OrRequirements =
					{
						-- did Surface followed by Underworld run
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "N_Opening01" },
							},
							{
								PathTrue = { "CurrentRun", "BiomesReached", "F" }
							},
						},
						-- did Underworld followed by Surface run
						{
							{
								PathTrue = { "PrevRun", "BiomesReached", "F" }
							},
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
							},
						},
					},
				},
				{ Cue = "/VO/Skelly_0144",
					Text = "I sense a great weight bearing down on you, young one. Not quite as bad as what old Atlas got, but still!" },
				{ Cue = "/VO/Melinoe_1580", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What do you advise as my next move, Commander: to pursue our enemy in the Underworld, or come to the aid of Olympus?" },
				{ Cue = "/VO/Skelly_0145",
					Text = "Well not to be all greedy here, {#Emph}but{#Prev}... I say go wherever you can get the stuff you need the most, right {#Emph}now! {#Prev}We got some stuff down here they don't got up there, and so on, right?" },
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Melinoe_1581", Text = "...I suppose..." },
				},

			},

			SkellyAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						Path = { "GameState", "Resources", "PlantNMoss" },
						Comparison = "<",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				{ Cue = "/VO/Skelly_0494",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 3.0 },
					PreLineAnim = "Skelly_Explaining",
					Text = "You're brave to venture through that previously-warded gateway, but come {#Emph}on! {#Prev}You Underworld types aren't cut out for surface life! Unless perchance there is an {#DialogLegendaryFormat}Incantation {#Prev}that could help..." },
				{ Cue = "/VO/Melinoe_3366", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "I think there is, Commander, except... it calls for reagents that can only be found up {#Emph}there... {#Prev}but, how am I supposed to gather them before the incantation is complete?" },
				{ Cue = "/VO/Skelly_0363",
					PreLineAnim = "Skelly_Babbling",
					Text = "Mayhaps just {#DialogLegendaryFormat}make a run for it{#Prev}, I don't know. So what if you can't stay long, just grab what you need and get out of there!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3367", Text = "It's not ideal, but..." },
				},
			},
			SkellyAboutSurface02 =
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
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAll = { "WorldUpgradeShadeMercs", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				{ Cue = "/VO/Skelly_0142",
					Text = "You remained upon the surface for considerably longer than before. How was it, any good?" },
				{ Cue = "/VO/Melinoe_1578", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "War rages above. The Olympians sent Heracles himself to contain the damage. Shades of the dead linger everywhere. So... {#Emph}not {#Prev}good, all in all." },
				{ Cue = "/VO/Skelly_0143",
					Text = "Shades of the dead! Sure sounds like more disciples we can use. {#Emph}Eh{#Prev}, {#DialogLegendaryFormat}sprint into 'em{#Prev}, will you?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_1579", Text = "Yes, sir." },
				},
			},
			SkellyAboutSurface03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "O_Boss01", "O_Boss02" },
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAll = { "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "ClearedSurfaceRunsCache" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Skelly_0495",
					PreLineAnim = "Skelly_Explaining",
					Text = "I understand your recent journey to the surface didn't last so long, young one. Life's hard up there, and always gonna be! Not like your cushy Underworld." },
				{ Cue = "/VO/Melinoe_4177", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not accustomed to it yet. Everything's intensified... whenever I fail to evade a foe, I feel it even more." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Salute",
					{ Cue = "/VO/Skelly_0496", Text = "Oh you're not gonna have an easy time." },
				},
			},

			SkellyAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "G_Intro" },
					},
					{
						PathFalse = { "PrevRun", "RoomsEntered", "H_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0077",
					Text = "I understand you ventured to the bottom of the sea. I, too, have been there in those depths, young one! But once, awhile back, and briefly, I might add!" },
				{ Cue = "/VO/Melinoe_1044", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course...! You were a famous mariner in your mortal days! But, then you finally met your end beneath the waters upon which you sailed?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0078", Text = "Nah! 'Twas way more glorious than that." },
				},
			},
			SkellyAboutOceanus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "G_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "H_Intro" },
						Comparison = "<=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Skelly_0187",
					Text = "How have you lately fared against the Lurkers and the Serpents all that way down in the watery depths? Knowing of 'em and squaring off against 'em are two very different things." },
				{ Cue = "/VO/Melinoe_2531", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They're significantly stronger than the Lost Souls lingering around here. And they have no sense of fear at all, attacking without any hesitation." },
				{ Cue = "/VO/Skelly_0188",
					Text = "They're basically just walking fish, young one. Not much for conversating, but they'll stick you with a trident just fine! Don't you let 'em." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2532", Text = "I won't." },
				},
			},

			SkellyAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0079",
					Text = "How fared your recent surface sea-journey, young one? I still remember well the boundless waters there. How blue and tranquil they were!" },
				{ Cue = "/VO/Melinoe_1045", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "{#Emph}Tranquil? {#Prev}My experience was not exactly that." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0080", Text = "They were tranquil, damn it..." },
				},
			},

			SkellyAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Intro" },
					},
					{
						Path = { "CurrentRun", "EnemyKills" },
						HasAny = { "SentryBot", "SentryBot_Elite", "AutomatonBeamer", "AutomatonBeamer_Elite", "AutomatonEnforcer", "AutomatonEnforcer_Elite" },
					},
				},
				{ Cue = "/VO/Skelly_0396",
					PreLineAnim = "Skelly_Explaining",
					Text = "My disciples and I all salute you on account of having made it up to the big mountain, young one! Back when we drew breath, we could only dream of those hallowed heights..." },
				{ Cue = "/VO/Melinoe_3805", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I appreciate the encouragement, Commander, but I've got a bit of a climb still. The legions of Chronos are there in droves... and the mountain's defenses can't tell us apart." },
				{ Cue = "/VO/Skelly_0397",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "Surely you jest! The mechanical marvels wrought by the gods themselves turned their deadly appendages on {#Emph}you? {#Prev}When you went all that way to help 'em out?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3806", Text = "Basically yes." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Salute",
						{ Cue = "/VO/Skelly_0398", Text = "{#Emph}Eh {#Prev}that's too bad." },
					},
				},

			},

			SkellyAboutGiftRack01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "KeepsakeRack" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutGiftRack02" },
					},
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = "<=",
						Value = 12,
					},
				},
				{ Cue = "/VO/Melinoe_1046", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The old storage case... so, it's an heirloom from my family." },
				{ Cue = "/VO/Skelly_0083",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 8.6 },
					PreLineAnim = "Skelly_Explaining",
					Text = "That it is, and for as long as I can recollect. Look upon it knowing that the burden which you bear, you need not bear alone. Plus it'll keep your {#DialogLegendaryFormat}Keepsakes {#Prev}all in one handy spot!" },
				{ Cue = "/VO/Melinoe_1047", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A symbol of the gift-giving custom of Olympus, then. A tradition that now falls to us." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0084", Text = "Yep." },
				},
			},
			SkellyAboutGiftRack02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = "<=",
						Value = 20,
					},
				},
				{ Cue = "/VO/Skelly_0085",
					Text = "You're beginning to fill out that {#DialogLegendaryFormat}Keepsake {#Prev}storage case, young one. Fine work, yet I must caution you not to collect just for collecting's sake..." },
				{ Cue = "/VO/Melinoe_1048", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The act of giving is its own intangible reward. Nectar sours when it's offered with impure intent." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0086", Text = "Won't have impure intent on my damn training grounds." },
				},
			},

			SkellyAboutUnusedWeaponBonus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonus" },
					},
					{
						SumPrevRuns = 4,
						Path = { "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0174",
					Text = "There's something up with those Nocturnal Arms of yours... a certain {#Emph}aura {#Prev}that's surrounding one of them. The {#DialogLegendaryFormat}Grave Thirst{#Prev}..." },
				{ Cue = "/VO/Melinoe_2490", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A relatively simple incantation. I expected there was more to the connection between Night's weapons and the dead. No wonder you can see it, too." },
				{ Cue = "/VO/Skelly_0343",
					PreLineAnim = "Skelly_Explaining",
					Text = "Come, now... not like I need eyes on the back of my cranium! But I can feel it in my bones! Want more {#DialogLegendaryFormat}Bones {#Prev}yourself, just {#DialogLegendaryFormat}use the weapon with the Thirst{#Prev}!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2491", Text = "Whenever possible." },
				},
			},

			SkellyAboutExorcismBook01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "ExorcismSuccessesManual" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "CurrentRun", "ExorcismSuccessesManual" },
					},
				},
				{ Cue = "/VO/Skelly_0226",
					Emote = "PortraitEmoteSparkly",
					Text = "Way to go with that {#DialogLegendaryFormat}Tablet of Peace{#Prev}, young one! Our ranks are beginning to swell with Shades who may yet find great purpose in their immortal coil!",
				},
				{ Cue = "/VO/Melinoe_2495", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Their lives, such as they are, will only improve once my father is restored to his rightful throne." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0184", Text = "Oh there's no doubt of that! But first, we fight!", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconDetermined" }, ReactionChance = 0.2 }, },
				},
			},

			SkellyAboutBountyBoard01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
					},
				},
				{ Cue = "/VO/Skelly_0089",
					Text = "My disciples, they were given quite a fright when that {#DialogLegendaryFormat}Pitch-Black Stone {#Prev}there suddenly lit up. You know what it is, do you not?" },
				{ Cue = "/VO/Melinoe_2818", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A shard of purest darkness from the depths of Chaos... in its countless facets, countless outcomes. Perhaps none of which the Fates have preordained." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0090", Text = "{#Emph}Uhh{#Prev}, yep." },
				},
			},
			SkellyAboutBounties01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				AllowPostBounty = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutBountyBoard01" },
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "PackagedBountyAttempts" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0248",
					PreLineAnim = "Skelly_Explaining",
					Text = "We all saw you disappear into that {#DialogLegendaryFormat}Pitch-Black Stone{#Prev}. Another means by which you may spring into action, retaining the element of surprise! {#Emph}Pretty nice!" },
				{ Cue = "/VO/Melinoe_2928", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That Stone has been here all this time. It's so much more than a monument to Night, and its origins, even more ancient. But I never considered it a weapon in our arsenal..." },
				{ Cue = "/VO/Skelly_0249",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well, not like you can crack me over the head with it, but {#Emph}yeah!" },
			},
			SkellyAboutBountyBoard02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				AllowPostBounty = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutBountyBoard01" },
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "PackagedBountyAttempts" },
						UseLength = true,
						Comparison = ">=",
						Value = 6,
					},
				},
				{ Cue = "/VO/Skelly_0465",
					PreLineAnim = "Skelly_Explaining",
					Text = "You keep on vanishing into the {#DialogLegendaryFormat}Pitch-Black Stone{#Prev}, young one. My disciples and I, we've been thinking must be something pretty good in there!" },
				{ Cue = "/VO/Melinoe_4154", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well Commander, it's not exactly a feast on the other side. Whenever I use the Stone, in many ways it's just like any other night, except... I really shouldn't say." },
				{ Cue = "/VO/Skelly_0466",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Aw {#Prev}c'mon why not? Not like somebody's gonna tell on you, I mean, have we not earned your trust, or what?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4155", Text = "The Stone reveals its own secrets, not I." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0467", Text = "Seriously?" },
					},
				},
			},

			SkellyAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutShrine02" },
					},
					NamedRequirements =  { "ShrineUnlocked" },
				},
				{ Cue = "/VO/Skelly_0231",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 4.8 },
					Text = "Your eyes do not deceive! Near the gateways outta here you'll find none other than the {#DialogLegendaryFormat}Oath of the Unseen{#Prev}, I think it's called. Ask me not whence it came... instead ask just how {#Emph}tough {#Prev}you really are!" },
				{ Cue = "/VO/Melinoe_2813", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I earned the right to look upon the Oath... the Testaments of Night. Do I dare speak the vows? And thereby spread the Fear that darkness brings...?" },
				{ Cue = "/VO/Skelly_0232",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "Come on, what are you, {#Emph}scared? {#Prev}Those Nocturnal Arms you got, they probably are gonna love that {#DialogLegendaryFormat}Fear {#Prev}and {#DialogLegendaryFormat}Testament {#Prev}type stuff. I say give it a shot! What's the worst that could happen?" },
				{ Cue = "/VO/Melinoe_2814", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All mortalkind condemned to never-ending torment and despair...?" },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Salute",
					{ Cue = "/VO/Skelly_0233", Text = "It's gonna be {#Emph}fine!" },
				},
			},

			SkellyAboutShrine02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "WeaponPointsRare", },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Skelly_0234",
					PreLineAnim = "Skelly_Explaining",
					Text = "How goes it with the never-ending torment stuff, now that you've got that {#DialogLegendaryFormat}Oath {#Prev}thing over there? Those {#DialogLegendaryFormat}Nocturnal Arms {#Prev}of yours, they must be having a {#Emph}great {#Prev}time!" },
				{ Cue = "/VO/Melinoe_2815", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Arms of Night... they're reacting to the Oath, I think. Growing stronger as her Testaments are carried out. Drinking the very Nightmares born of mortals' fear of the dark." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0235", Text = "Now {#Emph}that {#Prev}is what I like to hear!" },
				},
			},

			SkellyAboutShrine03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutShrine02" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = ">",
						Value = 3,
					},
				},
				{ Cue = "/VO/Melinoe_2816", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Even in all your wisdom, Commander... how is it that you know so much about the Oath of the Unseen? As far as I know it pre-dates even my father's rule within the Underworld." },
				{ Cue = "/VO/Skelly_0236",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh yeah, your papa took a different tack. Was all about his Pacts of Punishment! He even served your brother with 'em once, when they were really on the outs. But boyo just went for it, and then things {#Emph}really {#Prev}heated up!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2817", Text = "You didn't answer my question." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Salute",
						{ Cue = "/VO/Skelly_0237", Text = "And I'm not gonna! For I made certain Vows myself." },
					},
				},
			},

			SkellyAboutShrine04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutShrine02" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathTrue = { "CurrentRun", "ShrineBountiesCompleted" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = ">",
						Value = 3,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "WeaponPointsRare", },
						Comparison = ">=",
						Value = 6,
					},
				},
				{ Cue = "/VO/Skelly_0491",
					PreLineAnim = "Skelly_Explaining",
					Text = "We feared the worst on such a terrifying night. Not so easy out there with that {#DialogLegendaryFormat}Oath of the Unseen {#Prev}doing its thing!" },
				{ Cue = "/VO/Melinoe_4175", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Vows do make my task more difficult; but they make me grow stronger, little by little. Are you suggesting I let up?" },
				{ Cue = "/VO/Skelly_0492",
					PreLineAnim = "Skelly_Babbling",
					Text = "I mean I'm only saying if it's all too much you ought to turn that thing back down, nobody's judging over here! I'd rather you {#Emph}let {#Prev}up than {#Emph}give {#Prev}up." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4176", Text = "Neither is best." },
					},
				},
			},

			SkellyAboutNotUsingShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "CurrentRun", "BountyCleared" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "Cleared" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
						Comparison = "<=",
						Value = 4,
					},
					{
						Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
						Comparison = "<=",
						Value = 4,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = "<=",
						Value = 4,
					},
					NamedRequirements =  { "ShrineUnlocked" },
				},
				{ Cue = "/VO/Skelly_0475",
					PreLineAnim = "Skelly_Babbling",
					Text = "Must think you're pretty tough by now, don't you, beating Chronos or whoever down again and again! But are you pushing yourself to the fullest? Or taking it {#DialogLegendaryFormat}easy{#Prev}?" },
				{ Cue = "/VO/Melinoe_4163", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Few would consider the task of vanquishing the Titan of Time to be an easy one, Commander. Though I take your meaning. The Oath of the Unseen beckons..." },
				{ Cue = "/VO/Skelly_0476",
					PreLineAnim = "Skelly_Explaining",
					-- PreLineAnim = "Skelly_Babbling",
					-- PreLineAnim = "Skelly_Salute",
					-- PreLineAnim = "Skelly_Greeting",
					Emote = "PortraitEmoteSurprise",
					Text = "Come on, {#Emph}use it{#Prev}, my disciples and I are practically daring you! {#Emph}You'll {#Prev}get to spruce up your {#DialogLegendaryFormat}Nocturnal Arms{#Prev}, {#Emph}we'll {#Prev}get to see what happens! {#Emph}Win-win!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4164", Text = "Unless I fail." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0477", Text = "{#Emph}You? {#Prev}C'mon." },
					},
				},
			},

			SkellyAboutAltar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MemPointsCommon", },
						Comparison = ">=",
						Value = 20,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Skelly_0191",
					Emote = "PortraitEmoteSparkly",
					Text = "The incense and the smoke and stuff from that {#DialogLegendaryFormat}Altar of Ashes {#Prev}over there, it's energized the Shades about this place! And me, as well." },
				{ Cue = "/VO/Melinoe_2588", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm pleased to hear it, Commander. Even a brief visit to the Altar on a given night helps make me feel more prepared." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Skelly_0192", Text = "Keep doing what you're doing over there!" },
				},
			},

			SkellyAboutGodMode01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "RoomsEntered", "F_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "F_PostBoss01" },
					},
					{
						PathFalse = { "ConfigOptionCache", "EasyMode" },
					},
					{
						PathFalse = { "GameState", "TraitsTaken", "GodModeTrait" },
					},
				},
				{ Cue = "/VO/Skelly_0242",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 8.0 },
					Text = "Your struggles never are in vain, young one! You're no mere mortal; with each passing night, you grow in knowledge and in strength! 'Specially if you throw on that {#DialogLegendaryFormat}God Mode{#Prev}, then there won't be any stopping you!" },
				{ Cue = "/VO/Melinoe_2922", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Would that godhood was enough, Commander. Though, the last thing you said... {#Emph}erm{#Prev}, what exactly did you mean?" },
				{ Cue = "/VO/Skelly_0243",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh, {#DialogLegendaryFormat}God Mode{#Prev}? Well, it's this {#Emph}mode{#Prev}, you see. One which you're able to {#Emph}throw on! {#Prev}Or to throw off, entirely at whim! It's just an option's all I'm trying to say, so use it if you please!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2923", Text = "Just an option..." },
				},
			},

			SkellyAboutFamiliars01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", "CatFamiliar", "RavenFamiliar", "HoundFamiliar", "PolecatFamilair" },
					},
				},
				{ Cue = "/VO/Skelly_0081",
					Text = "You have an {#DialogLegendaryFormat}Animal Familiar {#Prev}now! Well, your disciples are my disciples, young one. They shall be trained and cared for here while you're away, and they can fight me also if they like?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,

					{ Cue = "/VO/Melinoe_3552_B", Text = "Yes, sir." },
				},
			},

			SkellyAboutCosmetics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutCosmetics01" },
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "PreRun" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Skelly_0401",
					PreLineAnim = "Skelly_Explaining",
					Text = "My disciples are appreciative for all of the improvements to these training grounds, young one! Soon we shall have a proper war camp here!" },
				{ Cue = "/VO/Melinoe_3810", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Anything we can do to raise morale is worth our while. Are there other improvements that you'd like to see?" },
				{ Cue = "/VO/Skelly_0402",
					PreLineAnim = "Skelly_Salute",
					Text = "Ah well, as you know I have but modest needs! A good smack in the head now and again is all that I require." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3811", Text = "Just let me know if there's anything else." },
				},
			},

			SkellyAboutDagger01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponDagger" },
					},
				},
				{ Cue = "/VO/Skelly_0176",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah{#Prev}, to have felt the deadly sting of the {#DialogLegendaryFormat}Sister Blades{#Prev}! Mayhaps these are the {#Emph}sharpest {#Prev}blades with which I've ever been {#Emph}sliced!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2492", Text = "I'm honored to bear them." },
				},
			},
			SkellyAboutHiddenDaggerAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect" },
					},
				},
				{ Cue = "/VO/Skelly_0503",
					Text = "So you've awakened newfound power in those Blades of yours. I figured they could pull a fancy trick like that! Your brother, his old weapons all worked pretty much the same!" },
				{ Cue = "/VO/Melinoe_4273", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Infernal Arms had hidden Aspects, too... though whose, I wonder. Perhaps one of your own, Commander! The Fates bestowed their weapons to heroes, as well as gods..." },
				{ Cue = "/VO/Skelly_0504",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "Careful there, young one! The secrets of the Arms are never to be loudly blabbed about..." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_4274", Text = "Of course. Apologies." },
				},
			},			
			SkellyAboutAxe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponAxe" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "AxePerfectCriticalAspect", "AxeRallyAspect" },
					},
				},
				{ Cue = "/VO/Skelly_0177",
					Text = "The monstrous power of the {#DialogLegendaryFormat}Moonstone Axe {#Prev}is yours! There isn't much out there it couldn't chop clean through, including {#Emph}me!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2493", Text = "It's got some heft." },
				},
			},
			SkellyAboutTorch01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponTorch" },
					},
				},
				{ Cue = "/VO/Skelly_0180",
					Text = "The {#DialogLegendaryFormat}Umbral Flames{#Prev}, young one! You're the spitting image of the big lady herself with those in hand. May they ever light your way, and light up anybody you don't like." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2494", Text = "I'll fight like Headmistress herself." },
				},
			},
			SkellyAboutLob01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponLob" },
					},
				},
				{ Cue = "/VO/Skelly_0403",
					PreLineAnim = "Skelly_Explaining",
					Text = "I must salute the bearer of the {#DialogLegendaryFormat}Argent Skull{#Prev}! Would that my own cranium were thusly reinforced with silver and could explode with such spectacular results!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Melinoe_3812", Text = "One good skull deserves another." },
				},
			},
			SkellyAboutSuit01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponSuit" },
					},
				},
				{ Cue = "/VO/Skelly_0404",
					PreLineAnim = "Skelly_Babbling",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 6.1 },
					Text = "So {#Emph}this {#Prev}is the {#DialogLegendaryFormat}Black Coat{#Prev}! An armament such as the world has never before seen! Probably because that thing can punch or blow up anybody fool enough to cross your path!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Melinoe_3813", Text = "It fits like it was made for me..." },
				},
			},

			-- trophy quest / skelly statues
			SkellyAboutTrophyQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Skelly",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestUnlocked" },
					NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
				},
				{ Cue = "/VO/Skelly_0303",
					PreLineAnim = "Skelly_Explaining",
					Text = "Your myriad accomplishments thus far are nothing in comparison to that which you now stand to gain, young one! {#DialogLegendaryFormat}Eternal glory {#Prev}can be yours, if you but prove your worth!" },
				{ Cue = "/VO/Melinoe_3269", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The patterns on that drapery... the secret Gifts of the Veil, bestowed on Night's most dedicated servants...! Commander, what are they doing here? Shades are never to look upon them!" },
				{ Cue = "/VO/Skelly_0304",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well let's just say the rules have lately changed! Those {#Emph}Gifts{#Prev}, as you refer to them, are yours to earn... provided you can do the stuff the {#DialogLegendaryFormat}Oath of the Unseen {#Prev}would ask of you! Which, as you probably surmised, shall be no simple feat." },
				{ Cue = "/VO/Melinoe_3270", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps a test merely of greed and arrogance... to overextend with the Oath may put my task in jeopardy." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					PreLineAnim = "Skelly_Greeting",
					ObjectType = "NPC_Skelly_01",
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Skelly_0305", Text = "{#Emph}C'mon{#Prev}, don't be such a {#Emph}baby!" },
				},
			},

			SkellyAboutTrophyQuest02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/Melinoe_3293", "/VO/Melinoe_3294", "/VO/Melinoe_3295" },
					},
					NamedRequirementsFalse = { "TrophyQuestStage3Complete" },
				},
				{ Cue = "/VO/Skelly_0306",
					PreLineAnim = "Skelly_Babbling",
					Text = "So are you gonna earn the Gifts of the Veil over there? Or squander your chance to get some of that {#DialogLegendaryFormat}eternal glory{#Prev}?" },
				{ Cue = "/VO/Melinoe_3271", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eternal glory... if such a thing may come to those who manage to achieve extraordinary feats, so be it. But to chase glory as a goal unto itself? That can't be right... at least, it's never been our way." },
				{ Cue = "/VO/Skelly_0307",
					PreLineAnim = "Skelly_Explaining",
					Text = "But our ways can {#Emph}change{#Prev}, wouldn't you say? We mustn't become mired in the olden ways of doing things! Though I don't mean to pressure you, kiddo, it's just... I think you ought to get what's yours, is all." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3272", Text = "...I'll think about it." },
					},
				},
			},

			SkellyAboutTrophyQuestProgress01_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress01_B", "TrophyQuestComplete01" },
					},
					NamedRequirements = { "TrophyQuestStage1CheckA" },
					NamedRequirementsFalse = { "TrophyQuestStage1CheckB" },
				},
				{ Cue = "/VO/Skelly_0358_B",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "Halfway to victory, kiddo! But to earn the Gifts of the Veil, one must conquer the Underworld {#Emph}and {#Prev}the surface realms upon a {#DialogLegendaryFormat}Fear{#Prev}-ful night, each in turn. You up for it?" },
				{ Cue = "/VO/Melinoe_3362", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For the glory of the Underworld and the everlasting rule of Night, I would do everything in my ability. Whether that makes me worthy of the Gifts of the Veil, I know not." },
				{ Cue = "/VO/Skelly_0359",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}C'mon{#Prev}, what kind of attitude is {#Emph}that? {#Prev}You did the Underworld already, now you just got to do the surface, and the Gifts are {#Emph}yours! {#Prev}First one of 'em at least. Come on, do it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3363", Text = "OK...!" },
					},
				},
			},
			SkellyAboutTrophyQuestProgress01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress01_A", "TrophyQuestComplete01" },
					},
					NamedRequirements = { "TrophyQuestStage1CheckB" },
					NamedRequirementsFalse = { "TrophyQuestStage1CheckA" },
				},
				{ Cue = "/VO/Skelly_0358",
					PreLineAnim = "Skelly_Explaining",
					Text = "Halfway to victory, young one! But to earn the Gifts of the Veil, one must conquer the Underworld {#Emph}and {#Prev}the surface realms upon a {#DialogLegendaryFormat}Fear{#Prev}-ful night each in turn. You up for it?" },
				{ Cue = "/VO/Melinoe_3362", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For the glory of the Underworld and the everlasting rule of Night, I would do everything in my ability. Whether that makes me worthy of the Gifts of the Veil, I know not." },
				{ Cue = "/VO/Skelly_0360",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}C'mon{#Prev}, what kind of attitude is {#Emph}that? {#Prev}You did the surface already, now you just got to do the Underworld, and the Gifts are {#Emph}yours! {#Prev}First one of 'em at least. Come on, do it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3363", Text = "OK...!" },
					},
				},
			},

			-- identical copy below (different prereqs)
			SkellyAboutTrophyQuestProgress02_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress02_B", "TrophyQuestComplete02" },
					},
					NamedRequirements = { "TrophyQuestStage2CheckA" },
					NamedRequirementsFalse = { "TrophyQuestStage2CheckB" },
				},
				{ Cue = "/VO/Skelly_0372",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "The second {#DialogLegendaryFormat}Gift of the Veil {#Prev}is {#Emph}almost {#Prev}within reach! Could actually just go right up and touch it, b-but anyway a-are you prepared to use the {#DialogLegendaryFormat}Oath {#Prev}and go the other way?" },
				{ Cue = "/VO/Melinoe_3485", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't mean to leave you in suspense, Commander, but we'll just have to see." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0373", Text = "I shall be waiting here with the equivalent of bated breath!" },
					},
				},
			},
			SkellyAboutTrophyQuestProgress02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress02_A", "TrophyQuestComplete02" },
					},
					NamedRequirements = { "TrophyQuestStage2CheckB" },
					NamedRequirementsFalse = { "TrophyQuestStage2CheckA" },
				},
				{ Cue = "/VO/Skelly_0372",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "The second {#DialogLegendaryFormat}Gift of the Veil {#Prev}is {#Emph}almost {#Prev}within reach! Could actually just go right up and touch it, b-but anyway a-are you prepared to use the {#DialogLegendaryFormat}Oath {#Prev}and go the other way?" },
				{ Cue = "/VO/Melinoe_3485", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't mean to leave you in suspense, Commander, but we'll just have to see." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0373", Text = "I shall be waiting here with the equivalent of bated breath!" },
					},
				},
			},

			-- identical copy below (different prereqs)
			SkellyAboutTrophyQuestProgress03_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress03_B", "TrophyQuestComplete03" },
					},
					NamedRequirements = { "TrophyQuestStage3CheckA" },
					NamedRequirementsFalse = { "TrophyQuestStage3CheckB" },
				},
				{ Cue = "/VO/Skelly_0374",
					PreLineAnim = "Skelly_Explaining",
					Text = "The final and most monumental {#DialogLegendaryFormat}Gift of the Veil {#Prev}is so close at hand! If you can get through {#Emph}one {#Prev}of your two routes under the Oath, then surely the rest is but a walk in the park!" },
				{ Cue = "/VO/Melinoe_3486", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can only assume a walk in this {#Emph}park {#Prev}you cite must be an absolutely grueling experience." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0375", Text = "Some parts of town? {#Emph}Ohh {#Prev}yeah." },
					},
				},
			},
			SkellyAboutTrophyQuestProgress03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress03_A", "TrophyQuestComplete03" },
					},
					NamedRequirements = { "TrophyQuestStage3CheckB" },
					NamedRequirementsFalse = { "TrophyQuestStage3CheckA" },
				},
				{ Cue = "/VO/Skelly_0374",
					PreLineAnim = "Skelly_Explaining",
					Text = "The final and most monumental {#DialogLegendaryFormat}Gift of the Veil {#Prev}is so close at hand! If you can get through {#Emph}one {#Prev}of your two routes under the Oath, then surely the rest is but a walk in the park!" },
				{ Cue = "/VO/Melinoe_3486", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can only assume a walk in this {#Emph}park {#Prev}you cite must be an absolutely grueling experience." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0375", Text = "Some parts of town? {#Emph}Ohh {#Prev}yeah." },
					},
				},
			},

			SkellyAboutTrophyQuest03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				{ Cue = "/VO/Melinoe_3288", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To think the Gifts of the Veil were those statues... I always thought it was the Veils themselves... the draperies, sewn with the finest fabric of the Fates. Where are they anyway?" },
				{ Cue = "/VO/Skelly_0322",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh, those? We, {#Emph}uh{#Prev}, we sent 'em back into the shadows whence they came. They were just packing materials, you know? You got the {#DialogLegendaryFormat}real deal{#Prev}, I swear!" },
				{ Cue = "/VO/Melinoe_3289", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I still cannot entirely believe that Night would honor me with such an ostentatious display. Although, perhaps these Gifts are less for {#Emph}me {#Prev}and more for those who serve our cause..." },
				{ Cue = "/VO/Skelly_0323",
					PreLineAnim = "Skelly_Explaining",
					Text = "Now that you mention it, the Shades {#Emph}do {#Prev}like to gawk at 'em when you're not here. You get to inspire them even if you're not around! If that's not {#DialogLegendaryFormat}eternal glory{#Prev}... what is?" },
				{ Cue = "/VO/Melinoe_3290", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "These Shades are inspired because I went out of my way to use the Oath of the Unseen purely for personal gain?" },
				{ Cue = "/VO/Skelly_0324_B",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "{#Emph}Yeah! {#Prev}They're easy to please! But not you, apparently. I didn't know Night's Champion was gonna have so many questions all the time! You want the statues, or don't you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3291", Text = "...I... I do!" },
					},
					{
						PreLineWait = 0.38,
						PreLineAnim = "Skelly_Explaining",
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0325", Text = "{#Emph}Good! {#Prev}'Cause we can't send 'em back now that you opened 'em up." },
					},
					{
						PreLineWait = 0.43,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3292", Text = "...What?" },
					},
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0326", Text = "What!" },
					},
				},

			},

			TrophyQuestComplete01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Skelly",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestStage1Complete" },
				},

				{ Cue = "/VO/Melinoe_3275", 

					PreLineFunctionName = "SkellyStatueUnveil",
					PreLineFunctionArgs =
					{
						StatueId = 589801,
						DrapeId = 589805,
						Subtitle = "SkellyStatue_Unlocked_Subtitle_01",

						AnimationNames = { "StatusIconOhBoy", "StatusIconEmbarrassed" },
						ReactionChance = 0.25,
						Delay = 1.01
					},

					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...Commander, is that supposed to be... {#Emph}me?" },
				{ Cue = "/VO/Skelly_0310",
					PreLineAnim = "Skelly_Explaining",
					Emote = "PortraitEmoteSparkly",
					Text = "It is {#DialogLegendaryFormat}Night's Champion {#Prev}foretold by Fate! She who shall strike {#DialogLegendaryFormat}Fear {#Prev}into the hearts of those who stand against the realm and stuff like that! I can see you're at a loss for words, such is the splendor of her likeness! And this is just the first of 'em!" },
				{ Cue = "/VO/Melinoe_3276", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Indeed. And are the other Gifts just as, {#Emph}erm... {#Prev}detailed? Either way, I'm not so certain I can handle twice let alone three times the glory, when my task is difficult enough as it is..." },
				{ Cue = "/VO/Skelly_0311",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Ahh{#Prev}, so then the {#DialogLegendaryFormat}Fear {#Prev}is getting to you. Do not give in to it, young one! Instead, give in to {#DialogLegendaryFormat}Curiosity {#Prev}about those other glorious Gifts! Think of the {#Emph}prestige! {#Prev}Now you can be a little scaredy quitter, or {#DialogLegendaryFormat}Night's Champion{#Prev}, which is it gonna be?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3277", Text = "...Do I have to decide this instant?" },
					},
					{
						PreLineWait = 0.44,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0312", Text = "{#Emph}Nah {#Prev}you take however long you need." },
					},
				},
			},

			TrophyQuestComplete02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Skelly",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestStage2Complete" },
				},
				{ Cue = "/VO/Melinoe_3280", 

					PreLineFunctionName = "SkellyStatueUnveil",
					PreLineFunctionArgs =
					{
						StatueId = 589803,
						DrapeId = 589806,
						Subtitle = "SkellyStatue_Unlocked_Subtitle_02",

						AnimationNames = { "StatusIconOhBoy", "StatusIconFiredUp" },
						ReactionChance = 0.30,
						Delay = 1.01
					},

					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...Commander, I... I'm rather at a loss for words, I think! Though I am honored, truly." },
				{ Cue = "/VO/Skelly_0315",
					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh you {#Emph}better {#Prev}be! You got any idea what I — I mean the {#Emph}Fates {#Prev}must have gone through to put these things together? But {#DialogLegendaryFormat}Night's Champion {#Prev}deserves only the best... which is that {#Emph}last {#Prev}one you haven't seen just yet!" },
				{ Cue = "/VO/Melinoe_3281", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My mind reels at the thought of a sculpture in excess of those. It's covered in Night's drapery... what's to stop me from merely taking a look? Apparently {#Emph}you've {#Prev}already seen it." },
				{ Cue = "/VO/Skelly_0316",
					PreLineAnim = "Skelly_Explaining",
					Text = "Sounds like {#Emph}you {#Prev}might not be {#DialogLegendaryFormat}Night's Champion {#Prev}after all, suggesting underhanded tactics such as that! You want to win top honors, you gotta {#Emph}have {#Prev}honor. And that means no peeking! Now you gonna use the {#DialogLegendaryFormat}Oath {#Prev}again, or what?" },
				{ Cue = "/VO/Melinoe_3282", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...I don't know. All this still strikes me as a bit unwise. While I value your encouragement and am inspired by your words of validation, perhaps I shouldn't be so quick to pin my sense of self-worth on accumulating material possessions." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Babbling",
						{ Cue = "/VO/Skelly_0317", Text = "Come {#Emph}on{#Prev}, young one, you mustn't {#Emph}speak {#Prev}that way!" },
					},
				},
			},

			TrophyQuestComplete03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Skelly",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestStage3Complete" },
				},
				{ Cue = "/VO/Melinoe_3285", 

					PreLineFunctionName = "SkellyStatueUnveil",
					PreLineFunctionArgs =
					{
						StatueId = 589804,
						DrapeId = 589807,
						Subtitle = "SkellyStatue_Unlocked_Subtitle_03",

						AnimationNames = { "StatusIconFiredUp", "StatusIconFear", "StatusIconEmbarrassed" },
						ReactionChance = 0.35,
						Delay = 1.01
					},

					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "I... I'm deeply honored, Commander. To be in service to the realm, and to have earned such... provocative sculptures. I thought art was about the expression of beauty; I never realized that it could inspire so many... complicated emotions." },
				{ Cue = "/VO/Skelly_0320",
					PreLineAnim = "Skelly_Babbling",
					Text = "I got a lot of complicated emotions just thinking about what it took to get those things in here without you noticing! But anyway, {#DialogLegendaryFormat}congrats{#Prev}. We'd have a feast in your honor or something, but... {#Emph}eh{#Prev}, nobody's supposed to know about this stuff. So it's gonna have to be our secret and all that." },
				{ Cue = "/VO/Melinoe_3286", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So, does this mean I truly am Night's Champion? And eternal glory is mine?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.43,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0321", Text = "You better believe it." },
					},
					{
						PreLineWait = 0.51,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3287", Text = "...OK." },
					},
				},
			},

			-- hints
			SkellyHintWeapons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonus" },
					},
				},
				{ Cue = "/VO/Skelly_0450",
					PreLineAnim = "Skelly_Explaining",
					Text = "All of those {#DialogLegendaryFormat}Nocturnal Arms {#Prev}of yours got their own different moves! Do not dwell upon which one of 'em is strongest; rather, choose whichever one really speaks to you." },
				{ Cue = "/VO/Melinoe_4054", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And what if they all speak to me? Faintly, but still." },
				EndVoiceLines =
				{
					PreLineWait = 0.33,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Greeting",
					{ Cue = "/VO/Skelly_0451", Text = "Then pick the one that gives you extra Bones!" },
				},
			},
			SkellyHintArmor01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "MiniBossTreant", "MiniBossFogEmitter" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "G_Boss01" },
					},
				},
				{ Cue = "/VO/Skelly_0482",
					PreLineAnim = "Skelly_Explaining",
					Text = "Take heed whensoever you observe some bozo with what looks to be a {#DialogLegendaryFormat}yellow barrier {#Prev}around 'em! Ere you punch through their armored protection, they can punch right back!" },
				{ Cue = "/VO/Melinoe_4167", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've never been able to make an armored foe so much as flinch from one of my strikes." },
				EndVoiceLines =
				{
					PreLineWait = 0.33,
					RequiredMinElapsedTime = 3,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Greeting",
					{ Cue = "/VO/Skelly_0483", Text = "That's perfectly normal, happens to all of us." },
				},
			},

			SkellyHintMetaCardPoints01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 100,
					},
					{
						Path = { "CurrentRun", "ResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 35,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaCardPointsCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0480",
					PreLineAnim = "Skelly_Explaining",
					Text = "Make sure you're nabbing all the {#DialogLegendaryFormat}Ashes {#Prev}you can find out there, kiddo. Then you can smudge 'em on your Altar to unlock those fancy {#DialogLegendaryFormat}Cards{#Prev}! You'll be brawnier in no time." },
				{ Cue = "/VO/Melinoe_4166", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Arcana reveal my fullest potential... from the Ashes of the past, a possibility for the future." },
				EndVoiceLines =
				{
					PreLineWait = 0.33,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Greeting",
					{ Cue = "/VO/Skelly_0481_B", Text = "A possibility to smack some bozos harder than before!" },
				},
			},

			SkellyHintCast01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0146",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 6.9 },
					Text = "All your training's gonna be for naught if you don't use it in a fight. Say I'm chasing after you with a club and you want to get me to stay put. Let's see you cast a {#DialogLegendaryFormat}Circle of Binding {#Prev}over here!",
					PostLineThreadedFunctionName = "StartSkellyCastQuest", },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					-- { Cue = "/VO/Melinoe_1579", Text = "Yes, sir." },
				},
			},
			SkellyHintCast02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						Path = { "CurrentRun", "WeaponsFiredRecord", "WeaponCast" },
						Comparison = "<=",
						Value = 30,
					},
				},
				{ Cue = "/VO/Skelly_0484",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 6.3 },
					PreLineAnim = "Skelly_Babbling",
					Text = "Don't forget to use that {#DialogLegendaryFormat}Cast {#Prev}of yours. Stops any bozos in their tracks! And if you give 'em the {#DialogLegendaryFormat}Omega {#Prev}version... {#Emph}wham!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_4168", Text = "A Binding Circle has its many uses to be sure..." },
				},
			},

			SkellyHintMana01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered", "G_Intro" },
						Comparison = "<=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0075",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 3.5 },
					Text = "The craft you seek to master takes its toll. But not for long, your magick power's gonna come right back by the time you get to the next place you're going. So {#Emph}use it{#Prev}, no point bottling it up!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
				},
			},
			SkellyHintDamage01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" },
					},
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponStaffSwing" },
					},
					{
						Path = { "CurrentRun", "WeaponsFiredRecord", "WeaponStaffBall" },
						Comparison = "<=",
						Value = 15,
					},
					{
						Path = { "CurrentRun", "WeaponsFiredRecord", "WeaponStaffSwing5" },
						Comparison = "<=",
						Value = 15,
					},
					{
						Path = { "CurrentRun", "WeaponsFiredRecord", "WeaponCastArm" },
						Comparison = "<=",
						Value = 15,
					},
				},
				{ Cue = "/VO/Skelly_0444",
					PreLineAnim = "Skelly_Babbling",
					Text = "Some of those bozos whom you run into out there are pretty tough! But your fancy {#DialogLegendaryFormat}Omega Moves {#Prev}ought to cut right through 'em as might a hot knife through butter. {#Emph}Battle getting old? {#Prev}{#DialogLegendaryItalicFormat}Press and hold." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4055", Text = "Magick is to be used sparingly, in times of need." },
					},
					{
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0445", Text = "And you {#Emph}need {#Prev}to win!" },
					},
				},
			},
			SkellyHintSpellDrop01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 14,
					},
				},
				{ Cue = "/VO/Skelly_0341",
					PreLineAnim = "Skelly_Explaining",
					Text = "I understand that Great Selene graced you with one of them {#DialogLegendaryFormat}Hexes {#Prev}that she's got. A powerful effect, but you must use a bunch of magick first to charge it up! {#Emph}Eh{#Prev}, like charging a crystal!" },
				{ Cue = "/VO/Melinoe_3359", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, I thought most of your experience was in the martial ways. But you know the intricacies of magick as well?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0342", Text = "Oh yeah." },
				},
			},

			SkellyHintDash01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0339",
					PreLineAnim = "Skelly_Explaining",
					Text = "Being a shadowy denizen of the Underworld comes with certain perks, young one! Take, for instance, how {#DialogLegendaryFormat}when you Dash, nothing can touch you{#Prev}!" },
				{ Cue = "/VO/Melinoe_3357", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We are the Unseen... at one with the darkness and the dead. I can evade anything, yes. But only for a moment, and even then... I can't prevail by dodging all night long." },
				{ Cue = "/VO/Skelly_0340",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Eh{#Prev}, I'd do it all the time if I was you! See the {#DialogLegendaryFormat}little trail {#Prev}when you Dash? Once it snaps back, you're good to go {#Emph}again!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_3358", Text = "{#Emph}The shadow follows..." },
				},
			},
			SkellyHintSprint01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 20,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered", "H_Intro" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Skelly_0076",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 10.2 },
					Text = "You have grown quick, young one. Real quick! Would that I, too, could {#DialogLegendaryFormat}dash {#Prev}so fast as {#DialogLegendaryFormat}to become untouchable{#Prev}, or sprint as fleetly as a... she-wolf, or something? Give me a couple of laps!",
					PostLineThreadedFunctionName = "StartSkellySprintQuest", },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					-- { Cue = "/VO/Melinoe_1579", Text = "Yes, sir." },
				},
			},
			SkellyHintShadeMercs01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeShadeMercs" },
					},
				},
				{ Cue = "/VO/Skelly_0140",
					Text = "Could always use some new disciples here. See any Shades of the dead out there just loitering around, remember your training and {#DialogLegendaryFormat}sprint right into them{#Prev}! They'll come around." },
				{ Cue = "/VO/Melinoe_1577", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They'll more than come around, sir. They're prepared to join our fight. By now they know exactly who I am, and what we stand for here.",
					PostLineThreadedFunctionName = "StartSkellyShadeMercQuest", },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0141", Text = "May you keep running into lots of them." },
				},
			},
			SkellyHintResources01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 10,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
						Comparison = "<=",
						Value = 45,
					},
				},
				{ Cue = "/VO/Skelly_0151",
					PreLineAnim = "Skelly_Explaining",
					Text = "My days of running around taking stuff may be over, but yours are only beginning, kiddo! Keep your eyes peeled for stuff you can use out there, and be sure to pack the best {#DialogLegendaryFormat}Tool {#Prev}for the job.",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2254", Text = "You used to run around and... take stuff?" },
				},
			},
			SkellyHintResources02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "ToolPickaxe" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "ToolExorcismBook", "ToolShovel" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				{ Cue = "/VO/Skelly_0364",
					PreLineAnim = "Skelly_Explaining",
					Text = "What ails you, young one? You have a look of consternation, which mayhaps my breadth of experience could alleviate. Go on, just spit it out!" },
				{ Cue = "/VO/Melinoe_3368", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, Commander... I was just thinking about all the reagents I still need. Some grow in different regions, or require different tools... it's a lot to keep in mind." },
				{ Cue = "/VO/Skelly_0365",
					PreLineAnim = "Skelly_Babbling",
					Text = "But you don't gotta keep it all in mind! That {#DialogLegendaryFormat}Purple Pack {#Prev}you carry all of your stuff in, somehow... don't you got all your notes in there too? So if you don't remember where to nab something, check {#Emph}there! {#Prev}In fact, why don't you do it now?",
					PostLineThreadedFunctionName = "StartSkellyInventoryQuest", },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3369", Text = "I do have notes on everything in there..." },
					},
				},
			},

			SkellyHintRoomRewards01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 12,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" }
					},
				},
				{ Cue = "/VO/Skelly_0446",
					PreLineAnim = "Skelly_Explaining",
					Text = "Your connection to the realm means you must have a sense of what's ahead at every turn. Like a window to the future at each threshold! You might not know what all the little symbols mean but you'll figure 'em all out eventually." },
				{ Cue = "/VO/Melinoe_4056", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Windows to the future... and at a branching path I simply choose whichever one looks best." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0447", Text = "I surely would if I were in your stead." },
				},
			},

			SkellyHintBones01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
					{
						Path = { "GameState", "Resources", "MetaCurrency" },
						Comparison = ">=",
						Value = 600,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaCurrency" },
						Comparison = "<=",
						Value = 400,
					},
				},
				{ Cue = "/VO/Skelly_0376",
					PreLineAnim = "Skelly_Explaining",
					Text = "With experience, one develops knacks for certain things, and one of {#Emph}my {#Prev}knacks is detecting {#DialogLegendaryFormat}Bones{#Prev}, all shapes and sizes and in varied quantities, and kiddo: {#Emph}You {#Prev}have got {#Emph}a lot." },
				{ Cue = "/VO/Melinoe_3480", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're in the realm of the dead, Commander. Bones aren't difficult to come by, especially this close to the surface. Though... the Broker may have better use for them." },
				{ Cue = "/VO/Skelly_0377",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "That's basically what {#Emph}I {#Prev}was gonna say! Sure maybe you could use a couple for an incantation here or there but the old {#DialogLegendaryFormat}Broker{#Prev}'s really gonna eat 'em up." },
				EndVoiceLines =
				{
					PreLineWait = 0.42,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3481", Text = "But I like hoarding them..." },
				},
			},

			SkellyHintChoices01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "FamiliarsUnlocked" },
						CountOf = { "FrogFamiliar", "CatFamiliar", "RavenFamiliar", "HoundFamiliar", "PolecatFamilair" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Skelly_0453",
					PreLineAnim = "Skelly_Explaining",
					Text = "Choose wisely, young one, ere you set forth each night! There's your {#DialogLegendaryFormat}Arcana {#Prev}at the Altar, your choice of {#DialogLegendaryFormat}Nocturnal Arms{#Prev}, your {#DialogLegendaryFormat}Keepsake{#Prev}, your {#DialogLegendaryFormat}Animal Familiar{#Prev}, I mean {#Emph}dang..." },
				{ Cue = "/VO/Melinoe_3370", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a lot to consider when you put it that way, Commander. But my objective is always clear: {#Emph}Find the Titan, slay the Titan. Free my family, free Olympus." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0368", Text = "Well that was like four different things right there..." },
					},
				},
			},

			SkellyHintDying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasNone = { "WeaponSuit" },
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = "<=",
						Value = 18,
					},
				},
				{ Cue = "/VO/Skelly_0152",
					Text = "Now don't lose heart just 'cause you're getting whacked, all right? Between your {#DialogLegendaryFormat}Altar {#Prev}and that {#DialogLegendaryFormat}Silver Puddle {#Prev}back there, you're going to get tougher and tougher, till {#Emph}you're {#Prev}the one doing all the whacking!",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2255", Text = "You mean the Silver Pool, sir." },
				},
			},

			SkellyHintGrasp01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "GraspLimitLayout" },
					},
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = "<=",
						Value = 16,
					}
				},
				{ Cue = "/VO/Skelly_0337",
					PreLineAnim = "Skelly_Explaining",
					Text = "So you have reached the limits of your {#DialogLegendaryFormat}Grasp of the Arcana{#Prev}. Happens to everyone! Just need some more of that {#DialogLegendaryFormat}Psyche {#Prev}and you'll soon be grasping for more of them Cards you got!" },
				{ Cue = "/VO/Melinoe_3355", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My connection to the dead, my connection to the past... and the Altar is the conduit! Commander, are you able to draw from the Arcana yourself?" },
				{ Cue = "/VO/Skelly_0338",
					PreLineWait = 0.35,
					Text = "Well used to be I could draw pretty good, but {#Emph}eh{#Prev}, maybe not as good as the pictures on those Cards." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3356", Text = "You draw {#Emph}pictures{#Prev}, sir...?" },
				},
			},

			SkellyHintProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "G_Intro" },
						Comparison = ">=",
						Value = 2,
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "H_Intro" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = "<=",
						Value = 18,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Intro" }
					},
				},
				{ Cue = "/VO/Skelly_0448",
					PreLineAnim = "Skelly_Explaining",
					Text = "What gives, young one, you feeling stuck? I mean you {#Emph}are {#Prev}stuck, but you're getting somewhere in the spiritual sense!" },
				{ Cue = "/VO/Melinoe_4057", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And where might that be, Commander...? I'm nowhere near my goal of vanquishing the Titan yet. I need to go farther." },
				{ Cue = "/VO/Skelly_0449",
					PreLineAnim = "Skelly_Babbling",
					Text = "Probably just need to {#DialogLegendaryFormat}Dash {#Prev}instead of getting hit so much, and get some more of those {#DialogLegendaryFormat}Arcana Cards{#Prev}, they'll toughen you right up! Each night is gonna go a little different, too." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Melinoe_4058", Text = "May this one go a little better." },
				},
			},

			SkellyAboutHealthQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Skelly",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllMaxedWeaponAspects,
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SkellyAboutTrophyQuest01", "SkellyGift06" }
					},
					{
						-- PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
				},
				{ Cue = "/VO/Skelly_0583",
					PreLineAnim = "Skelly_Explaining",
					Emote = "PortraitEmoteDepressed",
					Text = "Oh, {#Emph}curse {#Prev}these brittle old bones, that they cannot withstand as much punishment from you as once they did! Used to be I could really take a hit, but lately? I don't know." },
				{ Cue = "/VO/Melinoe_4947", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, what has gotten into you? I thought you longed to be struck by whichever armament I had available, the more savagely the better. Should I be holding back?" },
				{ Cue = "/VO/Skelly_0584",

					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteFiredUp",
					PostLineAnim = "Skelly_Greeting",
					Text = "{#Emph}Never! {#Prev}I long merely to absorb more punishment ere I fall to pieces and have to put myself back together. You are way stronger now, but I'm {#Emph}not! {#Prev}Just doesn't seem right! But there {#Emph}is {#Prev}something you can do..." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2.5, Title = "WorldUpgradeAdded", Text = "WorldUpgradeSkellyHealth" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.75,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4948", Text = "What's this? An incantation to augment {#Emph}bone density?" },
					},
					{
						PreLineWait = 0.36,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Greeting",
						{ Cue = "/VO/Skelly_0585", Text = "Just think about it, all right?" },
					},
				},
			},
			SkellyAboutHealthQuest02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutHealthQuest01" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeSkellyHealth" }
					},
					{
						PathFalse = { "GameState", "WorldUpgrades", "WorldUpgradeSkellyHealth" }
					},
					-- NamedRequirementsFalse = { "NearTrueEnding" },
				},
				{ Cue = "/VO/Melinoe_4949", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, the Augmentation of Bone Density you taught me... it's a costly incantation. Are you certain you're prepared? If we proceed, there's no undoing the effect." },

				{ Cue = "/VO/Skelly_0586",
					PreLineAnim = "Skelly_Explaining",
					Emote = "PortraitEmoteFiredUp",
					Text = "Young one, I was {#Emph}born {#Prev}prepared. Put yourself in my place: Wouldn't you want to be able to take a real beatin'?" },

				{ Cue = "/VO/Melinoe_4950", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I prefer to avoid beatings altogether, but can see the appeal from your perspective. Your bones would become much more durable... as long as falling to pieces is not the best part for you." },

				{ Cue = "/VO/Skelly_0587",

					PreLineAnim = "Skelly_Babbling",
					Text = "It's really not, because when I'm in pieces, I'm not getting hit, and {#Emph}that's {#Prev}the good stuff, let me tell {#Emph}you. {#Prev}So you gonna cast this thing or what?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4951", Text = "I'm looking into it..." },
					},
				},
			},
			SkellyAboutHealthQuest03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSkellyHealth" }
					},
				},

				{ Cue = "/VO/Skelly_0589",
					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah, hahaha, fools! {#Prev}I am now entirely {#DialogLegendaryFormat}invincible{#Prev}, and {#Emph}soon? {#Prev}Real soon, you all shall dearly pay for that which you've said behind my back... vengeance shall finally be {#Emph}mine!" },

				{ Cue = "/VO/Melinoe_4955", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, what is the meaning of this? You're not yourself! I merely cast the Augmentation of Bone Density!" },

				{ Cue = "/VO/Skelly_0590",
					PreLineAnim = "Skelly_Explaining",
					Text = "And you played right into my fingerbones. For now I cannot {#Emph}possibly {#Prev}be slain! Just you try it and see what occurs!",
					PostLineThreadedFunctionName = "StartSkellyKillQuest" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Greeting",
						{ Cue = "/VO/Skelly_0591", Text = "{#Emph}Ah, hahahahahaha!" },
					},
				},
			},
			SkellyAboutHealthQuest04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSkellyHealth" }
					},
				},

				{ Cue = "/VO/Skelly_0596",
					PreLineAnim = "Skelly_Salute",
					Text = "Well I hope you learned your lesson, kiddo! You thought I had become more powerful than any foe you'd ever faced, only to discover your {#DialogLegendaryFormat}Augmentation of Bone Density {#Prev}did not do all that much..." },

				{ Cue = "/VO/Melinoe_4959", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, I feared the worst when you acted as though were, well, drunk with newfound power. I'd never seen that side of you before." },

				{ Cue = "/VO/Skelly_0597",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "Nor shall you see that side of me {#Emph}again! {#Prev}Provided you don't make a habit of casting incantations you get from strangers!" },

				{ Cue = "/VO/Melinoe_4960", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But you're not a stranger. You're a trusted ally! Aren't you...?" },

				{ Cue = "/VO/Skelly_0598",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well, {#Emph}yeah{#Prev}, but... look forget it, all right? Just hit me like you used to, I don't even care." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4961", Text = "Very well..." },
					},
				},
			},
			SkellyAboutHealthQuest05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutHealthQuest04" }
					}
				},

				{ Cue = "/VO/Melinoe_4962", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a relief you're not a vengeful adversary who deceived me into casting a spell that awakened his true and terrifying might, Commander, but... do you feel any different after the Augmentation of Bone Density, or not?" },

				{ Cue = "/VO/Skelly_0599",
					PreLineAnim = "Skelly_Explaining",
					Text = "{#Emph}Oh{#Prev}, you know, I {#Emph}do {#Prev}feel somewhat tougher than before, young one, so thanks! That's really all I figured your incantation was gonna do, but I had you going, didn't I?" },

				{ Cue = "/VO/Melinoe_4963", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I suppose, but... mostly you just made me realize that I'd be very sad if some evening you did not come back. You're not just our Commander... you're my friend." },

				{ Cue = "/VO/Skelly_0600",
					PreLineAnim = "Skelly_Greeting",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 3.5 },

					Text = "What, you really mean that, kiddo? 'Cause let's face it, sometimes all I do is {#Emph}stand {#Prev}here. And not even {#Emph}sometimes!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4964", Text = "Of course I mean it, sir." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0601", Text = "{#Emph}Aw{#Prev}, now come {#Emph}on..." },
					},
				},
			},

			SkellyAboutUltimateProgress01 =
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
						HasAny = { "I_Boss01", "Q_Boss01", "Q_Boss02" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
				},

				{ Cue = "/VO/Melinoe_4977", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I try not to dwell on what shall happen if and when all this is finally over, Commander. I know I ought to be completely focused on the task, but... as we near a potential end, I cannot help but think ahead." },

				{ Cue = "/VO/Skelly_0614",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well {#Emph}stop {#Prev}it! How many times have I told you, {#EmphLegendary}never think ahead{#Prev}, kiddo. No good is ever gonna come of {#Emph}that. {#Prev}The here-and-now is all that counts!" },

				{ Cue = "/VO/Melinoe_4978", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're truly saying one should never plan? But you're a {#Emph}Commander... {#Prev}anticipation and strategy are integral to martial leadership...!" },

				{ Cue = "/VO/Skelly_0615",
					PreLineAnim = "Skelly_Explaining",
					Text = "If you're always doing good right {#Emph}now{#Prev}, you're always doing good later, that's all there is to it! Now quit with your worryin'." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_4979", Text = "{#Emph}Erm... {#Prev}OK." },
				},
			},

			SkellyPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 5,
						Path = { "TextLinesRecord", "TrueEndingFinale01" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0644",
					PreLineAnim = "Skelly_Explaining",
					Emote = "PortraitEmoteFiredUp",
					Text = "The rousing tales of your great accomplishment preceded you, young one! And I am here to heap still-further praise: Great job back there with all the Chronos stuff." },
				{ Cue = "/VO/Melinoe_5002", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Thank you very much, Commander, though... what are you still doing here? I kept expecting you'd return to your honorary post at the House, but eventually I had to depart." },
				{ Cue = "/VO/Skelly_0645",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well you are not exactly done with everything, {#Emph}are {#Prev}you? I see you eyeballing the gateways out, wondering what's gonna happen now. So as long as {#Emph}you're {#Prev}here... so am I!" },
				{ Cue = "/VO/Melinoe_5003", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "So then you're sworn to us... to me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Greeting",
						{ Cue = "/VO/Skelly_0646", Text = "Yeah I'm not going anywhere." },
					},
				},
			},
			SkellyPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AchillesTrueEnding01" },
					},
				},
				{ Cue = "/VO/Melinoe_5760", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I meant to note... I had an unusual experience at the House of Hades. I heard no mention of you there, despite your distinguished status. Only of a skeleton who would stand watch outside... {#Emph}Schele... Schelae... {#Prev}perhaps akin to that?" },

				{ Cue = "/VO/Skelly_0756",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Wha?! {#Prev}Kiddo. You think we skeletons are all the same? That's {#Emph}way {#Prev}over the line, pal! Come on, I would have thought... {#Emph}Bwuh! {#Prev}Unbelievable!" },

				{ Cue = "/VO/Melinoe_5761", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, I... I didn't mean to suggest... {#Emph}eugh{#Prev}, I apologize." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0757", Text = "{#Emph}Psh. {#Prev}I mean, I swear..." },
					},
				},

			},

			SkellyPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Melinoe_5675", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Commander, what say all your disciples of the reappearance of the Fates? I take it you've already heard." },

				{ Cue = "/VO/Skelly_0752",
					PreLineAnim = "Skelly_Explaining",
					Text = "{#Emph}Ah{#Prev}, yes, I've heard all right... {#DialogLegendaryItalicFormat}Fates, Shmates {#Prev}is what they say, if you must know." },

				{ Cue = "/VO/Melinoe_5676", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Fates, Shmates{#Prev}, what is {#Emph}that {#Prev}supposed to mean? It sounds rather disrespectful on initial impression." },

				{ Cue = "/VO/Skelly_0753",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Disrespectful? {#Prev}Oh {#Emph}far {#Prev}be that from {#Emph}me! {#Prev}I merely say {#DialogLegendaryItalicFormat}Fates, Shmates {#Prev}and ask that you consider the weight of my words." },

				{ Cue = "/VO/Melinoe_5677", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "You don't care that a new age may dawn... that the rule of gods may end." },

				{ Cue = "/VO/Skelly_0754",
					PreLineAnim = "Skelly_Greeting",
					Text = "Kiddo, I'll believe it when it happens. We'll probably all be dead by then." },

				{ Cue = "/VO/Melinoe_5678", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "I'm immortal and the rest of you already {#Emph}are {#Prev}dead!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0755", Text = "Just sayin' don't hold your breath." },
					},
				},
			},

			SkellyAboutSayingLittle01 =
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
						HasAll = { "SkellyGift09", "TrophyQuestComplete03" },
					},
				},
				{ Cue = "/VO/Skelly_0647",
					PreLineAnim = "Skelly_Explaining",
					Text = "Well we did it, kiddo! Or at least {#Emph}I {#Prev}did. This whole experience... it has given me a lot to think about." },
				{ Cue = "/VO/Melinoe_5004", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "At least you should have time to think about it now, Commander. Tell me if you have any epiphanies?" },
				{ Cue = "/VO/Skelly_0648",
					PreLineAnim = "Skelly_Babbling",
					Text = "You bet. But I will probably just not have much to say, I mean, I'm {#Emph}beat! {#Prev}Not beat enough by {#Emph}you{#Prev}, of course, can't ever get enough of {#Emph}that." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5005", Text = "Thanks again, Commander." },
					},
				},
			},

			-- partner conversations
			DoraWithSkelly01 =
			{
				Partner = "NPC_Dora_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				InteractDistance = 450,
			},

			-- Repeatable
			SkellyChat01 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0012",
					Text = "Mayhaps you could give my disciples a little demonstration, huh?" },
			},
			SkellyChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0013",
					Text = "Less discussion, more concussion here, kiddo!" },
			},
			SkellyChat03 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0048",
					Text = "Come, young one, let's see you deliver your best shot already." },
			},
			SkellyChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0049",
					Text = "Speak not, but concentrate, and strike repeatedly at me!" },
			},
			SkellyChat05 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0050",
					Text = "Patience, young one! You shall... probably get through this whole thing." },
			},
			SkellyChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0051",
					Text = "Have you come to train with me, perchance? Or merely passing through?" },
			},
			SkellyChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0052",
					Text = "Less greeting, more beating, if you would be so kind?" },
			},

			SkellyChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0092",
					Text = "I trust you have some damage to impart?" },
			},
			SkellyChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0093",
					Text = "Pray strike me down, young one, lest I be sad." },
			},
			SkellyChat10 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0094",
					Text = "Hold fast your questions and {#Emph}attack{#Prev}, young one!" },
			},
			SkellyChat11 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0095",
					Text = "Let us not conversate unnecessarily, though you can hit me if you want!" },
			},
			SkellyChat12 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0096",
					Text = "Have you not more important interactions to perform?" },
			},
			SkellyChat13 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0097",
					Text = "Each one of your attempts is but a step along your path. And so is hitting me." },
			},
			SkellyChat14 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0098",
					Text = "Pray focus on your path, or mayhaps beat me up a little first." },
			},
			SkellyChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0099",
					Text = "My disciples all believe in you and stuff." },
			},
			SkellyChat16 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0100",
					Text = "Go forth, young one, and we shall keep vigil here ere you return." },
			},
			SkellyChat17 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0101",
					Text = "Oh, these old bones are more resilient than they appear, see for yourself." },
			},
			SkellyChat18 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0102",
					Emote = "PortraitEmoteFiredUp",
					Text = "There shall be time enough for idle chat when victory is ours!" },
			},
			SkellyChat19 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0103",
					Text = "Speak with your {#Emph}weapons{#Prev}, young one, not your words!" },
			},

		},

		GiftTextLineSets =
		{
			-- grants a gift
			SkellyGift01 =
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
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_1050", UsePlayerSource = true,
					Text = "Commander, though it falls to us to keep the old traditions alive, may you partake of this Nectar unburdened by the weight of its significance." },
				{ Cue = "/VO/Skelly_0091",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 6.9 },
					Text = "I'm most appreciative of both the offering and of the sentiment. And I summarily shall do my part: {#Emph}Behold! {#Prev}The luckiest of my possessions is in {#Emph}your {#Prev}possession now!" },
			},
			SkellyGift02 =
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
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0046",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 10 },
					Text = "{#Emph}Ah{#Prev}, the memories, young one... your brother thusly used to favor me. And for his sake and yours, I shall accept this. Now, please accept {#Emph}my {#Prev}gratitude: {#Emph}Hey, thanks!" },
				{ Cue = "/VO/Melinoe_1051", UsePlayerSource = true,
					Text = "You are most welcome, Commander! And {#Emph}hey thanks {#Prev}to you in turn, for your peerless insight and steadfast presence." },
			},
			SkellyGift03 =
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
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0047",
					Text = "I'm most appreciative of your generosity. Would that I had more to give you in return besides the wisdom of my vast experience..." },
				{ Cue = "/VO/Melinoe_1052", UsePlayerSource = true,
					Text = "Please, sir, that is more than enough. Your disciples and I are fortunate to study under you." },
			},
			SkellyGift04 =
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
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0371",
					PreLineAnim = "Skelly_Explaining",
					Text = "I must not partake in such extravagances! For my disciples are counting on my clear-eyed counsel and undivided attention. But tell you what I'm gonna save this one for later when I'm off, OK?" },
				{ Cue = "/VO/Melinoe_3484", UsePlayerSource = true,
					Text = "What you call an extravagance... it must be nothing compared to the luxuries of my father's House. Yet you never want for anything. Besides the occasional hit or two." },
			},
			SkellyGift05 =
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
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0389",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 10 },
					Text = "Many a time have I been regaled with the most exquisite beverages and snacks, but never before from such a disciplined and honorable disciple such as yourself! Rest of you slackers hear {#Emph}that? {#Prev}More offerings, come on!" },
				{ Cue = "/VO/Melinoe_3372", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Nectar's yours to do with as you please, sir! May it lighten the burden of responsibility you bear to all the Shades and others counting on your skill and knowledge." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0390", Text = "Oh I'll give 'em skill and knowledge." },
					},
				},
			},
			SkellyGift06 =
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
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0391",
					PreLineAnim = "Skelly_Salute",
					Text = "Look kiddo... I got to level with you. Got kind of a drinking problem over here. Stuff goes right through me! I just don't want you wasting this when you could give it to one of those other guys out there." },
				{ Cue = "/VO/Melinoe_3551", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, thank you for your honesty with me... I hate to think all that Nectar only served to make you ill-at-ease. You do know you don't need to drink it, right? It can be a collector's item... a reminder of your friends, and the affection that they have for you." },
				{ Cue = "/VO/Skelly_0392",
					PreLineAnim = "Skelly_Babbling",
					Text = "Affection, shmuffection, look I'm gonna keep it just this {#Emph}sixth {#Prev}time... but don't go giving any more to me, OK?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3552", Text = "Yes, sir." },
					},
				},
			},
			SkellyGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_SkellyUnlockHint01",
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
						HasAll = { "SkellyGift06", "SkellyAboutHealthQuest05" },
					},
				},
				{ Cue = "/VO/Melinoe_4965", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know you don't want Nectar at this point, but what if I were to offer you Ambrosia, sir? In fact it's not even a hypothetical, so here!" },

				{ Cue = "/VO/Skelly_0602",
					Emote = "PortraitEmoteSparkly",
					PreLineAnim = "Skelly_Salute",
					Text = "Well this is a most-handsome gift, and it has left me speechless, for I have not received such {#DialogLegendaryFormat}Kudos {#Prev}since your own brother gave to me a similar reward {#Emph}long ago..." },

				{ Cue = "/VO/Melinoe_4966", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Truly? What was the circumstance then? Though this is no reward, merely a mark of our long-standing camaraderie." },

				{ Cue = "/VO/Skelly_0603",
					PreLineAnim = "Skelly_Explaining",
					Text = "The circumstance was that the boyo had repeatedly made use of me for target practice at around that time, so the Ambrosia was in recompense." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4967", Text = "I see..." },
					},
				},
			},
			SkellyGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
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
						HasAll = { "SkellyGift07" },
					},
				},
				{ Cue = "/VO/Melinoe_4968", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've served as target practice for me far more times than I can easily recall, sir. So I wish for you to have this Ambrosia as a token of my gratitude. No one else would be so willing!" },

				{ Cue = "/VO/Skelly_0604",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "{#Emph}Damn right {#Prev}no one else would be so willing! I've been in this profession longer than anybody, you've never seen me so much as move a {#Emph}muscle{#Prev}, have you?" },

				{ Cue = "/VO/Melinoe_4969", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 3.5 },

					Text = "Well you {#Emph}have {#Prev}no muscle, as far as I can see, Commander. But I know you've long served my family with honor, and such loyalty is never to be taken for granted." },

				{ Cue = "/VO/Skelly_0605",
					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteDepressed",
					Text = "I'll tell you what, not everybody thinks like {#Emph}you{#Prev}, kiddo. A lot of guys I've met, they pay you for a job, and that's the end of it, no {#Emph}loyalty{#Prev}, no long-term prospects, or stability..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4970", Text = "Mere mercenary work." },
					},
					{
						PreLineWait = 0.34,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0606", Text = "Totally." },
					},
				},
			},
			-- bond forged
			SkellyGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				CompletedHintId = "Codex_BondForgedSkelly",
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
						HasAll = { "SkellyGift08" },
					},
				},
				{ Cue = "/VO/Melinoe_4971", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To the honorable Commander Schelemeus, ward of the bloodline of Hades, the Fate-appointed regent of the Underworld: May this Ambrosia forever guarantee your service, for as long as you are willing to provide it!" },

				{ Cue = "/VO/Skelly_0607",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "Hey wait did you just grant me {#DialogLegendaryFormat}tenure {#Prev}in the family's name, kiddo? Can you even {#Emph}do {#Prev}that, and also... {#Emph}why?" },

				{ Cue = "/VO/Melinoe_4972", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm Princess of the Underworld; I'm well within my right. And as for why, I said before that I do not take loyalty for granted. I wanted you to know I meant it." },

				{ Cue = "/VO/Skelly_0608",
					PreLineAnim = "Skelly_Explaining",

					Text = "Look I didn't really think you were gonna replace me or anything, but... it means a lot you'd do all that for me. I know I helped teach you to hit real hard, kiddo... but I never thought you'd get me right in the heart..." },

				{ Cue = "/VO/Melinoe_4973", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelinoeSalute", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Skelly_01", Icon = "Keepsake_Skelly", Delay = 1.5, UseInputBlock = true },

					Text = "Thank you for everything, Commander." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0609", Text = "Just doing what they pay me for." },
					},
					{
						PreLineWait = 0.46,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4974", Text = "You're being paid for this?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0610", Text = "{#Emph}...No." },
					},
				},
			},

			SkellyBathHouseDecline01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},

				},
				{ Cue = "/VO/Melinoe_3361", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, would you be willing to accompany me to the Springs sometime? We could rest our weary bones a bit." },
				{ Cue = "/VO/Skelly_0345",
					Emote = "PortraitEmoteSurprise",
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "What are you gonna do, carry me? I'm required {#Emph}here{#Prev}, young one, for these Shades still require discipline! Mayhaps some other age, when all we hold dear isn't at stake..." },
			},
			SkellyFishingDecline01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3360", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, we've restored our fishing pier! Would you mind joining me there, given all your nautical experience?" },
				{ Cue = "/VO/Skelly_0344",
					PreLineAnim = "Skelly_Explaining",
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "My days amongst the fishes are long gone, young one. And besides, my place is here... right in this particular spot. Though, thanks!" },
			},

		},

		GiftGivenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1053", Text = "You honor me, Commander." },
			},
		},

		OnDeathThreadedFunctionName = "SkellyDeath",
		OnDeathFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.25, Delay = 0.25 },
		RespawnAtIdOnDeath = 589735,
		RespawnRequirements =
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SkellyAboutHealthQuest03" }
			},
		},
		OnDeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyIntro",
					SkipAnim = true,
					PreLineWait = 0.25,
					GameStateRequirements =
					{
						{
							PathTrue = { "ScreenState", "ActiveObjectives", "HitSkelly" },
						},
						{
							PathFalse = { "CurrentRun", "ObjectivesCompleted", "HitSkelly" },
						},
					},

					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					{ Cue = "/VO/Skelly_0172", Text = "Close enough..." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyIntro",
					SkipAnim = true,
					PreLineWait = 0.25,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0172" },
						},
					},

					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					{ Cue = "/VO/Skelly_0021", Text = "I shall return..." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyIntroResponse",
					BreakIfPlayed = true,
					UsePlayerSource = true,
					PreLineWait = 0.1,

					{ Cue = "/VO/Melinoe_0076", Text = "Forgive me, sir..." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyHealthQuestResponse",
					SkipAnim = true,
					PreLineWait = 0.25,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "ObjectivesCompleted", "KillSkelly" },
						},
					},

					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					{ Cue = "/VO/Skelly_0593", Text = "{#Emph}Aw{#Prev}, dang it!" },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyHealthQuestResponse",
					UsePlayerSource = true,
					PreLineWait = 3.5,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "ObjectivesCompleted", "KillSkelly" },
						},
					},

					{ Cue = "/VO/Melinoe_4956", Text = "Commander...? {#Emph}Commander!" },
					{ Cue = "/VO/Melinoe_5704", Text = "Commander, please, come back...", PreLineWait = 2, },
					{ Cue = "/VO/Melinoe_4957", Text = "Gods, he's gone...", PreLineWait = 2.5, BreakIfPlayed = true, },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SkipAnim = true,
					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 10 },
					},
					
					{ Cue = "/VO/Skelly_0021", Text = "I shall return..." },
					{ Cue = "/VO/Skelly_0020", Text = "A fatal blow..." },
					{ Cue = "/VO/Skelly_0061", Text = "I... must... go...", PlayFirst = true },
					{ Cue = "/VO/Skelly_0062", Text = "Curse these old bones!" },
					{ Cue = "/VO/Skelly_0063", Text = "Excellent!" },
					{ Cue = "/VO/Skelly_0064", Text = "Well struck!" },
					{ Cue = "/VO/Skelly_0065", Text = "I fall..." },
					{ Cue = "/VO/Skelly_0280", Text = "That's... the... stuff..." },
					{ Cue = "/VO/Skelly_0281", Text = "Got... me... good..." },
					{ Cue = "/VO/Skelly_0282", Text = "Ah, the memories..." },
					{ Cue = "/VO/Skelly_0283", Text = "That did the trick..." },
					{ Cue = "/VO/Skelly_0284", Text = "I'm... outta here..." },
					{ Cue = "/VO/Skelly_0285", Text = "There goes my body parts..." },
					{ Cue = "/VO/Skelly_0681", Text = "Avenge... me..." },
					{ Cue = "/VO/Skelly_0682", Text = "For... the cause..." },
					{ Cue = "/VO/Skelly_0683", Text = "It's... so... dark..." },
					{ Cue = "/VO/Skelly_0684", Text = "The honor... was mine..." },
					{ Cue = "/VO/Skelly_0685", Text = "Goodbye... world..." },
					{ Cue = "/VO/Skelly_0686", Text = "Wait... right... there..." },
					{ Cue = "/VO/Skelly_0687", Text = "Didn't... even... hurt..." },
					{ Cue = "/VO/Skelly_0688", Text = "I've... been... hit..." },
					{ Cue = "/VO/Skelly_0689", Text = "This is... nothing... {#Emph}augh..." },
					{ Cue = "/VO/Skelly_0690", Text = "Death... to Chronos..." },
					{ Cue = "/VO/Skelly_0696", Text = "I had... so much... left to say..." },
					{ Cue = "/VO/Skelly_0593", Text = "{#Emph}Aw{#Prev}, dang it!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSkellyHealth" }
							},
						},
					},
					{ Cue = "/VO/Skelly_0691", Text = "Twice... in a row...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "EnemyKills", "NPC_Skelly_01" },
								Comparison = "==",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/Skelly_0692", Text = "Thrice... in succession...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "EnemyKills", "NPC_Skelly_01" },
								Comparison = "==",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/Skelly_0693", Text = "That... makes... four...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "EnemyKills", "NPC_Skelly_01" },
								Comparison = "==",
								Value = 4,
							},
						},
					},
					{ Cue = "/VO/Skelly_0694", Text = "Five... in a row...?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "EnemyKills", "NPC_Skelly_01" },
								Comparison = "==",
								Value = 5,
							},
						},
					},
					{ Cue = "/VO/Skelly_0695", Text = "I... lost... count...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "EnemyKills", "NPC_Skelly_01" },
								Comparison = ">=",
								Value = 6,
							},
						},
					},
				},
			},
		},
		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "SkellyOnHitSpeech", Time = 9 },
			},
			GameStateRequirements =
			{
				{
					PathEmpty = { "ActiveScreens" },
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				ChanceToPlay = 0.5,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "ShadeMercSpiritball" },
					},
				},
				{ Cue = "/VO/Skelly_0407", Text = "Hey c'mon guys!" },
				{ Cue = "/VO/Skelly_0408", Text = "That all you got, you Shades?", PlayFirst = true },
				{ Cue = "/VO/Skelly_0409", Text = "Not impressed." },
				{ Cue = "/VO/Skelly_0410", Text = "Weak!" },
			},
			{
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "ShadeMercSpiritball" },
					},
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PlayOnceFromTableThisRun = true,
					SuccessiveChanceToPlay = 0.75,
					SuccessiveChanceToPlayAll = 0.5,
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "SourceProjectile", },
							IsAny = { "CatFamiliarPounce" },
						},
					},
					{ Cue = "/VO/Skelly_0352", Text = "I look like a scratching post to you?", PlayFirst = true },
					{ Cue = "/VO/Skelly_0353", Text = "{#Emph}Achoo!" },
					{ Cue = "/VO/Skelly_0354", Text = "{#Emph}Achoo..." },
					{ Cue = "/VO/Skelly_0355", Text = "{#Emph}<Sniff> {#Prev}Damn sinuses..." },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PlayOnceFromTableThisRun = true,
					SuccessiveChanceToPlay = 0.75,
					SuccessiveChanceToPlayAll = 0.5,
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "SourceProjectile", },
							IsAny = { "RavenFamiliarMelee" },
						},
					},
					{ Cue = "/VO/Skelly_0433", Text = "That the best you got, {#Emph}bird?", PlayFirst = true },
					{ Cue = "/VO/Skelly_0434", Text = "Tried to pluck my eyes out!" },
					{ Cue = "/VO/Skelly_0435", Text = "Flap away, pal!" },
					{ Cue = "/VO/Skelly_0436", Text = "I fear no raven!" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PlayOnceFromTableThisRun = true,
					SuccessiveChanceToPlay = 0.75,
					SuccessiveChanceToPlayAll = 0.5,
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "SourceProjectile", },
							IsAny = { "HoundFamiliarBark" },
						},
					},
					{ Cue = "/VO/Skelly_0437", Text = "Go fetch some other bone!" },
					{ Cue = "/VO/Skelly_0438", Text = "Want some of this, doggo?" },
					{ Cue = "/VO/Skelly_0439", Text = "{#Emph}Heel{#Prev}, you {#Emph}cur!", PlayFirst = true },
					{ Cue = "/VO/Skelly_0440", Text = "I fear no hound!" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PlayOnceFromTableThisRun = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "CompletedRunsCache" },
							Comparison = ">=",
							Value = 1,
						},
						{
							PathFromArgs = true,
							Path = { "SourceProjectile", },
							IsNone = { "CatFamiliarPounce", "RavenFamiliarSwoop", "HoundFamiliarBark", "ProjectileCast" },
						},
						ChanceToPlay = 0.2,
					},
					{ Cue = "/VO/Skelly_0217", Text = "That stick has got some heft!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0218", Text = "Sure that's no walking stick?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0546", Text = "You've really done a number on that staff!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0219", Text = "Like getting stung by bees...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "Weapons" },
								HasAny = { "WeaponDagger" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0506", Text = "A cut like none I've ever felt!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0170", Text = "That cuts straight to the bone!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "Weapons" },
								HasAny = { "WeaponDagger", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0178", Text = "What a chop!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0179", Text = "Such strength!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0220", Text = "Whoa {#Emph}Momma!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0550", Text = "{#Emph}Ah{#Prev}, now {#Emph}that's {#Prev}the stuff!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0181", Text = "{#Emph}Ah{#Prev}, it burns!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0182", Text = "Hot stuff right there!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0548", Text = "Burns like nobody's business!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchAutofireAspect" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0221", Text = "I almost budged!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "Weapons" },
								HasAny = { "WeaponAxe", "WeaponLob" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0222", Text = "Not a bad Skull you got!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0552", Text = "A skull almost as good as mine!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0424", Text = "{#Emph}Aw {#Prev}my {#Emph}jaw!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileSuit", "ProjectileSuit2", "ProjectileSuit3", "ProjectileSuitCharged" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0425", Text = "What a {#Emph}punch!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileSuitCharged" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0426", Text = "Smacked me good!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileSuit", "ProjectileSuit2", "ProjectileSuit3", "ProjectileSuitCharged" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0427", Text = "What {#Emph}are {#Prev}those things?",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileSuitRanged", "UnguidedProjectileSuitRanged", "GuidedProjectileSuitRangedCharged", "UnguidedProjectileSuitRangedCharged", "ProjectileSuitRangedChargedSplit", "ProjectileSuitRangedGuidedSplit", },
							},
						},
					},
					{ Cue = "/VO/Skelly_0428", Text = "{#Emph}Boom{#Prev}, yeah!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileSuitCharged", "ProjectileSuitRanged", "UnguidedProjectileSuitRanged", "GuidedProjectileSuitRangedCharged", "UnguidedProjectileSuitRangedCharged", "ProjectileSuitRangedChargedSplit", "ProjectileSuitRangedGuidedSplit", },
							},
						},
					},
					{ Cue = "/VO/Skelly_0429", Text = "Y-you hear that ringing sound...?",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileSuitCharged", "ProjectileSuitRanged", "UnguidedProjectileSuitRanged", "GuidedProjectileSuitRangedCharged", "UnguidedProjectileSuitRangedCharged", "ProjectileSuitRangedChargedSplit", "ProjectileSuitRangedGuidedSplit", },
							},
						},
					},
					{ Cue = "/VO/Skelly_0430", Text = "That's some {#Emph}heat!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "SourceProjectile", },
								IsAny = { "ProjectileTorchBall", "ProjectileTorchWave", "ProjectileTorchGhost", "ProjectileTorchGhostLarge", "ProjectileTorchBallEos", "ProjectileTorchGhostExplosion", "ProjectileTorchSupayBallEx", "ProjectileTorchBallSplit", "ProjectileTorchBallLargeSplit", "ProjectileTorchGhostLargeExplosion", "ProjectileTorchOrbit", "ProjectileTorchOrbitEx", "ProjectileSuitRanged", "UnguidedProjectileSuitRanged", "GuidedProjectileSuitRangedCharged", "UnguidedProjectileSuitRangedCharged", "ProjectileSuitRangedChargedSplit", "ProjectileSuitRangedGuidedSplit", },
							},
						},
					},
					{ Cue = "/VO/Skelly_0554", Text = "You're {#Emph}destroyin' {#Prev}me here!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitComboAspect" },
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.15,
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "SourceProjectile", },
							IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "ShadeMercSpiritball" },
						},
						ChanceToPlay = 0.3,
					},

					{ Cue = "/VO/Skelly_0166", Text = "Disciples, watch and learn!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0167", Text = "Observe, my disciples!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0168", Text = "You all see that technique?",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0169", Text = "Yeah, teach those Shades back there!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0018", Text = "Again!", PlayFirst = true,
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0019", Text = "Again, dammit!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0053", Text = "With all your might!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0054", Text = "Are you a witch, or aren't you?!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0055", Text = "A solid hit.",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0056", Text = "Right where the solar plexus used to be!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0057", Text = "Straight to the vertebrae!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0058", Text = "Right in the ribcage!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0059", Text = "Once more!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0060", Text = "Do not relent!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0117", Text = "Take the next step, young one.",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0118", Text = "The path to perfection!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
				},
			},
		},

		KillsRequiredForVoiceLines = 1,

		OnSpawnVoiceLines =
		{
			ThreadName = "SkellySpawnVoiceLines",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				Queue = "Interrupt",
				Cooldowns =
				{
					{ Name = "SkellyOnRespawnSpeech", Time = 20 },
					{ Name = "SkellyAnyQuipSpeech", Time = 9 }
				},

				{ Cue = "/VO/Skelly_0023", Text = "I have returned." },
				{ Cue = "/VO/Skelly_0068", Text = "I rise again." },
				{ Cue = "/VO/Skelly_0286", Text = "Never accept defeat!" },
				{ Cue = "/VO/Skelly_0288", Text = "What news?", PlayFirst = true },
				{ Cue = "/VO/Skelly_0291", Text = "The things that I have seen..." },
				{ Cue = "/VO/Skelly_0114", Text = "{#Emph}Behooold!" },
				{ Cue = "/VO/Skelly_0529", Text = "I'm here, I'm {#Emph}here{#Prev}, what's up?" },
				{ Cue = "/VO/Skelly_0530", Text = "Wait wait I'm back, just on a little break!" },
				{ Cue = "/VO/Skelly_0531", Text = "{#Emph}Uh {#Prev}hey, wanna try that thing out?" },
				{ Cue = "/VO/Skelly_0537", Text = "Mayhaps you wish to do some practicing?" },
				{ Cue = "/VO/Skelly_0538", Text = "Who dares to brandish the Nocturnal Arms?" },
				{ Cue = "/VO/Skelly_0539", Text = "Oh, hey, you're all still standing there..." },
				{ Cue = "/VO/Skelly_0540", Text = "My solitary meditation is complete!" },
				{ Cue = "/VO/Skelly_0718", Text = "{#Emph}Ooh {#Prev}you gotta try that one on {#Emph}me!" },
				{ Cue = "/VO/Skelly_0719", Text = "Give {#Emph}me {#Prev}a piece of that!" },
				{ Cue = "/VO/Skelly_0720", Text = "Did I hear someone switch Nocturnal Arms?!" },
				{ Cue = "/VO/Skelly_0721", Text = "At ease, disciples!" },
				{ Cue = "/VO/Skelly_0722", Text = "All right what'd I miss?" },
				{ Cue = "/VO/Skelly_0723", Text = "How's everybody doin'?" },
				{ Cue = "/VO/Skelly_0724", Text = "You guys are all still here {#Emph}huh?" },
				{ Cue = "/VO/Skelly_0725", Text = "Well {#Emph}that {#Prev}was interesting." },
				{ Cue = "/VO/Skelly_0532", Text = "Who summons me?" },
				{ Cue = "/VO/Skelly_0533", Text = "Who summons me? Oh {#Emph}you {#Prev}again!",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0532" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0534", Text = "Who summons me? Yeah figures.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0532" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0535", Text = "I am here!" },
				{ Cue = "/VO/Skelly_0536", Text = "I am here! And you're over there.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0535" },
						},
					},
				},
			},
		},

		OnRespawnVoiceLines =
		{
			ThreadName = "SkellySpawnVoiceLines",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.85,
				Queue = "Interrupt",
				Cooldowns =
				{
					{ Name = "SkellyOnRespawnSpeech", Time = 20 },
				},
				TriggerCooldowns = { "SkellyAnyQuipSpeech", "SkellyOnHitSpeech" },
				GameStateRequirements = 
				{
					{
						PathFalse = { "MapState", "InOverlook" },
					},
				},

				{ Cue = "/VO/Skelly_0022", Text = "You see?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "SkellyIntro",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0021" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0023", Text = "I have returned." },
				{ Cue = "/VO/Skelly_0066", Text = "Let us continue." },
				{ Cue = "/VO/Skelly_0067", Text = "We always get back up." },
				{ Cue = "/VO/Skelly_0068", Text = "I rise again." },
				{ Cue = "/VO/Skelly_0069", Text = "But can you vanquish me {#Emph}again?" },
				{ Cue = "/VO/Skelly_0286", Text = "Never accept defeat!" },
				{ Cue = "/VO/Skelly_0287", Text = "My vigil thus resumes." },
				{ Cue = "/VO/Skelly_0288", Text = "What news?" },
				{ Cue = "/VO/Skelly_0289", Text = "You may continue." },
				{ Cue = "/VO/Skelly_0290", Text = "A different tactic now?" },
				{ Cue = "/VO/Skelly_0291", Text = "The things that I have seen..." },
				{ Cue = "/VO/Skelly_0697", Text = "I {#Emph}live...!" },
				{ Cue = "/VO/Skelly_0698", Text = "These bones are {#Emph}tough." },
				{ Cue = "/VO/Skelly_0699", Text = "You'll never break me." },
				{ Cue = "/VO/Skelly_0700", Text = "Nice try, though!" },
				{ Cue = "/VO/Skelly_0701", Text = "Surprise, I'm {#Emph}back!" },
				{ Cue = "/VO/Skelly_0702", Text = "Let's see you do that again." },
				{ Cue = "/VO/Skelly_0703", Text = "How about {#Emph}another?" },
				{ Cue = "/VO/Skelly_0704", Text = "Resume your training!" },
				{ Cue = "/VO/Skelly_0705", Text = "As good as new." },
				{ Cue = "/VO/Skelly_0706", Text = "Who needs death?" },
				{ Cue = "/VO/Skelly_0707", Text = "Everyone, at ease." },
				{ Cue = "/VO/Skelly_0708", Text = "...I swore an oath." },
				{ Cue = "/VO/Skelly_0709", Text = "We'll chat some other night.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "UseRecord", "NPC_Skelly_01" },
						},
					},
				},
			},
		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
			NotifyName = "SkellyMissing",
			VoiceLines =
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.1,
				PlayOnceFromTableThisRun = true,
				GameStateRequirements =
				{
					
				},

				{ Cue = "/VO/Melinoe_2956", Text = "Where's the Commander?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2957", Text = "Commander...?" },
			},
		},
		
	},
}

-- Global Skelly Lines
GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Skelly_01",
		TriggerCooldowns = { "SkellyAnyQuipSpeech" },

		{ Cue = "/VO/Skelly_0015", Text = "A fitting armament.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "WeaponsUnlocked", "WeaponDagger" }
				},
			},
		},
		{ Cue = "/VO/Skelly_0026", Text = "Bear it with honor.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "WeaponsUnlocked", "WeaponAxe" }
				},
			},
		},
		{ Cue = "/VO/Skelly_0027", Text = "Would that I could see behind me now...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "WeaponsUnlocked", "WeaponTorch" }
				},
			},
		},
		{ Cue = "/VO/Skelly_0028", Text = "That creepy artifact is {#Emph}yours{#Prev}, kiddo.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "WeaponsUnlocked", "WeaponLob" }
				},
			},
		},
		{ Cue = "/VO/Skelly_0411", Text = "I like the sound of {#Emph}that!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "WeaponsUnlocked", "WeaponSuit" }
				},
			},
		},
		{ Cue = "/VO/Skelly_0412", Text = "Let me see, let me see!" },
	},
}

GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyUpgradeReactionSpeech", Time = 5 },
		},
		TriggerCooldowns = { "SkellyWelcomeSpeech", "SkellyAnyQuipSpeech" },

		{ Cue = "/VO/Skelly_0198", Text = "{#Emph}Whoa{#Prev}, what was that?" },
		{ Cue = "/VO/Skelly_0199", Text = "Hey, what just happened?" },
		{ Cue = "/VO/Skelly_0200", Text = "Oh {#Emph}dang!" },
		{ Cue = "/VO/Skelly_0201", Text = "Oh something's going on back there..." },
		{ Cue = "/VO/Skelly_0202", Text = "{#Emph}Oh{#Prev}, something's up!" },
		{ Cue = "/VO/Skelly_0203", Text = "I know that sound all right!" },
		{ Cue = "/VO/Skelly_0555", Text = "Now we're talkin'." },
		{ Cue = "/VO/Skelly_0556", Text = "Yeah, juice that baby {#Emph}up!" },
		{ Cue = "/VO/Skelly_0557", Text = "The stuff of Nightmares..." },
		{ Cue = "/VO/Skelly_0558", Text = "That's what I like to hear!" },
		{ Cue = "/VO/Skelly_0559", Text = "Aw, you got to try it on {#Emph}me!" },
		{ Cue = "/VO/Skelly_0560", Text = "Toughening up!" },
		{ Cue = "/VO/Skelly_0561", Text = "{#Emph}Yeah{#Prev}, making it happen!" },
		{ Cue = "/VO/Skelly_0562", Text = "The Arms of Night!" },
		{ Cue = "/VO/Skelly_0563", Text = "Yeah wake up!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2545", "/VO/Melinoe_2547", "/VO/Melinoe_3743", "/VO/Melinoe_3741", "/VO/Melinoe_3745", "/VO/Melinoe_3738" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0565", Text = "Wake up!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2545", "/VO/Melinoe_2547", "/VO/Melinoe_3743", "/VO/Melinoe_3741", "/VO/Melinoe_3745", "/VO/Melinoe_3738" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0564", Text = "Let's see 'em!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2546", "/VO/Melinoe_2548", "/VO/Melinoe_3744", "/VO/Melinoe_3742", "/VO/Melinoe_3746", "/VO/Melinoe_3739" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0566", Text = "They better be good!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2546", "/VO/Melinoe_2548", "/VO/Melinoe_3744", "/VO/Melinoe_3742", "/VO/Melinoe_3746", "/VO/Melinoe_3739" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0567", Text = "Not so hidden now!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2549" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0568", Text = "I bet there is!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2550" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0569", Text = "Do it!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2552" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0570", Text = "Can't hide for long!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2553" },
				},
			},
		},
		{ Cue = "/VO/Skelly_0571", Text = "Then show {#Emph}me!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_2554" },
				},
			},
		},
	},
}

GlobalVoiceLines.SkellyWeaponMaxUpgradeReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.63,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyUpgradeReactionSpeech", Time = 5 },
		},
		TriggerCooldowns = { "SkellyWelcomeSpeech", "SkellyAnyQuipSpeech" },

		{ Cue = "/VO/Skelly_0572", Text = "Topped {#Emph}that {#Prev}one off!" },
		{ Cue = "/VO/Skelly_0573", Text = "Did you do it?" },
		{ Cue = "/VO/Skelly_0574", Text = "That's the stuff!" },
		{ Cue = "/VO/Skelly_0575", Text = "Got it all charged up." },
		{ Cue = "/VO/Skelly_0576", Text = "You're {#Emph}all {#Prev}set!" },
		{ Cue = "/VO/Skelly_0577", Text = "Got something real special there." },
		{ Cue = "/VO/Skelly_0578", Text = "Now {#Emph}that {#Prev}is quality!" },
		{ Cue = "/VO/Skelly_0579", Text = "Just how strong {#Emph}is {#Prev}that thing?" },
	}
}

GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		CooldownTime = 5,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Skelly_01",
		TriggerCooldowns = { "SkellyAnyQuipSpeech", "SkellyWelcomeSpeech" },

		{ Cue = "/VO/Skelly_0014", Text = "Requisition authorized!" },
		{ Cue = "/VO/Skelly_0029", Text = "Do make good use of that." },
		{ Cue = "/VO/Skelly_0030", Text = "It shall serve you well." },
		{ Cue = "/VO/Skelly_0031", Text = "A trusty tool indeed." },
		{ Cue = "/VO/Skelly_0118", Text = "The path to perfection...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					HasAll = { "/VO/Skelly_0029", "/VO/Skelly_0030", "/VO/Skelly_0031" },
				},
			},
		},
	},
}

GlobalVoiceLines.SkellyBountyReturnReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.1,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyAnyQuipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "SkellyWelcomeSpeech" },

		{ Cue = "/VO/Skelly_0198", Text = "{#Emph}Whoa{#Prev}, what was that?" },
		{ Cue = "/VO/Skelly_0199", Text = "Hey, what just happened?" },
		{ Cue = "/VO/Skelly_0200", Text = "Oh {#Emph}dang!" },
		{ Cue = "/VO/Skelly_0201", Text = "Oh something's going on back there..." },
		{ Cue = "/VO/Skelly_0202", Text = "Oh, something's up!" },
		{ Cue = "/VO/Skelly_0203", Text = "I know that sound all right!" },
		{ Cue = "/VO/Skelly_0710", Text = "Wait what was {#Emph}that?" },
		{ Cue = "/VO/Skelly_0711", Text = "That weird sound again." },
		{ Cue = "/VO/Skelly_0712", Text = "That you, kiddo?", PlayFirst = true },
		{ Cue = "/VO/Skelly_0713", Text = "Who goes there?" },
		{ Cue = "/VO/Skelly_0714", Text = "Who did that?" },
		{ Cue = "/VO/Skelly_0715", Text = "The Pitch-Black Stone!" },
		{ Cue = "/VO/Skelly_0716", Text = "The {#Emph}call {#Prev}of the {#Emph}Stone!" },
		{ Cue = "/VO/Skelly_0717", Text = "Is she back...?" },
	},
}

GlobalVoiceLines.SkellyLockedReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "SkellyLockedSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0125", Text = "Please step away from that." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "SkellyLockedSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0126", Text = "Don't make me come over there." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "SkellyLockedSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0127", Text = "{#Emph}Eh{#Prev}, the incorrigible youth of today..." },
	},	
}

GlobalVoiceLines.TrophyAttackReactionVoiceLines =
{
	Cooldowns =
	{
		{ Name = "SkellyAnyQuipSpeech", Time = 8 },
	},
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "SourceProjectile", },
			IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
		},
	},
	{
		PreLineWait = 0.3,
		RandomRemaining = true,
		BreakIfPlayed = true,
		ChanceToPlay = 0.25,
		ObjectType = "NPC_Skelly_01",

		{ Cue = "/VO/Skelly_0327", Text = "Restrain yourself!" },
		{ Cue = "/VO/Skelly_0330", Text = "Watch out with those, will ya?", PlayFirst = true },
		{ Cue = "/VO/Skelly_0333", Text = "{#Emph}Please{#Prev}, young one!" },
		{ Cue = "/VO/Skelly_0334", Text = "Hey cut that out!" },
		{ Cue = "/VO/Skelly_0335", Text = "You mustn't hit those!" },
		{ Cue = "/VO/Skelly_0336", Text = "Night's gonna be so mad!" },
		{ Cue = "/VO/Skelly_0328", Text = "Don't chip the paint!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
				},
			}
		},
		{ Cue = "/VO/Skelly_0329", Text = "Do not defile the artistry!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
				},
			}
		},

		{ Cue = "/VO/Skelly_0331", Text = "Watch the statues!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
				},
			}
		},
		{ Cue = "/VO/Skelly_0332", Text = "No, the statues!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
				},
			}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Skelly )