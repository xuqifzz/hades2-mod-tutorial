UnitSetData.NPC_Eris =
{
	-- Eris, Id = 585573
	NPC_Eris_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Eris_Default_01",
		AnimOffsetZ = 0,
		Groups = { "NPCs" },
		SubtitleColor = Color.ErisVoice,
		EmoteOffsetY = -205,
		SpeakerName = "Eris",
		FieldSpeakerName = "ErisField",
		LoadPackages = { "Eris", },
		StatusAnimUseOwnerGroup = true,
		BlockExitText = "ExitBlockedByNPC",
		TurnInPlaceAnimation = "Eris_Turn",
		
		BecomingCloserFunctionName = "BecomingCloserErisPresentation",

		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		PreBathAnimationName = "Enemy_Eris_Hub_Flattered",
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Boss01", "O_Boss02" },
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

				{ Cue = "/VO/Melinoe_2693", Text = "Hail, Strife." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				ObjectType = "NPC_Eris_01",
				Cooldowns =
				{
					{ Name = "ErisSaluteSpeech", Time = 30 },
				},


				{ Cue = "/VO/Eris_0133", Text = "{#Emph}Huh?" },
				{ Cue = "/VO/Eris_0134", Text = "Same to you!",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
				},
				{ Cue = "/VO/Eris_0135", Text = "Kill 'em all.",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Eris_0136", Text = "Don't need it!",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Eris_0137", Text = "I'll find my own way.",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Eris_0138", Text = "Yes, ma'am!",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
				},
				{ Cue = "/VO/Eris_0139", Text = "You'll need it.",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Eris_0140", Text = "I guess!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Eris_0141", Text = "What's up, babe?",
					PreLineAnim = "Enemy_Eris_Hub_Greet",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784", "/VO/Melinoe_2693" },
						},
					},
				},
			},
		},

		ActivateRequirements =
		{
			NamedRequirements = { "ErisUnlocked" },
		},

		RotatorRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone =
				{
					"ErisAboutRelationship01",
					"ErisAboutRelationship02",

					"MorosGrantsQuestLog",
					"MorosSecondAppearance",
					"MorosGrantsSurfacePenaltyCure01",
					"NarcissusFirstMeeting",
					"EchoFirstMeeting",
					"ChronosNightmare01",
					"ChronosRevealFollowUp",
					"ChronosBossFirstMeeting",
					"ChronosBossFirstMeeting_B",
					"ChronosBossFirstMeeting_C",
					-- "HeraclesFirstMeeting",
					-- "MedeaFirstMeeting",
					-- "PolyphemusFirstMeeting",
				},
			},
			{
				Path = { "CurrentRun", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
				IsNone = { "Choice_ErisAccept" },
			},
			OrRequirements =
			{
				{
					-- more common before True Ending
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "PrevRun", "SpawnRecord", "NPC_Eris_01" },
					},
				},
			}
		},

		PostActivateEvents =
		{
			-- Eris Trash / Eris Litter
			{
				Threaded = true,
				FunctionName = "NPCLittering",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					ChanceToPlay = 1.0,
				},
				Args =
				{
					PreWaitForDistanceTrigger = 0.1,
					UnitDistanceTrigger =
					{
						GameStateRequirements =
						{
							{
								Path = { "ActiveLitter" },
								UseLength = true,
								Comparison = "<",
								Value = 9, -- max litter for toss
							},
							-- shouldn't throw trash if these events are queued
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsNone = { "ErisAboutRelationship01", "MorosWithEris01" }, },
							},
						},
						WithinDistance = 420,
						TriggerOnceThisRun = true,
						FunctionName = "NPCRewardDrop",
						Args =
						{
							Force = 300,
							Consumables =
							{
								{
									Name = "TrashPointsDrop",
									OverwriteSelf =
									{
										TouchdownGroup = "Terrain_02",
										OnTouchdownFunctionName = "SetupDynamicLitter",
									},
								},
							},
							ConsumablePreDropFunctionName = "ErisLitterPresentation",
							ConsumablePreDropFunctionDelay = 0.9,
						},
					},
					-- LitterSpawnPointIds = { 585561, 585562, 585563, 585565, 585566, 585567, 585570 },
					LitterSpawnPointIds = { 585562, 585563, 585565, 585566, 585570 },
					LitterSpawnsMin = 2,
					LitterSpawnsMax = 2,
					LitterName = "TrashPointsDrop",
					LitterGroupName = "Terrain_Litter01",
				},
			},
		},

		InteractTextLineSets =
		{
			-- alt below
			ErisFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisFirstMeeting_B" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					NamedRequirements = { "ErisUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0168",
					-- Portrait = "Portrait_Eris_FiredUp_01",
					-- Portrait = "Portrait_Eris_Unsure_01",
					-- Portrait = "Portrait_Eris_Default_02",
					-- Portrait = "Portrait_Eris_FiredUp_02",
					-- Portrait = "Portrait_Eris_Unsure_02",

					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					-- PreLineAnim = "Enemy_Eris_Hub_Greet",
					-- PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "D'you miss me, Trouble? Thought I'd flit on over to your neck of the woods again, since I'm still {#Emph}welcome here and safe {#Prev}and everything. What you been up to lately?" },
				{ Cue = "/VO/Melinoe_2419", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, not much really, Eris! So, what brings you back? For a while there, I thought maybe you really were gone for good this time." },
				{ Cue = "/VO/Eris_0169",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Hate to disappoint, but I just couldn't stay away! Especially not with everything we're in the middle of right now. {#Emph}You {#Prev}have been {#Emph}real {#Prev}busy lately, {#Emph}huh?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2653", Text = "Whatever it is you heard, please keep it confidential." },
					},
				},
			},
			ErisFirstMeeting_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisBossFirstMeeting", "ErisGrantsCurse01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisFirstMeeting" },
					},
					NamedRequirements = { "ErisUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0165",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					-- PreLineAnim = "Enemy_Eris_Hub_Greet",
					-- PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Miss me, Trouble? Thought I'd flit on over for a bit again, and see how everybody's doing, since I'm {#Emph}welcome here and safe {#Prev}still, aren't I? Though it {#Emph}has {#Prev}been a little while." },
				{ Cue = "/VO/Melinoe_3122", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's not been long enough. Much as I wished you'd grown past your childishness, Eris, I can't imagine you've returned for any reason other than to keep it up." },
				{ Cue = "/VO/Eris_0166",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "What, you can't imagine I just want to visit my big sister, if not you? I get it, you're still mad I slowed you down before, but... I will not do that again, I swear. So truce?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3213", Text = "We'll see." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0167", Text = "Truce!" },
					}
				},
			},

			ErisAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0024",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_Unsure_01",					
					Text = "You know how come I'm {#Emph}really {#Prev}back, don't you, Trouble? Because things {#Emph}finally {#Prev}started getting {#Emph}interesting. {#Prev}But you're trying to put a stop to it...!" },

				{ Cue = "/VO/Melinoe_2421", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I won't let you cast doubt on my task. Surely you've better uses of your energy than this, and throwing all your rubbish everywhere?" },

				{ Cue = "/VO/Eris_0025",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Portrait = "Portrait_Eris_FiredUp_01",
					Text = "What would {#Emph}you {#Prev}even know? I have {#Emph}every {#Prev}right to be here, and you're never getting rid of me! And you're never getting rid of Chronos, either. No going {#Emph}back {#Prev}to how things {#Emph}were!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2422", Text = "We're going forward not back." },
					},
				},
			},

			ErisAboutPurpose01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisTaverna01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0026",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "I don't get you people, honestly. So set on making things the way they used to be. {#Emph}You{#Prev}, especially! You don't even know what you're missing!" },

				{ Cue = "/VO/Melinoe_0084", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We're trying to set things right, not make them how they used to be. Though, what's your point, Eris?" },

				{ Cue = "/VO/Eris_0027",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "What's my point? What's {#Emph}your {#Prev}point? All of you are {#Emph}so {#Prev}obsessed with there being a {#Emph}Point {#Prev}to everything. You do know there isn't one, don't you? Can't just let loose and have a good time?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0085", Text = "Not under the present circumstances, no." },
					},
				},
			},

			ErisAboutHeart01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutPurpose01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2654", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eris, you... you said before that I don't even know what I'm missing. What did you mean by that?" },

				{ Cue = "/VO/Eris_0028",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Didn't mean your {#Emph}family{#Prev}, that's for sure! Come {#Emph}on{#Prev}, look at yourself. You've never lived a {#Emph}day {#Prev}in your {#Emph}life! {#Prev}That heart beating in your chest? You think it's only there to pump your blood! Just another muscle!" },

				{ Cue = "/VO/Melinoe_2655", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The heart {#Emph}is {#Prev}a muscle. What, should I be out feasting? When Olympus is in peril, and the Underworld in utter disarray?" },

				{ Cue = "/VO/Eris_0029",
					Text = "Maybe! But you just want everything nice, and orderly, and predictable, and {#Emph}boring." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2656", Text = "That's not true." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0030", Text = "You sure...?" },
					}
				},
			},

			-- this comes after Past02, because of how time works
			ErisAboutPast01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutPast02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2657", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Look... you're right I've never known what it was like before Chronos returned. You keep insinuating it was worse than now. How so?" },
				{ Cue = "/VO/Eris_0031",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Already told you, babe! Your father, my mother, whole inner circle... they got off bossing everyone around! Didn't give me space to spread my wings. Bunch of Olympus wannabes, but with {#Emph}mood lighting!" },
				{ Cue = "/VO/Melinoe_2658", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...So you prefer living in a state of total disorder and constant mayhem to living under a principled set of rules?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0032", Text = "That's a really good way to put it!" },
					}
				},
			},
			ErisAboutPast02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0035",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You really want to know the way things used to be, Trouble? Think about everything that gets you to come out of your tent night after night. Gets you {#Emph}fired up! {#Prev}What comes to mind?" },
				{ Cue = "/VO/Melinoe_2662", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sure. Those I care about are counting on me. And, I wish to learn; to grow strong in body, mind, and spirit." },
				{ Cue = "/VO/Eris_0036",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Inspiring. Now, imagine having everything you want... so you're left wanting nothing at all...." },
				{ Cue = "/VO/Melinoe_2663", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, I can't imagine that. So, everyone besides you was self-indulgent and unmotivated? But now the roles are reversed, I suppose?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0037", Text = "You don't get it. Fine." },
					}
				},
			},

			ErisAboutWeaponGun01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				-- OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0041",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Whoa, haha! {#Prev}You startled me there, Trouble! Sneaking up on me like that, I almost blasted you. You gotta be more careful!" },
				{ Cue = "/VO/Melinoe_2667", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I don't appreciate you brandishing that thing about. Weapons remain prohibited outside the training grounds, in case you didn't know." },
				{ Cue = "/VO/Eris_0042",
					Portrait = "Portrait_Eris_FiredUp_01",
					Text = "{#Emph}Weapons? Ah-ha! Hello{#Prev}, this is the Adamant Rail you're talking about. This baby once took {#Emph}Titans {#Prev}down! It's a work of art. And {#Emph}no one's {#Prev}taking it from me!" },
				{ Cue = "/VO/Melinoe_2668", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You ever going to tell me how you got your hands on it to begin with? It was intended to be in my {#Emph}father's {#Prev}care... yet, somehow it's in {#Emph}yours." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0043", Text = "Turns out he wasn't so good at protecting his own!" },
					}
				},
			},

			ErisAboutAltFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0201",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Augh {#Prev}what {#Emph}gives? {#Prev}The Adamant Rail's back to normal! I must have hit a hidden switch on it or something, but... it doesn't even {#Emph}work {#Prev}here, let alone transform!" },
				{ Cue = "/VO/Melinoe_4275", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Take the hint, Eris. You may be the bearer of the Rail for the time being, but it doesn't answer to you alone. Even if it lets you aim and shoot." },
				{ Cue = "/VO/Eris_0202",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "If only it let me aim and shoot right {#Emph}now! {#Prev}You better not be behind this, Trouble, or if you {#Emph}are... {#Prev}you change it {#Emph}back! {#Prev}I liked it more the other way!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4276", Text = "It can hear you, you know." },
					}
				},
			},

			ErisAboutTrash01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2669", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What compels you to fill this place with your rubbish, Eris? Do you wish to be welcome here only as a technicality?" },
				{ Cue = "/VO/Eris_0044",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Um{#Prev}, since when am I supposed to care what anybody thinks? You're all about borrowing from the earth. I'm just giving something back!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2670", Text = "That's... {#Emph}eugh..." },
					}
				},
			},
			ErisAboutTrash02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
						Comparison = ">=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2671", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What is this stuff you're always littering about here, anyway? {#Emph}Cyclops Jerky? {#Prev}Did you happen on a limitless supply?" },
				{ Cue = "/VO/Eris_0045",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Know what, as a matter of fact, I did! And you'll never guess where from. This stuff is {#Emph}so addictive {#Prev}once you get into it! Want to try some?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2672", Text = "No." },
					}
				},
			},

			ErisAboutTrash03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_ErisTrashcan" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "TrashPoints" },
						Comparison = ">=",
						Value = 20,
					},
					{
						SumPrevRuns = 9,
						Path = { "UseRecord", "TrashPointsDrop" },
						Comparison = ">=",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0190",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You don't need to pick up after me, you know. {#Emph}I {#Prev}was gonna get around to it! What do you {#Emph}do {#Prev}with all that, anyway?" },

				{ Cue = "/VO/Melinoe_4231", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I present it to the Wretched Broker, through whom anything we no longer require can return to the Earth. You could do so yourself...! The Broker's right there..." },

				{ Cue = "/VO/Eris_0191",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Oh{#Prev}, that's all right. I wouldn't want to impose! Though maybe I'll go through {#Emph}your {#Prev}things next time you're out, and have the Broker there return {#Emph}them {#Prev}to the Earth!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4232", Text = "You wouldn't dare." },
					}
				},
			},

			ErisAboutAlley01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0046",
					Text = "First I thought you stumbled back here by mistake. But {#Emph}you {#Prev}just keep on showing up. Something you want to tell me, babe?" },

				{ Cue = "/VO/Melinoe_2673", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, I... was just drawn here to you. By your trail of rubbish! You're luring me, aren't you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0047", Text = "You're an easy target." },
					},
				},
			},

			ErisAboutLoyalty01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2674", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Why are you really here, Eris? Tell me Chronos didn't put you up to this. You've made quite clear that you don't want me to succeed." },

				{ Cue = "/VO/Eris_0048",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteSurprise",
					Text = "Babe, I'm almost hurt! You don't get me at all, do you? Just because I'm not rooting for {#Emph}you {#Prev}doesn't mean I'm rooting for the {#Emph}other {#Prev}guy." },

				{ Cue = "/VO/Melinoe_2675", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then who exactly are you rooting for, pray tell?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0049", Text = "I'll let you puzzle that one out." },
					},
				},
			},

			ErisAboutSolitude01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2681", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eris, how come you're always back here on your own? You never struck me as particularly reticent, and seem to enjoy interacting with others, in your own way...." },

				{ Cue = "/VO/Eris_0056",
					Text = "Well, babe, it's a bit of a weird explanation, and you're not going to like it if I tell you. Which makes me {#Emph}really {#Prev}want to tell you! But then I think about how you must really want to know, which makes me {#Emph}not {#Prev}want to tell you anymore." },

				{ Cue = "/VO/Melinoe_2682", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm fairly certain it's not that you're just a figment of my imagination. Little voice in my head that keeps leading me astray." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.34,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0057", Text = "Long as you're not {#Emph}completely {#Prev}certain!" },
					},
				},
			},

			ErisAboutDisorder01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2683", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've seen firsthand the suffering out there, from all the endless warring between Chronos and the gods. But you're entirely unmoved?" },
				{ Cue = "/VO/Eris_0058",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Who says I'm {#Emph}unmoved? {#Prev}On the contrary, it makes me all {#Emph}emotional! {#Prev}I'm trying to live in the moment and everything, but... I just know I'm going to look back on this and think, {#Emph}these were the best of times." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2684", Text = "For you; not for anybody else." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0059", Text = "Yes, and...?" },
					},
				},
			},

			ErisAboutStrife01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll = { "NPC_Nemesis_01", "NPC_Moros_01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 557113 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0060",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "You don't know how good you've got it, Trouble. I grew up surrounded by siblings all thinking they were better than me. There's hoity-toity {#Emph}Retribution{#Prev}, over there! And {#Emph}Death{#Prev}, and {#Emph}Doom! {#Prev}Nobody wanted anything to do with {#Emph}Strife." },

				{ Cue = "/VO/Melinoe_2685", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Moros could relate more than you know. You children of Nyx are widely feared, but so what? You don't need a lot of friends. You just need a few good ones. And the very meaning of {#Emph}Strife {#Prev}is for {#Emph}you {#Prev}to define, isn't it?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0061", Text = "I mean, I {#Emph}guess..." },
					},
				},
			},
			ErisAboutStrife02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0125",
					Text = "Don't hate me, babe, OK? It's not my fault I keep lying to you, manipulating you, shooting you with the Rail, making you clean up after me, saying awful things behind your back..." },
				{ Cue = "/VO/Melinoe_3131", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 7.2 },

					Text = "While I cannot shake the sense that this is a personal failing of mine, in spite of everything, I {#Emph}don't {#Prev}hate you, Eris. Not entirely. Although... whose fault {#Emph}is {#Prev}all of that, if not your own?" },

				{ Cue = "/VO/Eris_0126",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteFiredUp",
					Text = "My {#Emph}mother's! {#Prev}It's Nyx's fault, {#Emph}that's {#Prev}whose! Because she literally made me what I am, and what I'll always be. I could have been {#Emph}Old Age{#Prev}, or {#Emph}Friendship! {#Prev}But, no! And I can't change my nature. No matter {#Emph}how {#Prev}hard I try." },

				{ Cue = "/VO/Melinoe_3132", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "And, approximately how hard would you say you've tried?" },

				{ Cue = "/VO/Eris_0127",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "I mean, I haven't {#Emph}really{#Prev}, yet! But I'm going to this time, I swear!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3133", Text = "And I encourage you." },
					},
				},
			},

			ErisAboutWar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0064",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You're {#Emph}so {#Prev}worked up about this war, like it's some {#Emph}huge thing. {#Prev}Olympus {#Emph}loves {#Prev}a good war! Have 'em all the time up there, got a whole {#Emph}god {#Prev}dedicated to 'em and everything. Know how {#Emph}easy {#Prev}it is to get 'em to start fighting?" },
				{ Cue = "/VO/Melinoe_2688", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, Eris, please, enlighten me. Just how easy is it to get my relatives to descend into acts of unconscionable violence and destruction?" },
				{ Cue = "/VO/Eris_0065",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Well this one time, they all flew into a tizzy over a single Golden Apple. A mysterious offering, marked for the {#Emph}fairest one of all! {#Prev}They had a little dispute over who the secret admirer meant, one thing led to another, and {#Emph}boom!" },
				{ Cue = "/VO/Melinoe_2689", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That sounds like a simple misunderstanding, if not a prank. But you say it grew into a full-scale war? What happened then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0066", Text = "{#Emph}Eh{#Prev}, long story..." },
					},
				},
			},
			ErisAboutWar02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisAboutLoyalty01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0062",
					Text = "Speaking as someone with no small experience starting wars, I gotta say... just 'cause I'm not working for Chronos, doesn't mean I don't respect what he's been able to achieve." },

				{ Cue = "/VO/Melinoe_2686", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eris... that was one of the worst sentences I think I've ever heard." },

				{ Cue = "/VO/Eris_0063",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_FiredUp_01",
					Text = "Go look at what he's done, objectively, and tell me I'm wrong!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2687", Text = "No, thank you..." },
					}
				},
			},

			ErisAboutTruth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0096",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Know what your problem is, Trouble? You're too green. Not done enough hard living to tease apart the truth from whatever it is you're told." },

				{ Cue = "/VO/Melinoe_2717", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Thank you for the feedback, Eris. You've given me a lot to think about. I regret our living here in this embattled camp just isn't hard enough." },

				{ Cue = "/VO/Eris_0097",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_FiredUp_01",
					Text = "{#Emph}<Gasp> {#Prev}Sarcasm! Good, I like it. You've got a mean streak in you, I just know it, babe. And I wouldn't want you keeping it all to {#Emph}yourself! {#Prev}Share your gift with the world!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2718", Text = "Whatever you say..." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0098", Text = "{#Emph}Tsch! {#Prev}No! Whatever {#Emph}you {#Prev}say!" },
					},
				},
			},

			ErisAboutRumors01 =
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
						HasAll = { "HecateGift01", "OdysseusGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0099",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "I know what it's like, being pushed away. Having everybody {#Emph}smile {#Prev}to your face then {#Emph}stab {#Prev}you in the back. Well, for what it's worth... I don't believe a word they're saying about you." },

				{ Cue = "/VO/Melinoe_2719", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I see. And to whom exactly are you referring, and can you cite an example of the words purportedly said?" },

				{ Cue = "/VO/Eris_0100",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Oh{#Prev}, it's just... Odysseus and Hecate. I can't believe they think you're gonna {#Emph}fail{#Prev}, that you don't have what it {#Emph}takes...! {#Prev}I mean, I don't want you to succeed, but... I never pretended otherwise!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2720", Text = "You're trying to undermine them." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0101", Text = "I'm just trying to help!" },
					},
				},
			},

			ErisAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Boss01" },
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0102",
					-- PreLineAnim = "Enemy_Eris_Hub_Flattered",
					-- PreLineAnim = "Enemy_Eris_Hub_Greet",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "I heard you went up top! Got to breathe some fresh surface air. What made you go and do a thing like that? Thought you were single-mindedly going after Chronos!" },
				{ Cue = "/VO/Melinoe_2721", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Figured that I might do well with a change of scenery for a bit. Though, I'm surprised you're not up there yourself, considering how things are." },
				{ Cue = "/VO/Eris_0103",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "It does sound pretty exciting! But, I'd probably just be getting in the way. From what I hear, Ares has things well in hand up there. {#Emph}Imagine {#Prev}being the god of war right now. You'd be {#Emph}thrilled!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2722", Text = "Your whole family would be in peril." },
					},
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0104", Text = "...So?" },
					},
				},
			},
			ErisAboutSurface02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- handled in NarrativeData
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "ErisAboutSurface01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0105",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I figured it out! All these visits topside. {#Emph}You're {#Prev}trying to get to {#Emph}Olympus! {#Prev}Come to the family's rescue! Put an end to the war up there, is that it?" },
				{ Cue = "/VO/Melinoe_2723", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, I just go up there to gather fresh reagents, really. Moss, bits of bronze. Comes in handy! The Olympians are very good at taking care of themselves." },
				{ Cue = "/VO/Eris_0106",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Sure they are. And they're too proud to ask for help. Just don't go ruining it for Ares when you're up there {#Emph}picking Moss. {#Prev}He's on a real hot streak lately!" },
				{ Cue = "/VO/Melinoe_2724", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sounds like you and the god of war are still pretty close. Been very busy lately, hasn't he?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0107", Text = "Sure has!" },
					},
				},
			},
			ErisPostGift01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift04" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0092",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "Hey, {#Emph}um{#Prev}, babe? I kind of got you something... didn't want to make it a big deal or anything, so... here! For always being sweet." },

				{ Cue = "/VO/Melinoe_2804", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "A Nectar bottle... thank you, Eris. Though, we're breaking from tradition here. What if we just kept giving each other this same bottle back and forth, what then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0093", Text = "It'd be {#Emph}total {#Prev}anarchy!" },
					}
				},
			},

			ErisFoughtAgainstHer01 =
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
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_3124", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You traitor! How dare you stand against me and our cause? And, of all the nerve to show your face again here! You'll be cast out for what you've done!" },
				{ Cue = "/VO/Eris_0117",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Sorry, babe, but I'm not going anywhere. Thank Nyx and Hecate and their {#Emph}unbreakable oaths! {#Prev}Besides, you got me all wrong." },
				{ Cue = "/VO/Melinoe_3125", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh? Perhaps I merely mistook you for one of Nyx's {#Emph}other {#Prev}daughters who readily shot at me using the Rail of Adamant!" },
				{ Cue = "/VO/Eris_0118",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "No, that was me all right, and I had a {#Emph}great {#Prev}time! But I take umbrage with the {#Emph}traitor {#Prev}thing. Think I made clear I wasn't on your side." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3126", Text = "Then you serve Chronos!" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0119", Text = "{#Emph}Ahahaha{#Prev}, sure!" },
					},
				},
			},

			ErisFoughtAgainstHer02 =
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0.65,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisGift05" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0120",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Hoo{#Prev}, babe, you know what? You put up more of a fight out there than I figured! The Rail was so hot to the touch, I could hardly {#Emph}stand {#Prev}it!" },
				{ Cue = "/VO/Melinoe_3127", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Pleased to be of entertainment for your benefit. Is that all this is to you, then? You jeopardize our continued existence, just for a cheap thrill?" },
				{ Cue = "/VO/Eris_0121",
					Text = "Don't go acting like there wasn't part of you that felt a little {#Emph}thrill {#Prev}out there, yourself. And now that you've had a taste, you want {#Emph}more{#Prev}, don't you?" },
				{ Cue = "/VO/Melinoe_3128", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I want you out of these Crossroads, and out of my blasted path." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0122", Text = "{#Emph}Eh{#Prev}, too bad we can't have it all..." },
					},
				},
			},
			ErisFoughtAgainstHer03 =
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_3129", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Is this what you want, Eris? To have our aimless clashes, only then to sneer at one another here, again and again? Such a worthy cause." },
				{ Cue = "/VO/Eris_0123",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Who are {#Emph}you {#Prev}to say what makes a worthy cause? 'Cause, {#Emph}yeah! {#Prev}I happen to be quite all right with {#Emph}everything! {#Prev}It's genuinely been a real blast!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3130", Text = "You're unbelievable." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0124", Text = "Thanks, Trouble!" },
					},
				},
			},

			ErisAboutCloseMatch01 =
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
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0.15,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = ">",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0170",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I really thought you had me that time, babe, but... I guess not. Maybe later. You must be mad you can't get back at me right now." },
				{ Cue = "/VO/Melinoe_3214", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wouldn't break the peace here even if I could, Eris. But you really test my self-control. When next I see you at the edge of the Rift, I'll not hold back." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0171", Text = "{#Emph}Ooh{#Prev}, she's {#Emph}angry! {#Prev}Just the way I like it." },
					},
				},
			},

			ErisAboutRematches01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 4,
						Path = { "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0172",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "Got me fair and square again, Trouble. More than a couple times! Starting to think maybe I'm losing it, you know?" },

				{ Cue = "/VO/Melinoe_3215", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, you poor thing. Please, let me cheer you up, so you'll proceed to fight against me even harder than before." },

				{ Cue = "/VO/Eris_0173",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PostLineThreadedFunctionName = "ErisExitPresentation",
					PostLineThreadedFunctionArgs = { NoLaugh = true },
					Text = "You mock me when I'm vulnerable, fine. But don't expect to cry on {#Emph}this {#Prev}shoulder when things take a turn for the worse, when it comes to {#Emph}your {#Prev}stuff. Outta my {#Emph}face!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3216", Text = "{#Emph}<Scoff>" },
					},
				},
			},

			ErisAboutNotFighting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift03" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "O_Boss01", "O_Boss02" },
					},
					{
						SumPrevRuns = 5,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ErisAboutNotFighting02" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0196",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "I can't believe you stood me up last night, Trouble! Do you know how {#Emph}demeaning {#Prev}it is having to wait around for you at a beach, in the middle of the night, all {#Emph}alone?" },
				{ Cue = "/VO/Melinoe_4236", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? We had no plans to meet as I recall, else I'd have honored them. You truly expect me to abandon the main focus of my task, just to fight with you again and again?" },
				{ Cue = "/VO/Eris_0197",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I thought I felt something was all... that our times at the beach might be just a little more special to you than your boring job. But I guess I was wrong..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4237", Text = "You guess correctly." },
					},
				},
			},
			ErisAboutNotFighting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered", },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = "<=",
						Value = 0,
					},
					{
						SumPrevRuns = 9,
						Path = { "RoomsEntered", },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ErisAboutNotFighting01" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0198",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Not seen you topside in a while, babe. I didn't want to say anything but it's starting to feel a little {#Emph}personal{#Prev}, you know?" },
				{ Cue = "/VO/Melinoe_4238", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eris, have you considered the possibility that when I pursue my task within the Underworld, you could not be further from my mind?" },
				{ Cue = "/VO/Eris_0199",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "That's what they all say. You know what {#Emph}I {#Prev}think? You're {#Emph}afraid. {#Prev}Not just to face me, but to face your feelings. Fine! Go run away into the Underworld some more." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4239", Text = "Why do I speak to you?" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0200", Text = "Only to hurt us both..." },
					},
				},
			},

			ErisAboutRunCleared01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					--[[
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					]]
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0185",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Great job last night, babe! {#Prev}Is that what you want to hear? Well tough, because you won't be hearing it from {#Emph}me. {#Prev}Other than that one time." },

				{ Cue = "/VO/Melinoe_4205", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "As much as I probably would appreciate the occasional bit of encouragement from you now that you mention it, Eris, I know it's not your tendency. I was just checking up on you." },

				{ Cue = "/VO/Eris_0186",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Aw, thanks! {#Prev}Whenever you accomplish something important it's like you're putting a {#Emph}knife {#Prev}right in my heart. Though, good to know you'll come around and check up on my {#Emph}corpse!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4206", Text = "Oh don't be so dramatic." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						PreLineAnim = "Enemy_Eris_Hub_Scoff",
						{ Cue = "/VO/Eris_0187", Text = "{#Emph}Shut up!" },
					},
				},
			},
			ErisAboutSurfaceRunCleared01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0188",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "They're saying you beat Typhon single-handedly last night. One step closer to putting everything back to normal, huh?" },
				{ Cue = "/VO/Melinoe_4207", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I did not beat Typhon single-handedly, but we managed to defeat him, yes. Though I don't think you need to fear a return to normalcy anytime soon..." },
				{ Cue = "/VO/Eris_0189",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I know you're trying to reassure me, but I can't help the way I {#Emph}feel! {#Prev}I ought to be enjoying all this while it {#Emph}lasts! {#Prev}The future might be boring as dirt, but right now? Things are OK." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4208", Text = "Things are not OK." },
					},
				},
			},

			ErisAboutRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisGift06", "ErisBathHouse01", "ErisTaverna01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisCrying,

				{ Cue = "/VO/Melinoe_4362", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eris, what's the matter? Are you... have you been weeping?" },

				{ Cue = "/VO/Eris_0255",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}No! {#Prev}And... what if I was, {#Emph}huh? {#Prev}It's not like you care about me! Not you or anybody in this whole damn place." },

				{ Cue = "/VO/Melinoe_4363", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh stop it. If you made even the slightest effort not to be a scourge on these Crossroads, perhaps you'd have more companions. I keep foolishly believing that you'll change." },

				{ Cue = "/VO/Eris_0256",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You're not my companion. No one is! No one I'm close to... no one I can depend on... share my secrets with..." },

				{ Cue = "/VO/Melinoe_4364", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Look... I'll not betray your trust if you need someone to confide in. Provided what you share won't put the others whom I care about in any sort of peril." },
					
				{ Cue = "/VO/Eris_0257",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Tsch... {#Prev}others whom you care about. You lump me in with {#Emph}them? {#Prev}Come on, babe, all we do is {#Emph}fight! {#Prev}Which I don't mind, of course! But there's much more to a relationship." },

				{ Cue = "/VO/Melinoe_4365", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've told you to speak plain with me before. What sort of relationship are you expecting us to have when all you do is interfere with me?" },
					
				{ Cue = "/VO/Eris_0258",
					Portrait = "Portrait_Eris_Unsure_01",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					
					PostLineThreadedFunctionArgs = { Delay = 3.5 },
					Text = "You're so stupid sometimes! Look, I can't help the way I feel, and I'm not exactly a good judge of character. Whatever's wrong with me, I know it can't be fixed." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4366", Text = "How could you possibly know that?" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						-- PostLineThreadedFunctionName = "ErisExitPresentation",
						-- PostLineThreadedFunctionArgs = { NoLaugh = true },
						{ Cue = "/VO/Eris_0259", Text = "I just {#Emph}do!" },
					},
				},
			},
			-- see also ErisBossAboutRelationship02
			ErisAboutRelationship02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutRelationship01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisBossAboutRelationship02"}
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_4367", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "When last we spoke you said whatever's wrong with you couldn't be fixed. What makes you say such things?" },

				{ Cue = "/VO/Eris_0260",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Appreciate all the concern but I just had a little moment that you're making a big deal. We're all a little broken, right?" },

				{ Cue = "/VO/Melinoe_4368", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps so. But we can better ourselves through effort and discipline, as much as we can muster. Or, we could endlessly get in each other's way." },

				{ Cue = "/VO/Eris_0261",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PostLineThreadedFunctionName = "ErisExitPresentation",
					Text = "The thing is, I don't want to have to {#Emph}try. {#Prev}Not with {#Emph}this{#Prev}, not with {#Emph}you. {#Prev}I want things to be {#Emph}easy{#Prev}, you want things to be {#Emph}hard. {#Prev}But at least we really {#Emph}get {#Prev}each other now!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 1.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4369", Text = "Eris...!" },
					},
				},
			},

			-- alt below
			ErisAboutRelationship03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01" },
						IsAny = { "Choice_ErisAccept" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_4502", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey about the other night, are we... I mean, are you all right with everything? I don't know what I'm trying to say..." },

				{ Cue = "/VO/Eris_0286",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Babe, {#Emph}stop. {#Prev}You said you never had any regrets about me. Probably lying to yourself, but still. We had our fun, so what?" },

				{ Cue = "/VO/Melinoe_4503", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps I'm just not yet accustomed to what you consider {#Emph}fun. {#Prev}I've had a lot of other things to think about." },

				{ Cue = "/VO/Eris_0287",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "And you always {#Emph}will! {#Prev}But if you don't leave room for any mayhem in your life, it's gonna be a real drag. I swear." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4504", Text = "Mayhem? We were talking about fun." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0288", Text = "Same thing." },
					},
				},
			},
			ErisAboutRelationship03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
						IsAny = { "Choice_ErisDecline" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_4502", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey about the other night, are we... I mean, are you all right with everything? I don't know what I'm trying to say..." },

				{ Cue = "/VO/Eris_0289",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Babe, stop. As much as I like messing with your head, I can't stand it when you act all pathetic. What, you're worried you hurt my little feelings, or just having second thoughts?" },

				{ Cue = "/VO/Melinoe_4505", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Mostly the former. If I've somehow earned some of your trust, it's not my wish to ruin that, in spite of everything." },

				{ Cue = "/VO/Eris_0290",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Then all you have to do is shut up about it! It's only a big deal if you decide to make it one, right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4506", Text = "Right." },
					},
				},
			},

			ErisAboutRelationship04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisBathHouse03", "MorosGift08" },
					},
					{
						Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01" },
						IsAny = { "Choice_ErisAccept" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0291",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You're really turning heads around here, babe. I've seen the way Nemmie and Moros look at you! What do you think, maybe it's time we finally told them about {#Emph}us?" },

				{ Cue = "/VO/Melinoe_4507", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh cut it out, Eris. No serious commitments, right? You happen to come from an attractive family, and we have all the time in the world. Especially once all of this is over." },

				{ Cue = "/VO/Eris_0292",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "I mean, I guess! Assuming this {#Emph}will {#Prev}be over at some point, or something worse doesn't come up! Anyway just messing with your head. I like how gullible you are...!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4510", Text = "What are you talking about?" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0293", Text = "See, that was {#Emph}it!" },
					},
				},
			},

			-- about other characters
			ErisAboutChronos01 =
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
						Path = { "CurrentRun" },
						HasAny = { "Cleared", "BountyCleared" }
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0247",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "So what's been going on with you and Chronos anyway? You keep {#Emph}beating {#Prev}him but he keeps coming {#Emph}back! {#Prev}I like how pointless it seems, but... there has to be more to it, right?" },

				{ Cue = "/VO/Melinoe_4357", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Come on, Eris. I'm not about to reveal the critical details of my task, especially to someone who had every opportunity to be part of it to begin with. Go about your business." },

				{ Cue = "/VO/Eris_0248",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 3.9 },
					Text = "How about you just give me a little hint. Are you planning to use his own powers against him? Break free our family members one by one? Anything like that?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4358", Text = "Not telling you!" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0249", Text = "{#Emph}Mean!" },
					},
				},
			},

			ErisAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutTyphon01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Eris" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0250",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Sounds like there was a big commotion on Olympus last night! And I wasn't even around, thanks to you. How'd it go?" },

				{ Cue = "/VO/Melinoe_4359", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Just great! Almost got eaten by the Father of All Monsters trying to distract him from destroying everything in sight! You really had to be there." },

				{ Cue = "/VO/Eris_0251",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Greet",
					Text = "You know, babe, when somebody misses out on a good time, you ought to play it {#Emph}down{#Prev}, like, {#Emph}oh it wasn't anything that great. {#Prev}Or they'll feel {#Emph}bad {#Prev}they couldn't {#Emph}make it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4360", Text = "You {#Emph}should {#Prev}feel bad." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						PreLineAnim = "Enemy_Eris_Hub_Scoff",
						{ Cue = "/VO/Eris_0252", Text = "Well now, I {#Emph}don't!" },
					},
				},
			},

			ErisAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2659", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You've such disdain for what we're trying to achieve. You act as though nothing was lost. Don't you want to see Nyx again? Or Thanatos?" },
				{ Cue = "/VO/Eris_0033",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 3.9 },
					Text = "Don't I want to see my mother again, or brother number-I-have-no-idea? {#Emph}Pff, hahaha{#Prev}, no. They were even more stuck up than you. {#Emph}No offense." },
				{ Cue = "/VO/Melinoe_2660", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...How can you say such things about your relatives? Were they crueler to you than this?" },
				{ Cue = "/VO/Eris_0034",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Nyx always wanted things {#Emph}her {#Prev}way. Why should she, or anybody, have that kind of power over {#Emph}me? {#Prev}Because she {#Emph}made {#Prev}me? She didn't ask {#Emph}my {#Prev}permission. And I don't need hers." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2661", Text = "I'm sorry..." },
					}
				},
			},
			ErisAboutNyx02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Nyx_Story_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0395",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "So what'd you think of Nyx? You met her, right? Now you know where Nemmie gets her looks, and where {#Emph}I {#Prev}get my personality." },

				{ Cue = "/VO/Melinoe_4924", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? I hardly got to know her but even still, Nyx didn't seem anything like you at all. She was very elegant." },

				{ Cue = "/VO/Eris_0396",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",

					Text = "{#Emph}Aw{#Prev}, thanks, babe. But beneath that cold exterior she's got a wild side, I swear. Why {#Emph}else {#Prev}would she have so many kids all by herself? She's out of her {#Emph}mind!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4925", Text = "Or just you, perhaps." },
					},
				},
			},

			ErisAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutNyx01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2664", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You don't even speak with Headmistress anymore, do you? Makes her relationship with Nemesis look positively healthy by comparison." },

				{ Cue = "/VO/Eris_0038",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "She said a {#Emph}lot {#Prev}of nasty things about me, babe. And not just to my face. All because I didn't {#Emph}fit her model {#Prev}of a {#Emph}star disciple! {#Prev}I had to move on. It's just, I don't need anybody like that in my life." },

				{ Cue = "/VO/Melinoe_2665", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eris, you repeatedly stole from her, kept using the cauldron to create explosives, and my tent for target practice, vandalized Hypnos in his slumber, salted the garden, and continually harassed Shades about the way they died..." },

				{ Cue = "/VO/Eris_0039",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Well, Miss Perfect, so I made a few slip-ups! Doesn't make it OK for Hecate to lecture me, in {#Emph}private{#Prev}, where I couldn't even get full credit for the things I did. You don't know the half of it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2666", Text = "She silence-warded you, didn't she?" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0040", Text = "I think maybe she did..." },
					},
				},
			},

			ErisAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGetFreeItemIntro01", "NemesisGift02" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 557113 }, Alive = false },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0052",
					Text = "You're {#Emph}really {#Prev}getting under Nemmie's skin lately! Saw her run out in a huff, {#Emph}clanky clank{#Prev}, not long after talking to you. What'd you say that got her so worked up? I'll have to add it to my arsenal." },
				{ Cue = "/VO/Melinoe_2677", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wouldn't know. We've discussed my task from time to time, and she's interested in helping out however she can. I think she's just very determined to see our plans succeed." },
				{ Cue = "/VO/Eris_0053",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Ah{#Prev}, I hear you! Fine. A witch never reveals her tricks, something like that? Well, just watch yourself with Sis, is all I'll say. She won't let {#Emph}anybody {#Prev}get too far ahead!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2678", Text = "She sure won't." },
					},
				},
			},

			ErisAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Moros_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
						Comparison = ">=",
						Value = 10,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560612 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0050",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "If I have to listen to another one of your conversations with Moros, I am going to vomit. Though, you'll just clean that up too, won't you?" },
				{ Cue = "/VO/Melinoe_2676", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're not to eavesdrop on my private conversations. Particularly if they induce in you a sense of nausea! You might do well to speak with your brother yourself, sometime." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0051", Text = "I'd much rather see how long he'll keep pretending I'm not here." },
					},
				},
			},
			ErisAboutMoros02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "MorosBathHouse01", "MorosFishing01", "MorosTaverna01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithEris01", "MorosWithEris02" }, Min = 3 },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560612 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_4233", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You've been back a while yet still isolate yourself. Your brother makes more of an effort to fit in, but he struggles too... you may have more in common than you think." },
				{ Cue = "/VO/Eris_0193",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Oh {#Prev}really? Maybe I'll go over and tell him you said that! What, you think just because most of the world hates {#Emph}his {#Prev}guts same as mine that we're {#Emph}alike?" },
				{ Cue = "/VO/Melinoe_4234", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, I'd not put it that way at all... though I do think each of you has been misunderstood in your own right." },
				{ Cue = "/VO/Eris_0194",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "What's not to understand? I'm {#Emph}Strife{#Prev}; he's {#Emph}Doom{#Prev}. These are simple concepts, babe! Though granted, most of the world {#Emph}is {#Prev}pretty stupid..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4235", Text = "You shouldn't say such things." },
					},
					{
						PreLineWait = 0.32,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0195", Text = "You mean the truth?" },
					}
				},
			},

			ErisAboutHypnosWakeUp01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0417",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Aw{#Prev}, Hypnos is {#Emph}gone? {#Prev}I had big plans for him involving a bag of cats and a couple bottles of Nectar you gave me." },

				{ Cue = "/VO/Melinoe_4939", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then I saved him from a terrible fate of some sort. Perhaps at some point down the line he'll thank me properly, as he was in a bit of a hurry to depart." },

				{ Cue = "/VO/Eris_0418",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Why don't you let me kill you next time we're out there on the Rift, and chances are, you'll wash on down into the River Styx, and wind up right in front of him again? He's the greeter at the House of Hades isn't he?" },
				{ Cue = "/VO/Melinoe_4940", UsePlayerSource = true,
					-- Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He's not a {#Emph}greeter. {#Prev}He holds a position of high honor." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0419", Text = "{#Emph}Welcome to the House of Hades! {#Prev}He's a greeter, babe." },
					},
				},
			},

			ErisAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2", "HeraclesCombatF", "HeraclesCombatF2", "HeraclesCombatG", "HeraclesCombatG2" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0054",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "That Heracles sure is {#Emph}something{#Prev}, isn't he? Too bad there's not much going on between his ears. That lion pelt he likes to strut around in probably has got more smarts than {#Emph}him." },
				{ Cue = "/VO/Melinoe_2679", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What makes you say that? Other than your general tendency to speak ill of others. Heracles seems no fool to me; a bit disillusioned, maybe." },
				{ Cue = "/VO/Eris_0055",
					Text = "His club does all the thinking for him, and most of the talking, too. {#Emph}Ehh{#Prev}, you're both gullible! Maybe that's why you think he's so great. Or, maybe he's just your type?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2680", Text = "{#Emph}<Scoff> {#Prev}No...!" },
					},
				},
			},

			-- relationship
			ErisBecomingCloser01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				StatusAnimation = "StatusIconWantsAffection",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll =
						{
							"ErisTaverna02",
							-- back-compat
							"ErisBathHouse02",
							"ErisFishing01",
						},
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Eris" },
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "O_Boss01", "O_Boss02" }, Count = 2 },
					},
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 6,
					},
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "IcarusBecomingCloser01" } },
					},
					NamedRequirements = { "NoRecentBecomingCloserEvent" },
					NamedRequirementsFalse = { "NearTrueEnding" },
					--[[
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					]]--
				},

				{ Cue = "/VO/Eris_0276",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Ungh{#Prev}, I'm still worked up after last night. When did you get so strong? I don't stand a chance against you anymore. Hey, want to go someplace with me, blow off some steam?" },

				{ Cue = "/VO/Melinoe_4491", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm not entirely certain I do. At the taverna at least there are plenty of witnesses in case you try anything untoward." },

				{ Cue = "/VO/Eris_0277",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Portrait = "Portrait_Eris_FiredUp_01",
					PortraitExitAnimation = "Portrait_Eris_FiredUp_01_Exit",
					Text = "C'mon, what are you afraid of? Not like you can't take me in a {#Emph}fight! {#Prev}Anyway, it's not too far. I swear." },

				-- SWITCH TO NEW SCENE

				{ Cue = "/VO/Melinoe_4493", UsePlayerSource = true,
					PreLineFunctionName = "GoSomeplaceStartPresentation",
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...Wait this is it? You weren't jesting when you said it wasn't far. What's so special about this spot?" },

				{ Cue = "/VO/Eris_0278",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I like it here is all. No frogs croaking, no Shades wandering around... no one to catch us if we fool around a little bit..." },

				{ Cue = "/VO/Melinoe_4494", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 2.6 },
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "By fool around a little bit you mean... {#Emph}oh{#Prev}, right. Eris, look, I'm not prepared for any serious commitment here." },
				{ Cue = "/VO/Eris_0279",
					PreLineAnim = "Enemy_Eris_Hub_Greet",
					Text = "Babe, I've never made a serious commitment in my {#Emph}life. {#Prev}I just like to have a little fun from time to time after a hard night trying to shoot you to pieces! What do you say?" },

				EndVoiceLines =
				{
					{
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
								IsAny = { "Choice_ErisDecline" },
							},
						},
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_4496", Text = "Please don't." },
						},
						{
							PreLineWait = 0.35,
							ObjectType = "NPC_Eris_01",
							{ Cue = "/VO/Eris_0281", Text = "{#Emph}Aw..." },
						},
					},
					{
						PreLineWait = 1.5,
						PreLineThreadedFunctionName = "ErisExitPresentation",
						PreLineThreadedFunctionArgs = { NoLaugh = true },
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
								IsAny = { "Choice_ErisAccept" },
							},
						},
						{ Cue = "/VO/Melinoe_4501", Text = "{#Emph}Whew...", UsePlayerSource = true },
					},
				},
				{
					Text = "Choice_ErisBecomingCloser01",
					IgnoreRawText = true,
					IsNarration = true,
					BoxAnimation = "NarrationBubbleRomance",
					BoxExitAnimation = "NarrationBubbleRomanceOut",
					DisableCharacterFadeColorLag = true,
					KeepContextArt = true,
					IgnoreContinueArrow = true,
					TextOffsetY = 0,
					PreContentSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					Choices =
					{
						{
							ChoiceText = "Choice_ErisDecline",
							{ Cue = "/VO/Melinoe_4495", UsePlayerSource = true,
								PreLineWait = 1.0,
								Portrait = "Portrait_Mel_Empathetic_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "It means a lot that you would ask, because I know it's not been easy to get close to anybody here. But this isn't something that I'm looking for right now. Whatever it is we have between us... I've come to like it just the way it is." },

							{ Cue = "/VO/Eris_0280",
								PreLineAnim = "Enemy_Eris_Hub_Flattered",
								Text = "That's how {#Emph}I {#Prev}feel! And I get it, long as you're doing what {#Emph}you {#Prev}want instead of what everybody else wants. Though, mind if I tell everybody that we fooled around here anyway?" },
						},
						{
							ChoiceText = "Choice_ErisAccept",
							{ Cue = "/VO/Melinoe_4497", UsePlayerSource = true,
								PreLineWait = 1.0,
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

								PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 4.8 },

								PortraitExitAnimation = "Portrait_Mel_Proud_01_Exit",
								PostLineFunctionName = "BecomingCloserPresentation",
								PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", Partner = "Eris", TimeTicks = 10, ExtraWaitTime = 0.25 },

								Text = "...While I should probably regret a great many things about our relationship, the truth is, I never have. And besides... I like to learn from my mistakes." },

							-- INTERMISSION PRESENTATION

							{ Cue = "/VO/Melinoe_4498", UsePlayerSource = true,
								Portrait = "Portrait_Mel_PleasedFlushed_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "Well! I think I learned a lot this evening, all in all. Though I should probably get back. If anybody asks, we were at the fishing pier." },

							{ Cue = "/VO/Eris_0283",
								Portrait = "Portrait_Eris_Flushed_01",
								PreLineAnim = "Enemy_Eris_Hub_Greet",
								Text = "We {#Emph}are {#Prev}at the fishing pier, babe. And what does it even matter if anybody asks? Who {#Emph}cares? {#Prev}We were just having a good time! That's not forbidden here, is it?" },

							{ Cue = "/VO/Melinoe_4499", UsePlayerSource = true,
								Portrait = "Portrait_Mel_EmpatheticFlushed_01",
								PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "It isn't, no. So I suppose you now go back to trying to shoot me to pieces night after night like nothing happened?" },

							{ Cue = "/VO/Eris_0284",
								Portrait = "Portrait_Eris_Flushed_01",
								Emote = "PortraitEmoteSparkly",
								Text = "You got it! What, did you really think I was gonna fall so hard that I'd give up on everything that makes me {#Emph}me? {#Prev}Please. No serious commitments, remember?" },

							{ Cue = "/VO/Melinoe_4500", UsePlayerSource = true,
								Portrait = "Portrait_Mel_EmpatheticFlushed_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "I do. And I don't mean to think like mortals here, it's just... I don't understand you sometimes, Eris. To be so... carefree." },

							{ Cue = "/VO/Eris_0285",
								Portrait = "Portrait_Eris_Flushed_01",
								PostLineThreadedFunctionName = "InCombatTextEvent",
								PostLineThreadedFunctionArgs = GameData.PostIntermissionArgs,
								Text = "I'll let you in on a little secret, babe: We like what we don't understand or can't have. Anyway that's always {#Emph}my {#Prev}excuse! See you around!" },
						},
					},
				},
			},

			ErisAboutUltimateProgress01 =
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
						PathTrue = { "CurrentRun", "Cleared" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0379",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Eris_Unsure_01", WaitTime = 5.6 },

					Text = "I'm warning you, you better cut this out, Trouble. Messing with {#Emph}Chronos{#Prev}, messing with {#Emph}Typhon{#Prev}, messing everything {#Emph}up! {#Prev}That's supposed to be {#Emph}my job!" },

				{ Cue = "/VO/Melinoe_4911", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "You clearly did your job already. I'm in the process of undoing it. Much like how I often pick up after you here." },

				{ Cue = "/VO/Eris_0380",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Well you're not gonna. And even if you {#Emph}do{#Prev}, you'll look back on this and wish things were as {#Emph}interesting {#Prev}as they are now!" },

				{ Cue = "/VO/Melinoe_4912", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I wouldn't mind if things were boring for a change." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0381", Text = "I {#Emph}would!" },
					},
				},
			},
			ErisPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0382",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "Say it isn't so, Trouble! The Chronos stuff I'm hearing? He's really calling it quits? And he let Nyx and everybody off? Wh-what did you {#Emph}do {#Prev}to him?!" },

				{ Cue = "/VO/Melinoe_4913", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Working with my brother in a bygone time, we flooded our grandfather's mind with a cascade of new memories of the family he then realized he always had, creating in him a profound and sudden change. Why, what's your concern?" },

				{ Cue = "/VO/Eris_0383",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "My {#Emph}concern {#Prev}is that you ruined everything. So {#Emph}now {#Prev}we'll all have peace and harmony, joyful reunions, apologies, promises to never let this type of thing happen {#Emph}again?! Ungh!" },

				{ Cue = "/VO/Melinoe_4914", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Have you met our families, Eris? It's never that simple." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0384", Text = "It {#Emph}better {#Prev}not be, or I'll {#Emph}never {#Prev}forgive you!" },
					},
				},
			},
			ErisPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift04" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0385",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "What are you even {#Emph}doing {#Prev}in this dump still, anyway? If your mom and pop are back in charge, you ought to be living in style with them down in Tartarus. Are they {#Emph}that {#Prev}bad?" },

				{ Cue = "/VO/Melinoe_4915", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 5.5 },

					Text = "{#Emph}No! {#Prev}I may have been born in Tartarus, but my home is here, as well as my responsibilities. And the Crossroads are {#Emph}not {#Prev}a dump, or at least wouldn't be if you could mind your rubbish." },

				{ Cue = "/VO/Eris_0386",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Whatever! {#Prev}Though at least that's one good thing that came out of all this. I really thought I was gonna lose you, babe." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4916", Text = "Very touching." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0387", Text = "I'm serious!" },
					},
				},
			},
			ErisPostTrueEnding03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift04" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0388",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "How come you have to keep on doing all of this? I thought you {#Emph}won! {#Prev}But, you're still fighting! {#Emph}We're {#Prev}still fighting! I keep telling myself this is {#Emph}way {#Prev}too good to be true...!" },

				{ Cue = "/VO/Melinoe_4917", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 5 },

					Text = "Suffice it to say we have some lingering matters to resolve, which require continuing the process that got us here. So congratulations! Things are going to stay messy for a while." },

				{ Cue = "/VO/Eris_0389",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Eris_Default_01", WaitTime = 2.9 },

					Text = "You don't {#Emph}mean {#Prev}that! You're just trying to get my {#Emph}hopes {#Prev}up! Well, don't you worry. Whatever it is you're planning, sooner or later I'll get involved." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4918", Text = "I've learned to count on it." },
					},
				},
			},
			ErisPostTrueEnding04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,


				{ Cue = "/VO/Melinoe_4921", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So was it worth it, Eris? Impeding me, making my task more difficult at every turn? You didn't prevent this outcome... you could have just aided me like so many others." },

				{ Cue = "/VO/Eris_0392",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Eris_Unsure_01", WaitTime = 2 },

					Text = "And why would I have wanted to do that? Although I {#Emph}am {#Prev}a little disappointed in myself. Looking back, I could have caused {#Emph}so {#Prev}much more mayhem along the way..." },

				{ Cue = "/VO/Melinoe_4922", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well look at you, reflecting on how you could improve! Even if it's at making things worse for everybody else." },

				{ Cue = "/VO/Eris_0393",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Eris_Unsure_01", WaitTime = 3.6 },
					Text = "You taught me that yourself, you know, Trouble? Not that I ever really learn, but... if I don't stay on top of things, maybe sometime in the future, everything will turn out {#Emph}fine..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4923", Text = "We can't have {#Emph}that." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0394", Text = "{#Emph}No." },
					},
				},
			},

			ErisPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0397",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Something's up with you lately, babe! But you're not gonna tell me, so I'm just gonna start guessing. Is it Hecate? I bet it is, because something's up with {#Emph}her {#Prev}lately, too." },

				{ Cue = "/VO/Melinoe_4926", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's nothing, it's just... I've not had opportunity to speak with Headmistress at length since all of this drew to a close. We had... a lot we needed to sort out. And still do." },

				{ Cue = "/VO/Eris_0398",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Aw{#Prev}, too {#Emph}bad! {#Prev}Even with all those scary issues you've been dealing with now mostly gone, turns out you've both got plenty of issues left. It's like they never go {#Emph}away!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4927", Text = "At least you don't have issues, Eris." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0399", Text = "Not a one." },
					},
				},
			},
			ErisPostEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosPostEpilogue01" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0400",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Moros was all giddy recently, at least for {#Emph}him. {#Prev}So you finally got a hold of his sisters, huh? {#Emph}You {#Prev}should feel {#Emph}lucky! {#Prev}They're {#Emph}my {#Prev}sisters too and we've never even {#Emph}met." },

				{ Cue = "/VO/Melinoe_4928", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I saw a bit of {#Emph}you {#Prev}in them, perhaps, Eris. If their past work is any indication, they seem to value spontaneity... making things up as they go." },

				{ Cue = "/VO/Eris_0401",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "So {#Emph}bizarre{#Prev}, right? I mean why be like that when you could try and meticulously plan for every little {#Emph}detail {#Prev}in advance?" },

				{ Cue = "/VO/Melinoe_4929", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They're weavers... they {#Emph}do {#Prev}have to plan. That and spontaneity are not inherently opposed. Speaking of which, you must have heard they're planning an extended break." },

				{ Cue = "/VO/Eris_0402",
					Text = "Meaning {#Emph}we {#Prev}get to make things up as we go, for a change!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4930", Text = "We'll see how that turns out..." },
					},
				},
			},

			-- partner conversations
			ErisWithHecate01 =
			{
				Partner = "NPC_Hecate_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 556921,
				InteractDistance = 450,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutHecate01" }
					},
				},
				OnQueuedFunctionName = "CenterInteractRange",

				{ Cue = "/VO/Eris_0245", PreLineWait = 0.35,
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Thanks for the suggestion, ma'am, but I'll be sticking around as {#Emph}long {#Prev}as I want. Last I checked, you can't do anything about that, right?" },
				{ Cue = "/VO/Hecate_0603", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					PreLineAnimTarget = 556921,
					PostLineAnimTarget = 556921,
					Text = "You are {#Emph}correct{#Prev}, Eris, I cannot stop you from going where you please. But, I {#Emph}can {#Prev}make your life profoundly difficult, in ways you cannot possibly begin to imagine... I refrain only for the vow I made to your mother." },
				{ Cue = "/VO/Eris_0246",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You can't intimidate me. Nyx tried before and look where {#Emph}that {#Prev}got her!" },
				EndVoiceLines =
				{
					PreLineWait = 0.38,
					ObjectType = "NPC_Hecate_01",
					PreLineAnim = "Hecate_Hub_Scoff",

					{ Cue = "/VO/Hecate_0559", Text = "{#Emph}<Sigh>" },
				},
			},

			NemesisWithEris01 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
			},
			NemesisWithEris02 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
			},

			MorosWithEris01 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
			},
			MorosWithEris02 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				-- StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
			},
			IcarusWithEris01 =
			{
				Partner = "NPC_Icarus_01",
				PartnerVariant = "IcarusHome",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				BlockDistanceTriggers = true,
				CopyDataFromPartner = true,
			},

			-- repeatable
			ErisChat01 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0004",
					Text = "Think you might have missed a spot back there, Trouble?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat02 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0005",
					Text = "Just keep at it, whatever it is you think you've got to prove!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat03 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0006",
					Text = "What's the big rush? We've got all the time in the world!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat04 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0007",
					Text = "You know this whole place is turning into a real dump..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat05 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0008",
					Text = "Real shame what's been happening between us lately, Trouble." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat06 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 557113 }, Alive = false },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0009",
					Text = "See Nemmie around, tell her I {#Emph}really {#Prev}wanted to talk to her, OK?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat07 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0010",
					Text = "Life sure moves fast, even for deathless goddesses, {#Emph}huh{#Prev}, Trouble?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat08 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0011",
					Text = "{#Emph}Ahh{#Prev}, don't give me that look. {#Emph}I {#Prev}belong here just as much as {#Emph}you." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat09 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0012",
					Text = "You're not getting anywhere, babe. None of us are!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat10 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0013",
					Text = "How about you mind your own business, Trouble, and lemme mind mine." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat11 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0014",
					PostLineThreadedFunctionName = "ErisExitPresentation",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSurprise",
					Text = "Uh-oh, she's here! I'd better fly away and hide!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat12 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0015",
					Text = "Thought I'd drop in again and check up on everything, y'know?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat13 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0016",
					Text = "You must be {#Emph}really {#Prev}making a difference out there, huh?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat14 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0017",
					Text = "{#Emph}Whew{#Prev}, it's all just been a little much lately, y'know?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat15 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0018",
					Text = "Move along there, Trouble, I don't really want to talk to you right now." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat16 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0019",
					Text = "Come {#Emph}on{#Prev}, babe! You know rumors gonna fly if they catch us like this!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat17 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0020",
					Text = "{#Emph}Eugh{#Prev}, looks like {#Emph}you {#Prev}just woke up! Couldn't wait to see me again, huh?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat18 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0021",
					Text = "Got my eye on you, Trouble. So you better keep your nose clean." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat19 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0022",
					Text = "All this stress, it isn't getting to you, is it, babe?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat20 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0023",
					Text = "Why talk to me? Do what you want! {#Emph}Nobody {#Prev}cares!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},

		},

		GiftTextLineSets =
		{
			ErisGiftDecline01 =
			{
				PlayOnce = true,
				Cost =
				{
					GiftPoints = 1,
				},
				SkipGiftPresentationPost = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Eris_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Eris_0068",
					Text = "You know I can't accept this, now. Not after everything that's {#Emph}happened {#Prev}between us. Let's just... move on with our lives?" },
				{ Cue = "/VO/Melinoe_2692", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "{#Emph}Huh? {#Prev}And, what exactly happened between us, would you say, if you had to summarize...? You're just... mocking me as usual, aren't you..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0069", Text = "Just {#Emph}<sniff> {#Prev}have a good life!" },
					}
				},
			},

			ErisGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,

				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
							},
						},
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAny = { "ErisBossFirstMeeting" },
							},
						},
					},
				},
				{ Cue = "/VO/Melinoe_2690", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Look, I... do want you to feel welcome here and safe. It's not just something that we say. May this gift of Nectar show my words are true." },
				{ Cue = "/VO/Eris_0067",
					PreLineAnim = "Enemy_Eris_Hub_Toss",
					Text = "{#Emph}Wow... {#Prev}made with real Golden Apples! {#Emph}Thanks{#Prev}, babe. You're the only one who's made a real effort to bring me into the fold! Say, why don't you take this? It isn't much, but I've been holding onto it, in case I found a friend..." },
			},

			ErisGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
					},
				},
				{ Cue = "/VO/Eris_0088",
					Text = "But, you already got me one of these. Don't you have anything else? {#Emph}Mmhmhmhm{#Prev}, only messing with you, babe! I'll get you back for this sometime, OK?" },
				{ Cue = "/VO/Melinoe_2801", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Please, don't... I mean, I just wanted you to have it since I know you have a taste for this stuff, but it's been harder to come by. Anyway...!" },

			},
			ErisGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
					},
				},
				{ Cue = "/VO/Eris_0089",
					Emote = "PortraitEmoteSurprise",
					Text = "Babe, no one ever gets me anything like this! Except the last couple of times you got me the exact same thing. But oh, I feel so bad I don't have anything for {#Emph}you!" },
				{ Cue = "/VO/Melinoe_2802", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's only a gift, to make you feel a little better, not worse! Don't mention it, just... you enjoy. But, please don't leave the empty bottle on the ground." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0158", Text = "{#Emph}Ehh..." },
					}
				},

			},
			ErisGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
					},
				},
				{ Cue = "/VO/Eris_0090",
					Text = "Just had to see my reaction to another one of these, huh? You say it's only a gift, but you're {#Emph}probably {#Prev}keeping {#Emph}meticulous {#Prev}track of every Nectar you dole out. Hoping whoever {#Emph}gets {#Prev}one's gonna like you just a little more each time." },
				{ Cue = "/VO/Melinoe_2803", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Congratulations on making this weird, Eris... Fine, you figured me out! I'm {#Emph}desperate {#Prev}for your approval and affection. Yours and everyone's! Is {#Emph}that {#Prev}what you think?" },
				{ Cue = "/VO/Eris_0091",
					Text = "You said it, babe, not me. Now, come off it. Though, if you can keep a secret...? I {#Emph}do {#Prev}like you just a little more, I think." },
			},
			ErisGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
					},
				},
				{ Cue = "/VO/Eris_0203",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "You know I've tried brewing Nectar myself. Got most of the key ingredients, except my batches never tasted right! Not like the stuff you get {#Emph}your {#Prev}hands on." },
				{ Cue = "/VO/Melinoe_4288", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nectar's always best when it's a gift. Ever had somebody else give yours a try? Perhaps it's better than you think." },
				{ Cue = "/VO/Eris_0204",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Well, {#Emph}no{#Prev}, because... for that I'd need a {#Emph}friend. {#Prev}Though I {#Emph}could {#Prev}always {#Emph}trick {#Prev}somebody into drinking it..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4289", Text = "{#Emph}Eris!" },
					},
				},
			},
			ErisGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
					},
				},
				{ Cue = "/VO/Eris_0205",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Right when you trotted over to me here, I wished you'd bring another Nectar, since I'm out. And, {#Emph}lo and behold! {#Prev}It's like you're a {#Emph}mind-reader... {#Prev}or a {#Emph}dream-weaver!" },
				{ Cue = "/VO/Melinoe_4290", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Advanced techniques I haven't mastered yet. Besides, pure intuition still is our most powerful tool in cases such as this! I simply had a feeling you were up for another bottle." },
				{ Cue = "/VO/Eris_0206",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "Way to make it sound like I'm some big experiment for you! Keep {#Emph}poking {#Prev}and {#Emph}prodding {#Prev}and eventually you'll get through my defenses and see the real {#Emph}me? {#Prev}Well this is {#Emph}it. {#Prev}And you know {#Emph}what? {#Prev}I don't want your Nectar anymore." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4291", Text = "Including the one I just gave you?" },
					},
					{
						PreLineWait = 0.43,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0207", Text = "No I'll keep that one." },
					}
				},
			},

			ErisGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				LockedHintId = "Codex_ErisUnlockHint01",
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
						HasAll = { "ErisTaverna01", "ErisGift06", "ErisAboutRelationship01" },
					},
				},

				{ Cue = "/VO/Melinoe_4476", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You said you didn't want my Nectar anymore but said nothing of Ambrosia, Eris, so... what do you say we visit the taverna once again?" },

				{ Cue = "/VO/Eris_0262",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Oh I might visit the taverna, thanks! Though this time I'll be doing it alone. Don't take this the wrong way, but... I don't think we should be seen together anymore." },

				{ Cue = "/VO/Melinoe_4477", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, because you're concerned some baseless rumors will begin to spread? I thought Strife Incarnate wasn't supposed to care what anybody thought." },

				{ Cue = "/VO/Eris_0263",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", WaitTime = 7.5 },
					Text = "It's for your own good. You're the one who's got a reputation to uphold. Really doesn't take much for me to live up to mine. I can just tell you to get out of my {#Emph}face!" },
			},

			ErisGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				StartBecomingCloserTrack = true,
				HintId = "Codex_GrowingCloser01",
				PostBlockSpecialInteract = true,
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
						HasAll = { "ErisGift07" },
					},
				},

				{ Cue = "/VO/Melinoe_4478", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You sure you won't come with me to the taverna anymore? Here's some Ambrosia for you either way. You'll know from its flavor that my intentions are true." },

				{ Cue = "/VO/Eris_0264",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Emote = "PortraitEmoteFiredUp",
					Text = "Yeah, well! Not if I never {#Emph}try {#Prev}it! What if I just smash the bottle on the ground right here? What would you say to {#Emph}that?" },

				{ Cue = "/VO/Melinoe_4479", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'd probably just offer you another. You get on my nerves all the time; Nemesis herself would say it's only fair that I occasionally get on yours." },

				{ Cue = "/VO/Eris_0265",
					Text = "{#Emph}Occasionally? {#Prev}Babe, you've been on my {#Emph}nerves {#Prev}for basically the whole time I've been back. I'm not falling for your tricks!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4480", Text = "What tricks...?" },
					},
				},
			},

			ErisGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_GrowingCloser01",
				PostBlockSpecialInteract = true,
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
						HasAll = { "ErisGift08", "ErisBathHouse02", "ErisFishing01" },
					},
				},

				{ Cue = "/VO/Melinoe_4481", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "For your stockpile of Ambrosia, Strife. Whether you choose to partake of it at the taverna with me, or someone else, or in a quiet moment on your own." },

				{ Cue = "/VO/Eris_0266",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You should know better than to mess with me like this. You know {#Emph}exactly {#Prev}what I am. I happen to kind of like you, but... I can make your life {#Emph}so {#Prev}miserable, you don't even know." },

				{ Cue = "/VO/Melinoe_4482", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps it's your own influence on me but I'm prepared to take my chances. Why else would I keep speaking to you here? As part of some elaborate jest?" },

				{ Cue = "/VO/Eris_0267",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", WaitTime = 9.65 },
					Text = "I don't {#Emph}know {#Prev}why, but the nicer you act with me, the {#Emph}stupider {#Prev}I think you are, and the more {#Emph}suspicious {#Prev}I get! And you've been acting {#Emph}real nice. {#Prev}This whole taverna thing, would you just... ask me {#Emph}normally {#Prev}next time?!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4483", Text = "Can I get that Ambrosia back at least?" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0268", Text = "No!" },
					}
				},
			},

			ErisBathHouse01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",
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
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift02" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3474", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Please don't make me regret this, Eris, but... would you like to join me at the hot springs for a bit? Helps ease the tension." },

				{ Cue = "/VO/Eris_0176",
					PortraitExitAnimation = "Portrait_Eris_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Emote = "PortraitEmoteSurprise",
					Text = "Wait, the springs are purified again? I've been out of the loop! Surprised I'd get another invite after last time, but... {#Emph}OK!" }, 

				{ Cue = "/VO/Eris_0180",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					Text = "{#Emph}Ungh{#Prev}, so {#Emph}this {#Prev}is what you still do to relax? Hot as magma in this thing! Can we get out yet?" },

				{ Cue = "/VO/Melinoe_3475", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Permission denied. You'll quickly grow accustomed to the heat. Just try to concentrate on any tensions that you feel, and let the waters take them." },

				{ Cue = "/VO/Eris_0181",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					Text = "Tensions, {#Emph}me? {#Prev}Babe. I don't need to {#Emph}boil alive {#Prev}in order to cut loose. Though good to know you've found a way to bottle tensions up. What happens if you drink this stuff?" },

				{ Cue = "/VO/Melinoe_3476", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "These springs are pure thanks partly to the Salts we use. Though even still, I wouldn't recommend imbibing them. Next thing you know, {#Emph}you {#Prev}might be purified as well." },

				{ Cue = "/VO/Eris_0182",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					Text = "Oh I'm not worried about that! This is the way I am down to my very core. And if {#Emph}you {#Prev}don't like it, and brought me in here hoping a nice hot bath was all it'd take for me to change, well then... I hate to disappoint." },

				{ Cue = "/VO/Melinoe_3477", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Looks like the waters haven't rid you of your tensions yet...! Sometimes a hot spring is just a hot spring, Eris. Not everything is an assault on your ideals." },

				{ Cue = "/VO/Eris_0183",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "With all of you, I never can be sure. Though, this is nicer than the last time, and the heat isn't so bad right now, I guess..." },

				{ Cue = "/VO/Eris_0184",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,
					
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Eugh{#Prev}... think I drank {#Emph}way {#Prev}too much bath water back there. Is this what being purified feels like? {#Emph}Whew!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3479", Text = "See you, Eris..." },
					},
				},

			},
			ErisBathHouse02 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",
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
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift05" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4292", UsePlayerSource = true,
					Text = "Hey how about another visit to the springs? You seemed to enjoy yourself last time, and I find it truly helps." },

				{ Cue = "/VO/Eris_0208",
					PortraitExitAnimation = "Portrait_Eris_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Well as long as it {#Emph}helps! {#Prev}Look, I don't get my wings wet for just {#Emph}anybody{#Prev}, babe, but you're special. So let's go?" }, 

				{ Cue = "/VO/Melinoe_4293", UsePlayerSource = true,
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "...What is it like having so many siblings? I have but one and didn't even know him growing up. Though I often tried confiding in him anyway, like an imaginary friend." },

				{ Cue = "/VO/Eris_0212",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					Text = "The more brothers and sisters you have, the bigger the disappointment you can be! And it is so embarrassing when you forget their {#Emph}names. {#Prev}Just look how us kids of Nyx get on. The only family more messed up than mine is {#Emph}yours!" },

				{ Cue = "/VO/Melinoe_4294", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "You mean the Olympians. How do you figure? They have their differences to be sure. But they still work together to maintain the natural order of the realms." },

				{ Cue = "/VO/Eris_0213",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					Text = "Work {#Emph}together? {#Prev}Come {#Emph}on{#Prev}, they can barely stand each other, from the very top on down! They never should have gone into business. Always caught between their blood commitments and their jobs!" },

				{ Cue = "/VO/Melinoe_4295", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I won't deny that family adds a complicated layer to their responsibilities. But it's also a source of solidarity and strength. Look at them now, standing together against a common foe. {#Emph}This {#Prev}is the Olympus mortals love and fear." },

				{ Cue = "/VO/Eris_0214",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					Text = "Sorry, not impressed. They say family is a bond that can never be broken, but... as is so often the case, they're {#Emph}wrong. {#Prev}Just because someone's related to you doesn't make them {#Emph}special {#Prev}or deserving of respect." },

				{ Cue = "/VO/Melinoe_4296", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "What {#Emph}does {#Prev}it take to earn respect from you, Eris?" },

				{ Cue = "/VO/Eris_0215",
					Portrait = "Portrait_Eris_Bath_01",
					PortraitExitAnimation = "Portrait_Eris_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "I actually don't even know the answer to that right now. Though, sitting naked with me in half-boiling water helps!" },

				{ Cue = "/VO/Eris_0216",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,
					
					Emote = "PortraitEmoteSparkly",
					Text = "I had a blast there, babe. And look how {#Emph}clean {#Prev}my wings are now! Won't stay like this for long, but... still." },
			},

			ErisBathHouseDecline01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ErisFirstMeeting", "ErisFirstMeeting_B" }
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},

				},
				{ Cue = "/VO/Melinoe_3553", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey... what would you say about a visit to the hot springs, to cleanse yourself of all your foul deeds? And me of mine?" },
				{ Cue = "/VO/Eris_0094",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteSurprise",
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "Oh, {#Emph}haha{#Prev}, well... you know, I'd feel way too self-conscious there with anybody else. Sorry!" },
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

			-- taverna
			ErisTaverna01 =
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisBathHouse01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4277", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're always in this corner on your own. Come to the taverna for a bit! We can {#Emph}let loose and have a good time{#Prev}, as you say. Got a bottle of Ambrosia right here." },

				{ Cue = "/VO/Eris_0238",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_FiredUp_01",
					PortraitExitAnimation = "Portrait_Eris_FiredUp_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Babe that's so {#Emph}spontaneous {#Prev}of you! How could I say {#Emph}no? {#Prev}As long as I'm still allowed in there after what {#Emph}happened..." },

				{ Cue = "/VO/Eris_0239",
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSparkly",
					SkipContextArt = true,
					Text = "{#Emph}Ahh! {#Prev}That stuff does go down {#Emph}smooth! {#Prev}How 'bout another? And {#Emph}nice job {#Prev}with this place! Really looks like you all fixed everything up!" },

				{ Cue = "/VO/Melinoe_4278", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					SkipContextArt = true,
					Text = "This entire area was off limits for some time. It took a rather complex purification ritual and the efforts of a great many Shades to restore it, so... well, I won't even ask." },

				{ Cue = "/VO/Eris_0240",
					PreLineAnim = "Enemy_Eris_Hub_Greet",
					SkipContextArt = true,
					Text = "Good, I'm glad you won't even ask! Means we're {#Emph}really {#Prev}starting to get to know each other. Though, aren't you worried what the Shades are gonna say? I mean, about us...?" },

				{ Cue = "/VO/Melinoe_4279", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					SkipContextArt = true,
					Text = "No, I hadn't considered that there might be some regrettable way to misconstrue our meeting; although in retrospect that was foolish. What do you expect they'll say?" },

				{ Cue = "/VO/Eris_0241",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					SkipContextArt = true,
					Text = "Oh, {#Emph}you {#Prev}know! They see the way you talk to me, pick up after me, take me to the hot springs, give me Nectar, even Ambrosia. I mean, {#Emph}heh{#Prev}, come on! They're not {#Emph}stupid!" },

				{ Cue = "/VO/Melinoe_4280", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					SkipContextArt = true,
					Text = "What? Eris, none of those things... an outing at the taverna is not some sort of... {#Emph}ungh. {#Prev}This simply was an opportunity to speak at greater length for once." },

				{ Cue = "/VO/Eris_0242",
					SkipContextArt = true,

					PortraitExitAnimation = "Portrait_Eris_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "Hate to disappoint, but I didn't come here to {#Emph}speak. {#Prev}Now pour up! I don't have all night and this Ambrosia's {#Emph}way {#Prev}too bitter just for taking little swigs." },

				{ Cue = "/VO/Eris_0243",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,
					Text = "...That was so sweet of you to bring me along! And not a single piece of property destroyed! Glad we could do this." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4282", Text = "Same here..." },
					},
				},
			},

			-- bond forged 
			ErisTaverna02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_GrowingCloser01",
				CompletedHintId = "Codex_BondForgedEris",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHintEris",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisGift09" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" }
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
				{ Cue = "/VO/Melinoe_4484", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm{#Prev}, Eris? Care to join me over at the taverna for a quick break? If you're not otherwise preoccupied." },

				{ Cue = "/VO/Eris_0269",
					Emote = "PortraitEmoteSurprise",
					PortraitExitAnimation = "Portrait_Eris_Default_01_Exit",
					Text = "Wait babe are you asking me out? After {#Emph}all {#Prev}we've been through together, you're {#Emph}still {#Prev}trying to make a fresh start." },

				{ Cue = "/VO/Melinoe_4485", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Last time you suggested I ask normally, so I attempted to. Now are we going for a blasted drink or not?" },

				{ Cue = "/VO/Eris_0270",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_Unsure_01",
					PortraitExitAnimation = "Portrait_Eris_Unsure_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Sure! I'm... into it if you are, though... I don't see the point." },

				{ Cue = "/VO/Eris_0271",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_FiredUp_01",
					Text = "{#Emph}Whew! {#Prev}Now pour another one, come on. Both got a busy night ahead, so let's move it along!" },

				{ Cue = "/VO/Melinoe_4486", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "All right, it's just... Ambrosia is meant more for sipping and savoring than gulping down in one incredibly long tilt." },

				{ Cue = "/VO/Eris_0272",
					SkipContextArt = true,
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "What makes you think I care? I won't feel {#Emph}anything {#Prev}if I take little tiny sips. Hardly feel anything right now!" },

				{ Cue = "/VO/Melinoe_4487", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Perhaps you simply haven't given it a shot the proper way. You lift it to your lips like so. Briefly inhale, consider the aroma, and then drink. But only a bit." },

				{ Cue = "/VO/Eris_0273",
					SkipContextArt = true,
					PreLineWait = 1.1,
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteSurprise",
					Text = "...Oh. {#Emph}Ohhh. {#Prev}That's different, isn't it. I... didn't even know that's how it worked. Why {#Emph}are {#Prev}you being nice to me?" },

				{ Cue = "/VO/Melinoe_4488", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I'm not entirely certain. Just to see what happens I suppose? You said before that you happen to kind of like me. I kind of like you, too! Even though I know I shouldn't..." },

				{ Cue = "/VO/Eris_0274",
					SkipContextArt = true,
					Portrait = "Portrait_Eris_Unsure_01",
					PortraitExitAnimation = "Portrait_Eris_Unsure_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },
					Text = "Well, I feel sorry for you, babe. Really do. We always want what we can never have. Now show me how you sip this stuff again! Aren't you supposed to say something first?" },

				{ Cue = "/VO/Eris_0275",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Eris_01", Icon = "Keepsake_Eris", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostTavernaArgs },

					Text = "...Look that was fun and all but next I spot you at the Rift of Thessaly, I'm still gonna hit you with everything I've got! And you better keep showing up." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4490", Text = "I'm planning on it. Don't ever change, Eris." },
					},
				},

			},

			ErisTavernaDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ErisFirstMeeting_B" }
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4283", UsePlayerSource = true,
					Text = "What if we head to the taverna for a little while? You don't seem particularly busy and we probably should talk..." },
				{ Cue = "/VO/Eris_0244",
					PreLineWait = 0.35,
					Portrait = "Portrait_Eris_Unsure_01",
					PostLineThreadedFunctionName = "SuperGiftPointRefundPresentation",
					Text = "What if you get out of my {#Emph}face {#Prev}for a little while? Don't feel like seeing you and all those Shades judging me, thanks." },
			},

			-- fishing
			ErisFishing01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GiftableOffSource = true,
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
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift04" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				{ Cue = "/VO/Melinoe_4284", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about we head down to the fishing pier a bit? Not like it's far out of the way or anything, and it's a change of pace." },

				{ Cue = "/VO/Eris_0217",
					PostLineRemoveContextArt = true,
					Portrait = "Portrait_Eris_FiredUp_01",
					PortraitExitAnimation = "Portrait_Eris_FiredUp_01_Exit",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Sure{#Prev}, I'm easy, babe! Except when I'm not, but right now I could go for {#Emph}anything! {#Prev}Even stand around for fish to bite!" },

				{ Cue = "/VO/Eris_0218",
					Portrait = "Portrait_Eris_Unsure_01",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					Text = "...Know what I hate more than just about anything else? Having to be perfectly quiet while standing perfectly still. What have I done to deserve this {#Emph}torture?!" },

				{ Cue = "/VO/Melinoe_4285", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "I know it's difficult, which is part of the reason to do it from time to time... just concentrate on being who you are and being here. A fishing pier isn't strictly required." },

				{ Cue = "/VO/Eris_0219",
					SkipContextArt = true,
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "Being focused in on the moment, come {#Emph}on! {#Prev}How can you not {#Emph}always {#Prev}be doing that? At least in other moments I'd be doing what I {#Emph}want. {#Prev}Not caving to your every demand!" },

				{ Cue = "/VO/Melinoe_4286", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "If you don't find anything worthwhile in this, you don't have to do it again. But since we're here, why not find out if we can catch something?" },

				{ Cue = "/VO/Eris_0220",
					SkipContextArt = true,
					PortraitExitAnimation = "Portrait_Eris_Default_01_Exit",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", WaitTime = 4.2 },
					Text = "All {#Emph}you {#Prev}are gonna catch is my {#Emph}fist {#Prev}in your {#Emph}face {#Prev}if you keep on mouthing off to me, babe! Though wait, {#Emph}shut up! {#Prev}Think I just saw something swim by!",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 },
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 16, IncludeFishingSFX = true }, },

				{ Cue = "/VO/Eris_0237",
					PreLineFunctionName = "FishingPierEndPresentation",
					Portrait = "Portrait_Eris_FiredUp_01",
					PortraitExitAnimation = "Portrait_Eris_FiredUp_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "Babe I had a {#Emph}totally {#Prev}amazing time, I {#Emph}swear! {#Prev}And, you don't stink at {#Emph}all!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4692", Text = "Nor do you." },
					},
				},
			},

			ErisFishingDecline01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ErisFirstMeeting_B" }
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3554", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					Text = "The fishing pier's wide open as you can see... any impulse to make use of it a while?" },
				{ Cue = "/VO/Eris_0095",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "{#Emph}Mmm{#Prev}, a trip to the fishing-hole involves a lot more being still and quiet than I think I can handle right now, thanks." },
			},

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
							Path = { "PreviousDeathAreaRoom", "Name" },
							IsNone = { "Hub_PreRun" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B", "ErisFoughtAgainstHer01" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/Melinoe_1158", Text = "Eris is gone...", PlayFirst = true },
					{ Cue = "/VO/Melinoe_2854", Text = "What's Eris up to now..." },
				},
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_2691", Text = "Oh, this really isn't necessary but, {#Emph}erm{#Prev}... thanks." },
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			{ GlobalVoiceLines = "ErisInvulnerableVoiceLines" },
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_1709", Text = "Go... {#Emph}away!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1710", Text = "I'm warning you!" },
				{ Cue = "/VO/MelinoeField_1711", Text = "Not talking to you!" },
				{ Cue = "/VO/MelinoeField_1712", Text = "{#Emph}Argh!" },
			},
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.5,
				ObjectType = "NPC_Eris_01",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/ErisField_0019", Text = "Oh, one last thing...", PlayFirst = true, PreLineWait = 0.35 },
				{ Cue = "/VO/ErisField_0032", Text = "{#Emph}Oopsie!" },
				{ Cue = "/VO/ErisField_0033", Text = "See you later!" },
				{ Cue = "/VO/ErisField_0034", Text = "Bye now!" },
				{ Cue = "/VO/ErisField_0035", Text = "My work here is done!" },
				{ Cue = "/VO/ErisField_0036", Text = "Death to {#Emph}Chronos!",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "TextLinesRecord" },
							HasNone = { "ErisGrantsCurse03", "ErisGrantsCurse05" }
						},
					},
				},
				{ Cue = "/VO/ErisField_0037", Text = "OK, gotta go!" },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 1.15,
				Cooldowns =
				{
					{ Name = "ErisResourceGranted", Time = 8 },
				},

				{ Cue = "/VO/MelinoeField_1703", Text = "What did she do to me...?", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1704", Text = "{#Emph}Eugh{#Prev}, great..." },
				{ Cue = "/VO/MelinoeField_1705", Text = "Curses..." },
				{ Cue = "/VO/MelinoeField_1706", Text = "Trying to slow me down..." },
				{ Cue = "/VO/MelinoeField_1707", Text = "This again?" },
				{ Cue = "/VO/MelinoeField_1708", Text = "I don't appreciate this, Eris...!" },
			},
		},

		Using = 
		{
			Sounds = 
			{
				"/Leftovers/SFX/RobeFlutter",
				"/SFX/Player Sounds/ZagreusGunRunningMisc",
				"/Leftovers/World Sounds/LeavesRustleSoft",
				"/Leftovers/World Sounds/LeavesRustle",
				"/Leftovers/SFX/WingFlapLarge",
				"/Leftovers/World Sounds/LeavesRustleLimited",
				"/Leftovers/World Sounds/QuickSnap2",
				"/Leftovers/World Sounds/LeavesRustleMedium",
			},
		},
	},
}

