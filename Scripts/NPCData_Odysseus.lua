UnitSetData.NPC_Odysseus =
{
	-- Odysseus, Id = 557112
	NPC_Odysseus_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Odysseus_Default_01",
		AnimOffsetZ = 10,
		Groups = { "NPCs" },
		SubtitleColor = Color.OdysseusVoice,
		SpeakerName = "Odysseus",
		TurnInPlaceAnimation = "Odysseus_Turn",
		
		ActivateRequirements =
		{
			-- None
		},

		PreBathAnimationName = "Odysseus_Salute",
		SpecialInteractFunctionName = "SpecialInteractSaluteInterrupt",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Odysseus_01" },
			},
		},
		SpecialInteractCooldown = 60,

		PreSelectGiftFunctionName = "ActivityInterrupt",

		ReportSummonVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,

			{ Cue = "/VO/Odysseus_0300", Text = "Lambda, report." },
			{ Cue = "/VO/Odysseus_0301", Text = "Alpha, report?" },
			{ Cue = "/VO/Odysseus_0302", Text = "Gamma, report in." },
			{ Cue = "/VO/Odysseus_0303", Text = "Delta, your report." },
		},
		ReportResponseVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,

			{ Cue = "/VO/Odysseus_0304", Text = "Aye." },
			{ Cue = "/VO/Odysseus_0305", Text = "Aye..." },
			{ Cue = "/VO/Odysseus_0306", Text = "Aye?" },
			{ Cue = "/VO/Odysseus_0307", Text = "What else." },
			{ Cue = "/VO/Odysseus_0308", Text = "Go on." },
			{ Cue = "/VO/Odysseus_0309", Text = "And?" },
			{ Cue = "/VO/Odysseus_0310", Text = "Anything else?" },
			{ Cue = "/VO/Odysseus_0311", Text = "Details." },
			{ Cue = "/VO/Odysseus_0312", Text = "Blast..." },
			{ Cue = "/VO/Odysseus_0313", Text = "Understood." },
			{ Cue = "/VO/Odysseus_0314", Text = "Very well." },
			{ Cue = "/VO/Odysseus_0315", Text = "Noted." },
			{ Cue = "/VO/Odysseus_0316", Text = "So it seems." },
		},
		ReportConcludedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,

			{ Cue = "/VO/Odysseus_0317", Text = "Shadows conceal you." },
			{ Cue = "/VO/Odysseus_0318", Text = "Well done. Dismissed." },
			{ Cue = "/VO/Odysseus_0319", Text = "Good. Dismissed.", PlayFirst = true },
		},

		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				PlayOnceThisRun = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 3 },
				},

				{ Cue = "/VO/Melinoe_1707", Text = "Death to Chronos, sir." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				ObjectType = "NPC_Odysseus_01",
				PreLineAnim = "Odysseus_Salute",

				-- { Cue = "/VO/Odysseus_0213", Text = "Aye we do." },
				{ Cue = "/VO/Odysseus_0214", Text = "And greetings!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0215", Text = "Salutations!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0216", Text = "Salutations, Goddess.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0217", Text = "You'll get him yet.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2", "/VO/Melinoe_1707" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0224", Text = "He'll get his.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2", "/VO/Melinoe_1707" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0102", Text = "Oh, don't I wish.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2", "/VO/Melinoe_1707" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0218", Text = "And you as well.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0219", Text = "You likewise.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0220", Text = "And may you prevail.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2", "/VO/Melinoe_1705_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0221", Text = "We'll find our way.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0222", Text = "Aye that.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Odysseus_0223", Text = "We'll get through this.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				-- { Cue = "/VO/Odysseus_0096", Text = "You got it." },
				-- { Cue = "/VO/Odysseus_0098", Text = "Your will be done, Goddess." },
				-- { Cue = "/VO/Odysseus_0124", Text = "Seriously, now." },
			},
		},

		NoConversationFunctions =
		{
			-- Odysseus Patrol
			-- Odysseus Idle Behavior - Garden Inspect
			{
				Name = "NPCFollowPath",
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionState", "InFlashback" },
					},
					{
						Path = { "GameState", "GardenPlots", },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
					RequiredFalseQueuedTextLines = GameData.OdysseusTavernaEvents,
				},
				Args =
				{
					Loop = true,
					Timeout = 9.0,
					Path =
					{
						-- Table
						{
							Id = 561464,
							OffsetRadius = 50,
							MinDistanceForMove = 120,
							ArriveFunctionName = "OdysseusArriveAtTable",
							ArriveFunctionArgs =
							{
								GreetDistance = 300,
							},
						},
						{
							Branch =
							{
								{
									-- Branch Option A - Garden Plot 1
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "GardenPlots", 558337 },
										},
									},
									{
										Id = 558337,
										ArriveFunctionName = "OdysseusArriveAtGardenPlot",
										ArriveFunctionArgs =
										{
											GreetDistance = 400,
										},
									},
								},
								{
									-- Branch Option B - Garden Plot 2
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "GardenPlots", 558335 },
										},
									},
									{
										Id = 558335,
										ArriveFunctionName = "OdysseusArriveAtGardenPlot",
										ArriveFunctionArgs =
										{
											GreetDistance = 400,
										},
									},
								},
								{
									-- Branch Option C - Garden Plot 3
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "GardenPlots", 583640 },
										},
									},
									{
										Id = 583640,
										ArriveFunctionName = "OdysseusArriveAtGardenPlot",
										ArriveFunctionArgs =
										{
											GreetDistance = 400,
										},
									},
								},
							},
						},
					},
				},
			},
		},

		InteractTextLineSets =
		{
			OdysseusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0002",
					Text = "Tell me you killed the bastard? Drove your staff into his wretched skull, slid a dagger in his gut? {#Emph}Ungh{#Prev}, not that he'd die from that; works on mortals, though!" },
				{ Cue = "/VO/Melinoe_1166", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I've nothing to report, Odysseus. Not yet." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						{ Cue = "/VO/Odysseus_0225", Text = "Well you'll get him next time, I reckon." },
					},
				},
			},

			OdysseusAboutMountains01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomCountCache", "N_Opening01" },
					},
					AreIdsAlive = { 556921 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0033",
					Text = "Our good witch there knows you've a mountain of a journey ahead of you, Goddess. You hear about our mountains on the surface? Big tall rocks?" },
				{ Cue = "/VO/Melinoe_0448", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What, you mean like Mount Olympus, or Mount Othrys? Of course I've heard of them! They reach up to the sky. I can only imagine." },
				{ Cue = "/VO/Odysseus_0034",
					Text = "You look up from the base to the peak, you'll swear they can't be climbed, {#Emph}but! {#Prev}If you only concern yourself with making that next step... you'll make it to the top." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0058", Text = "To the top..." },
					},
				},
			},
			OdysseusAboutErebus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Odysseus_01" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "H" },
					},					
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0028",
					Text = "Those thorny chaps you've been dealing with... their numbers grow in each report I get. If you've thoughts on how we could have better prepared you..." },
				{ Cue = "/VO/Melinoe_0056", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'll share my thoughts when necessary, Odysseus. For the moment, I'm sorting through them still." },
				{ Cue = "/VO/Odysseus_0029",
					Text = "Aye, best not to speak without prepared remarks. I understand the feeling only too well. You'll keep me posted, though?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- I will.
						{ Cue = "/VO/Melinoe_0057", Text = "I will." },
					},
				},
			},

			OdysseusAboutAdvice01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0035",
					Text = "You run into anything bad whilst you're out there, you come talk to me about it. Chances are I've seen it, fought it, otherwise gotten past it, and can offer some advice." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- Definitely.
						{ Cue = "/VO/Melinoe_0450", Text = "Definitely." },
					},
				},
			},
			OdysseusMeeting05 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- I most certainly do.
						{ Cue = "/VO/Melinoe_0451", Text = "I most certainly do." },
					},
				},
				{ Cue = "/VO/Odysseus_0036",
					Text = "You be wary of the sorts you meet out there, all right? You find a live one gives you any trouble, you know where to hit him where it hurts." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},

			OdysseusAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusWithHecate01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Melinoe_0456", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've known Headmistress quite a while, haven't you? Where did you meet, I always wanted to ask?" },
				{ Cue = "/VO/Odysseus_0040",
					Text = "{#Emph}Heh{#Prev}, well. All I can say is that I was... alone. At the end of one life, and the start of another. Lost. She appeared before me then, in all her splendor, and... she revealed to me a path I hadn't seen." },
				{ Cue = "/VO/Melinoe_0457", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That all sounds very figurative. Were you already dead?" },
				{ Cue = "/VO/Odysseus_0041",
					Text = "I was. She told me she could grant me a new life. She needed a tactician knowledgable of the surface. I thought, who am I to turn a goddess down? I followed her. It's been a while now." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0458", Text = "A good while I'm sure." },
					},
				},
			},
			OdysseusAboutLosingToHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Boss01", },
					},
					{
						PathFalse = { "CurrentRun", "EnemyKills", "Hecate" },
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Odysseus_0143",
					Text = "The good witch put you to the test out there, did she? Quite an intensive teaching style, I always thought. She expects a lot from you, but that's just what happens when you've such potential." },
				{ Cue = "/VO/Melinoe_2185", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Then she must be disappointed with my results, although she's careful not to show it. Same as you, Odysseus." },
				{ Cue = "/VO/Odysseus_0144",
					Text = "Come, I know how dispiriting it is to chart one's course, only to lose one's way. We rarely get where we must go the fastest way we can." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Melinoe_2186", Text = "As long as we get there at all." },
				},
			},
			OdysseusAboutFamiliars01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "CrossroadsPet01" },
						Comparison = ">=",
						Value = 3,
					},
					-- @ update with additional requirements
					NamedRequirementsFalse = { "HecateFamiliarsInHub" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3333", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey where'd Hecuba and Gale scamper off to? I'd ask Headmistress but she doesn't like it when I show even the slightest concern for her Familiars. {#Emph}They're fine, Melinoë." },
				{ Cue = "/VO/Odysseus_0268",
					PreLineAnim = "Odysseus_Greet",
					Text = "Oh they probably {#Emph}are {#Prev}fine! Each on a little scouting expedition at my own behest, under the auspices of the good witch of course. The hound goes one way, the polecat another." },
				{ Cue = "/VO/Melinoe_3334", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Those little scouting expeditions always seem to last a while. I'll have to keep an eye out for them, then." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0269", Text = "Where they're going, they shall appreciate seeing a friendly face." },
					},
				},
			},

			OdysseusAboutErisCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Eris_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisGrantsCurse01" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0235",
					Text = "Word has it Eris has been spotted in the depths along your path... intelligence you likely could have used {#Emph}before {#Prev}she made your journey worse for you. Apologies, Goddess..." },
				{ Cue = "/VO/Melinoe_3096", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She's trying to stop me, or at least slow me down. And... she knows too much about our intentions. What do we do? Children of Nyx are supposed to be on {#Emph}our {#Prev}side." },
				{ Cue = "/VO/Odysseus_0236",
					Text = "She doesn't know the {#Emph}half {#Prev}of what we've planned. Besides, her {#Emph}boredom {#Prev}drives her more than anything. Run into her a few more times, she'll soon grow sick of it and go away." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3097", Text = "So deems the Great Tactician...?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0237", Text = "Aye, Goddess." },
					},
				},
			},

			OdysseusAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with additional requirements 1.0
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisAboutTask01", "ErisAboutPurpose01" },
					},
					AreIdsAlive = { 585573 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3335", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you caught Eris snooping through our plans or anything? Have to be even more discreet with her about..." },
				{ Cue = "/VO/Odysseus_0270",
					Text = "She stays over in her little corner mostly, Goddess, but I've been keeping my eye on her in case of anything. As long as she undermines our efforts well out of earshot..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3336", Text = "We can plan around it, you mean." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0271", Text = "Aye." },
					},
				},
			},

			OdysseusAboutErisBoss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					MaxRunsSinceAnyTextLines = { TextLines = { "ErisBossFirstMeeting" }, Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0272",
					Text = "Good, you're back. According to reports, Eris flew off toward the Rift of Thessaly on an intercept course with the fleet. Except I don't think that she's headed there to help. Not {#Emph}you{#Prev}, at least." },
				{ Cue = "/VO/Melinoe_3311", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "These reports aren't of much benefit to me after the fact. But at least I can confirm they're accurate. How preposterous that we cannot rid ourselves of her." },
				{ Cue = "/VO/Odysseus_0273",
					Text = "All we can do is work with what we've got. I apologize that we could not forewarn you on this one. We'll continue investigating her motives and accomplices." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3312", Text = "I'm not convinced she has any of either." },
					},
				},
			},

			OdysseusAboutNemesis01 =
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutNemesis02" },
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0157",
					Text = "Nemesis has been in an especially foul mood of late. Anything I should know about?" },
				{ Cue = "/VO/Melinoe_2212", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was going to ask you the same. She sought my task, but that's nothing new. Though, she's been clashing with Headmistress more and more..." },
				{ Cue = "/VO/Odysseus_0158",
					Text = "{#Emph}Ah{#Prev}, shame it's been this way. Personally, I'd rather have Divine Retribution with me than against. I reckon you can't just smooth things over with her, can you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2213", Text = "I have my doubts..." },
					},
				},
			},
			OdysseusAboutNemesis02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {  "NemesisCombatFirstIntro", "NemesisGetFreeItemIntro01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0159",
					Text = "So how has Nemesis been faring out there? Taking matters into her {#Emph}very {#Prev}capable hands. Not making {#Emph}too {#Prev}much grief for you, I hope?" },
				{ Cue = "/VO/Melinoe_2214", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So you know already? And Headmistress must, too. Nemesis is being Nemesis! Discovering firsthand our task is not as simple as it seems." },
				{ Cue = "/VO/Odysseus_0160",
					Text = "Say no more, then! Though, if she becomes too intent on impeding your results over achieving her own, we'll step in." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2215", Text = "It won't come to that." },
					},
				},
			},

			OdysseusAboutSkelly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift03", "SkellyGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Melinoe_2218", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You and Commander Schelemeus both were great and famous sailors, weren't you, Od? Did the two of you ever meet in your mortal days?" },
				{ Cue = "/VO/Odysseus_0163",
					Text = "Oh, {#Emph}great sailor {#Prev}is an understatement, Goddess! They say his exploits rivaled even mine! Alas that I never once had an opportunity to witness his prowess. {#Emph}Ah{#Prev}, it must have been something!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2219", Text = "We're fortunate to have you both." },
					},
				},
			},

			OdysseusAboutHypnos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Hypnos_01"},
						Comparison = "<=",
						Value = 3,
					},
					-- @ update with more requirements later
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Melinoe_2209", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You ever seen Hypnos so much as shift in his sleep, Od? I know he's been through a lot, but... still." },
				{ Cue = "/VO/Odysseus_0151",
					Text = "Can't say I have. Been just that way from the night the good witch got him. The snoring I became accustomed to eventually..." },
				{ Cue = "/VO/Melinoe_2210", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Think he's ever going to wake? None of the incantations we've tried have had any effect." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Odysseus_0152", Text = "He's Sleep itself, isn't he?" },
					},
				},
			},

			OdysseusAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					-- NamedRequirements = { "NotSpokenToOdysseusRecently" },
					AreIdsAlive = { 560612 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0153",
					Text = "So {#Emph}Doom {#Prev}has come to stay with us a bit? My last and only other brush with him did not resolve {#Emph}particularly {#Prev}well, so... I'll just keep my distance, if that's quite all right." },
				{ Cue = "/VO/Melinoe_2211", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All children of Nyx are welcome in these Crossroads. Though I think Lord Moros wishes to keep {#Emph}his {#Prev}distance, too." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Odysseus_0154", Text = "No objections here!" },
					},
				},
			},

			OdysseusAboutCirce01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "O_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3313", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "During a recent voyage, I found Circe the Enchantress on her little isle, evidently safe from all the turmoil at sea. Don't you two know each other fairly well?" },
				{ Cue = "/VO/Odysseus_0261",
					PreLineWait = 0.35,
					Text = "In life and death we can but strive to know each other well, Goddess.... Though I knew Circe... just a bit, at least; as casual acquaintances is all, why do you ask?" },
				{ Cue = "/VO/Melinoe_3314", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh just in case you wanted me to tell her anything when next we met, as she may be providing some assistance when I navigate the Rift of Thessaly." },
				{ Cue = "/VO/Odysseus_0262",
					Text = "No, no need to tell her anything. Best keep your focus on the task at hand." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3315", Text = "Noted." },
					},
				},
			},
			OdysseusAboutCirce02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusAboutCirce01", "CirceAboutOdysseus01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3330", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What happened between you and Circe, Od? She mentioned you, said nothing in particular, except... I sensed a pain there, and I sense it here and now." },
				{ Cue = "/VO/Odysseus_0263",
					PreLineAnim = "Odysseus_Greet",
					Text = "It's not a pain entirely, Goddess. When I was whole, returning from a war, I found Circe and her isle, and... I lived there for about a year. She housed me and my men, and we grew close. I learned a lot from her, and then... we left." },
				{ Cue = "/VO/Melinoe_3331", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your voyage home. You stopped for an entire year, then voyaged on and never saw her again..." },
				{ Cue = "/VO/Odysseus_0264",
					Text = "Well, aye, until I saw her again here. It's just... it's in the past, and for the both of us, I think. Not every such relationship need last eternally." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3332", Text = "I understand, I think..." },
					},
				},
			},

			OdysseusAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomCountCache", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0135",
					Text = "We've multiple reports the armies of Chronos are massing on the surface up there, and not yet caught wind of your efforts. At least you aren't contending with {#Emph}them{#Prev}, aye?" },
				{ Cue = "/VO/Melinoe_2172", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My route through the Underworld is fraught in its own right, but yes, it's comforting to know that army of traitors remains ignorant of me." },
				{ Cue = "/VO/Odysseus_0136",
					Text = "There's not a downward route that's more discreet. Those thorny chaps in the woods, {#Emph}they've {#Prev}no love for Chronos either, at least." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2173", Text = "I'll get past them." },
					},
				},
			},

			OdysseusAboutChronosAnomaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosAnomalyIntro01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0242",
					Text = "You look as though you've seen a ghost, if you'll forgive the very antiquated mortal turn-of-phrase, Goddess. So we'd say to someone looking disconcerted. Things all right?" },
				{ Cue = "/VO/Melinoe_3304", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes and no; I saw Chronos out there. I thought he had me, but I broke free from his spell. This was in Oceanus, though I also caught him snooping near the pathways out of Erebus." },
				{ Cue = "/VO/Odysseus_0243",
					Text = "Damn it... our reports said nothing of the sort, but then... some of our Shade informants haven't yet returned. We had expected Chronos to stay put in the lowest reaches. You must have caused enough of a stir to catch his notice." },
				{ Cue = "/VO/Melinoe_3305", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've hardly been discreet in my approach. Is there truly no other way?" },
				{ Cue = "/VO/Odysseus_0244",
					Text = "We reckon not. We're counting on him thinking you're inconsequential to his plans. As for our own, I shall go over this with the good witch. Be safe, and cheers for the report." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3306", Text = "Of course." },
					},
				},
			},

			OdysseusAboutChronos02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosReveal01B", "ChronosRevealFollowUp", },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0161",
					Text = "Got a most troubling report, a sighting in the pathways on the outskirts of Erebus. Did our eyes out there see true?" },
				{ Cue = "/VO/Melinoe_2216", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If it's Chronos that they saw, then yes. Now at least I know what he looks like; but he knows {#Emph}me{#Prev}, in turn. Why do you think he let me go? Have we been compromised?" },
				{ Cue = "/VO/Odysseus_0162",
					Text = "No one gets into the Crossroads whom we don't permit, or can even know we're here... not even him. So he's sniffing around? Fine. He wastes {#Emph}his {#Prev}time whilst {#Emph}you {#Prev}get closer to your mark." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2217", Text = "Is he even capable of wasting time...?" },
					},
				},
			},

			OdysseusAboutChronosBossW01 =
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0228",
					Text = "You got him, didn't you? Killed the bastard, for... one night, at least. The first report I heard, I scarce believed, but by the third or fourth, I'd come around. {#Emph}Well done{#Prev}, Goddess!" },
				{ Cue = "/VO/Melinoe_2967", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thanks, Od. Though I'd not be surprised if our reports already say he's returned. But I got what I needed for now. And a little bit of payback, I suppose." },
				{ Cue = "/VO/Odysseus_0229",
					Text = "Aye, and he'll be sore about it, I expect, but... even though we're not there yet... we needed this, I think. {#Emph}You {#Prev}needed this. On to the next phase then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2968", Text = "Oh, yes." },
					},
				},

			},
			OdysseusAboutChronosBossL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutChronosBossW01"},
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
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0230",
					Text = "You found him, Goddess... your look says it all, along with my reports. Gave him something to remember you by, I reckon, even if the battle didn't go your way..." },
				{ Cue = "/VO/Melinoe_3094", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos was exactly where we expected... but I could not foresee his every technique. And my ability to withstand his magick went only so far." },
				{ Cue = "/VO/Odysseus_0231",
					Text = "Well, fortunately for you, the old are often rather slow to learn. You run into him a few more times like that, you'll soon know every trick he's got. Though... do be very careful out there, aye?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3095", Text = "Aye..." },
					},
				},

			},

			OdysseusAboutScylla01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "G_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0172",
					Text = "How's life of late down at the bottom of the sea? All sorts of nastiness lurking there, {#Emph}that {#Prev}the reports make clear. I wager you've seen some things." },
				{ Cue = "/VO/Melinoe_2181", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You'd win that wager handily. The worst of them has to be this sea-monstress called Scylla, and her Siren friends. They have this ridiculous act..." },
				{ Cue = "/VO/Odysseus_0173",
					PreLineAnim = "Odysseus_Greet",
					Text = "What, Scylla's still around? With the Sirens, no less, {#Emph}hah! {#Prev}It's a wonder you made it back. Please tell me you didn't listen to a word they sang?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2182", Text = "Oh, I heard an earful." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0174", Text = "{#Emph}Ungh..." },
					},
				},
			},
			OdysseusAboutScylla02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutScylla01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "G_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0175",
					Text = "I once was desperate to hear the Sirens' song... I barely resisted their temptations; of course I was... merely mortal. Perhaps you're less susceptible to their allure." },
				{ Cue = "/VO/Melinoe_2183", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps. At any rate, I fail to see the appeal. Although it's possible the Sirens were better off without Scylla. She seems rather bossy..." },
				{ Cue = "/VO/Odysseus_0176",
					Text = "Oh she's a menace. Caught half a dozen of my crew like she'd a separate set of teeth for each of the poor lads. We'd little choice but to pray to the gods, and sail on. Tell her hello for me!" },
				{ Cue = "/VO/Melinoe_2184", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did the gods answer your call at least?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0177", Text = "{#Emph}Erm{#Prev}, for the most part!" },
					},
				},
			},
			OdysseusAboutScylla03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				TeleportToId = 589482,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusBackstory01", "OdysseusAboutScylla02", "OdysseusAboutMood01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "OdysseusBackstory02", "OdysseusAboutMood01" }, Count = 2 },
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Melinoe_2202", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've seen you here alone more often lately, Od. You miss Penelope, don't you? And your son, what was his name? Telemachus." },
				{ Cue = "/VO/Odysseus_0195",
					Text = "{#Emph}Ah{#Prev}, Goddess, you may see through most of us Shades, but your empathy for me's a bit... misplaced. Penelope, Telemachus, and I... we're cordial with each other still, but... how to say this without sounding callous..." },
				{ Cue = "/VO/Melinoe_2203", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please speak your mind with me. I'm certain you're not callous." },
				{ Cue = "/VO/Odysseus_0232",
					Text = "...My mind wanders not to matters of family, but... to the Sirens' blasted song. I scarce got to hear it even once, whilst navigating through their waters. I wanted {#Emph}desperately {#Prev}to cast myself into the sea, just for a better listen..." },
				{ Cue = "/VO/Melinoe_2204", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Sirens' song? You can't expect me to believe that Scylla's incessant drivel is the source of the Great Tactician's concerns of late?" },
				{ Cue = "/VO/Odysseus_0197",
					PreLineAnim = "Odysseus_Salute",
					Text = "Now, now, spare me the ridicule, I'm dead serious about this. You weren't with me on the surface there and wouldn't understand..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2205", Text = "Seemingly not..." },
					},
				},
			},
			OdysseusAboutScylla04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutScylla03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_2206", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When last we spoke in the taverna. I didn't mean to shame you for your musical tastes. I just had no idea that Scylla could be taken seriously by anybody... much less you." },
				{ Cue = "/VO/Odysseus_0233",
					PreLineAnim = "Odysseus_Greet",
					Text = "{#Emph}Ah{#Prev}, think nothing of it. Siren music's an {#Emph}acquired taste... {#Prev}acquired by all those who sailed in their vicinity whilst I was whole. {#Emph}Incessant drivel{#Prev}, though, that's all you think it is?" },
				{ Cue = "/VO/Melinoe_2207", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well... perhaps I was a bit uncharitable in my assessment, it's just... I have trouble separating my disdain for the performer from the quality of her craft." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0199", Text = "It must be very catchy, aye?" },
					},
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2208", Text = "Aye..." },
					},
				},
			},

			-- if you haven't fought the infernal beast
			OdysseusAboutCerberus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutCerberus01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0254",
					Text = "A word of caution, Goddess, in regard to an impediment you may confront when finally you reach the far end of the Mourning Fields. Reports suggest it's some sort of infernal beast... a big one. Our Shades had to stay very far away." },
				{ Cue = "/VO/Melinoe_3324", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We knew there was a secure entrance into Tartarus around that point... this beast must be how come the tunnel stays secure. Have we any details?" },
				{ Cue = "/VO/Odysseus_0255",
					Text = "Well it has several fire-spitting maws, allegedly, which troublingly fits the profile of your father's household pet. Though, if this really is the case... may it simply let you pass!" },
				{ Cue = "/VO/Melinoe_3325", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What, you mean Cerberus himself guards the entrance to Tartarus? Why would he do the bidding of Chronos? Impossible." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0256", Text = "The reports are inconclusive, but I thought you should know." },
					},
				},
			},
			-- if you fought the infernal beast
			OdysseusAboutCerberus01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutCerberus01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0254",
					Text = "A word of caution, Goddess, in regard to an impediment you may confront when finally you reach the far end of the Mourning Fields. Reports suggest it's some sort of infernal beast... a big one. Our Shades had to stay very far away." },
				{ Cue = "/VO/Melinoe_3326", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can corroborate our Shades' reports. And add that this infernal beast is none other than Cerberus, my father's household pet... acting on instinct and pure rage." },
				{ Cue = "/VO/Odysseus_0257",
					Text = "{#Emph}Ahh{#Prev}, I feared as much. For they said the beast had several fire-spitting maws. I don't suppose he recognized you after all this time, and... let you pass...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3327", Text = "He did neither of those things. I have to help him." },
					},
				},
			},

			OdysseusAboutPoseidon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "PoseidonFirstPickUp", "ZeusFirstPickUp" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0129",
					Text = "With your Olympus-dwelling relatives assisting you, I've half a mind to ask you to let them know I'm on your side, except... {#Emph}erm{#Prev}, not all of them love me." },
				{ Cue = "/VO/Melinoe_0478", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}What? {#Prev}But you're the Great Tactician, Odysseus! Even the gods were impressed with your machinations in your glory days." },
				{ Cue = "/VO/Odysseus_0130",
					Text = "{#Emph}Erm{#Prev}, Lady Athena and others favored me, it's true, but your uncle Poseidon, well... I got on his bad side, I believe. Maybe he's let it go after all this time, but that's a risk I'm not prepared to take, so... keep quiet about me, would you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0479", Text = "I hear you." },
					},
				},
			},

			OdysseusAboutHermes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0204",
					Text = "So, there's a bit of a new wrinkle in our plans. We've been able to verify some of the details that Master Hermes suggested to you, about what's... brewing on the surface." },
				{ Cue = "/VO/Melinoe_2223", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Please tell me what you may; and if you think it wise for me to deviate from my objective to address whatever's going on up there." },
				{ Cue = "/VO/Odysseus_0205",
					Text = "The forces of Chronos gather to sail on Olympus through a channel cut across the land. You're poised to disrupt the enemy ranks from within. Aid Olympus, and your chances against Chronos may improve." },
				{ Cue = "/VO/Melinoe_2224", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "The warded pathway leading up should drop me right into the heart of our foe's forward garrison. It seems so reckless..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0206", Text = "Call it a calculated risk." },
					},
				},
			},

			OdysseusAboutTreant01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_MiniBoss01", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_2189", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Inquiry for you, Od. When was the last reported sighting of a Root-Stalker out in the woods?" },
				{ Cue = "/VO/Odysseus_0190",
					Text = "See, that's the sort of inquiry I'd expect from somebody who sighted a Root-Stalker out in the woods very, very recently. So there's still something rotten in Erebus, then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2190", Text = "Unfortunately, yes." },
					},
				},
			},
			OdysseusAboutFogEmitter01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_MiniBoss02", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0188",
					Text = "What was the source of your misfortune, that you're back with such a scowl? Some Wailers, or Caskets, perhaps? Oh... a {#Emph}Shadow-Spiller." },
				{ Cue = "/VO/Melinoe_2187", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, a Shadow-Spiller. I lost my way against one. Can hardly see a thing when they're about! I should be stronger than this..." },
				{ Cue = "/VO/Odysseus_0189",
					Text = "You've strength enough. They merely test your nerve. Foes such as that are to be faced head-on, no hesitation. Set for another go?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2188", Text = "I am." },
					},
				},
			},
			OdysseusAboutWaterUnitMiniboss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "G_MiniBoss01", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0191",
					Text = "Heard reports you were proceeding well through Oceanus, but evidently they were not up-to-date. What brings you back, Goddess?" },
				{ Cue = "/VO/Melinoe_2191", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A Sea-Serpent, if you must know. A particularly substantial one caught me out. You ever face them in your mortal voyages?" },
				{ Cue = "/VO/Odysseus_0192",
					Text = "I did, aye. But not alone! Even with my shipmates, seasoned veterans all, we scarce could track the slippery bastards darting out of the waters. {#Emph}Erm{#Prev}, not reassuring, is this?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2192", Text = "Not entirely." },
					},
				},
			},
			OdysseusAboutVerminMiniboss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "G_MiniBoss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0193",
					Text = "Goddess, latest reports said you encountered the King Vermin! Don't care if you're immortal, I'm relieved you made it back in one piece..." },
				{ Cue = "/VO/Melinoe_2193", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It can't be. I did confront a rodent of extraordinary savagery, but it was so little! I assumed the King Vermin was huge." },
				{ Cue = "/VO/Odysseus_0194",
					Text = "Tall tales. The King Vermin's wrath is inversely proportional to its stature. And its stature, as I understand, is very small indeed..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2194", Text = "{#Emph}Brr..." },
					},
				},
			},

			-- lower-priority variant below
			OdysseusAboutVampire01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "H_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVampire01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0288",
					Text = "Found yourself a Phantom Lair in the Fields, if my Shades down there are still to be believed. Blood-sucking bastards... the {#Emph}Phantoms{#Prev}, not the Shades." },
				{ Cue = "/VO/Melinoe_3347", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't such creatures usually stalk the surface in their search of {#Emph}living {#Prev}prey? They must go rather hungry in the Underworld." },
				{ Cue = "/VO/Odysseus_0289",
					Text = "Better {#Emph}that {#Prev}than burn under the break of day, or so they figure, probably. Well, you know what they're after next you meet again." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3348", Text = "They won't get it." },
					},
				},
			},
			OdysseusAboutVampire01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "H_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVampire01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0288",
					Text = "Found yourself a Phantom Lair in the Fields, if my Shades down there are still to be believed. Blood-sucking bastards... the {#Emph}Phantoms{#Prev}, not the Shades." },
				{ Cue = "/VO/Melinoe_3347", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't such creatures usually stalk the surface in their search of {#Emph}living {#Prev}prey? They must go rather hungry in the Underworld." },
				{ Cue = "/VO/Odysseus_0289",
					Text = "Better {#Emph}that {#Prev}than burn under the break of day, or so they figure, probably. Well, you know what they're after next you meet again." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3348", Text = "They won't get it." },
					},
				},
			},
			OdysseusAboutLamia01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "H_MiniBoss02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVampire01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0286",
					Text = "Can you confirm a sighting of Queen Lamia down in the Mourning Fields, Goddess? I'd caution you to watch for signs of slithering about, except I reckon I may be too late..." },
				{ Cue = "/VO/Melinoe_3346", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I must have drawn her out of her den, yes. That or I barged into it, but either way, her magick proved too much for me last night..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0287", Text = "Too much even for {#Emph}you? {#Prev}Nay." },
					},
				},
			},
			OdysseusAboutRatCatcher01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "I_MiniBoss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0290",
					Text = "They sent the {#Emph}Verminancer {#Prev}after you, Goddess? We know that Satyr by no other title, nor of any others of that size. He's one of the Titan Lord's high priests!" },
				{ Cue = "/VO/Melinoe_3349", UsePlayerSource = true,
					Text = "Then the Titan Lord shall soon have one {#Emph}fewer {#Prev}high priest." },
				{ Cue = "/VO/Odysseus_0291",
					Text = "Even if you take him, our reports say that he cannot {#Emph}truly {#Prev}die. A gift from Chronos, in exchange for performing the ritual that brought him back..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3350", Text = "I can at least test the veracity of our reports." },
					},
				},
			},
			OdysseusAboutGoldElemental01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "I_MiniBoss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3351", UsePlayerSource = true,
					Text = "Not the report I wished to deliver, though I've some idea of what Chronos has been doing with all of his excess gold... I was trounced last night by a gigantic bag of coins." },
				{ Cue = "/VO/Odysseus_0292",
					Text = "A {#Emph}Goldwrath{#Prev}, then! I reckon if you're Chronos, and you've got a limitless supply of shiny metal... might as well use some of them for your profane research. {#Emph}Ah{#Prev}, but you were close..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3352", Text = "That I was..." },
					},
				},
			},

			OdysseusAboutSatyrCrossbow01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "N_MiniBoss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0247",
					Text = "Not sighted Chronos on the surface yet. Why risk it when you've got bloodthirsty Satyrs serving as your eyes and ears? His forces are more organized than first they seemed." },
				{ Cue = "/VO/Melinoe_3320", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I just had an unfortunate run-in with one of those Satyrs. Well-armed, well-trained... and Chronos has entire legions." },
				{ Cue = "/VO/Odysseus_0248",
					Text = "{#Emph}Hrm{#Prev}, this is the war they've sought ever since the gods put Chronos in the ground. The promise of the Titan's return; immortality and untold riches..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3321", Text = "...Lies." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0299", Text = "Most likely, aye." },
					},
				},
			},

			OdysseusAboutCharybdis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Intro" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3316", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I must admit, on some occasion all the tales you told about the sea-monster Charybdis felt almost beyond belief. Now having faced the blasted thing, I feel you sold it short." },
				{ Cue = "/VO/Odysseus_0249",
					Text = "What, faced {#Emph}Charybdis? Hah{#Prev}, Goddess. I'd seen reports about some sort of whirlpool in Poseidon's Rift, and now my fear's confirmed. {#Emph}Eh{#Prev}, at least it didn't swallow you outright." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3317", Text = "Any tips on how to deal with it?" },
					},
					{
						PreLineWait = 0.4,
						{ Cue = "/VO/Odysseus_0250", Text = "Avoid it at all costs?" },
					},
				},
			},

			OdysseusAboutAxe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
					{
						PathTrue = { "CurrentRun", "WeaponsCache", "WeaponAxe" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0044",
					Text = "You're really using that labrys, Goddess? Double-bladed axe thing. I mean you no offense, but isn't it a little much? Not even Ajax could have wielded that." },

				{ Cue = "/VO/Melinoe_0059", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Weren't you the one who taught me to improvise, Odysseus? I'll use whatever means at my disposal. Who is Ajax?" },

				{ Cue = "/VO/Odysseus_0045",
					Emote = "PortraitEmoteSurprise",
					Text = "Who is {#Emph}Ajax? {#Prev}Only the biggest lad I've ever met, {#Emph}who's Ajax{#Prev}. But I forget myself, for {#Emph}he {#Prev}didn't have the strength of Hades flowing through him. Or maybe it's your own. Good hunting." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
					},
				},
			},
			OdysseusAboutBows01 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAny = { "WeaponDagger", "WeaponTorch", "WeaponLob" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Doesn't count.
						{ Cue = "/VO/Melinoe_0481", Text = "Doesn't count." },
					},
				},
				{ Cue = "/VO/Odysseus_0131",
					Text = "If I may be so bold, Goddess? You witches are reliant on your magick when it comes to fighting from afar. You ever think of taking up the bow again? I could give you some pointers..." },

				{ Cue = "/VO/Melinoe_0480", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We don't discuss the bow, Odysseus. I'm still recovering from the last time you gave me some of those pointers about it." },

				{ Cue = "/VO/Odysseus_0132",
					Text = "Ah, well. We all have our strengths and weaknesses. A single weakness in your case, perhaps." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},

			OdysseusAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "G_Intro", },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "G_PostBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutScylla01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0133",
					Text = "The good witch there noted you were able to vanquish her in a full-on contest. Impressive stuff! You get much farther?" },
				{ Cue = "/VO/Melinoe_0482", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I did. Down to the chambers near the bottom of the sea. Strange music echoing all through the place. I wasn't prepared." },
				{ Cue = "/VO/Odysseus_0134",
					Text = "Strange music, huh? Reminds me of when... {#Emph}erm{#Prev}. Oh, I'll spare the tales for another time, you've enough on your mind, I can tell." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- Doesn't count.
						-- { Cue = "/VO/Melinoe_0481", Text = "Doesn't count." },
					},
					AreIdsAlive = { 556921 },
				},
			},

			OdysseusAboutFields01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "H_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "H_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "H_Intro" },
						Comparison = "<=",
						Value = 8,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0245",
					Text = "{#Emph}Ah{#Prev}, you made it to the Mourning Fields, good! Tartarus is not too far behind... directly underneath, in fact, but the ingress is a bit of a walk from your initial drop..." },
				{ Cue = "/VO/Melinoe_3318", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A bit of a walk, fraught with soul-devouring daemons and other life-hating fiends. Too powerful to be imprisoned so they're free to wander there, something like that?" },
				{ Cue = "/VO/Odysseus_0246",
					Text = "We mortals just love the Fields, Goddess! A place to rid oneself of misery — or drown in it. A perfect spot for daemons, only {#Emph}some {#Prev}of which shall leave you be." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3319", Text = "That has been my experience." },
					},
				},
			},

			OdysseusAboutTartarus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Story01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0258",
					Text = "I heard your efforts to bring Cerberus back to his senses were successful... at least temporarily, Goddess. He bounded off to Tartarus, only to be cast out into the Fields again?" },
				{ Cue = "/VO/Melinoe_3328", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's what I gathered, yes. In Tartarus, he seeks his master... my father. Whom I happened upon, bound in chains! Chronos is torturing them... mocking them." },
				{ Cue = "/VO/Odysseus_0259",
					Text = "Chronos is using {#Emph}them {#Prev}to get at {#Emph}you. {#Prev}Instill in you emotions that compel you to throw caution to the wind. Remember, wars are won and lost in hearts and minds." },
				{ Cue = "/VO/Melinoe_3329", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did you not act on your emotions in your mortal days?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0260", Text = "Well, yes... I always did..." },
					},
				},
			},

			OdysseusAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutHermes01" },
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_2225", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why not send Nemesis to the surface in my stead? Even if I undo the wards sealing the path, I don't know that I'll last long up there." },
				{ Cue = "/VO/Odysseus_0207",
					Text = "The matter on Olympus isn't as personal for Nemesis as it is for you; and she hasn't been especially receptive to suggestion recently." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2226", Text = "No, I suppose not." },
					},
				},
			},

			OdysseusAboutSurface02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomCountCache", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0208",
					Text = "The good witch always figured you would make your way up to the mortal realm. Once you were ready and the situation called for it. Well done." },
				{ Cue = "/VO/Melinoe_2227", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "She warded the pathway there, until such time as I had the means to pass through. But the climate on the surface is another matter..." },
				{ Cue = "/VO/Odysseus_0209",
					Text = "Your Underworld birthright stuff getting in the way? A curse not just a blessing, it would seem. Well, if your witchery got you this far, surely it can aid with this... predicament." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2228", Text = "That's the plan." },
					},
				},
			},

			OdysseusAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
					},
					{
						Path = { "CurrentRun", "BiomeDepthCache" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0239",
					Text = "How was it sailing through the Rift of Thessaly, Goddess? Sometimes I long for my past days and nights at sea. Probably since I've forgotten just how miserable it was..." },
				{ Cue = "/VO/Melinoe_3307", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I feel I could remind you at this point. Chronos has this vast fleet of ships drawn from the very depths, drowned crews and all. I had to commandeer whichever craft I could." },
				{ Cue = "/VO/Odysseus_0240",

					Text = "A proper nautical experience, then! Fraught with {#Emph}danger, mystery...! Ah{#Prev}, I feel a little envious of those drowned crews! After I died, I thought my sailing days were done." },
				{ Cue = "/VO/Melinoe_3308", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, Chronos could probably use more sailors after what I did to them." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0241", PreLineAnim = "Odysseus_Greet", Text = "Put in a good word for me would you?" },
					},
				},
			},

			OdysseusAboutPolyphemus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0210",
					Text = "How was the surface, still warm and welcoming I reckon? You're to be commended for even setting foot up there." },
				{ Cue = "/VO/Melinoe_0060", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "It was dreadful. The city of Ephyra is completely overrun. And, there's a blind Cyclops making sure no one gets out." },
				{ Cue = "/VO/Odysseus_0031",
					Text = "Well, that all sounds entirely unfortunate. Blind Cyclops, {#Emph}eh? {#Prev}That must be Polyphemus. Gave him that scrape myself, way back. He still going on about eating people?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0061", Text = "He is." },
					},
					{
						PreLineWait = 0.3,
						{ Cue = "/VO/Odysseus_0032", Text = "{#Emph}Augh..." },
					},
				},
			},
			OdysseusAboutPolyphemus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutNobody03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3337", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Your old adversary Polyphemus wanted me to give you a message on his behalf. Though, come to think, I'm uncertain what he wanted me to say. Perhaps just... kick you savagely?" },
				{ Cue = "/VO/Odysseus_0274",
					Text = "{#Emph}Eh{#Prev}, sounds like the Cyclops that I used to know all right. My crew and I, we were his captives for a while... and his food supply. I found a way to get us out of there, but it was ugly..." },
				{ Cue = "/VO/Melinoe_3338", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "He calls you Nobody. How did he come to know you by that name?" },
				{ Cue = "/VO/Odysseus_0275",
					Text = "{#Emph}Nobody {#Prev}took his {#Emph}eye{#Prev}, Goddess... I gave to him a name that wouldn't make a lick of sense when he called over to his mates for help. We had to try." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3339", Text = "He has {#Emph}mates?" },
					},
					{
						PreLineWait = 0.37,
						{ Cue = "/VO/Odysseus_0276", Text = "Perhaps not anymore." },
					},
				},
			},
			OdysseusAboutPolyphemus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutNobody03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0277",
					Text = "How is old Polyphemus, anyhow? Slowed down a bit since he was young, perhaps...? I scarce was any match for him, but I was merely mortal, whilst you're... {#Emph}you." },
				{ Cue = "/VO/Melinoe_3340", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "He's territorial, though seems much more concerned with sleep and appetite than any other cause. So, you really blinded him, then...?" },
				{ Cue = "/VO/Odysseus_0278",
					PreLineWait = 0.35,
					Text = "I did... and only wish he had {#Emph}another {#Prev}eye so that I could have done it {#Emph}twice{#Prev}. For evidently {#Emph}he {#Prev}is not remorseful in the least for what he did, and... as you {#Emph}plainly {#Prev}see, neither am I." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3341", Text = "...I'll get him for you." },
					},
					{
						PreLineWait = 0.4,
						{ Cue = "/VO/Odysseus_0279", Text = "Good." },
					},
				},
			},

			OdysseusAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "SpawnRecord", "NPC_Heracles_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_2220", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I encountered mighty Heracles on the surface. No mistaking him! Though I thought he was dead. He seemed very much alive, on the outside, anyway. And still in service to the gods..." },
				{ Cue = "/VO/Odysseus_0211",
					Text = "The great {#Emph}Heracles... {#Prev}that's a complicated one. Part {#Emph}man{#Prev}, part {#Emph}god... {#Prev}part monster too, perhaps. The rules of death don't quite apply to him. What did he want? He give you any trouble?" },
				{ Cue = "/VO/Melinoe_2221", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "He was quite brusque. Told me to stay out of his way. Sounds like he has a task of his own. Maybe Olympus isn't counting on me to succeed..." },
				{ Cue = "/VO/Odysseus_0212",
					Text = "{#Emph}Eh, {#Prev}don't take it personally. You have wise relatives, and ruthless ones. They may not like their odds hinging on any one individual. And... do watch yourself with Heracles, aye?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2222", Text = "Aye..." },
					},
				},
			},

			OdysseusAboutTravel01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0147",
					Text = "Goddess, I was just thinking of your travels, taking you beneath the surface and above, I reckon to the ends of the earth! No mere {#Emph}journey... {#Prev}got to be a better word for it..." },
				{ Cue = "/VO/Melinoe_2195", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "What, is {#Emph}task {#Prev}not sufficiently extravagant? Perhaps {#Emph}assignment? {#Prev}Or {#Emph}voyage? Quest {#Prev}doesn't feel right at all..." },
				{ Cue = "/VO/Odysseus_0148",
					Text = "No, too upbeat, and {#Emph}voyage {#Prev}is more of a nautical term.... {#Emph}Erm{#Prev}, we'll think of something." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2196", Text = "{#Emph}...trek... sojourn..." },
					},
				},
			},

			OdysseusAboutPressure01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateHideAndSeek01", "OdysseusGift01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Melinoe_2174", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "How did you manage it, Odysseus? Back when you had the outcome of a full-scale war riding on you, then a treacherous sea-journey, all with only one life to live... or so then you thought?" },
				{ Cue = "/VO/Odysseus_0137",
					Text = "For certain the one-life-to-live bit instilled in me the will to survive. Most mortals cling to life, but I was better than most at rejecting my doubts. And when my plans all fell apart, I improvised...!" },
				{ Cue = "/VO/Melinoe_2175", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "{#Emph}Your {#Prev}plans fell apart? How did you avoid becoming distraught? Keep all your doubts at bay in the face of failure?" },
				{ Cue = "/VO/Odysseus_0138",
					Text = "It's that I always relished finding a way out. No matter what I'd gotten myself into. Treating my predicaments as mazes to be navigated, puzzles to be solved..." },
				{ Cue = "/VO/Melinoe_2176", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "But at times there are impasses; outcomes that simply cannot be achieved..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0139", Text = "Nay, Goddess. Not if you ask me." },
					},
				},
			},

			OdysseusAboutPressure02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutPressure01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Odysseus_0140",
					Text = "You asked before about how I managed it... the pressure to always prevail through what, in retrospect, were... many {#Emph}terribly exciting {#Prev}scenarios, all whilst bearing the burden of so many others' expectations and my own." },
				{ Cue = "/VO/Melinoe_2177", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You said you always believed there was a solution, a positive outcome that could be discovered and achieved... I've been thinking about that." },
				{ Cue = "/VO/Odysseus_0141",
					Text = "Good. But, it occurred to me there's something else. 'Twas love that drove me on. The great war that earned me my place in Elysium... I wanted {#Emph}desperately {#Prev}not to go. To stay with my wife and then-newborn son." },
				{ Cue = "/VO/Melinoe_2178", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You were left with no choice but to fight. So you held to hope that someday you'd see your family again..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0142", Text = "Sound familiar, does it?" },
					},
				},
			},

			OdysseusBackstory01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01", },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Melinoe_0452", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Wanted to say, I appreciate your counsel, Odysseus. You've been like a brother to me. Or an uncle? One of those. You'd know better than I." },
				{ Cue = "/VO/Odysseus_0037",
					Text = "Look, you don't have to tell me what it's like not having a family about. I spent a good-sized portion of my mortal days away from home. Had a war to fight, got a little sidetracked after." },
				{ Cue = "/VO/Melinoe_0453", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Sidetracked? Headmistress says that you spent many years at sea. Some of them in the company of goddesses, at that." },
				{ Cue = "/VO/Odysseus_0038",
					Text = "Yes, well. By the time I finally returned, I hardly recognized my son, and my wife... we lived out our mortal days together, and that was enough. I reckon they're comfortable somewhere below." },
				{ Cue = "/VO/Melinoe_0454", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You haven't seen them? What happened?" },
				{ Cue = "/VO/Odysseus_0039",
					Text = "Penelope and I drifted apart. Happens with mortals, sometimes. And it happens with Shades too. As for my son Telemachus, he's his own man. Such is life. Or death, as it turns out." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_0455", Text = "Yes..." },
					},
				},
			},

			OdysseusAboutRain01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "NextBiomeStateName" },
						IsAny = { "Rain" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0155",
					Text = "{#Emph}Ah{#Prev}, I miss the feeling of the rain, sometimes. Then I remember years at sea, soaked to the bone, and thank the gods the blasted stuff can't get to me as once it did." },
				{ Cue = "/VO/Melinoe_2179", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The rain brings life, as well as death... especially the latter on this night. The Lost Souls out there seem to hate it near as much as you." },
				{ Cue = "/VO/Odysseus_0156",
					Text = "Aye, almost seems to soften them up, doesn't it? Leave them ripe for the harvest. Go pick some off for me, will you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2180", Text = "I think I will." },
					},
				},
			},

			OdysseusAboutMailbox01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "MailboxScreen" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0145",
					Text = "See Charon's latest haul, Goddess? Shipment by the riverside, all yours. And we're watching the rivers, making certain this won't be the last." },
				{ Cue = "/VO/Melinoe_2335", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Charon risks aiding my efforts in such a direct way. Are we able to compensate him at all?" },
				{ Cue = "/VO/Odysseus_0146",
					Text = "Aye, with what Gold we've gathered recently. He really means to melt down every last one of those Chronos coins we can get our hands on." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2336", Text = "Oh yes." },
					},
				},
			},

			OdysseusAboutGarden01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGarden" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "LifetimeResourcesGained", "PlantGCattail" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0265",
					Text = "Your little garden there has cheered this old place up a bit, Goddess! In trying times, such simple pleasures oft are first to fade. Precisely when they're needed most." },
				{ Cue = "/VO/Melinoe_3309", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you, and pleased to hear it, Great Tactician. Though, I'd not expected a mere flower patch to leave such an impression on someone like you." },
				{ Cue = "/VO/Odysseus_0266",
					Text = "Come now, all I {#Emph}do {#Prev}is pay attention to details. Victory comes to those whose hearts are predisposed. I mean, look at us, our spirits are quite literally all we have; and now, flowers!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3310", Text = "Help keep an eye on them for me, would you?" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0267", Text = "Of course." },
					},
				},
			},

			OdysseusBackstory02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				TeleportToId = 589482,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "OdysseusAboutMood01" }, Count = 2 },
					-- @ update with more requirements later
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0178",
					Text = "Come join us, Goddess! I was just regaling the Shades about when first I traveled to the Underworld. Whilst I yet lived and breathed, if you can believe it! And thusly I got out." },
				{ Cue = "/VO/Melinoe_2197", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Come on, Odysseus, there was no escape from here when my father ruled. Are these Shades truly so impressionable?" },
				{ Cue = "/VO/Odysseus_0179",
					Text = "Oh I'm {#Emph}dead {#Prev}serious! My tales aren't... quite as tall as they may seem. But now, the gates of hell are flung wide open, aren't they...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2198", Text = "We're going to seal them shut." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0222", Text = "Aye that." },
					},
				},
			},

			OdysseusAboutMood01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				TeleportToId = 589482,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 6,
					},
					MinRunsSinceAnyTextLines = { TextLines = { "OdysseusBackstory02" }, Count = 2 },
					-- @ update with more requirements later
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0180",
					Emote = "PortraitEmoteSurprise",
					Text = "Oh! Hail, Goddess, I, {#Emph}erm... {#Prev}didn't notice your approach. Half-inclined to blame the onset of the years, but I've no such excuses in this state." },
				{ Cue = "/VO/Melinoe_2199", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I didn't mean to startle you, Od. How's the mood been around here, everything all right?" },
				{ Cue = "/VO/Odysseus_0181",
					Text = "Mood and everything is well enough. Our ranks swell with Shades moved by the tale that the Princess of the Underworld has returned, with vengeance on her mind." },
				{ Cue = "/VO/Melinoe_2200", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nothing like a bit of sworn vengeance to inspire the masses. Though, what about you?" },
				{ Cue = "/VO/Odysseus_0182",
					Text = "Everything's shipshape with me; especially after a brief reprieve right here. Be well, Goddess." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2201", Text = "You, too." },
					},
				},
			},

			OdysseusHideAndSeek01 =
			{
				PlayOnce = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Flashback_Hub_Main" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusHideAndSeek,
				PreEventFunctionName = "GenericPresentation",
				PreEventFunctionArgs =
				{
					KillTaggedThread = "HecateHideAndSeekHint",
				},

				{ Cue = "/VO/Melinoe_2118", UsePlayerSource = true,
					PreLineAnim = "Melinoe_Young_Brooding_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Brooding_End", PostLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Text = "Odysseus, have you seen Hecate about?" },
				{ Cue = "/VO/Odysseus_0200",
					PreLineAnim = "Odysseus_Greet",
					PostLineThreadedFunctionName = "HecateHideAndSeekHint",
					Text = "{#Emph}Mm{#Prev}, not in a little while, little goddess. Though, I'd expect that pointy hat of hers to give her away!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2119", Text = "I'll look for it! Thank you!" },
					},
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0201", Text = "She's got to be around here somewhere, little goddess!" },
					},

				},
			},

			-- Partner Conversations
			OdysseusWithHecate01 =
			{
				Partner = "NPC_Hecate_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 12,
					},
				},

				PlayOnce = true,
				UseText = "UseListenNPC",
				StatusAnimation = false,
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 566620,
				-- TeleportOffsetX = 200,
				-- TeleportOffsetY = -300,
				InteractDistance = 450,
				{ Cue = "/VO/Hecate_0201", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "The Tactician brings ill tidings with an optimistic bent. Fine. And what news from the men of the isles, if any yet survive?" },
				{ Cue = "/VO/Odysseus_0042",
					PreLineAnim = "Odysseus_Greet",
					Text = "According to my confidants, they've all sworn in with Chronos, I'm afraid. Mortals... they often want whatever they don't have. Another Golden Age, in this case. The {#Emph}promise {#Prev}of one." },
				{ Cue = "/VO/Hecate_0202", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "'Tis a {#Emph}lie {#Prev}that spurs their betrayal, rather than a promise. They shall perish, then... by the wrath of the gods." },
				{ Cue = "/VO/Odysseus_0043",
					Text = "And then their wretched souls shall hound us with renewed vengefulness. I've witnessed endless wars before, Madam. So have you gods. How can we stop this?" },
				{ Cue = "/VO/Hecate_0203", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "{#Emph}We {#Prev}cannot. {#Emph}Melinoë{#Prev}, however? Certainly {#Emph}you {#Prev}can, correct?" },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0459", Text = "I can and shall." },
				},
			},
			OdysseusWithHecate02 =
			{
				Partner = "NPC_Hecate_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusWithHecate01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift01", "OdysseusGift01" }
					},
					MinRunsSinceAnyTextLines = { TextLines = { "OdysseusWithHecate01" }, Count = 4 },
				},

				PlayOnce = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 566620,
				-- TeleportOffsetX = 200,
				-- TeleportOffsetY = -300,
				InteractDistance = 450,
				{ Cue = "/VO/Odysseus_0149",
					PreLineAnim = "Odysseus_Greet",
					PreLineWait = 0.35,
					Text = "...And, {#Emph}erm{#Prev}, that's the end of my report this time, Madam. Should you have any questions, please don't hesitate to summon me at any time." },
				{ Cue = "/VO/Hecate_0204", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "I shan't, Odysseus. Although, there is one further matter that I wanted to discuss with you, and rather quietly..." },
				EndVoiceLines =
				{
					PreLineWait = 0.44,
					UsePlayerSource = true,
					ObjectType = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_Salute",
					{ Cue = "/VO/Odysseus_0150", Text = "Certainly, Madam." },
				},
			},

			OdysseusWithNemesis01 =
			{
				Partner = "NPC_Nemesis_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 12,
					},
				},

				PlayOnce = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				TeleportToId = 566621,
				TeleportOffsetX = 0,
				TeleportOffsetY = 0,
				-- AngleTowardTargetId = 557113,
				InteractDistance = 450,

				{ Cue = "/VO/Odysseus_0164",
					Text = "...I'm saying that the possibility exists, yes. Eternal vigilance is near impossible. Enemies have always exploited the lack thereof. I ever tell you of the old wooden horse trick?" },
				{ Cue = "/VO/Nemesis_0135", Portrait = "Portrait_Nemesis_Default_01", Speaker = "NPC_Nemesis_01",
					Text = "The old wooden horse trick, yeah. Surely your reputation as the Great Tactician hinges on more than this one tale?" },
				{ Cue = "/VO/Odysseus_0165",
					Text = "{#Emph}Ah{#Prev}, but classics ought to be retold! Though, if you'd rather, I have far more tales of trickery and valor. Take the Cave of the Cyclops!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0136", Text = "Not Cave of the Cyclops..." },
					},
				},					
			},
			MorosWithOdysseus01 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				AngleTowardTargetId = 585621,
				PostBlockSpecialInteract = true,
			},
			MorosWithOdysseus02 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				AngleTowardTargetId = 585621,
				PostBlockSpecialInteract = true,
			},
			MorosWithOdysseus03 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				AngleTowardTargetId = 585621,
				PostBlockSpecialInteract = true,
			},

			-- Repeatable
			OdysseusChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0004",
					Text = "You watch your back out there, all right?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0005",
					Text = "Ready to take another stab at this, Goddess?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat03 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0006",
					Text = "If I were Chronos, I'd be properly afraid of you." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat04 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0007",
					Text = "Got everything here well under control." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat05 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0008",
					Text = "Courage, Goddess. And no quarter to your enemies, all right?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat06 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0009",
					Text = "Moonlight guide you, as you witches say." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat07 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0010",
					Text = "Quite a mess we've gotten ourselves into, haven't we?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat08 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0011",
					Text = "I know things must seem dire, but take heart. We'll navigate through this." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat09 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0012",
					Text = "Any luck finding the head of Chronos yet?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat10 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0013",
					Text = "Be sure to hit them where it hurts for me, will you?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat11 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0014",
					Text = "All's well enough here. We'll see you when you're back." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat12 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0015",
					Text = "Death to Chronos and all that, aye?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0016",
					Text = "Beg pardon, Goddess, I must get this correspondence to the surface right away." },
			},
			OdysseusChat14 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0017",
					Text = "Fresh shipment of supplies came in while you were out." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat15 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0018",
					Text = "Don't mind me, Goddess, I'm just busy drafting up some of our latest schemes." },
			},
			OdysseusChat16 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0019",
					Text = "We've many sympathizers on the surface and below still loyal to your father." },
			},
			OdysseusChat17 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0020",
					Text = "Go forth and slaughter me some wretched traitors, will you, Goddess?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat18 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0021",
					Text = "Once more you grace me with your presence here, Goddess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat19 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0022",
					Text = "Would that we could just talk like this a while, but alas." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat20 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0023",
					Text = "The Nightmare Goddess stands before me in all her glory..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat21 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0024",
					Text = "You need anything at all, you know where to find me, Goddess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat22 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0025",
					Text = "You come back safely, else I'll have to venture out there and haul you in myself." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat23 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0026",
					Text = "You'll have your vengeance, Goddess. I am sure of it." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat24 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0027",
					Text = "We'll dig ourselves out of this one yet, you rest assured, Goddess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat25 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0320",
					Text = "May your witchery and silver always serve you well." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat26 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0321",
					Text = "No telling what the Fates may have in store for us, aye?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat27 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0322",
					Text = "Always a pleasure to be in your company, Goddess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat28 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0323",
					Text = "Through hard times such as these, our bonds grow strong." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat29 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift06", "OdysseusGift06" }
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0324",
					Text = "The good witch is very proud of you, you know that, aye?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat30 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift06" }
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0325",
					Text = "Our Shades shall keep us well apprised of your progress." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat31 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift04" }
					},
					-- @ update with more requirements later
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0326",
					Text = "There's not much worse than being separated from one's family, aye...?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat32 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift04" }
					},
					-- @ update with more requirements later
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0327",
					Text = "We'll back you on this every step of the way, as many nights as it requires, Goddess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},

		},

		GiftTextLineSets =
		{
			OdysseusGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Odysseus_01" },
					},
				},
				{ Cue = "/VO/Melinoe_0471", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey Odysseus, got you something here I wanted you to have. For always keeping an eye out!" },
				{ Cue = "/VO/Odysseus_0087",
					Text = "Goddess, your presence alone is all I could ask. Though, if you're in a giving mood, then perhaps you'll accept a small gift from me, in turn?" },
			},
			OdysseusGift02 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01" },
					},
				},
				{ Cue = "/VO/Odysseus_0088",
					Text = "I'm most grateful, Goddess, and expect to knock this back at the taverna at the soonest opportunity." },
				{ Cue = "/VO/Melinoe_0473", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No rush, just as long as you enjoy it when that opportunity presents itself!" },
			},
			OdysseusGift03 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift02" },
					},
				},
				{ Cue = "/VO/Odysseus_0089",
					Text = "Well, would you look at that! How could I possibly say no? It seems you've found my weakness here, Goddess." },
				{ Cue = "/VO/Melinoe_0474", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Great Tactician has no weaknesses, I'm sure! Though he does now have an extra bottle of Nectar." },
			},
			OdysseusGift04 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift03" },
					},
				},
				{ Cue = "/VO/Odysseus_0090",
					Text = "I ought to be the one honoring {#Emph}you{#Prev}, Goddess. My inclination is to save this for the moment of our victory, but it's good to have in reserve, in case of some emergency, you understand." },
				{ Cue = "/VO/Melinoe_0475", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I understand indeed. And you already honor me with your friendship, Odysseus. As well as with your knowledge about how to deal swift death!" },
			},
			OdysseusGift05 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift04" },
					},
				},
				{ Cue = "/VO/Odysseus_0091",
					Text = "Oh I see what you're up to, here, Goddess. If you continue to exploit my weakness to this stuff, I may yet learn to turn it to a strength. Good plan!" },
				{ Cue = "/VO/Melinoe_0476", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What can I say? I learned from the best. May you grow stronger and stronger." },
			},
			OdysseusGift06 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift05" },
					},
				},
				{ Cue = "/VO/Odysseus_0092",
					Text = "You know, I journeyed far and wide throughout my mortal days. Met great mortals and even greater gods. But never could I have imagined ending up here, only to receive such a handsome gift from one such as you." },
				{ Cue = "/VO/Melinoe_0477", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They say life takes strange turns, and so apparently does death, Odysseus. Whatever the Fates may have in store, I hope you'll always be nearby to lend your counsel." },
			},

			-- taverna
			OdysseusTaverna01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift05" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				{ Cue = "/VO/Melinoe_3342", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If you're not too caught up in your reports right now, what do you say we put this bottle of Ambrosia to its proper use?" },

				{ Cue = "/VO/Odysseus_0280",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					Text = "I {#Emph}am {#Prev}caught up in my reports, Goddess! Focused on what matters most... meet you at the taverna." },

				{ Cue = "/VO/Odysseus_0281",
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					Text = "...We mortals had what we called {#Emph}wine{#Prev}, an acrid sort of drink made of crushed {#Emph}grapes{#Prev}. We'd sometimes say it tasted as good as Ambrosia, but... it most certainly did not." },

				{ Cue = "/VO/Melinoe_3343", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You speak of so many hardships from your mortal days and nights and yet, there's always this sense of longing there... you miss those times, don't you?" },

				{ Cue = "/VO/Odysseus_0282",
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_Greet",
					Text = "...Such moments and occasions do occur. I know a lot more {#Emph}now {#Prev}than I did then, and... sometimes I miss that feeling... knowing less. Or the camaraderie of sailing with my crew." },

				{ Cue = "/VO/Melinoe_3344", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But many of your crew are with you here now, right? Even the Shade of your old dog. How can you miss them if they're still around?" },

				{ Cue = "/VO/Odysseus_0283",
					Text = "We're Shades, Goddess, and... not all quite as whole as I. Besides, you still can miss your past with those you still know now! Remember when you used to play at hiding with our good witch, back when you were very small?" },

				{ Cue = "/VO/Melinoe_3345", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I never thought that we were playing; she was teaching me to hunt for unseen prey. But, I {#Emph}do {#Prev}see your point." },

				{ Cue = "/VO/Odysseus_0284",

					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "Well my original point was merely that this Ambrosia's {#Emph}really {#Prev}something else! Let us ensure it does not go to waste." },

				{ Cue = "/VO/Odysseus_0285",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					Text = "I'd not realized how much I needed that. It's true what they say, that Ambrosia tastes much better in good company." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0769", Text = "Of course." },
					},
				},

			},

			OdysseusFishing01 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift02" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_0470", UsePlayerSource = true,
					Text = "Got these Twin Lures, Od, and I can't exactly use them on my own. You know the rules!" },
				{ Cue = "/VO/Odysseus_0066",
					PreLineAnim = "Odysseus_Greet",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					Emote = "PortraitEmoteFiredUp",
					PostLineRemoveContextArt = true,
					Text = "Fishing! {#Emph}Ah{#Prev}, my greatest weakness, Goddess! The waters and I have never mixed too well. But then, who am I to say no to you? Besides, I'm overdue for a short leave I think. Let's go!" },
				{ Cue = "/VO/Odysseus_0251",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					Text = "Used to be I fished out of necessity alone. The earth would oft be stingy with her bounties, whilst the sea would yield plenty to us mortals, if we knew where to look." },
				{ Cue = "/VO/Melinoe_3322", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineAnim = "MelTalkBrooding01", PostLineAnimTarget = "Hero",
					Text = "What's been the biggest difference for you since those times? Not having to eat for sustenance? Not having to watch your mortal body slowly fall apart as you grew older?" },
				{ Cue = "/VO/Odysseus_0252",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Greet",
					Text = "{#Emph}Heh{#Prev}, well! You already know a couple of the points if for some reason we were tasked to make a list, but... the biggest difference, if I had to choose, is that... I finally am free." },
				{ Cue = "/VO/Melinoe_3323", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "You're free? But as a mortal, weren't you a king? A mighty warrior, leader of men... and a husband, and a father! Here you have a place of honor, too, except... we dwell in shadows. Our deeds are never to be told." },
				{ Cue = "/VO/Odysseus_0253",
					SkipContextArt = true,
					Text = "Well, we shall see about that last bit, but for the rest! Perhaps I got all of the wanderlust out of my system whilst I lived and breathed. Most of it, anyhow!",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },
				{ Cue = "/VO/Odysseus_0084",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash" },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "I thoroughly enjoyed our outing, though I still thoroughly hate fish." },
			},

			OdysseusBathHouse01 =
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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_0462", UsePlayerSource = true,
					Text = "I was just thinking nothing clears the mind like a refreshing, burning-hot soak. Care to accompany me?" },
				{ Cue = "/VO/Odysseus_0047",
					PreLineAnim = "Odysseus_Greet",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Look, I do love a good hot bath, even whilst dead, and I am not one to say no to goddesses, so, {#Emph}erm{#Prev}... why not!" }, 
				{ Cue = "/VO/Odysseus_0049",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "My eyes are properly averted, Goddess. That I swear."
				},
				{ Cue = "/VO/Melinoe_0464", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Would mortals often {#Emph}bathe{#Prev}, Odysseus?" },
				{ Cue = "/VO/Odysseus_0057", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "Oh! {#Emph}Erm{#Prev}, well... most of them would bathe, from time to time, though... seldomly together, like this. Men with women... it could be... untoward." },
				{ Cue = "/VO/Melinoe_0465", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I see. We gods have no such shame, I realize. Have I made you uncomfortable?" },
				{ Cue = "/VO/Odysseus_0058", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Me? No{#Prev}, no no, Goddess, of course not, {#Emph}no! {#Prev}In fact I've bathed with goddesses before, it's just... it's been a little while." },
				{ Cue = "/VO/Melinoe_0466", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Well... as long as it's agreeable for you." },
				{ Cue = "/VO/Odysseus_0059", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },
					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "It is! Agreeable, it is." },

				{ Cue = "/VO/Odysseus_0063",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "Well! Don't know about you, but I am properly relaxed, I'd say!" },
			},

			OdysseusBathHouse02 =
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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift04" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_0463", UsePlayerSource = true,
					Text = "Hey I was thinking I'm due for a good boil in the springs. Join me for a bit?" },
				{ Cue = "/VO/Odysseus_0048",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "A visit to the baths, with you, right now? {#Emph}Hah! {#Prev}Sure! I'm honored to accompany you, Goddess." }, 
				{ Cue = "/VO/Odysseus_0051",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "I trust the temperature is to your liking, aye?"
				},
				{ Cue = "/VO/Melinoe_0467", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "You've met many goddesses even in your mortal days, haven't you, Od?" },
				{ Cue = "/VO/Odysseus_0060", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "In this I'm very fortunate, indeed. The lady Athena often watched over me. I'd never have survived the war if not for her. Then, on my travels home, there was Calypso... and Circe... a witch, not unlike you." },
				{ Cue = "/VO/Melinoe_3217", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Circe used to study under Headmistress, always with her crystals. And Calypso... she's a nymph, correct? A lesser goddess I suppose." },
				{ Cue = "/VO/Odysseus_0061", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Emote = "PortraitEmoteSurprise",
					Text = "Nothing lesser about her, with respect. These goddesses, the hospitality they showed me, why... it almost made me forget myself... forget my family." },
				{ Cue = "/VO/Melinoe_0469", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "But you did not forget. You made your journey home. Even I know the tale." },
				{ Cue = "/VO/Odysseus_0062", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },
					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "It's a tale, Goddess. Anyway, life takes its complicated turns. Take it from me." },

				{ Cue = "/VO/Odysseus_0064",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "That was a splendid and much-needed time. Truly appreciate the invitation." },
			},

			-- placeholder
			OdysseusGiftTemp =
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

			OdysseusBathHouseDecline01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Odysseus_01" },
					},
					{
						PathFalse = { "CurrentRun", "GiftResourceRecord", "GiftPointsEpic" },
					},
					RequiredFalseQueuedTextLines = GameData.OdysseusTavernaEvents,
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Maybe some other time.
						{ Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},				
				{ Cue = "/VO/Melinoe_0460", UsePlayerSource = true,
					Text = "Odysseus, how about alleviating the rigors of all this tactical planning with a visit to the springs?" },
				{ Cue = "/VO/Odysseus_0046",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "{#Emph}Erm, {#Prev}I really do appreciate the offer, Goddess, just... I think your Headmistress would rather I stay here. You understand, don't you?" },
			},

		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
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
					AreIdsNotAlive = { 557112 },
				},

				{ Cue = "/VO/Melinoe_1156", Text = "Odysseus on leave..." },
				{ Cue = "/VO/Melinoe_2412", Text = "Odysseus out checking on reports...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2413", Text = "Od must be needed elsewhere...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01", },
						},
					}
				},
				{ Cue = "/VO/Melinoe_1157", Text = "Od's on assignment huh?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01", },
						},
					}
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Odysseus_01",
			CooldownTime = 7,

			-- Pathetic.
			-- { Cue = "/VO/Hades_0050", Text = "Pathetic." },
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_2899", Text = "Your trusty Knuckle Bones? Thank you!" },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Odysseus )