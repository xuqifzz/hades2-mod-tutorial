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
		SpeakerName = "Eris",
		StatusAnimUseOwnerGroup = true,
		BlockExitText = "ExitBlockedByNPC",
		TurnInPlaceAnimation = "Eris_Turn",

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
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "ErisGift01", "ErisGift01_B" },
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

				{ Cue = "/VO/Melinoe_2693", Text = "Hail, Strife." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				PreLineWait = 0.4,
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
			{
				PathFalse = { "PrevRun", "SpawnRecord", "NPC_Eris_01" },
			},
			NamedRequirements = { "ErisUnlocked" },
		},

		PostActivateEvents =
		{
			-- Eris Trash / Rubbish / Litter
			{
				FunctionName = "ErisCurseBackCompatSpawnDrops",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnPointIds = { 585561, 585562, 585563, 585565, 585566, 585567, 585570 },
					OceanusRandomConsumables =
					{
						Force = 0,
						NotRequiredPickup = true,
						IgnoreSounds = true,
						LootOptions =
						{
							{
								Name = "MetaCardPointsCommonDrop",
								Overrides =
								{
									AddResources =
									{
										MetaCardPointsCommon = 20,
									},
									MetaConversionEligible = false,
								},
							},
						}
					},
					FieldsRandomConsumables =
					{
						Force = 0,
						NotRequiredPickup = true,
						IgnoreSounds = true,
						LootOptions =
						{
							{
								Name = "MemPointsCommonDrop",
								Overrides =
								{
									AddResources =
									{
										MemPointsCommon = 50,
									},
									MetaConversionEligible = false,
								},
							},
						}
					},
					TartarusGiveRandomConsumables =
					{
						Force = 0,
						NotRequiredPickup = true,
						IgnoreSounds = true,
						LootOptions =
						{
							{
								Name = "MetaCurrencyDrop",
								Overrides =
								{
									AddResources =
									{
										MetaCurrency = 300,
									},
									MetaConversionEligible = false,
								},
							},
						}
					},
				},
			},
			{
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
					UnitDistanceTrigger =
					{
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
					LitterSpawnPointIds = { 585561, 585562, 585563, 585565, 585566, 585567, 585570 },
					LitterSpawnsMin = 2,
					LitterSpawnsMax = 3,
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
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					-- PreLineAnim = "Enemy_Eris_Hub_Greet",
					-- PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "D'you miss me, Trouble? Thought I'd flit on over to your neck of the woods again, since I'm still {#Emph}welcome here and safe {#Prev}and everything. What you been up to lately?" },
				{ Cue = "/VO/Melinoe_2419", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0024",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You know how come I'm {#Emph}really {#Prev}back, don't you, Trouble? Because things {#Emph}finally {#Prev}started getting {#Emph}interesting. {#Prev}But you're trying to put a stop to it...!" },
				{ Cue = "/VO/Melinoe_2421", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I won't let you cast doubt on my task. Surely you've better uses of your energy than this, and throwing all your rubbish everywhere?" },
				{ Cue = "/VO/Eris_0025",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
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
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0026",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I don't get you people, honestly. So set on making things the way they used to be. {#Emph}You{#Prev}, especially! You don't even know what you're missing!" },
				{ Cue = "/VO/Melinoe_0084", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're trying to set things right, not make them how they used to be. Though, what's your point, Eris?" },
				{ Cue = "/VO/Eris_0027",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2654", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris, you... you said before that I don't even know what I'm missing. What did you mean by that?" },
				{ Cue = "/VO/Eris_0028",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Didn't mean your family, that's for sure! Come on, look at yourself. You've never lived a day in your life! That heart beating in your chest, you think it's only there to pump your blood. Just another muscle!" },
				{ Cue = "/VO/Melinoe_2655", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The heart {#Emph}is {#Prev}a muscle. And so what if I never lived a day? I'm more of a night person. What, should I be out feasting? When Olympus is in peril, and the Underworld in utter disarray?" },
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
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2657", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Look... you're right I've never known what it was like before Chronos returned. You keep insinuating it was worse than now. How so?" },
				{ Cue = "/VO/Eris_0031",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Already told you, babe! Your father, my mother, whole inner circle... they got off bossing everyone around! Didn't give me space to spread my wings. Bunch of Olympus wannabes, but with {#Emph}mood lighting!" },
				{ Cue = "/VO/Melinoe_2658", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0035",
					Text = "You really want to know the way things used to be, Trouble? Think about everything that gets you to come out of your tent night after night. Gets you {#Emph}fired up! {#Prev}What comes to mind?" },
				{ Cue = "/VO/Melinoe_2662", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sure. Those I care about are counting on me. And, I wish to learn; to grow strong in body, mind, and spirit." },
				{ Cue = "/VO/Eris_0036",
					Text = "Inspiring. Now, imagine having everything you want... so you're left wanting nothing at all...." },
				{ Cue = "/VO/Melinoe_2663", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Whoa, haha! {#Prev}You startled me there, Trouble! Sneaking up on me like that, I almost blasted you. You gotta be more careful!" },
				{ Cue = "/VO/Melinoe_2667", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't appreciate you brandishing that thing about. Weapons remain prohibited outside the training grounds, in case you didn't know." },
				{ Cue = "/VO/Eris_0042",
					Text = "{#Emph}Weapons? Ah-ha. {#Prev}Hello, this is the Adamant Rail you're talking about. This baby once took {#Emph}Titans {#Prev}down! It's a work of art. And no one's taking it from me!" },
				{ Cue = "/VO/Melinoe_2668", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			ErisAboutTrash01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2669", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2671", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2674", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why are you really here, Eris? Tell me Chronos didn't put you up to this. You've made quite clear that you don't want me to succeed." },
				{ Cue = "/VO/Eris_0048",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteSurprise",
					Text = "Babe, I'm almost hurt! You don't get me at all, do you? Just because I'm not rooting for {#Emph}you {#Prev}doesn't mean I'm rooting for the {#Emph}other {#Prev}guy." },
				{ Cue = "/VO/Melinoe_2675", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris, how come you're always back here on your own? You never struck me as particularly reticent, and seem to enjoy interacting with others, in your own way...." },
				{ Cue = "/VO/Eris_0056",
					Text = "Well, babe, it's a bit of a weird explanation, and you're not going to like it if I tell you. Which makes me {#Emph}really {#Prev}want to tell you! But then I think about how you must really want to know, which makes me {#Emph}not {#Prev}want to tell you anymore." },
				{ Cue = "/VO/Melinoe_2682", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2683", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've seen firsthand the suffering out there, from all the endless warring between Chronos and the gods. But you're entirely unmoved?" },
				{ Cue = "/VO/Eris_0058",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Who says I'm unmoved? On the contrary, it makes me all emotional. I'm trying to live in the moment and everything, but... I just know I'm going to look back on this and think, {#Emph}these were the best of times." },
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
					AreIdsAlive = { 557113 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0060",
					Text = "You don't know how good you've got it, Trouble. I grew up surrounded by siblings all thinking they were better than me. There's hoity-toity {#Emph}Retribution{#Prev}, over there! And {#Emph}Death{#Prev}, and {#Emph}Doom! {#Prev}Nobody wanted anything to do with {#Emph}Strife." },
				{ Cue = "/VO/Melinoe_2685", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "O_Boss01" },
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "While I cannot shake the sense that this is a personal failing of mine, in spite of everything, I {#Emph}don't {#Prev}hate you, Eris. Not entirely. Although... whose fault {#Emph}is {#Prev}all of that, if not your own?" },
				{ Cue = "/VO/Eris_0126",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteFiredUp",
					Text = "My {#Emph}mother's! {#Prev}It's Nyx's fault, {#Emph}that's {#Prev}whose! Because she literally made me what I am, and what I'll always be. I could have been {#Emph}Old Age{#Prev}, or {#Emph}Friendship! {#Prev}But, no! And I can't change my nature. No matter {#Emph}how {#Prev}hard I try." },
				{ Cue = "/VO/Melinoe_3132", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And, approximately how hard would you say you've tried?" },
				{ Cue = "/VO/Eris_0127",
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0062",
					Text = "Speaking as someone with no small experience starting wars, I gotta say... just 'cause I'm not working for Chronos, doesn't mean I don't respect what he's been able to achieve." },
				{ Cue = "/VO/Melinoe_2686", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris... that was one of the worst sentences I think I've ever heard." },
				{ Cue = "/VO/Eris_0063",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
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
					Text = "Know what your problem is, Trouble? You're too green. Not done enough hard living to tease apart the truth from whatever it is you're told." },
				{ Cue = "/VO/Melinoe_2717", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you for the feedback, Eris. You've given me a lot to think about. I regret our living here in this embattled camp just isn't hard enough." },
				{ Cue = "/VO/Eris_0097",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift01", "OdysseusGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0099",
					Text = "I know what it's like, being pushed away. Having everybody {#Emph}smile {#Prev}to your face then {#Emph}stab {#Prev}you in the back. Well, for what it's worth... I don't believe a word they're saying about you." },
				{ Cue = "/VO/Melinoe_2719", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutSurface01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "O_Boss01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0105",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I figured it out! All these visits topside. {#Emph}You're {#Prev}trying to get to {#Emph}Olympus! {#Prev}Come to the family's rescue! Put an end to the war up there, is that it?" },
				{ Cue = "/VO/Melinoe_2723", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, I just go up there to gather fresh reagents, really. Moss, bits of bronze. Comes in handy! The Olympians are very good at taking care of themselves." },
				{ Cue = "/VO/Eris_0106",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Sure they are. And they're too proud to ask for help. Just don't go ruining it for Ares when you're up there {#Emph}picking Moss. {#Prev}He's on a real hot streak lately!" },
				{ Cue = "/VO/Melinoe_2724", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "Hey, {#Emph}um{#Prev}, babe? I kind of got you something... didn't want to make it a big deal or anything, so... here! For always being sweet." },
				{ Cue = "/VO/Melinoe_2804", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A Nectar bottle... thank you, Eris. Though, we're breaking from tradition here. What if we just kept giving each other this same bottle back and forth, what then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0093", Text = "It'd be total anarchy!" },
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
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_3124", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You traitor! How dare you stand against me and our cause? And, of all the nerve to show your face again here! You'll be cast out for what you've done!" },
				{ Cue = "/VO/Eris_0117",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Sorry, babe, but I'm not going anywhere. Thank Nyx and Hecate and their {#Emph}unbreakable oaths! {#Prev}Besides, you got me all wrong." },
				{ Cue = "/VO/Melinoe_3125", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0.65,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0120",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Hoo{#Prev}, babe, you know what? You put up more of a fight out there than I figured! The Rail was so hot to the touch, I could hardly {#Emph}stand {#Prev}it!" },
				{ Cue = "/VO/Melinoe_3127", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Pleased to be of entertainment for your benefit. Is that all this is to you, then? You jeopardize our continued existence, just for a cheap thrill?" },
				{ Cue = "/VO/Eris_0121",
					Text = "Don't go acting like there wasn't part of you that felt a little {#Emph}thrill {#Prev}out there, yourself. And now that you've had a taste, you want {#Emph}more{#Prev}, don't you?" },
				{ Cue = "/VO/Melinoe_3128", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				-- InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "O_Boss01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_3129", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "PrevRun", "RoomsEntered", "O_Boss01" },
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
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0170",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I really thought you had me that time, babe, but... I guess not. Maybe later. You must be mad you can't get back at me right now." },
				{ Cue = "/VO/Melinoe_3214", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0172",
					Text = "Got me fair and square again, Trouble. More than a couple times! Starting to think maybe I'm losing it, you know?" },
				{ Cue = "/VO/Melinoe_3215", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, you poor thing. Please, let me cheer you up, so you'll proceed to fight against me even harder than before." },
				{ Cue = "/VO/Eris_0173",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You mock me when I'm vulnerable, fine. But don't expect to cry on {#Emph}this {#Prev}shoulder when things take a turn for the worse, when it comes to {#Emph}your {#Prev}stuff. Outta my {#Emph}face!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3216", Text = "{#Emph}Khh." },
					},
				},
			},

			-- about other characters
			ErisAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Melinoe_2659", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've such disdain for what we're trying to achieve. You act as though nothing was lost. Don't you want to see Nyx again? Or Thanatos?" },
				{ Cue = "/VO/Eris_0033",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 3.9 },
					Text = "Don't I want to see my mother again, or brother number-I-have-no-idea? {#Emph}Pff, hahaha{#Prev}, no. They were even more stuck up than you. {#Emph}No offense." },
				{ Cue = "/VO/Melinoe_2660", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...How can you say such things about your relatives? Were they crueler to you than this?" },
				{ Cue = "/VO/Eris_0034",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You don't even speak with Headmistress anymore, do you? Makes her relationship with Nemesis look positively healthy by comparison." },
				{ Cue = "/VO/Eris_0038",
					Text = "She said a {#Emph}lot {#Prev}of nasty things about me, babe. And not just to my face. All because I didn't {#Emph}fit her model {#Prev}of a {#Emph}star disciple! {#Prev}I had to move on. It's just, I don't need anybody like that in my life." },
				{ Cue = "/VO/Melinoe_2665", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris, you repeatedly stole from her, kept using the cauldron to create explosives, and my tent for target practice, vandalized Hypnos in his slumber, salted the garden, and continually harassed Shades about the way they died..." },
				{ Cue = "/VO/Eris_0039",
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
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGetFreeItemIntro01" },
					},
					AreIdsNotAlive = { 557113 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0052",
					Text = "You're {#Emph}really {#Prev}getting under Nemmie's skin lately! Saw her run out in a huff, {#Emph}clanky clank{#Prev}, not long after talking to you. What'd you say that got her so worked up? I'll have to add it to my arsenal." },
				{ Cue = "/VO/Melinoe_2677", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't know. We've discussed my task from time to time, and she's interested in helping out however she can. I think she's just very determined to see our plans succeed." },
				{ Cue = "/VO/Eris_0053",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Ah{#Prev}, I hear you! Fine. A witch never reveals her tricks, somethin' like that? Well, just watch yourself with Sis, is all I'll say. She won't let {#Emph}anybody {#Prev}get too far ahead." },
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
					RequiredFalseQueuedTextLines = { "DoraWithMoros01", "DoraWithMoros02", "MorosWithOdysseus01", "MorosWithOdysseus02" },
					AreIdsAlive = { 560612 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnacking,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0050",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "If I have to listen to another one of your conversations with Moros, I am going to vomit. Though, you'll just clean that up too, won't you?" },
				{ Cue = "/VO/Melinoe_2676", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			ErisAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatN", "HeraclesCombatO", "HeraclesCombatP", "HeraclesCombatF", "HeraclesCombatG" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,

				{ Cue = "/VO/Eris_0054",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "That Heracles sure is {#Emph}something{#Prev}, isn't he? Too bad there's not much going on between his ears. That lion pelt he likes to strut around in probably has got more smarts than {#Emph}him." },
				{ Cue = "/VO/Melinoe_2679", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			-- Partner Conversations
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
				StatusAnimation = "StatusIconWantsToTalk",
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

			-- Repeatable
			ErisChat01 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnackingRepeatable,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0004",
					Text = "Think you might have missed a spot back there, Trouble?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat02 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnackingRepeatable,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0005",
					Text = "Just keep at it, whatever it is you think you've got to prove!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat03 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnackingRepeatable,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0006",
					Text = "What's the big rush? We've got all the time in the world!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat04 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnackingRepeatable,
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreetingRepeatable,
				{ Cue = "/VO/Eris_0007",
					Text = "You know this whole place is turning into a real dump..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Eris",
			},
			ErisChat05 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				-- OnQueuedFunctionArgs = PresetEventArgs.ErisSnackingRepeatable,
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
					AreIdsNotAlive = { 557113 },
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ErisGreeting,
				{ Cue = "/VO/Eris_0014",
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
			-- alt below (for CurseGiver path)
			ErisGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				AltGiftTrackEvent = "ErisGift01_B",

				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ErisGrantsCurse01", "ErisFirstMeeting_B", "ErisGift01_B" },
					},
				},
				{ Cue = "/VO/Melinoe_2690", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Look, I... do want you to feel welcome here and safe. It's not just something that we say. All of us have lost something here. May this gift of Nectar show my words are true." },
				{ Cue = "/VO/Eris_0067",
					PreLineAnim = "Enemy_Eris_Hub_Toss",
					Text = "Wow... made with real Golden Apples! {#Emph}Thanks{#Prev}, babe. You're the only one who's made a real effort to bring me into the fold. Say, why don't you take this? It isn't much, but I've been holding onto it, in case I found a friend..." },
			},
			ErisGift01_B =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				-- HintId = "Codex_NemesisGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisBossFirstMeeting", "ErisGrantsCurse01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ErisGift01" },
					},
				},
				{ Cue = "/VO/Melinoe_2690", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Look, I... do want you to feel welcome here and safe. It's not just something that we say. All of us have lost something here. May this gift of Nectar show my words are true." },
				{ Cue = "/VO/Eris_0067",
					PreLineAnim = "Enemy_Eris_Hub_Toss",
					Text = "Wow... made with real Golden Apples! {#Emph}Thanks{#Prev}, babe. You're the only one who's made a real effort to bring me into the fold. Say, why don't you take this? It isn't much, but I've been holding onto it, in case I found a friend..." },
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisGift01", "ErisGift01_B" },
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
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift02" },
					},
				},
				{ Cue = "/VO/Eris_0089",
					Emote = "PortraitEmoteSurprise",
					Text = "Babe, no one ever gets me anything like this! Except the last couple of times you got me the exact same thing. But oh, I feel so bad I don't have anything for {#Emph}you!" },
				{ Cue = "/VO/Melinoe_2802", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
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
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift03" },
					},
				},
				{ Cue = "/VO/Eris_0090",
					Text = "Just had to see my reaction to another one of these, huh? You say it's only a gift, but you're {#Emph}probably {#Prev}keeping {#Emph}meticulous {#Prev}track of every Nectar you dole out. Hoping whoever {#Emph}gets {#Prev}one's gonna like you just a little more each time." },
				{ Cue = "/VO/Melinoe_2803", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Congratulations on making this weird, Eris... Fine, you figured me out! I'm desperate for your approval and affection. Yours and everyone's! Is that what you think?" },
				{ Cue = "/VO/Eris_0091",
					Text = "You said it, babe, not me. Now, come off it. Though, if you can keep a secret...? I {#Emph}do {#Prev}like you just a little more, I think." },
			},

			-- placeholder
			ErisGiftTemp =
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

			ErisBathHouse01 =
			{
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
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift03" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},

				},
				{ Cue = "/VO/Melinoe_3553", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey... what would you say about a visit to the hot springs, to cleanse yourself of all your foul deeds? And me of mine?" },
				{ Cue = "/VO/Eris_0094",
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_3554", UsePlayerSource = true,
					Text = "The fishing pier's wide open as you can see... any impulse to make use of it a while?" },
				{ Cue = "/VO/Eris_0095",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "{#Emph}Mmm{#Prev}, a trip to the fishing-hole involves a lot more being still and quiet than I think I can handle right now, thanks." },
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
						AreIdsNotAlive = { 585573 },
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
			[1] = GlobalVoiceLines.ErisInvulnerableVoiceLines,
			[2] =
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

				{ Cue = "/VO/MelinoeField_1709", Text = "Go... {#Emph}away!" },
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
				{ Cue = "/VO/ErisField_0036", Text = "Death to {#Emph}Chronos!" },
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

	},
}

VariantSetData.NPC_Eris_01 =
{
	ErisCurseGiver =
	{
		NarrativeDataName = "NPC_Eris_01",
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
					Text = "Actually, yes, I was a little worried about that. You got past the {#Emph}Sirens! {#Prev}What next, you'll go kill Chronos, and then what? Come on, babe. Let's not do anything {#Emph}rash." },
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
					Text = "While I'd love to slow you down with a delightful chat, I think {#Emph}this {#Prev}will get the job done even better.", },
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
					Text = "Look, {#Emph}heh! {#Prev}I know it's been a little rocky between us, but... we'll look back on this and laugh!", },
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
					Text = "You don't look so happy to see me, babe! And I haven't even done anything yet...", },
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
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ungh! {#Prev}This isn't working...! Why won't you stop? What's it going to take, huh?!", },
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
					Text = "You just don't know when to quit, do you, Trouble? Fine!", },
				EndFunctionName = "ApplyErisCurse",
				EndFunctionArgs = PresetEventArgs.ApplyErisCurse,
			},

		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Eris )
OverwriteTableKeys( NPCVariantData, VariantSetData.NPC_Eris_01 )