VariantSetData.NPC_Eris_01 =
{
	ErisCurseGiver =
	{
		NarrativeDataName = "NPC_Eris_01",

		SetupEvents =
		{
			{
				FunctionName = "CenterInteractRange",
				Args = { Distance = 250 },
			},
		},

		InteractTextLinePriorities = "CurseGiverPriorities",
		InteractTextLineSets =
		{
			ErisGrantsCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0017",
					Text = "{#Emph}You're {#Prev}a long way from the Crossroads, Trouble! So, this is where the real action is, {#Emph}huh? {#Prev}Weren't you supposed to still be practicing?" },
				{ Cue = "/VO/MelinoeField_1698", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Things took a turn, Eris...! You know how it goes. Now, if you'll excuse me, I have some urgent business to attend to." },
				{ Cue = "/VO/ErisField_0018",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Always in such a rush! I'd really hate to slow you down, though let's hang out sometime, OK? Have a great night." },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},
			ErisGrantsCurse02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/MelinoeField_1699", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Here to set another curse on me, Eris? For all your {#Emph}idiosyncrasies{#Prev}, I never took you for a traitor." },
				{ Cue = "/VO/ErisField_0020",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "I'm not, {#Emph}I swear! {#Prev}It's just... {#Emph}ugh{#Prev}, you'll never understand. I wanted this to be a {#Emph}special moment{#Prev}, but you had to go and {#Emph}ruin {#Prev}it!" },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},
			ErisGrantsCurse03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/MelinoeField_1700", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You again. What, are you concerned my task just isn't difficult enough? Going a bit too swimmingly?" },
				{ Cue = "/VO/ErisField_0021",
					Text = "Actually {#Emph}yes{#Prev}, I was a little worried about that. You got past the {#Emph}Sirens! {#Prev}What next, you'll go kill Chronos, and then what? Come on, babe. Let's not do anything rash." },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},
			ErisGrantsCurse04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/MelinoeField_1701", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Out of my way, Eris! I won't be wasting any further breath on you while you perpetuate this nonsense." },
				{ Cue = "/VO/ErisField_0022",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "You never understood me, Trouble. Fine! You don't have to. Just remember that I'm doing this for your own good. And actually, mine too!" },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},
			ErisGrantsCurse05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0023",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "What's all the commotion, anyway, {#Emph}huh? {#Prev}Chronos started bashing on Olympus again, sure. But it's not like you have to go after him now, do you?", },
				{ Cue = "/VO/MelinoeField_1702", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Believe me, I'd much rather stay and chitchat with you than sully my hands in Titan blood. But you have a choice, Eris. You can help me finish this, rather than hinder me." },
				{ Cue = "/VO/ErisField_0024",
					Text = "You know, babe... when you're right, you're {#Emph}right. {#Prev}You've given me a lot to chew on. Now you chew on {#Emph}this." },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},
			ErisGrantsCurse06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/MelinoeField_1925", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What are you doing here in Tartarus? There's no way you could have access to this place, unless..." },
				{ Cue = "/VO/ErisField_0025",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Unless I could, like, {#Emph}fly? {#Prev}Come off it, babe, you're {#Emph}way {#Prev}too stuck in your own head. You'll probably be stuck here too!" },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

			-- repeatable
			ErisGrantsCurseMisc01 =
			{
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0026",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Don't take this personally, babe, but some things we just have to do, you know?", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

			ErisGrantsCurseMisc02 =
			{
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0027",
					Text = "While I'd love to slow you down with a delightful chat, I think {#Emph}this {#Prev}will get the job done {#Emph}even better.", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

			ErisGrantsCurseMisc03 =
			{
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0028",
					Text = "Look, {#Emph}heh! {#Prev}I know it's been a little rocky between us, but... we'll probably look back at this and laugh!", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

			ErisGrantsCurseMisc04 =
			{
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0029",
					Text = "You don't look so happy to see me, babe! And I haven't even {#Emph}done {#Prev}anything yet...", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

			ErisGrantsCurseMisc05 =
			{
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0030",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ungh! {#Prev}This isn't working...! Why won't you stop? What's it going to take, {#Emph}huh?", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

			ErisGrantsCurseMisc06 =
			{
				UseableOffSource = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/ErisField_0031",
					Text = "You just don't know when to quit, do you, Trouble? {#Emph}Fine!", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Eris )
OverwriteTableKeys( NPCVariantData, VariantSetData.NPC_Eris_01 )
