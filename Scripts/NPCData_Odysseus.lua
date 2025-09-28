UnitSetData.NPC_Odysseus =
{
	-- Odysseus, Id = 557112
	NPC_Odysseus_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Odysseus_Default_01",
		AnimOffsetZ = 20,
		Groups = { "NPCs" },
		SubtitleColor = Color.OdysseusVoice,
		EmoteOffsetY = -280,
		EmoteOffsetX = 80,
		SpeakerName = "Odysseus",
		LoadPackages = { "Odysseus" },
		TurnInPlaceAnimation = "Odysseus_Turn",
		-- TavernaTeleportId = 589482,
		TavernaOverrides =
		{
			AnimOffsetX = -40,
			EmoteOffsetY = -180,
			EmoteOffsetX = 40,
		},
		
		ActivateRequirements =
		{
			NamedRequirementsFalse = { "OdysseusWandering" },
		},

		RotatorRequirements =
		{
			NamedRequirementsFalse = { "OdysseusWandering" },
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
					{ Name = "MelinoeSaluteSpeech", Time = 3 },
				},

				{ Cue = "/VO/Melinoe_1707", Text = "Death to Chronos, sir.",
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
					}
				},
			},

			{ GlobalVoiceLines = "SaluteVoiceLines" },
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
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
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
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
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
				{ Cue = "/VO/Odysseus_0317", Text = "Shadows conceal you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2" },
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
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2", "/VO/Melinoe_1707" },
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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = GameData.OdysseusTavernaEvents, },
					},
				},
				Args =
				{
					Loop = true,
					Timeout = 13.0,
					Path =
					{
						{
							Branch =
							{
								-- Table
								{
									GameStateRequirements =
									{
										{
											--PathTrue = { "GameState", "GardenPlots", 558337 },
										},
									},
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
								},
								-- Shade
								{
									GameStateRequirements =
									{
										{
											--PathTrue = { "GameState", "GardenPlots", 558337 },
										},
									},
									{
										Id = 589590,
										OffsetRadius = 50,
										MinDistanceForMove = 120,
										ArriveFunctionName = "OdysseusArriveAtShade",
									},
								},
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
					PreLineAnim = "Odysseus_KnifeToss",
					-- PreLineAnim = "Odysseus_Pensive_Start",
					-- PostLineAnim = "Odysseus_Pensive_End",
					-- PreLineAnim = "Odysseus_Explaining",
					-- PreLineAnim = "Odysseus_Greet",
					-- PreLineAnim = "Odysseus_Salute",
					Text = "Tell me you killed the bastard? Drove your staff into his wretched skull, slid a dagger in his gut? {#Emph}Eh{#Prev}, not that he'd die from that; works on mortals, though!" },
				{ Cue = "/VO/Melinoe_0016_C", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 5.0 },
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Chronos the Titan of Time is vanquished, Odysseus. I have his head right here! At least... I wish I did." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0033",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Our good witch there knows you've a mountain of a journey ahead of you, Goddess. You hear about our mountains on the surface? Big tall rocks?" },
				{ Cue = "/VO/Melinoe_0448", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What, you mean like Mount Olympus, or Mount Othrys? Of course I've heard of them! They reach up to the sky. I can only imagine." },
				{ Cue = "/VO/Odysseus_0034",
					PreLineAnim = "Odysseus_KnifeToss",
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
						Path = { "CurrentRun", "BiomesReached" },
						HasNone = { "H", "N" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0028",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Those thorny chaps you've been dealing with... their numbers grow in each report I get. If you've thoughts on how we could have better prepared you..." },
				{ Cue = "/VO/Melinoe_0056", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'll share my thoughts when necessary, Odysseus. For the moment, I'm sorting through them still." },
				{ Cue = "/VO/Odysseus_0029",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Aye, best not to speak without prepared remarks. I understand the feeling only too well. You'll keep me posted, though?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
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
					PreLineAnim = "Odysseus_Explaining",
					Text = "You run into anything bad whilst you're out there, you come talk to me about it. Chances are I've seen it, fought it, otherwise gotten past it, and can offer some advice." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0450", Text = "Definitely." },
					},
				},
			},
			OdysseusMeeting05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0036",
					Text = "You be wary of the sorts you meet out there, all right? You find a live one gives you any trouble, you know where to hit him where it hurts." },
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift03" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_0456", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've known Headmistress quite a while, haven't you? Where did you meet, I always wanted to ask?" },
				{ Cue = "/VO/Odysseus_0040",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Thoughtful_01", WaitTime = 4.9 },
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "{#Emph}Heh{#Prev}, well. All I can say is that I was... alone. At the end of one life, and the start of another. Lost. She appeared before me then, in all her splendor, and... she revealed to me a path I hadn't seen." },
				{ Cue = "/VO/Melinoe_0457", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That all sounds very figurative. Were you already dead?" },
				{ Cue = "/VO/Odysseus_0041",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "I was. She told me she could grant me a new life. She needed a tactician knowledgeable of the surface. I thought, who am I to turn a goddess down? I followed her. It's been a while now." },
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "F_Boss01", "F_Boss02" },
					},
					{
						PathFalse = { "CurrentRun", "EnemyKills", "Hecate" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "G_Intro" },
					},
					--[[
					{
						Path = { "GameState", "RoomsEntered", "F_PostBoss01" },
						Comparison = "<=",
						Value = 3,
					},
					]]--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Odysseus_0143",
					Text = "The good witch put you to the test out there, did she? Quite an intensive teaching style, I always thought. She expects a lot from you, but that's just what happens when you've such potential." },
				{ Cue = "/VO/Melinoe_2185", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then she must be disappointed with my results, although she's careful not to show it. Same as you, Odysseus." },
				{ Cue = "/VO/Odysseus_0144",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Come, I know how dispiriting it is to chart one's course, only to lose one's way. We rarely get where we must go the fastest way we can." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Melinoe_2186", Text = "As long as we get there at all." },
				},
			},

			OdysseusAboutArtemis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" }
					},
					-- @ somewhat hacky way of detecting duet singing
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Artemis_0304" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0377",
					PreLineAnim = "Odysseus_Explaining",
					Text = "You and the Goddess Artemis make quite a force out there by all accounts. And you sing together beautifully, at that...! Olympus sent her to check up on us, then, aye?" },
				{ Cue = "/VO/Melinoe_4102", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think so, yes. But I have complete trust in her if that's what you're wondering. She tells Olympus no more than they need to know to rest assured about our partnership." },
				{ Cue = "/VO/Odysseus_0378",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Default_01", WaitTime = 4 },
					Text = "She is by nature rather cautious, isn't she? Well for my part, I'm pleased you have in her not just an ally... but a friend." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4103", Text = "For my part, too." },
					},
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
					{
						Path = { "GameState", "SpecialInteractRecord" },
						HasNone = { "HoundFamiliar", "PolecatFamiliar" },
					},
					NamedRequirementsFalse = { "HecateFamiliarsInHub" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3333", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, where'd Hecuba and Gale scamper off to? I'd ask Headmistress but she doesn't like it when I show even the slightest concern for her Familiars. {#Emph}They're fine, Melinoë." },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Word has it Eris has been spotted in the depths along your path... intelligence you likely could have used {#Emph}before {#Prev}she made your journey worse for you. Apologies, Goddess..." },
				{ Cue = "/VO/Melinoe_3096", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She's trying to stop me, or at least slow me down. And... she knows too much about our intentions. What do we do? Children of Nyx are supposed to be on {#Emph}our {#Prev}side." },
				{ Cue = "/VO/Odysseus_0236",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "She doesn't know the {#Emph}half {#Prev}of what we've planned. Besides, her boredom drives her more than anything. Run into her a few more times, she'll soon grow sick of it and go away." },
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
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisAboutTask01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ErisGift06" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 585573 }, },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3335", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you caught Eris snooping through our plans or anything? Have to be even more discreet with her about..." },
				{ Cue = "/VO/Odysseus_0270",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ErisBossFirstMeeting" }, Max = 4 },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisGift06" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0272",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Good, you're back. According to reports, Eris flew off toward the Rift of Thessaly on an intercept course with the fleet. Except I don't think that she's headed there to help. Not {#Emph}you{#Prev}, at least." },
				{ Cue = "/VO/Melinoe_3311", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "These reports aren't of much benefit to me after the fact. But at least I can confirm they're accurate. How preposterous that we cannot rid ourselves of her." },
				{ Cue = "/VO/Odysseus_0273",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
			OdysseusAboutErisBossTactics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
						Value = 3,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Eris" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0422",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Eris making problems for you on the surface, isn't she... whilst so close to your goal. Well if it's any reassurance, we know the workings of her weapon better than she does. She must run out of ammunition frequently..." },
				{ Cue = "/VO/Melinoe_4213", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She does. Sometimes she jams the mechanism, gets distracted getting it unstuck. Should use those opportunities to strike. Not much place for taking cover anyhow." },
				{ Cue = "/VO/Odysseus_0423",
					PreLineAnim = "Odysseus_KnifeToss",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "She's trying to intimidate you. With the Rail of Adamant, she's much more dangerous at range. Perhaps you could outflank or outmaneuver her somehow..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4214", Text = "It's worth a shot." },
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
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "OdysseusAboutNemesis02", "NemesisGift07", "ZeusPalaceAboutTyphonDeath01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0157",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Nemesis has been in an especially foul mood of late. Anything I should know about?" },
				{ Cue = "/VO/Melinoe_2212", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was going to ask you the same. She sought my task, but that's nothing new. Though, she's been clashing with Headmistress more and more..." },
				{ Cue = "/VO/Odysseus_0158",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0159",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "So, how has Nemesis been faring out there? Taking matters into her very capable hands. Not making {#Emph}too {#Prev}much grief for you, I reckon?" },
				{ Cue = "/VO/Melinoe_2214", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So you know already? And Headmistress must, too. Nemesis is being Nemesis! Discovering firsthand our task is not as simple as it seems." },
				{ Cue = "/VO/Odysseus_0160",
					PreLineAnim = "Odysseus_KnifeToss",
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

			OdysseusAboutHypnosWakeUp01 =
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
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0622",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "So blasted quiet now... at first I couldn't tell what changed, till I recalled Hypnos had gone away. I was so accustomed to always hearing him in the background..." },
				{ Cue = "/VO/Melinoe_5244", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wait, you miss his ceaseless snoring? You of everyone at the Crossroads were in closest proximity, so I figured you'd be the most pleased that he's finally home." },
				{ Cue = "/VO/Odysseus_0623",
					PreLineAnim = "Odysseus_Greet",
					Text = "Pleased for {#Emph}him{#Prev}, aye, and the auditory change isn't a {#Emph}bad {#Prev}one, but... even when things improve, it can be an adjustment." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_5245", Text = "I'll miss him too, mostly..." },
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
					Text = "You and Commander Schelemeus both were great and famous sailors, isn't that so? Did the two of you ever meet in your mortal days?" },
				{ Cue = "/VO/Odysseus_0163",
					PreLineAnim = "Odysseus_Explaining",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosWakeUp03" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_2209", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Odysseus, have you ever seen Hypnos so much as shift in his sleep? I know he's been through a lot, but still..." },
				{ Cue = "/VO/Odysseus_0151",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Can't say I have! Been just that way from the night the good witch got him. The snoring I became accustomed to eventually..." },
				{ Cue = "/VO/Melinoe_2210", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
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
					{
						SumPrevRuns = 8,
						Path = { "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560612 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0153",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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

			OdysseusAboutIcarus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Icarus_01", }, Alive = true },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0396",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "I take it {#Emph}you're {#Prev}the reason Icarus is back. Always seemed like a good lad! I kept my mouth shut at the time but I was disappointed when he left." },
				{ Cue = "/VO/Melinoe_4508", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It was his choice to make. I think he always valued your experience as well. He didn't get to have adventures like you back when he was alive." },
				{ Cue = "/VO/Odysseus_0397",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Who does, Goddess? Though clearly he picked up some know-how whilst away. Even got {#Emph}wings {#Prev}to show for it! Think he might have an extra set?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4509", Text = "Oh I don't know..." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0083", Text = "Ah well..." },
					},
				},
			},

			OdysseusAboutAthena01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0393",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "We've not too many Shades all the way out on the Olympus front, only a few brave souls. They're saying that you met Lady Athena face-to-face, how is she holding up?" },
				{ Cue = "/VO/Melinoe_4185", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Considering she's holding back great numbers of the Titan's forces single-handedly, she seems remarkably composed." },
				{ Cue = "/VO/Odysseus_0394",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "I'd ask you thank her for the times she may have saved my skin, but... discretion's for the best." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4186", Text = "You sure I shouldn't say anything?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0395", Text = "Aye." },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Default_01", WaitTime = 5.0 },
					Text = "In life and death we can but strive to know each other well, Goddess.... Though I knew Circe... just a bit, at least; as casual acquaintances is all, why do you ask?" },
				{ Cue = "/VO/Melinoe_3314", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh just in case you wanted me to tell her anything when next we met, as she may be providing some assistance when I navigate the Rift of Thessaly." },
				{ Cue = "/VO/Odysseus_0262",
					PreLineAnim = "Odysseus_KnifeToss",
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
						HasAll = { "OdysseusAboutCirce01", "CirceAboutOdysseus01", "OdysseusGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3330", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Odysseus, what happened between you and Circe, anyhow? She mentioned you, said nothing in particular, except... I sensed some pain. There {#Emph}and {#Prev}here." },
				{ Cue = "/VO/Odysseus_0263",
					PreLineAnim = "Odysseus_Greet",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "It's not a pain entirely, Goddess. When I was whole, returning from a war, I found Circe and her isle, and... I lived there for about a year. She housed me and my men, and we grew close. I learned a lot from her, and then... we left." },
				{ Cue = "/VO/Melinoe_3331", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your voyage home. You stopped for an entire year, then voyaged on and never saw her again..." },
				{ Cue = "/VO/Odysseus_0264",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
						PathFalse = { "GameState", "RoomsEntered", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0135",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "We've multiple reports the armies of Chronos are massing on the surface up there, and not yet caught wind of your efforts. At least you aren't contending with {#Emph}them{#Prev}, aye?" },
				{ Cue = "/VO/Melinoe_2172", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My route through the Underworld is fraught in its own right, but yes, it's comforting to know that army of traitors remains ignorant of me." },
				{ Cue = "/VO/Odysseus_0136",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "There's not a downward route that's more discreet. Those thorny chaps in the woods, they've no love for Chronos either, at least." },
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
					NamedRequirementsFalse = { "OdysseusWandering" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Damn it... our reports said nothing of the sort, but then... some of our Shade informants haven't yet returned. We had expected Chronos to stay put in the lowest reaches. You must have caused enough of a stir to catch his notice." },
				{ Cue = "/VO/Melinoe_3305", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've hardly been discreet in my approach. Is there truly no other way?" },
				{ Cue = "/VO/Odysseus_0244",
					PreLineAnim = "Odysseus_Pensive_End",
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
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutChronosAnomaly01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0161",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Got a most troubling report, a sighting in the pathways on the outskirts of Erebus. Did our eyes out there see true?" },
				{ Cue = "/VO/Melinoe_2216", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If it's Chronos that they saw, then yes. Now at least I know what he looks like; but he knows {#Emph}me{#Prev}, in turn. Why do you think he let me go? Have we been compromised?" },
				{ Cue = "/VO/Odysseus_0162",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
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
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0228",
					-- PreLineAnim = "Odysseus_KnifeToss",
					-- PreLineAnim = "Odysseus_Pensive_Start",
					-- PostLineAnim = "Odysseus_Pensive_End",
					PreLineAnim = "Odysseus_Explaining",
					-- PreLineAnim = "Odysseus_Greet",
					-- PreLineAnim = "Odysseus_Salute",

					Text = "You got him, didn't you? Killed the bastard, for... one night, at least. The first report I heard, I scarce believed, but by the third or fourth, I'd come around. {#Emph}Well done{#Prev}, Goddess!" },
				{ Cue = "/VO/Melinoe_2967", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'd not be surprised if our reports already say he's returned. But I got what I needed for now. And a little bit of payback, I suppose." },
				{ Cue = "/VO/Odysseus_0229",
					PreLineAnim = "Odysseus_KnifeToss",
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "You found him, Goddess... your look says it all, along with my reports. Gave him something to remember you by, I reckon, even if the battle didn't go your way..." },
				{ Cue = "/VO/Melinoe_3094", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Chronos was exactly where we expected... but I could not foresee his every technique. And my ability to withstand his magick went only so far." },
				{ Cue = "/VO/Odysseus_0231",
					PreLineAnim = "Odysseus_KnifeToss",
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
			OdysseusAboutChronosBossTactics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0420",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Our Shades have proved unable to approach the House of Hades, so they've no reports about the way the Titan fights. I'm afraid you're on your own for that one, Goddess..." },
				{ Cue = "/VO/Melinoe_4211", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh I can give you a report myself. He looks rather frail, but he's quick. His scythe has significant reach, and he can freeze me at a moment's notice, but only for so long. And his forces are present to ensure I'm outnumbered." },
				{ Cue = "/VO/Odysseus_0421",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "{#Emph}Freeze you... {#Prev}meaning he tries to stop you using {#Emph}time{#Prev}, but can't hold you for long. Just as the good witch thought then, aye? It means his power over you is limited; {#Emph}you're {#Prev}the one that can't be stopped, not {#Emph}him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4212", Text = "It hasn't felt that way to me as yet." },
					},
				},
			},

			-- similar alt below
			OdysseusAboutTyphon01 =
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
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutPolyphemus01", "OdysseusAboutPolyphemus02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "OdysseusAboutTyphonW01", "OdysseusAboutTyphonL01", "OdysseusAboutTyphon01_B" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0384",
					-- PreLineAnim = "Odysseus_KnifeToss",
					-- PreLineAnim = "Odysseus_Greet",
					-- PreLineAnim = "Odysseus_Salute",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "You've {#Emph}Typhon {#Prev}to contend with on that mountaintop, Goddess...? Our Shades say he's near the size of a mountain himself... please tell me that's hyperbole on their part?" },
				{ Cue = "/VO/Melinoe_4109", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well to put it in perspective... by my estimation, he's at least a hundred times the size of Polyphemus. Though I've not had the opportunity to take his measure properly." },
				{ Cue = "/VO/Odysseus_0385",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You'll take his measure yet, I reckon. It's what you've done with every other foe you've faced thus far! Our Shades and the good witch think it unwise to take on such a threat yourself, but... you're not planning to back down, are you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4110", Text = "No." },
					},
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0386", Text = "Good." },
					},
				},
			},
			OdysseusAboutTyphon01_B =
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
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "OdysseusAboutTyphonW01", "OdysseusAboutTyphonL01", "OdysseusAboutTyphon01", "OdysseusAboutPolyphemus01", "OdysseusAboutPolyphemus02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0384",
					-- PreLineAnim = "Odysseus_KnifeToss",
					-- PreLineAnim = "Odysseus_Greet",
					-- PreLineAnim = "Odysseus_Salute",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "You've {#Emph}Typhon {#Prev}to contend with on that mountaintop, Goddess...? Our Shades say he's near the size of a mountain himself... please tell me that's hyperbole on their part?" },
				{ Cue = "/VO/Melinoe_4230", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well to put it in perspective... by my estimation, he's more than a hundred times the size of a Cyclops. Though I've not had the opportunity to take his measure properly." },
				{ Cue = "/VO/Odysseus_0385",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You'll take his measure yet, I reckon. It's what you've done with every other foe you've faced thus far! Our Shades and the good witch think it unwise to take on such a threat yourself, but... you're not planning to back down, are you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4110", Text = "No." },
					},
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0386", Text = "Good." },
					},
				},
			},

			OdysseusAboutTyphonL01 =
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
						PathFalse = { "CurrentRun", "Cleared" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutTyphonFight01", "HecateAboutTyphonFight01_B", "HecateBossAboutTyphonFight01", "HecateBossAboutTyphonFight01_B" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "HecateAboutTyphonFight01", "HecateAboutTyphonFight01_B" }
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0387",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "The good witch has been quite concerned about your confrontations with Typhon. Reckon you never trained to take opponents of {#Emph}that {#Prev}size." },
				{ Cue = "/VO/Melinoe_4111", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh I trained just last night. Typhon is immensely strong, and large enough to blot out the light of the Moon, but evidently {#Emph}not {#Prev}invincible. They say Lord Zeus defeated him before." },
				{ Cue = "/VO/Odysseus_0388",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "{#Emph}They {#Prev}say a lot of things, Goddess; I'm far more interested in {#Emph}your {#Prev}account. If it's your instinct that this monster can be stopped, your word is good enough for me. Though I would... also love to see some {#Emph}proof{#Prev}, of course." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4112", Text = "Of course." },
					},
				},
			},
			OdysseusAboutTyphonW01 =
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
						PathTrue = { "CurrentRun", "Cleared" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0389",
					PreLineAnim = "Odysseus_Explaining",
					Text = "You felled that mountain-sized monstrosity, Goddess...! It would be false of me to say I had no doubt you {#Emph}would{#Prev}, though... I'd only a bit, I swear. So, how did you outsmart him?" },
				{ Cue = "/VO/Melinoe_4113", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Outsmart {#Prev}him? All I could do was keep hitting him with all my might. It helped that Lord Zeus also struck him hard with lightning bolts. Eventually it worked, and Typhon fell." },
				{ Cue = "/VO/Odysseus_0390",
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Well! Your battle prowess may be unsurpassed, but your ability to weave a yarn is... not {#Emph}quite {#Prev}there. When next you overcome the Father of All Monsters, do make of it a much more rousing tale, would you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4114", Text = "...No promises." },
					},
				},
			},
			OdysseusAboutTyphonW02 =
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
						PathTrue = { "CurrentRun", "Cleared" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutTyphonW01"}
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0391",
					PreLineAnim = "Odysseus_Explaining",
					Text = "So there you were! Alone, atop the rain-soaked mountain... when out of the dark came a roar so deafening it shook Olympus to its roots. And with it came Typhon himself, more vengeful even than before...! What then, Goddess?" },
				{ Cue = "/VO/Melinoe_4115", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 5, Emote2 = "PortraitEmoteFiredUp", Portrait2 = "Portrait_Mel_Intense_01", WaitTime2 = 4 },
					Text = "We fought. I prevailed. Oh, blast... I was supposed to weave a yarn. {#Emph}Erm{#Prev}, he kept trying to crush me with his {#Emph}chin... {#Prev}but I evaded, and clambered to the top of his head, where I drove the Sister Blades Lim and Oros into his {#Emph}brain!" },
				{ Cue = "/VO/Odysseus_0392",
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "{#Emph}Oh{#Prev}, quite gruesome at the end there, I {#Emph}like {#Prev}it! My only criticism, if I may, is that... all too many tales involving huge monstrosities resolve that way. {#Emph}Erm{#Prev}, what if... he were to swallow you whole? Only for you to cut yourself out of his gullet?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4116", Text = "I was just getting to that part!" },
					},
					{
						PreLineWait = 0.1,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0106", Text = "{#Emph}<Chuckle>" },
					},
				},
			},

			OdysseusAboutTyphonDeath01 =
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
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0592",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "How are you holding up, Goddess...? My instinct is to {#Emph}celebrate {#Prev}the death of Typhon, but... I never forgot the first man I slew. How the light left his eyes..." },

				{ Cue = "/VO/Melinoe_5050", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Typhon sought destruction, and he got it. I won't rejoice in the outcome, but won't lament it either. Especially when there's more left to be done." },

				{ Cue = "/VO/Odysseus_0593",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You have the right approach. You'll have time to recount every choice and consequence when all of this is over, but for now... best to press on and finish what you started." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/Melinoe_5051", Text = "I intend to." },
					},
				},
			},

			OdysseusAboutUltimateProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0588",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Your goal is within reach, Goddess, that much I know just from how tense the good witch seems to be of late... not to pry but are you clear about what more needs to be done?" },

				{ Cue = "/VO/Melinoe_5048", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I believe so. I'd be inclined to tell you all of it, except you know how Headmistress gets about these things. Suffice it to say that the final phase of our plan is in progress." },

				{ Cue = "/VO/Odysseus_0589",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "That's all I need to hear. This phase is up to you and her. For my part, it seems you're able to get to where you need to be consistently enough." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5049", Text = "Yes. Thank you for charting my course." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0590", Text = "Anytime." },
					},
				},
			},

			OdysseusAboutHecateKidnapped01 =
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
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0594",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Not seen the good witch recently, have you, Goddess? You'd tell me if there was any reason for concern...?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5052", Text = "No need to worry about a thing." },
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutScyllaTactics01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0172",
					Text = "How's life of late down at the bottom of the sea? All sorts of nastiness lurking there, {#Emph}that {#Prev}the reports make clear. I wager you've seen some things." },
				{ Cue = "/VO/Melinoe_2181", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You'd win that wager handily. The worst of them has to be this sea-monstress called Scylla, and her Siren friends. They have this ridiculous act..." },
				{ Cue = "/VO/Odysseus_0173",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Greet",
					Text = "What, Scylla's still around? With the Sirens, no less, {#Emph}hah! {#Prev}It's a wonder you made it back. Please tell me you didn't listen to a word they sang?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutScylla01", "OdysseusAboutScyllaTactics01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "I once was desperate to hear the Sirens' song... I barely resisted their temptations; of course I was... merely mortal. Perhaps you're less susceptible to their allure." },
				{ Cue = "/VO/Melinoe_2183", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps. At any rate I fail to see the appeal. Although, it's possible the Sirens were better off without Scylla. She seems rather bossy..." },
				{ Cue = "/VO/Odysseus_0176",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
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
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- taverna
				TeleportToId = 589482,
				SkipContextArt = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusAboutScylla02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = GameData.OdysseusTavernaEvents,
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Melinoe_2202_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've seen you here alone more often lately, Odysseus. You're thinking about your family, aren't you? Some potent memory from your past." },

				{ Cue = "/VO/Odysseus_0195",
					-- PreLineAnim = "Odysseus_Drinking_LemonSpin_Full",
					-- PreLineAnim = "Odysseus_Drinking_LemonSpin_Start",
					-- PostLineAnim = "Odysseus_Drinking_LemonSpin_End",
					-- PreLineAnim = "Odysseus_Drinking_Sip",
					-- PreLineAnim = "Odysseus_Drinking_Toast",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "{#Emph}Ah{#Prev}, Goddess, you may see through most of us Shades, but your empathy for me's a bit... misplaced. Penelope, Telemachus, and I... we're cordial with each other still, but... how to say this without sounding callous..." },

				{ Cue = "/VO/Melinoe_2203", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please speak your mind with me. I'm certain you're not callous." },

				{ Cue = "/VO/Odysseus_0232",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "...My mind wanders not to matters of family, but... to the Sirens' blasted song. I scarce got to hear it even once, whilst navigating through their waters. I wanted {#Emph}desperately {#Prev}to cast myself into the sea, just for a better listen..." },

				{ Cue = "/VO/Melinoe_2204", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Sirens' song? You can't expect me to believe that Scylla's incessant drivel is the source of the Great Tactician's concerns of late?" },

				{ Cue = "/VO/Odysseus_0197",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Drinking_Sip",
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
					Text = "When last we spoke in the taverna, I didn't mean to shame you for your musical tastes. I just had no idea that Scylla could be taken seriously by anybody... much less you." },
				{ Cue = "/VO/Odysseus_0233",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Greet",
					Text = "{#Emph}Ah{#Prev}, think nothing of it. Siren music's an {#Emph}acquired taste... {#Prev}acquired by all those who sailed in their vicinity whilst I was whole. {#Emph}Incessant drivel{#Prev}, though, that's all you think it is?" },
				{ Cue = "/VO/Melinoe_2207", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, perhaps I was a bit uncharitable in my assessment, it's just... I have trouble separating my disdain for the performer from the quality of her craft." },
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
			OdysseusAboutScyllaAltFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Scylla" },
					},
					NamedRequirementsFalse = { "SawOdysseusOnBigStageRecently" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_5248", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Were you aware that Scylla and Charybdis had teamed up?" },

				{ Cue = "/VO/Odysseus_0626",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Oh you could certainly say that. Why do you ask?" },

				{ Cue = "/VO/Melinoe_5249", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I caught their latest performance. It was quite a spectacle to say the least. You could have forewarned me that the two were working in concert!" },

				{ Cue = "/VO/Odysseus_0627",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Goddess, forgive me, but I thought it was quite common knowledge that Scylla and Charybdis were collaborating... it's not a new development at all." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5250", Text = "Perhaps I merely missed the news." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Greet",
						{ Cue = "/VO/Odysseus_0628", Text = "I don't see how you could have..." },
					},
				},
			},

			OdysseusAboutScyllaSponsor01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusAboutScylla03", "ScyllaAboutDiving01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_5246", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Scylla mentioned something about a potential sponsor in the audience of one of her shows, Odysseus. Do you have any idea who that could be? I thought it might be Chronos, but can't imagine him listening to her music." },

				{ Cue = "/VO/Odysseus_0624",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "A potential sponsor... that's not come up in our reports, though I'll review and let you know if anything turns up. Probably just some old sailor who got an earful and couldn't let it go. Do you know what this sponsorship entails?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5247", Text = "Probably more of her nightly shows." },
					},
					{
						PreLineWait = 0.4,
						{ Cue = "/VO/Odysseus_0625", Text = "She's having quite a run..." },
					},

				},
			},

			OdysseusAboutScyllaTactics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "G_Boss01", "G_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Scylla" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0418",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Sirens proving to be quite the hindrance, aren't they. Our Shades have intermingled with the crowd of onlookers surrounding them, and have some observations to impart." },
				{ Cue = "/VO/Melinoe_4209", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "About what, my repeated failures to overcome a deranged musical troupe despite intensive lifelong training in both magickal and martial ways?" },
				{ Cue = "/VO/Odysseus_0419",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "No need to stand in your own way, Goddess. With Scylla and the Sirens, you are up against three foes at once. The percussionist is stuck in place but presents a significant threat. Our Shades suggest dealing with that one first." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4210", Text = "I'll give it a shot." },
					},
				},
			},

			OdysseusAboutScyllaSong01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny =
						{
							"/Music/MusicPlayer/Iris/IrisMusicScylla1MusicPlayer",
							"/Music/MusicPlayer/Iris/IrisMusicScylla1bMusicPlayer",
							"/Music/MusicPlayer/Iris/IrisMusicScylla2MusicPlayer",
							"/Music/MusicPlayer/Iris/IrisMusicScylla2bMusicPlayer",
							"/Music/MusicPlayer/Iris/IrisMusicScylla3MusicPlayer",
							"/Music/MusicPlayer/Iris/IrisMusicScylla3bMusicPlayer",
						},
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0398",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "That music... I'd recognize it anywhere! Even without the words. And here I thought I must have been the sole admirer of Siren songs in all the Crossroads." },
				{ Cue = "/VO/Melinoe_4187", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I... just wanted to see if our Music Maker even knew that particular piece. Perhaps it shouldn't be permitted here. Especially if it has insidious power over men's hearts." },
				{ Cue = "/VO/Odysseus_0399",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "{#Emph}Oh {#Prev}I think we dead men are no longer as susceptible. Though I'd best give it another listen, just to be certain." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4188", Text = "Let me know if it becomes distracting." },
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
						Path = { "CurrentRun", "BiomesReached" },
						HasAny = { "F" },
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We knew there was a secure entrance into Tartarus around that point... this beast must be how come the tunnel stays secure. Have we any details?" },
				{ Cue = "/VO/Odysseus_0255",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Well it has several fire-spitting maws, allegedly, which troublingly fits the profile of your father's household pet. Though, if this really is the case... may it simply let you pass!" },
				{ Cue = "/VO/Melinoe_3325", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasAny = { "F" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "H_Boss01", "H_Boss02" },
						Comparison = "<=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0254",
					Text = "A word of caution, Goddess, in regard to an impediment you may confront when finally you reach the far end of the Mourning Fields. Reports suggest it's some sort of infernal beast... a big one. Our Shades had to stay very far away." },
				{ Cue = "/VO/Melinoe_3326", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I can corroborate our Shades' reports. And add that this infernal beast is none other than Cerberus, my father's household pet... acting on instinct and pure rage." },
				{ Cue = "/VO/Odysseus_0257",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
						PathFalse = { "GameState", "RoomsEntered", "N_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0129",
					Text = "With your Olympus-dwelling relatives assisting you, I've half a mind to ask you to let them know I'm on your side, except... not all of them love me." },
				{ Cue = "/VO/Melinoe_0478", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}What? {#Prev}But you're the Great Tactician, Odysseus! Even the gods were impressed with your machinations in your glory days." },
				{ Cue = "/VO/Odysseus_0130",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Lady Athena and others favored me, it's true, but your uncle Poseidon, well... I got on his bad side, I believe. Maybe he's let it go after all this time but that's a risk I'm not prepared to take, so {#Emph}erm{#Prev}, keep quiet about me, would you?" },
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
				-- StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
					},
					{
						PathFalse = { "PathFalse", "RoomsEntered", "N_Opening01" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0204",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "So, there's a bit of a new wrinkle in our plans. We've been able to verify some of the details that Master Hermes suggested to you, about what's... brewing on the surface." },
				{ Cue = "/VO/Melinoe_2223", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Please tell me what you may... and if you think it wise for me to deviate from my objective to address whatever's going on up there." },
				{ Cue = "/VO/Odysseus_0205",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "The forces of Chronos gather to sail on Olympus through a channel cut across the land. You're poised to disrupt the enemy ranks from within. Aid Olympus, and your chances against Chronos may improve." },
				{ Cue = "/VO/Melinoe_2224", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_MiniBoss01", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_2189", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When was the last reported sighting of a Root-Stalker out in the woods?" },
				{ Cue = "/VO/Odysseus_0190",
					PreLineAnim = "Odysseus_Explaining",
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
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_MiniBoss02", },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0188",
					Text = "What was the source of your misfortune, that you're back with such a scowl? Some Wailers, or Caskets, perhaps? Oh... a {#Emph}Shadow-Spiller." },
				{ Cue = "/VO/Melinoe_2187", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, a Shadow-Spiller. I lost my way against one. Can hardly see a thing when they're about! I should be stronger than this..." },
				{ Cue = "/VO/Odysseus_0189",
					PreLineAnim = "Odysseus_KnifeToss",
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
						Path = { "CurrentRun", "CurrentRoom", "Name" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_KnifeToss",
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
			-- lower-priority alt below
			OdysseusAboutVerminMiniboss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "G_MiniBoss02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0193",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Goddess, latest reports said you encountered the King Vermin! Don't care if you're immortal, I'm relieved you made it back in one piece..." },
				{ Cue = "/VO/Melinoe_2193", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It can't be. I did confront a rodent of extraordinary savagery, but it was so little! I assumed the King Vermin was huge." },
				{ Cue = "/VO/Odysseus_0194",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_KnifeToss",
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
			OdysseusAboutVerminMiniboss01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "G_MiniBoss02", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0193",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Goddess, latest reports said you encountered the King Vermin! Don't care if you're immortal, I'm relieved you made it back in one piece..." },
				{ Cue = "/VO/Melinoe_2193", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It can't be. I did confront a rodent of extraordinary savagery, but it was so little! I assumed the King Vermin was huge." },
				{ Cue = "/VO/Odysseus_0194",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_KnifeToss",
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
			-- lower-priority alt below
			OdysseusAboutOctofish01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "G_MiniBoss03", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutOctofish01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0403",
					Text = "It's swarming season for the Hellifish in Oceanus, as you may have seen. Should you run into them, advice is not to bother much with smaller ones but get the {#Emph}biggest {#Prev}one." },
				{ Cue = "/VO/Melinoe_4191", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'd rather not bother with any of them and all their stinging. How long do swarming seasons typically go on?" },
				{ Cue = "/VO/Odysseus_0404",
					PreLineAnim = "Odysseus_KnifeToss",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Default_01", WaitTime = 5.3 },
					Text = "Well, {#Emph}season {#Prev}is a bit of a misnomer, as the current season started back when I was just a lad. The good news is you get accustomed to the stinging after a while!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4192", Text = "Wonderful." },
					},
				},
			},
			OdysseusAboutOctofish01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--[[
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsAny = { "G_MiniBoss03", },
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "G_MiniBoss03", },
							},
							{
								PathFalse = { "CurrentRun", "Cleared", },
							},
						},
					},
					]]--
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "G_MiniBoss03", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutOctofish01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0403",
					Text = "It's swarming season for the Hellifish in Oceanus, as you may have seen. Should you run into them, advice is not to bother much with smaller ones but get the {#Emph}biggest {#Prev}one." },
				{ Cue = "/VO/Melinoe_4191", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'd rather not bother with any of them and all their stinging. How long do swarming seasons typically go on?" },
				{ Cue = "/VO/Odysseus_0404",
					PreLineAnim = "Odysseus_KnifeToss",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Default_01", WaitTime = 5.3 },
					Text = "Well, {#Emph}season {#Prev}is a bit of a misnomer, as the current season started back when I was just a lad. The good news is you get accustomed to the stinging after a while!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4192", Text = "Wonderful." },
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
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVampire01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0288",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Found yourself a Phantom Lair in the Fields, if my Shades down there are still to be believed. Blood-sucking bastards... the {#Emph}Phantoms{#Prev}, not the Shades." },
				{ Cue = "/VO/Melinoe_3347", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Don't such creatures usually stalk the surface in their search of {#Emph}living {#Prev}prey? They must go rather hungry in the Underworld." },
				{ Cue = "/VO/Odysseus_0289",
					PreLineAnim = "Odysseus_KnifeToss",
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Found yourself a Phantom Lair in the Fields, if my Shades down there are still to be believed. Blood-sucking bastards... the {#Emph}Phantoms{#Prev}, not the Shades." },
				{ Cue = "/VO/Melinoe_3347", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Don't such creatures usually stalk the surface in their search of {#Emph}living {#Prev}prey? They must go rather hungry in the Underworld." },
				{ Cue = "/VO/Odysseus_0289",
					PreLineAnim = "Odysseus_KnifeToss",
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
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_MiniBoss02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutVampire01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0286",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Can you confirm a sighting of Queen Lamia down in the Mourning Fields, Goddess? I'd caution you to watch for signs of slithering about, except I reckon I may be too late..." },
				{ Cue = "/VO/Melinoe_3346", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_MiniBoss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3351", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not the report I wished to deliver, though I've some idea of what Chronos has been doing with all of his excess Gold... I was trounced last night by a gigantic bag of coins." },
				{ Cue = "/VO/Odysseus_0292",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_KnifeToss",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "N_MiniBoss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0247",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Not sighted Chronos on the surface yet. Why risk it when you've got bloodthirsty Satyrs serving as your eyes and ears? His forces are more organized than first they seemed." },
				{ Cue = "/VO/Melinoe_3320", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I just had an unfortunate run-in with one of those Satyrs. Well-armed, well-trained... and Chronos has entire legions." },
				{ Cue = "/VO/Odysseus_0248",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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

			-- lower-priority alt below
			OdysseusAboutCharybdis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "O_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutCharybdis01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3316", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I must admit, on some occasion all the tales you told about the sea-monster Charybdis felt almost beyond belief. Now having faced the blasted thing, I feel you sold it short." },
				{ Cue = "/VO/Odysseus_0410",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "What, faced Charybdis? {#Emph}Ah{#Prev}, Goddess. I'd heard reports about some sort of whirlpool within Poseidon's Rift and now my fear's confirmed. At least she didn't swallow you outright...!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4199", Text = "Any practical advice on how to deal with her?" },
					},
					{
						PreLineWait = 0.4,
						{ Cue = "/VO/Odysseus_0411", Text = "Avoid her at all costs?" },
					},
				},
			},
			OdysseusAboutCharybdis01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutCharybdis01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3316", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I must admit, on some occasion all the tales you told about the sea-monster Charybdis felt almost beyond belief. Now having faced the blasted thing, I feel you sold it short." },
				{ Cue = "/VO/Odysseus_0410",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "What, faced Charybdis? {#Emph}Ah{#Prev}, Goddess. I'd heard reports about some sort of whirlpool within Poseidon's Rift and now my fear's confirmed. At least she didn't swallow you outright...!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4199", Text = "Any practical advice on how to deal with her?" },
					},
					{
						PreLineWait = 0.4,
						{ Cue = "/VO/Odysseus_0411", Text = "Avoid her at all costs?" },
					},
				},
			},

			OdysseusAboutCharybdis02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutCharybdis01", "OdysseusAboutCharybdis01_B" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "O_MiniBoss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0412",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Perhaps I could have offered more-creative ways of navigating past Charybdis in your voyages when last we spoke of her. I realize sailing around may not be possible..." },
				{ Cue = "/VO/Melinoe_4200", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, it is not. I thought the main threat was to fall into that maw of hers... but I've found that her many thrashing arms or tentacles present more of a problem." },
				{ Cue = "/VO/Odysseus_0413",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Then worry about {#Emph}them. {#Prev}Perhaps you could isolate a couple at a time, use whatever space you have to keep moving. Poke her in the arms enough and she ought to back off." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4201", Text = "I can relate to that." },
					},
				},
			},

			-- alt below
			OdysseusAboutZombieCaptain01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutThessaly01" }
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_MiniBoss02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutZombieCaptain01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0405",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Some of the drowned sailors whom you face up there whilst sailing through Poseidon's Rift were probably once men I used to know... not that I could recognize them now." },
				{ Cue = "/VO/Melinoe_4193", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "There's one at least that seems to have a level of command over the rest, if fancier attire and weaponry are any indication. I fought him just last night on his big ship." },
				{ Cue = "/VO/Odysseus_0406",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "Likely the Yargonaut, if the reports add up. There was a band of similarly-named adventurers he may have hailed from. But they were from a bit before my time. Perhaps still trying to re-live their glory days..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4194", Text = "And getting in my way." },
					},
				},
			},
			OdysseusAboutZombieCaptain01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutThessaly01" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "O_MiniBoss02", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutZombieCaptain01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0405",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Some of the drowned sailors whom you face up there whilst sailing through Poseidon's Rift were probably once men I used to know... not that I could recognize them now." },
				{ Cue = "/VO/Melinoe_4193", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "There's one at least that seems to have a level of command over the rest, if fancier attire and weaponry are any indication. I fought him just last night on his big ship." },
				{ Cue = "/VO/Odysseus_0406",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "Likely the Yargonaut, if the reports add up. There was a band of similarly-named adventurers he may have hailed from. But they were from a bit before my time. Perhaps still trying to re-live their glory days..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4194", Text = "And getting in my way." },
					},
				},
			},

			-- lower-priority alt below
			OdysseusAboutDragonMiniBoss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_MiniBoss02", },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutDragonMiniBoss01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_4195", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Did you ever face Dracons in your mortal days, Odysseus? The kind that fly about on wings much like a bat's, but huge. They've become quite a problem on Olympus recently." },
				{ Cue = "/VO/Odysseus_0407",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "My home was mountainous though we were mostly free from flying beasts. Still, in my experience they all have something in common: Susceptibility to being shot out of the sky." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4196", Text = "I can see that." },
					},
				},
			},
			OdysseusAboutDragonMiniBoss01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_MiniBoss02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutDragonMiniBoss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_4195", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Did you ever face Dracons in your mortal days, Odysseus? The kind that fly about on wings much like a bat's, but huge. They've become quite a problem on Olympus recently." },
				{ Cue = "/VO/Odysseus_0407",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "My home was mountainous though we were mostly free from flying beasts. Still, in my experience they all have something in common: Susceptibility to being shot out of the sky." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4196", Text = "I can see that." },
					},
				},
			},

			-- lower-priority alt below
			OdysseusAboutTalos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutTalos01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3610", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know the great Olympian defender, Talos? One of the most ingenious inventions of Hephaestus, and a walking work of art... yet utterly unable to distinguish friend from foe." },
				{ Cue = "/VO/Odysseus_0297",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "That disappointing lack of judgment allegedly is not an oversight. Olympus deploys Talos where they want {#Emph}no one {#Prev}to tread, and lately, their own mountain is that place." },
				{ Cue = "/VO/Melinoe_3611", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sometimes I think Olympus doesn't have the most cohesive plan for their defense. Isn't Lady Athena herself supposed to be in charge?" },
				{ Cue = "/VO/Odysseus_0298",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Supposed to be, aye. You know your family, Goddess! In matters of importance, they all want to get involved." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3612", Text = "For their sake, I hope Talos isn't costly to repair." },
					},
				},
			},
			OdysseusAboutTalos01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_MiniBoss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutTalos01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_3610", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know the great Olympian defender, Talos? One of the most ingenious inventions of Hephaestus, and a walking work of art... yet utterly unable to distinguish friend from foe." },
				{ Cue = "/VO/Odysseus_0297",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "That disappointing lack of judgment allegedly is not an oversight. Olympus deploys Talos where they want {#Emph}no one {#Prev}to tread, and lately, their own mountain is that place." },
				{ Cue = "/VO/Melinoe_3611", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sometimes I think Olympus doesn't have the most cohesive plan for their defense. Isn't Lady Athena herself supposed to be in charge?" },
				{ Cue = "/VO/Odysseus_0298",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Supposed to be, aye. You know your family, Goddess! In matters of importance, they all want to get involved." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3612", Text = "For their sake, I hope Talos isn't costly to repair." },
					},
				},
			},

			-- lower-priority alt below
			OdysseusAboutTyphonMiniboss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "Q_MiniBoss02", "Q_MiniBoss05" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutTyphonMiniboss01_B" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0408",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Which sorts of foul monstrosities were the Olympians contending with of late? As if the Titan's armies weren't troublesome enough, now Typhon's brood..." },
				{ Cue = "/VO/Melinoe_4197", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well... imagine horrors of all shapes and sizes, each some mix of muscle, eyes, and {#Emph}teeth. {#Prev}They climb up from beneath the ground... some practically ooze from the walls! The one that got me last night was particularly large." },
				{ Cue = "/VO/Odysseus_0409",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "And I take it Typhon has far more of these children than even your Lord Uncle Zeus, and all spoiled rotten. Feuding families! The cause of most every great war I've known." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4198", Text = "I'd not considered it that way..." },
					},
				},
			},
			OdysseusAboutTyphonMiniboss01_B =
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
						HasAny = { "Q_MiniBoss02", "Q_MiniBoss05" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutTyphonMiniboss01" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0408",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Which sorts of foul monstrosities were the Olympians contending with of late? As if the Titan's armies weren't troublesome enough, now Typhon's brood..." },
				{ Cue = "/VO/Melinoe_4197_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well... imagine horrors of all shapes and sizes, each some mix of muscle, eyes, and {#Emph}teeth. {#Prev}They climb up from beneath the ground... some practically ooze from the walls!" },
				{ Cue = "/VO/Odysseus_0409",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "And I take it that he has far more of these children than even your Lord Uncle Zeus, and all spoiled rotten. Feuding families! Cause of most every great war I've known." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4198", Text = "I'd not considered it that way..." },
					},
				},
			},
			OdysseusAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0541",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "What brought you back that it would cause you visible distress, Goddess? We heard you made it to the summit but reports are inconclusive after that... or, unbelievable." },
				{ Cue = "/VO/Melinoe_5079", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Some sort of infestation plagues the summit... monstrosities abound. They can't possibly be servants of Chronos, but... they must be part of his scheme." },
				{ Cue = "/VO/Odysseus_0542",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Well let's not speculate before we gather all the necessary facts. You've stood against these monstrosities and managed to return. Your family members must know more, provided they're... still able to reach you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5080", Text = "I ought to make certain of that." },
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
					Text = "You're really using that labrys, Goddess? Or, pardon, what you call the Moonstone Axe. No disrespect, but isn't it... a little much? Not even Ajax could have wielded such a thing." },
				{ Cue = "/VO/Melinoe_0059", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Weren't you the one who taught me to improvise, Odysseus? I'll use whatever means at my disposal. Who is Ajax?" },
				{ Cue = "/VO/Odysseus_0045",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Who's {#Emph}Ajax? {#Prev}Only the biggest lad I've ever met, {#Emph}who's Ajax{#Prev}. But I forget myself, for he didn't have the strength of Hades flowing through him." },
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
				PlayOnce = true,
				UseableOffSource = true,
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0131",
					PreLineAnim = "Odysseus_Explaining",
					Text = "If I may be so bold, Goddess? You witches are reliant on your magick when it comes to fighting from afar. Ever think of taking up the bow again? I could give you some pointers..." },
				{ Cue = "/VO/Melinoe_0480", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We don't discuss the bow, Odysseus. I'm still recovering from the last time you gave me some of those pointers about it." },
				{ Cue = "/VO/Odysseus_0132",
					Text = "Ah, well. We all have our strengths and weaknesses. A single weakness in your case, perhaps." },
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
			},

			OdysseusAboutBiomeMap01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "G_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "H_Intro" },
						Comparison = "<=",
						Value = 12,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0354",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "How has our map been working out for you thus far? You reached Oceanus, sure, though the path ahead grows still more labyrinthine based on all we've ascertained." },
				{ Cue = "/VO/Melinoe_4089", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There seem as many pathways in the Underworld as stars in the night sky... yet your map has shown the way precisely. You must have an excellent sense of direction." },
				{ Cue = "/VO/Odysseus_0355",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "{#Emph}Oh {#Prev}I don't know, but if our map helps overcompensate for my own lack, then good. Though, careful when you reach the Mourning Fields. No map shall benefit you {#Emph}there." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4090", Text = "What of the golden petals?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0356", Text = "Do watch for those." },
					},
				},
			},
			OdysseusAboutBiomeMap02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Intro" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Intro" },
						Comparison = "<=",
						Value = 16,
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0357",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "We've ceased attempts to find a good route through Elysium, hence your somewhat unconventional way into Tartarus. The old administrative corridor remains neglected still?" },
				{ Cue = "/VO/Melinoe_4091", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Completely deserted, to the point of being rather peaceful. Drops me right into the maintenance sector, just as you mapped out." },
				{ Cue = "/VO/Odysseus_0358",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Oh, our Shades deserve the greatest share of credit for {#Emph}that {#Prev}feat, though I'll take {#Emph}some {#Prev}if you insist. Your task is difficult enough that we didn't need you getting lost along the way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4092", Text = "No objections here." },
					},
				},
			},

			OdysseusAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "G_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0352",
					PreLineAnim = "Odysseus_KnifeToss",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Your pathway down into the Underworld may seem a little roundabout, but avoiding the main regions is your best shot at eluding Chronos till you can face him on {#Emph}your {#Prev}terms. " },
				{ Cue = "/VO/Melinoe_4088", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I have that pathway long since memorized; a straight shot down to Tartarus would have been too good to be true. I'm grateful that this other route even exists." },
				{ Cue = "/VO/Odysseus_0353",
					PreLineAnim = "Odysseus_Explaining",
					Text = "And {#Emph}I {#Prev}am grateful that your father's realm is vast indeed, that we could chart a course along its border all the way to where you need to be." },
			},

			OdysseusAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "G_Intro" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Strange music, {#Emph}huh... {#Prev}reminds me of when... {#Emph}oh{#Prev}, I'll spare the tales for another time! You've enough on your mind, I can tell." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						-- { Cue = "/VO/Melinoe_0481", Text = "Doesn't count." },
					},
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "H_Boss01", "H_Boss02" },
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
					Text = "A bit of a walk, fraught with soul-devouring Daemons and other life-hating fiends. Too powerful to be imprisoned so they're free to wander there, something like that?" },
				{ Cue = "/VO/Odysseus_0246",
					PreLineAnim = "Odysseus_Explaining",
					Text = "We mortals just love the Fields, Goddess! A place to rid oneself of misery — or drown in it. A perfect spot for Daemons, only {#Emph}some {#Prev}of which shall leave you be." },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Chronos is using {#Emph}them {#Prev}to get at {#Emph}you. {#Prev}Instill in you emotions that compel you to throw caution to the wind. Remember, wars are won and lost in hearts and minds." },
				{ Cue = "/VO/Melinoe_3329", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did you not act on your emotions in your mortal days?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0438", Text = "And just look at the mess I'm in now!" },
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why not send Nemesis to the surface in my stead? Even if I undo the wards sealing the path, I don't know that I'll last long up there." },
				{ Cue = "/VO/Odysseus_0207",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
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
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0208",
					Text = "The good witch always figured you would make your way up to the mortal realm. Once you were ready and the situation called for it. Well done." },
				{ Cue = "/VO/Melinoe_2227", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "She warded the pathway there, until such time as I had the means to pass through. But the climate on the surface is another matter..." },
				{ Cue = "/VO/Odysseus_0209",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "A proper nautical experience, then! Fraught with {#Emph}danger, mystery...! Ah{#Prev}, I feel a little envious of those drowned crews! After I died, I thought my sailing days were done." },
				{ Cue = "/VO/Melinoe_3308", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, Chronos could probably use more sailors after what I did to them." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Greet",
						{ Cue = "/VO/Odysseus_0241", Text = "Put in a good word for me would you?" },
					},
				},
			},

			OdysseusAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0295",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "This may not be the best occasion to inform you but we've reason to believe the trouble brewing on Olympus is significantly worse than it appears. Not even the gods are fully aware. Unfortunately, neither are we..." },
				{ Cue = "/VO/Melinoe_3608", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The forces of Chronos attack nonstop, while the gods and their defenses hold them back... then it's a ruse for some especially dramatic gesture that the Titan has in store?" },
				{ Cue = "/VO/Odysseus_0296",
					PreLineAnim = "Odysseus_Greet",
					Text = "My thoughts exactly. But have no fear, Goddess! I once fought alongside a great warrior who said {#Emph}fear is for the weak{#Prev}. I happen to think fear is for the living, but like most good things, it isn't healthy in abundance." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3609", Text = "Fear is for our enemies." },
					},
					{
						PreLineWait = 0.4,
						{ Cue = "/VO/Odysseus_0304", Text = "Aye." },
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0210",
					Text = "How was the surface, still warm and welcoming I reckon? You're to be commended for even setting foot up there." },
				{ Cue = "/VO/Melinoe_0060", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "It was dreadful. The city of Ephyra is completely overrun. And, there's a blind Cyclops making sure no one gets out." },
				{ Cue = "/VO/Odysseus_0031",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Well, that all sounds entirely unfortunate. That blind Cyclops must be Polyphemus. My crew and I once had a bad run-in with him. He still going on about eating people?" },
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
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "{#Emph}Eh{#Prev}, sounds like the Cyclops that I used to know all right. My crew and I, we were his captives for a while... and his food supply. I found a way to get us out of there, but it was ugly..." },
				{ Cue = "/VO/Melinoe_3338", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "He calls you Nobody. How did he come to know you by that name?" },
				{ Cue = "/VO/Odysseus_0275",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "N_Boss01", "N_Boss02" },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_KnifeToss",
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "The great {#Emph}Heracles... {#Prev}that's a complicated one. Part {#Emph}man{#Prev}, part {#Emph}god... {#Prev}part monster too, perhaps. The rules of death don't quite apply to him. What did he want? He give you any trouble?" },
				{ Cue = "/VO/Melinoe_2221", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "He was quite brusque. Told me to stay out of his way. Sounds like he has a task of his own. Maybe Olympus isn't counting on me to succeed..." },
				{ Cue = "/VO/Odysseus_0212",
					PreLineAnim = "Odysseus_Explaining",
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

			-- lower-priority alt below
			OdysseusAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutPrometheus01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0293",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Prometheus opposes us... now {#Emph}that {#Prev}one hurts, Goddess. Amongst us mortals, he was quite popular. Beloved, even! Gave us the gift of fire. Practically made us who we are." },
				{ Cue = "/VO/Melinoe_3606", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And in so doing, he violated the will of Olympus. Supposedly he has the gift of foresight... he ought to have anticipated the consequences of his disobedience." },
				{ Cue = "/VO/Odysseus_0294",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "What makes you think he didn't? All the more reason we admired him. He knew the cost of what he did for us, and paid it willingly, or... so I choose to think. But all that's in the past. If he's thrown in with Chronos now, he's lost his way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3607", Text = "He's done both." },
					},
				},
			},
			OdysseusAboutPrometheus01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutPrometheus01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0293",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Prometheus opposes us... now {#Emph}that {#Prev}one hurts, Goddess. Amongst us mortals, he was quite popular. Beloved, even! Gave us the gift of fire. Practically made us who we are." },
				{ Cue = "/VO/Melinoe_3606", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And in so doing, he violated the will of Olympus. Supposedly he has the gift of foresight... he ought to have anticipated the consequences of his disobedience." },
				{ Cue = "/VO/Odysseus_0294",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "What makes you think he didn't? All the more reason we admired him. He knew the cost of what he did for us, and paid it willingly, or... so I choose to think. But all that's in the past. If he's thrown in with Chronos now, he's lost his way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3607", Text = "He's done both." },
					},
				},
			},
			OdysseusAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutPrometheus01", "OdysseusAboutPrometheus01_B" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "TrueEndingFinale01", "OdysseusAboutPrometheusAltFight01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0379",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Wanted to ask you more about Prometheus. By your own estimation, is he truly mad...? And, if he stands opposed to all your family, then who set him loose to begin with...?" },
				{ Cue = "/VO/Melinoe_4104", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I don't exactly know on either count. He speaks in riddles sometimes, but he doesn't sound as though he's lost his mind. My suspicion is that the forces of Chronos liberated him in exchange for his obedience, but..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0380", Text = "...But he's no hired thug, is he." },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4105", Text = "No, I think not." },
					},
				},
			},
			OdysseusAboutPrometheus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutMortals03" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
					},
					-- NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_4106", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "You know mortals better than anybody here. Prometheus claims that the gods are cruel, and that he fights not for the Titan Lord, but mortalkind. What do you make of all that?" },

				{ Cue = "/VO/Odysseus_0381",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Look, I've known mortals who think gods can be uncaring. Some of them defy the gods even in death. Others understand that gods are... {#Emph}everything{#Prev}, really. We have only this world, more beautiful than it is flawed." },

				{ Cue = "/VO/Melinoe_4107", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "You're speaking in the abstract. I want to know your personal opinion here, Odysseus. Are the gods in the wrong? Did we bring this on ourselves...?" },

				{ Cue = "/VO/Odysseus_0382",
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "My personal opinion is that gods and mortals are a {#Emph}complicated {#Prev}bunch; and that you shouldn't doubt yourself, lest you falter. If I felt you or the good witch were in the wrong, I'd tell you so." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4108", Text = "You swear to that?" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0383", Text = "Aye, Goddess." },
					},
				},
			},

			OdysseusAboutPrometheusAltFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_5223", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Odysseus, I need your counsel and discretion on something. Prometheus has an ally whom I thought was on my family's side. I faced them together near the mountain's summit, where the smoke is thick. But, I mustn't say who..." },

				{ Cue = "/VO/Odysseus_0614",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "{#Emph}Mm{#Prev}, quite the report all right, and I have my suspicions as to whom you mean. Certainly the gods must know, at least Master Hermes, or... do you reckon that they're unaware?" },

				{ Cue = "/VO/Melinoe_5224", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I don't think they realize, though perhaps Hermes does and won't let on. Prometheus said I wouldn't tell a soul who it was because of the harm that doing so would bring. Do you think he's telling the truth?" },

				{ Cue = "/VO/Odysseus_0615",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "I'd not wager otherwise. We had best treat it as the truth for now, unless you believe this ally poses an imminent threat to your family. Are you in a position to further investigate?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5225", Text = "I think so..." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0616", Text = "Keep me apprised." },
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
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Goddess, I was just thinking of your travels, taking you beneath the surface and above, I reckon to the ends of the earth! No mere {#Emph}journey... {#Prev}got to be a better word for it..." },
				{ Cue = "/VO/Melinoe_2195", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What, is {#Emph}task {#Prev}not sufficiently extravagant? Perhaps {#Emph}assignment? {#Prev}Or {#Emph}voyage? Quest {#Prev}doesn't feel right at all..." },
				{ Cue = "/VO/Odysseus_0148",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
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
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "For certain, the one-life-to-live bit instilled in me the will to survive. Most mortals cling to life, but I was better than most at rejecting my doubts. And when my plans all fell apart, I improvised...!" },
				{ Cue = "/VO/Melinoe_2175", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "{#Emph}Your {#Prev}plans fell apart? How did you avoid becoming distraught? Keep all your doubts at bay in the face of failure?" },
				{ Cue = "/VO/Odysseus_0138",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You said you always believed there was a solution, a positive outcome that could be discovered and achieved... I've been thinking about that." },
				{ Cue = "/VO/Odysseus_0141",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Good. But it occurred to me there's something else: Love drove me on, Goddess. The great war that earned me my place in Elysium... I wanted desperately not to go. To stay home with my wife and newborn son." },
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

			OdysseusPostTrueEnding01 =
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
						HasNone = { "NeoChronosAboutTartarus01", "NeoChronosAboutOlympus01" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0596",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You found a path to victory and got us there. Wouldn't have been much of a plan if it didn't leave room to improvise! Of course our plan now also has this {#Emph}other {#Prev}phase as a result..." },

				{ Cue = "/VO/Melinoe_5053", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Cleaning up after Chronos. I know you thought I would get rid of him, but... my family is better off not knowing such a thing could even be done, except to real monsters." },

				{ Cue = "/VO/Odysseus_0597",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "I well and truly understand, Goddess, and do believe your choice was wise. As for what's next, everything is ready for you to proceed if and when you are." },

				{ Cue = "/VO/Melinoe_5684", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I want your counsel here, Odysseus... should we be doing this? Ensuring {#Emph}time flows freely forward? {#Prev}The remnants of the Titan's legions likely won't be happy to see me, retracing my steps like nothing happened." },

				{ Cue = "/VO/Odysseus_0598",
					PreLineAnim = "Odysseus_Explaining",
					Text = "{#Emph}Eh{#Prev}, my personal opinion is it doesn't hurt to {#Emph}try! {#Prev}To the extent you'd other matters to resolve, consider it an opportunity to do so. And, we'll always be anticipating your return." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5055", Text = "Then let's give it a go." },
					},
				},
			},
			OdysseusPostTrueEnding02 =
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
						HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutOlympus01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0599",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Everything proceeding as expected in the new phase of your task thus far, Goddess? Stretching the definition of {#Emph}expected{#Prev}, perhaps, as this is... new territory for us all." },

				{ Cue = "/VO/Melinoe_5111", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "It's an unusual assignment, ensuring time flows freely. If done correctly, everything will seem as before. And even if not... there's no guarantee anything will go wrong." },

				{ Cue = "/VO/Odysseus_0600",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Well that makes this sound more familiar than I thought. Life in all its uncertainties! Anyway, we're watching Chronos and ensuring that your route remains intact." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5112", Text = "I'll make the most of it. Thank you." },
					},
				},
			},

			OdysseusPostTrueEndingAboutHouse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutroPostTrueEnding01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0601",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Sounds like your father's House is back in some semblance of order. Always wanted to visit if ever I could, if only to greet an old comrade or two from the war." },

				{ Cue = "/VO/Melinoe_5213", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I'd also like to visit again, but there's no telling when if ever we would have that chance so long as we're Unseen. Officially they're not even supposed to know we're here." },

				{ Cue = "/VO/Odysseus_0602",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "I know, but it doesn't make the desire go away! At any rate, as long as the servants of the King and Queen are well. Perhaps our paths shall later cross, who knows." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5214", Text = "The Fates?" },
					},
					{
						PreLineWait = 0.31,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0603", Text = "Or Prometheus, aye." },
					},
				},
			},
			OdysseusPostTrueEndingAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0604",
					PreLineAnim = "Odysseus_Pensive_Start",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Is Typhon really up there on the summit still? {#Emph}Hm{#Prev}, no trace of him in our reports, but if Chronos... {#Emph}erm{#Prev}, your grandfather, that is... if he's using some sort of chronomancy to transport you..." },

				{ Cue = "/VO/Melinoe_5215", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "He is, yes. And I end up confronting Typhon as before. Apparently these are possibilities within the flow of time in which I haven't prevailed... until I do." },

				{ Cue = "/VO/Odysseus_0605",
					PreLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "I don't see how that's possible. What, there are all these other instances of you out there, some failing, some prevailing, all at the same time? Nonsense... but then again, who am I to question bizarre plans?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5216", Text = "Whatever works, aye?" },
					},
				},
			},

			OdysseusPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_5217", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I take it you heard about the Fates? Apparently everyone already has, figured you'd be among the first. Though come to think of it, I've not heard you speak about them much..." },

				{ Cue = "/VO/Odysseus_0608",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					PreLineWait = 0.35,
					Text = "...It's because deep down I've always felt we make our choices for ourselves. Admittedly a controversial point of view when we've strong evidence that those three often choose for us, but... I have to heed my instincts on this one." },

				{ Cue = "/VO/Melinoe_5218", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Wait, you don't believe in what they do? Their prophecies, the coming of a new age... none of it?" },

				{ Cue = "/VO/Odysseus_0609",
					PreLineAnim = "Odysseus_Explaining",
					Text = "I wouldn't go {#Emph}that {#Prev}far, but... I {#Emph}choose {#Prev}to believe in those I know and trust, including members of your family. If that makes me a fool, then so be it." },

				{ Cue = "/VO/Melinoe_5219", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					Text = "{#Emph}So be it? {#Prev}Sounds like accepting fate to me." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.31,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Greet",
						{ Cue = "/VO/Odysseus_0610", Text = "{#Emph}Oh {#Prev}you know what I mean!" },
					},
				},
			},
			OdysseusPostEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_5220", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "This new age the Fates foretold, when they'll {#Emph}hand it over to mortals{#Prev}, by which I think they meant the big decisions... what say our Shades about all that?" },

				{ Cue = "/VO/Odysseus_0611",
					PreLineAnim = "Odysseus_Explaining",
					Text = "I've heard a mix of viewpoints, though they've been enthusiastic on the whole. Ungrateful wretches, aye? We're only here by the grace of the gods." },

				{ Cue = "/VO/Melinoe_5221", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "It isn't always grace, I suppose. Many of these Shades met an early demise due to acts of gods. They don't want to be pushed around." },

				{ Cue = "/VO/Odysseus_0612",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "There shall always be someone or something to push such people around. Whether it's a god or not hardly matters. The gods can have their moods, I know. But I'd not have gone far without them. It's why I'm here." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5222", Text = "Nice of you to say." },
					},
					{
						PreLineWait = 0.31,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0613", Text = "I don't say, I swear." },
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift02" },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Wanted to say, I appreciate your counsel, Odysseus. You've been like a brother to me. Or an uncle? One of those. You'd know better than I." },
				{ Cue = "/VO/Odysseus_0037",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Look, you don't have to tell me what it's like not having a family about. I spent a good-sized portion of my mortal days away from home. Had a war to fight, got a little sidetracked after." },
				{ Cue = "/VO/Melinoe_0453", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "{#Emph}Sidetracked? {#Prev}Headmistress says that you spent many years at sea. Some of them in the company of goddesses, at that." },
				{ Cue = "/VO/Odysseus_0038",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "Aye, well. By the time I finally returned, I scarce recognized my son, and my wife... we lived out our mortal days together, and that was enough. I reckon they're comfortable somewhere below." },
				{ Cue = "/VO/Melinoe_0454", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "You haven't seen them? What happened?" },
				{ Cue = "/VO/Odysseus_0039",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_End",
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

			OdysseusLooseEndsQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusAboutScylla03", "OdysseusAboutPolyphemus03", "OdysseusAboutCirce02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusBathHouse02", "OdysseusTaverna01" },
					},
					NamedRequirementsFalse = { "NearTrueEnding", "HecateMissing" },
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0430",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "Fair warning I'm a proper wretch right now, Goddess. Used to think I lived a complete life! But all your journeys made me realize that there was {#Emph}much {#Prev}I left unsaid. Too much." },
				{ Cue = "/VO/Melinoe_4219", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? How do my journeys factor into that? And cease your wretchedness at once... or tell me how to make it stop." },
				{ Cue = "/VO/Odysseus_0431",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "{#Emph}Eh{#Prev}, you've met Scylla and the Sirens, the Cyclops Polyphemus, the Enchantress Circe... one way or another, they each left an indelible mark on me; to say nothing of my wife and son, wherever they are. I think... I need to go..." },
				{ Cue = "/VO/Melinoe_4220", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Go {#Emph}where? {#Prev}Odysseus, you can't leave now, we need you here! There must be something we can do." },
				{ Cue = "/VO/Odysseus_0432",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "{#Emph}Eugh. {#Prev}Probably there is, but I — I wouldn't wish to overburden you. You already take on far too much." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4221", Text = "Tell me more." },
					},
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Drinking_Sip",
						{ Cue = "/VO/Odysseus_0433", Text = "Perhaps some... other time..." },
					},

				},
			},
			OdysseusLooseEndsQuest02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusLooseEndsQuest01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0563",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Apologies, I've... started letting my misery break free. Moments of weakness, becoming more frequent than I care to admit. I've been thinking about what to do... a {#Emph}plan." },

				{ Cue = "/VO/Melinoe_5101", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What is it? You mentioned Scylla, Polyphemus, Circe... I see them frequently enough that I could speak to them on your behalf if you'd like?" },

				{ Cue = "/VO/Odysseus_0564",
					PreLineAnim = "Odysseus_Explaining",
					Text = "{#Emph}Oh{#Prev}, I'd not ask you to do {#Emph}that. {#Prev}However, your connection to my Knuckle Bones is strong enough, perhaps I could relay a message to them myself. Just get my Keepsake there and I could do the rest?" },

				{ Cue = "/VO/Melinoe_5102", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "A spirit projection... I could probably maintain one for a little while. You mean to confront your old acquaintances?" },

				{ Cue = "/VO/Odysseus_0565",
					PreLineAnim = "Odysseus_Greet",
					Text = "For now, that's all, Goddess. If aiding me this way won't stray from your objectives." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5103", Text = "Of course not. We'll see it through." },
					},
				},
			},
			OdysseusLooseEndsQuestComplete01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {  "ScyllaAboutOdysseusQuest01", "PolyphemusAboutOdysseusQuest01", "CirceAboutOdysseusQuest01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0581",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "I'm grateful that you let me pay a visit to some of my former associates, Goddess. It changed nothing, really, but... I felt as though I put several matters to rest. As for what happens now... I may be gone a little while..." },

				{ Cue = "/VO/Melinoe_5104", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Things are settled here enough... take all the time you need, and you'll be welcome whenever you return. Can you say where you're going?" },

				{ Cue = "/VO/Odysseus_0582",
					PreLineWait = 0.35,
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Default_01", WaitTime = 4.1 },
					Text = "...To find my mortal family... my wife and son. I've done it before. May it not take quite as long on {#Emph}this {#Prev}occasion, though." },

				{ Cue = "/VO/Melinoe_5105", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It won't. You must have charted every passageway through the Underworld by now! But what will you do then?" },

				{ Cue = "/VO/Odysseus_0583",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "I'll figure that out on the way. In the meantime, I've deputized some of our Shades to keep an eye on things, and privately said my goodbyes to our good witch. Be well, in my absence." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5106", Text = "Safe journeys, Odysseus..." },
					},
				},
			},

			OdysseusAboutReturn01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {  "OdysseusLooseEndsQuestComplete01" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Melinoe_5108", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We missed you here, and I'm so pleased you're back! How was your trip? Did you find your family?" },

				{ Cue = "/VO/Odysseus_0585",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Aye, Goddess, I found them all right. Followed a couple leads down in Elysium, ran into a couple of former compatriots, and we got there. Penelope and Telemachus... {#Emph}erm{#Prev}, well, they recognized me right away." },

				{ Cue = "/VO/Melinoe_5109", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Were they all right? Apologies, it's not my wish to drag these details out of you, it's just... this is your latest tale!" },

				{ Cue = "/VO/Odysseus_0586",
					PreLineWait = 0.35,
					Text = "{#Emph}Ahh{#Prev}, what's to tell? It was... well, it was comforting. I reckon the time we spent apart was healing in a way. They asked I visit them again, down the line." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5110", Text = "I think you should. I'm glad it went well." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0587", Text = "It could have gone far worse." },
					},
				},
			},

			OdysseusAboutAssistance01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ScyllaAboutOdysseusQuest01", "PolyphemusAboutOdysseusQuest01", "CirceAboutOdysseusQuest01" },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0543",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "If I may confide something, Goddess? Throughout my mortal life, I never wanted to depend on anyone. But, I always had aid... from great warriors, sailors, even gods! Yet... even still, it's difficult to ask assistance in personal matters." },

				{ Cue = "/VO/Melinoe_5081", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I know the feeling well. A sense of weakness... the inability to do something oneself. We strive for self-sufficience and we don't wish to heap our troubles on our comrades." },

				{ Cue = "/VO/Odysseus_0544",
					PreLineAnim = "Odysseus_Drinking_Toast",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 3.5 },

					Text = "Aye, we know it {#Emph}isn't {#Prev}weakness, but... we have to fight our instincts there a bit, don't we? Though mainly, what I wished to say was, {#Emph}thank you. {#Prev}For the aid you've given me. You needn't have gone out of your way." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5082", Text = "Of course. We've come this far together." },
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
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

			OdysseusAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01" },
					},
					{
						PathTrue = { "CurrentRun", "TraitCache", "BossPreDamageKeepsake" },
					},
					{
						Path = { "GameState", "TraitUses", "BossPreDamageKeepsake" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0400",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Have the old Knuckle Bones been of some use, Goddess? Must look a little worn, but... brought me fortune many times, in games of chance and when my life was on the line." },
				{ Cue = "/VO/Melinoe_4189", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Odysseus, if they were dear to you all through your life, why would you give them to me now? No matter how useful they still may be, which is quite a bit!" },
				{ Cue = "/VO/Odysseus_0401",
					PreLineAnim = "Odysseus_Explaining",			
					Text = "Come now, nothing would please me more than for you to succeed. If some small token of my past could be of benefit, it's yours. Besides, I got a Nectar bottle in exchange!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4190", Text = "It wasn't meant to be a trade." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0402", Text = "Just keep the blasted Bones." },
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
						-- PathTrue = { "GameState", "ScreensViewed", "MailboxScreen" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "CharonGrantsMailbox01" }, Max = 8 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0145",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "See Charon's latest haul, Goddess? Shipment by the riverside, all yours. And we're watching the rivers, making certain this won't be the last." },
				{ Cue = "/VO/Melinoe_2335", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Charon risks aiding my efforts in such a direct way. Are we able to compensate him at all?" },
				{ Cue = "/VO/Odysseus_0146",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
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
			OdysseusAboutMailbox02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CharonPoints" },
						Comparison = ">=",
						Value = 20,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0427",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You must be Charon's finest customer. I reckon he enjoys the frequent visits to the Underworld, in his way. At least it's mostly cargo shipments now, not just confused, complaining Shades of the recently deceased..." },
				{ Cue = "/VO/Melinoe_4217", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did you accept your death with dignity when it was finally your time, Odysseus? You seem as though you would have clung to life with all your might." },
				{ Cue = "/VO/Odysseus_0428",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Oh, I'd gotten on in years by then. Still didn't care much for the circumstances, not that anybody does! Though, I did appreciate the opportunity to meet the fearsome Boatman at long last, and ride into the Underworld the {#Emph}proper {#Prev}way." },
				{ Cue = "/VO/Melinoe_4218", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've mentioned that you'd gone into the Underworld and back while you still lived. Lord Charon didn't take you then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0429", Text = "He certainly did not! A tale for another night, perhaps." },
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
					PreLineAnim = "Odysseus_Explaining",
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

			OdysseusAboutCrossroads01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesRevealed" },
						HasAny = { "WorldUpgradeBathHouse", "WorldUpgradeGarden", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasNone = { "WorldUpgradeBathHouse", "WorldUpgradeGarden", "WorldUpgradeTaverna" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0434",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Note we have several projects to expand these Crossroads that could use your blessings when you get the opportunity, Goddess. Your choice, and there's no urgency at all." },
				{ Cue = "/VO/Melinoe_4222", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Eventually the waters in the hot springs and the fishing pier need to be purified, not to mention the taverna grounds. Have you a preferential order between those?" },
				{ Cue = "/VO/Odysseus_0435",
					PreLineWait = 0.3,
					PreLineAnim = "Odysseus_Explaining",
					Text = "Well you know the Shades, they like to gather up in the taverna, so I reckon I'd start there... or whichever one is simplest for you!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4223", Text = "I'll look into it." },
					},
				},
			},

			OdysseusAboutCosmetics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGift01", "OdysseusGift01", "DoraListless03" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusAboutCosmetics02" },
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = "<=",
						Value = 7,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0183",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "That renewal project that we used to talk about? I still think of it all the time, these Crossroads flourishing with worldly delights...!" },
				{ Cue = "/VO/Melinoe_3800", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I still think about it, too, and made some preliminary steps of late. The well-being of every last Shade in this place is important to our goal." },
				{ Cue = "/VO/Odysseus_0184",
					PreLineAnim = "Odysseus_Explaining",
					Text = "But, we've more pressing matters now, it seems. What, you intend to stop fighting Chronos just to spruce up the surroundings here?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3801", Text = "Not exactly. I have a delegate in mind." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0185", Text = "Interesting..." },
					},
				},
			},
			OdysseusAboutCosmetics02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" },
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0186",
					PreLineAnim = "Odysseus_Explaining",
					Text = "You've recruited that one shifty-looking Shade for the renewal project! A scrappy start is still a start, I'm... pleased to see it underway!" },
				{ Cue = "/VO/Melinoe_3802", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I thought you might say that! It gives Dora something practical to do. And means the project needn't be a hopeless dream." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0187", Text = "A sound plan, Goddess." },
					},
				},
			},

			OdysseusAboutTable01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_OdysseusTable01a" },
					},
					--[[
					{
						SumPrevRuns = 9,
						Path = { "WorldUpgradesAdded", "Cosmetic_OdysseusTable01a" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0424",
					PreLineAnim = "Odysseus_Explaining",
					Text = "This new table's {#Emph}excellent! {#Prev}Plenty of room for our map of all the regions that we're monitoring, and these side compartments for our new reports, and an elegant finish...!" },
				{ Cue = "/VO/Melinoe_4215", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Odysseus, somehow I'd not expected you to have this much enthusiasm for a piece of furnishing. Especially a piece you strictly need to carry out your duties here." },
				{ Cue = "/VO/Odysseus_0425",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Well, that's quite an accusation... coming from someone who seems to love her work at {#Emph}least {#Prev}as much as I. Or perhaps you've just never had a proper {#Emph}table {#Prev}to your name?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.39,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4216", Text = "I don't use tables much now that you mention it." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0426", Text = "Your loss!" },
					},
				},
			},

			OdysseusAboutMusicPlayer01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeMusicPlayer" },
					},
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsNone = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						PathTrue = { "AudioState", "AmbientTrackName" },
					},
					{
						Path = { "GameState", "UseRecord", "MusicPlayerScreen" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 4,
						Path = { "UseRecord", "MusicPlayerScreen" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 2 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0525",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "It's grown much livelier now with the Music Maker here! A fine choice of recruit for us, Goddess. I was always partial to a rousing battle-ballad, though a variety is welcome, too." },
				{ Cue = "/VO/Melinoe_4224", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I figured that the Music Maker would grow rather popular quite soon. Got any song requests?" },
				{ Cue = "/VO/Odysseus_0526",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "Oh you don't want to know; happy for {#Emph}you {#Prev}to make the hard decisions there!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4225", Text = "And live with the consequences, yes." },
					},
				},
			},
			OdysseusAboutGameStats01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGameStats" },
					},
					{
						Path = { "GameState", "UseRecord", "GameStatsScreen" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 4,
						Path = { "UseRecord", "GameStatsScreen" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 2 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0527",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Our Record Keeper there once worked in a secure Administrative Chamber in your father's halls, if you can believe it, Goddess. Must have been quite the experience!" },
				{ Cue = "/VO/Melinoe_4226", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My father must have prized such analytical minds as that one's. Perhaps once all of this is over, the Record Keeper could return to working in my father's House." },
				{ Cue = "/VO/Odysseus_0528",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "I'd floated that idea myself, to which the Record Keeper cowered, for some reason, and refused to talk to me again! Bit of an odd one, aye?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4227", Text = "Probably been through quite a bit." },
					},
				},
			},

			OdysseusAboutRunProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 50,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 60,
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAll = { "WorldUpgradeBathHouse", "WorldUpgradeGarden", "WorldUpgradeTaverna" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0414",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "You've gone at this for fifty nights at least, Goddess. Is there occasion yet to give yourself a bit of a reprieve? You're putting yourself through a lot is all." },
				{ Cue = "/VO/Melinoe_4202", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've had reprieve along the way, thank you. The springs, the garden, the taverna... even just conversing like this! It's not as though I'm pushing myself in every waking moment." },
				{ Cue = "/VO/Odysseus_0415",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Aye, we never can push ourselves as hard as possible for as long as we'd like. But, you've come a long way, and in the off chance you're not keeping track, I am!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4203", Text = "Good. And I'll go farther still." },
					},
				},
			},
			OdysseusAboutRunProgress02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 100,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 115,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0416",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "This is about your hundredth night, Goddess... several moons at least in mortal terms. Feels like a while, yet no time at all. That's the insidious work of Chronos for you!" },
				{ Cue = "/VO/Melinoe_4204", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think you're right, now that you mention it! The passage of time has always felt strange to me, but even more so since this all began. Did you feel similarly in your mortal days?" },
				{ Cue = "/VO/Odysseus_0417",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Aye, like you have no idea. It must be even stranger for you gods... so much time can pass in the blink of an eye! The best we all can do is use it well." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2222", Text = "Aye..." },
					},
				},
			},

			OdysseusAboutRunProgress03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = ">=",
						Value = 50,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "<=",
						Value = 70,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0710",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "According to our counts, you have prevailed on more than fifty nights now, Goddess. Wanted to take a moment to celebrate that achievement with you." },
				{ Cue = "/VO/Melinoe_5447", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Has it already been that long? Time works in strange ways." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0711", Text = "Aye, we can all agree on that by now." },
					},
				},
			},
			OdysseusAboutRunProgress04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 500,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 515,
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0712",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "It's been five hundred nights since all of this began, Goddess. Well, more or less. In mortal terms... that's quite a while. Perhaps even for you." },
				{ Cue = "/VO/Melinoe_5448", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I ceased keeping track at a certain point, and relinquished any coherent sense of the passage of time. When do you suppose we ought to wind down on all this?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0713", Text = "Whenever you please, and no sooner than that." },
					},
				},
			},

			-- other events
			-- alt below
			OdysseusBackstory02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					--[[
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "OdysseusAboutMood01" }, Min = 2 },
					},
					]]--
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0178",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Come join us, Goddess! I was just regaling the Shades about when first I traveled to the Underworld. Whilst I yet lived and breathed, if you can believe it! And thusly I got out." },
				{ Cue = "/VO/Melinoe_2197", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Come on, Odysseus, there was no escape from here when my father ruled. Are these Shades truly so impressionable?" },
				{ Cue = "/VO/Odysseus_0179",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Oh I'm {#Emph}dead serious! {#Prev}My tales aren't... quite as tall as they may seem! But now, the gates of hell are flung wide open, aren't they...?" },
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
			OdysseusBackstory02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusBackstory02" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					--[[
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "OdysseusAboutMood01" }, Min = 2 },
					},
					]]--
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0178",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Come join us, Goddess! I was just regaling the Shades about when first I traveled to the Underworld. Whilst I yet lived and breathed, if you can believe it! And thusly I got out." },
				{ Cue = "/VO/Melinoe_2197_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Come on, Odysseus. Are these Shades truly so impressionable?" },
				{ Cue = "/VO/Odysseus_0179",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Oh I'm {#Emph}dead serious! {#Prev}My tales aren't... quite as tall as they may seem! But now, the gates of hell are flung wide open, aren't they...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,

						{ Cue = "/VO/Melinoe_5243", Text = "Not for much longer!" },
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
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 6,
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0180",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Odysseus_Drinking_Toast",
					-- Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "{#Emph}Oh! {#Prev}Hail, Goddess, I, {#Emph}erm... {#Prev}didn't notice your approach. Half-inclined to blame the onset of the years, but I've no such excuses in this state." },

				{ Cue = "/VO/Melinoe_2199", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I didn't mean to startle you. How's the mood been around here, everything all right?" },

				{ Cue = "/VO/Odysseus_0181",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Mood and everything is well enough. Our ranks swell with Shades moved by the tale that the Princess of the Underworld has returned, with vengeance on her mind." },

				{ Cue = "/VO/Melinoe_2200", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nothing like a bit of sworn vengeance to inspire the masses. Though, what about you?" },

				{ Cue = "/VO/Odysseus_0182",
					PreLineAnim = "Odysseus_Drinking_Toast",
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

			-- flashback
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
					Portrait = "Portrait_Mel_Child_02",
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

			-- resource donations
			OdysseusGrantsMetaCardPoints01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
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
						Path = { "GameState", "LifetimeResourcesSpent", "MetaCardPointsCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "UseRecord", "MetaCardPointsCommonDrop" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0359",
					PreLineAnim = "Odysseus_Explaining",
					Text = "It isn't much but our Shades out there, they... scraped together some {#Emph}materials {#Prev}that we reckon you could use. Here! Least we can do." },
				{ Cue = "/VO/Melinoe_4093", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Ash of the Dead... Odysseus, are these...? Our Shades are giving up their own mortal remains. All for our cause." },
				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "MetaCardPointsCommon", ResourceAmount = 15, SoundName = "/SFX/AshRewardDrop" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0360", Text = "And who can blame them?" },
					},
				},
			},

			OdysseusGrantsOreFSilver01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
						Comparison = "<=",
						Value = 30,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "OreFSilver" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "PickaxeSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0361",
					PreLineAnim = "Odysseus_Explaining",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Odysseus_Default_01", WaitTime = 7.0 },
					Text = "Back in my mortal days, bronze was the most precious metal that I knew, so quickly could it cut a man's life short. But I've come to understand your appreciation for silver! Go on. Take it! Our Shades and I, we practically insist." },
				{ Cue = "/VO/Melinoe_4094", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Truly? Silver so pure isn't easy to come by, even with the proper tools. I'll make good use of it, for all our sakes." },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "OreFSilver", ResourceAmount = 5, SoundName = "/SFX/KeyPickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0362", Text = "That's all we ask." },
					},
				},
			},

			-- alt below
			OdysseusGrantsPlantFMoly01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "GhostAdmin" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "PlantFMoly" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusGrantsPlantFMoly01_B" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0363",
					Text = "You're on the prowl for ingredients that can go into that pot, aren't you, Goddess? Here, perhaps you can use these. No mere flowers, I've been told." },
				{ Cue = "/VO/Melinoe_4095", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Fresh Molies...! The roots are still perfectly black. Several incantations I've been mulling all would benefit from these. How did you know?" },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "PlantFMoly", ResourceAmount = 2, SoundName = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0364", Text = "{#Emph}Oh{#Prev}, I have my ways." },
					},
				},
			},
			OdysseusGrantsPlantFMoly01_B =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "GhostAdmin" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusGrantsPlantFMoly01" }
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "BiomeVisits", "H" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0363",
					Text = "You're on the prowl for ingredients that can go into that pot, aren't you, Goddess? Here, perhaps you can use these. No mere flowers, I've been told." },
				{ Cue = "/VO/Melinoe_4095", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Fresh Molies...! The roots are still perfectly black. Several incantations I've been mulling all would benefit from these. How did you know?" },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "PlantFMoly", ResourceAmount = 2, SoundName = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0364", Text = "{#Emph}Oh{#Prev}, I have my ways." },
					},
				},
			},

			-- alt below
			OdysseusGrantsMemPointsCommon01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 16,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 350,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MemPointsCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusGrantsMemPointsCommon01_B" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0365",
					PreLineAnim = "Odysseus_Explaining",
					Text = "You'll soon surpass the good witch at your current rate, Goddess! So say some of our Shades at least, and they make a persuasive argument. Here! A symbol of their faith." },
				{ Cue = "/VO/Melinoe_4096", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They would relinquish some of their Psyche, to benefit a task I never could achieve alone..." },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "MemPointsCommon", ResourceAmount = 30, SoundName = "/SFX/Player Sounds/PsycheRewardPickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0366", Text = "Fortunately, you don't have to!" },
					},
				},
			},
			OdysseusGrantsMemPointsCommon01_B =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = "<=",
						Value = 12,
					},
					{
						Path = { "GameState", "MetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 60,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MemPointsCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusGrantsMemPointsCommon01" }
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "BiomeVisits", "H" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0365",
					PreLineAnim = "Odysseus_Explaining",
					Text = "You'll soon surpass the good witch at your current rate, Goddess! So say some of our Shades at least, and they make a persuasive argument. Here! A symbol of their faith." },
				{ Cue = "/VO/Melinoe_4096", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They would relinquish some of their Psyche, to benefit a task I never could achieve alone..." },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "MemPointsCommon", ResourceAmount = 30, SoundName = "/SFX/Player Sounds/PsycheRewardPickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0366", Text = "Fortunately, you don't have to!" },
					},
				},
			},

			OdysseusGrantsMetaCurrency01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MarketScreen" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeMarket" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
						Comparison = ">=",
						Value = 50,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
						Comparison = "<=",
						Value = 1000,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0367",
					PreLineAnim = "Odysseus_Explaining",
					Text = "A bit of something for you here, Goddess. The gift of skeletal remains would not be looked on favorably back where I come from, but then... you've more respect for the dead than mortals generally did." },
				{ Cue = "/VO/Melinoe_4097", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "More Bones than I can quickly count, or locate on my own. Then I shall leave them in the Wretched Broker's care!" },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "MetaCurrency", ResourceAmount = 80, SoundName = "/SFX/BoneRewardPickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0368", Text = "And get yourself a fair deal in exchange." },
					},
				},
			},

			-- alt below
			OdysseusGrantsMetaFabric01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						SumPrevRuns = 3,
						Path = { "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaFabric" },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaFabric" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaFabric" },
						Comparison = "<=",
						Value = 50,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusGrantsMetaFabric01_B" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0369",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "I'm not the sort to dwell too much about what the Three Fates may have in store for us, Goddess, but... I do have a bit of Fabric we attribute to their work. And now it's yours." },
				{ Cue = "/VO/Melinoe_4098", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Fate Fabric! Few better ways to ensure the cauldron properly conducts a magickal effect. I could definitely use this if you'd be so kind." },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "MetaFabric", ResourceAmount = 2, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Explaining",
						{ Cue = "/VO/Odysseus_0370", Text = "Oh I'm not {#Emph}kind{#Prev}, I just... don't like to lose." },
					},
				},
			},
			OdysseusGrantsMetaFabric01_B =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeMorosUnlock" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaFabric" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaFabric" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaFabric" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaFabric" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "OdysseusGrantsMetaFabric01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0369",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "I'm not the sort to dwell too much about what the Three Fates may have in store for us, Goddess, but... I do have a bit of Fabric we attribute to their work. And now it's yours." },
				{ Cue = "/VO/Melinoe_4098", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Fate Fabric! Few better ways to ensure the cauldron properly conducts a magickal effect. I could definitely use this if you'd be so kind." },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "MetaFabric", ResourceAmount = 2, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Explaining",
						{ Cue = "/VO/Odysseus_0370", Text = "Oh I'm not {#Emph}kind{#Prev}, I just... don't like to lose." },
					},
				},
			},

			OdysseusGrantsCardUpgradePoints01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = "<=",
						Value = 50,
					},
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "~=",
						Value = 5,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0371",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Beautiful night, isn't it? The kind where one may catch brief glimpses of the Moon amid her race across the sky. She even left a little something for you here." },
				{ Cue = "/VO/Melinoe_4099", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Moon Dust. You've no idea how much I could use this in my meditations recently...! Although you always have an idea, don't you?" },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 3, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Salute",
						{ Cue = "/VO/Odysseus_0372", Text = "One, at the very least." },
					},
				},
			},

			OdysseusGrantsSeedMystery01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGardenT3" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeGardenT3" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift03" },
					},
					{
						Path = { "GameState", "HarvestSuccesses" },
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "SeedMystery" },
						Comparison = "<=",
						Value = 50,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0373",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "Got something here for you, Goddess. For whenever our little garden over there could use a little extra greenery... or if you're ever left unsure about what to plant next." },
				{ Cue = "/VO/Melinoe_4100", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Thank you, Odysseus! But, what are these? I try to keep whatever seeds I find well-organized." },
				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "SeedMystery", ResourceAmount = 3, SoundName = "/SFX/TrashPickup" },
				-- EndFunctionArgs = { ResourceName = "SeedMystery", ResourceAmount = 3, SoundName = "/SFX/TrashPickup", AllowOnAddVoiceLines = true },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0374", Text = "Mystery Seeds! A little surprise." },
					},
				},
			},
			OdysseusGrantsFamiliarPoints01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "FamiliarsUnlocked" },
						CountOf =
						{
							"FrogFamiliar",
							"RavenFamiliar",
							"CatFamiliar",
							"HoundFamiliar",
							"PolecatFamiliar",
						},
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FamiliarPoints" },
						Comparison = "<=",
						Value = 30,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0375",
					PreLineAnim = "Odysseus_Explaining",
					Text = "Our Shades report good things about your Animal Familiars, you know. Not all such creatures get on well with spirits of the dead, so... here's a little token of appreciation!" },
				{ Cue = "/VO/Melinoe_4101", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Witch's Delight, cooked to perfection. Headmistress must have made this batch herself... does she know you're giving this to me?" },
				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 2, SoundName = "/SFX/CrappyRewardPickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0376", Text = "Just take the blasted gifts, Goddess, the Shades insist!" },
					},
				},
			},
			OdysseusGrantsGiftPoints01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Odysseus",
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
						Comparison = "<=",
						Value = 30,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusResourceEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0629",
					PreLineAnim = "Odysseus_Salute",
					Text = "I have an offering for you, Goddess! On behalf of all the Shades residing here, we are honored to be in your service and stand ready to do whatever it takes to prevail! Please share these spoils with whomever you see fit." },
				{ Cue = "/VO/Melinoe_5230", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Some Nectar, thank you! I feel like one of the gods of Olympus right now. You truly won't mind if I pass these bottles along?" },
				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "GiftPoints", ResourceAmount = 2, SoundName = "/SFX/GiftAmbrosiaBottlePickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_KnifeToss",
						{ Cue = "/VO/Odysseus_0630", Text = "The Shades and I would only mind if you hoarded them." },
					},
				},
			},

			-- update OdysseusResourceEvents when adding more

			-- partner conversations
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Explaining",
					Text = "According to my confidants, they've all sworn in with Chronos, I'm afraid. Mortals... they often want whatever they don't have. Another Golden Age, in this case. The {#Emph}promise {#Prev}of one." },
				{ Cue = "/VO/Hecate_0202", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "'Tis a {#Emph}lie {#Prev}that spurs their betrayal, rather than a promise. They shall perish, then... by the wrath of the gods." },
				{ Cue = "/VO/Odysseus_0043",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "OdysseusWithHecate01" }, Min = 4 },
					},
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
			OdysseusWithHecate03 =
			{
				Partner = "NPC_Hecate_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PlayOnce = true,
				UseText = "UseListenNPC",
				-- StatusAnimation = false,
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 566620,
				-- TeleportOffsetX = 200,
				-- TeleportOffsetY = -300,
				InteractDistance = 450,
				{ Cue = "/VO/Odysseus_0708",
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "...In short, the reconstruction is proceeding, though not at a brisk pace, and the damage on the surface is contained. Wounds that shall slowly heal. We'll see what scars remain." },
				{ Cue = "/VO/Hecate_0881", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "Sister Selene makes a similar assessment. Well, then... what shall you do from here, Odysseus? You could visit the surface whilst the Underworld remains in disrepair." },
				{ Cue = "/VO/Odysseus_0709",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Oh I may wander for a bit, Madam, but... by your leave, I'd like to keep the Crossroads as my base of operations for the time. I reckon we've a good thing going here, don't we?" },
				EndVoiceLines =
				{
					PreLineWait = 0.38,
					ObjectType = "NPC_Hecate_01",
					PreLineAnim = "HecateHubGreet",
					{ Cue = "/VO/Hecate_0882", Text = "I daresay yes we do." },
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
					PreLineAnim = "Odysseus_Explaining",
					Text = "...I'm saying that the possibility exists. Eternal vigilance is near impossible. Enemies have always exploited the lack thereof... I ever tell you of the old wooden horse trick?" },
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
			IcarusWithOdysseus01 =
			{
				Partner = "NPC_Icarus_01",
				PartnerVariant = "IcarusHome",
				PlayOnce = true,
				StatusAnimation = false,
				AngleTowardTargetId = 800098,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			IcarusWithOdysseus02 =
			{
				Partner = "NPC_Icarus_01",
				PartnerVariant = "IcarusHome",
				PlayOnce = true,
				-- StatusAnimation = false,
				AngleTowardTargetId = 800098,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},

			-- Repeatable
			OdysseusChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0004",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You watch your back out there, all right?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0005",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Ready to take another stab at this, Goddess?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					}
				},

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
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Got everything here well under control." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat05 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0008",
					PreLineAnim = "Odysseus_Explaining",
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
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Quite a mess we've gotten ourselves into, haven't we?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat08 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0011",
					Text = "I know things must seem dire, but take heart. We'll navigate through this." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusChat09 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				{ Cue = "/VO/Odysseus_0012",
					Text = "Any luck finding the head of Chronos yet?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusChat10 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0013",
					PreLineAnim = "Odysseus_KnifeToss",
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
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0015",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Death to Chronos and all that, aye?" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0016",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Beg pardon, Goddess, I must get this correspondence to the surface right away." },
			},
			OdysseusChat14 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",

				{ Cue = "/VO/Odysseus_0017",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Fresh shipment of supplies came in whilst you were out." },
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
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Odysseus_0019",
					Text = "We've many sympathizers on the surface and below still loyal to your father." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusChat17 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0020",
					PreLineAnim = "Odysseus_KnifeToss",
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
					Text = "{#Emph}Eh{#Prev}, would that we could talk like this a while, but I've a matter to resolve." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat20 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0023",
					PreLineAnim = "Odysseus_Explaining",
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
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You come back safely, else I'll have to venture out there and haul you in myself." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat23 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,

				{ Cue = "/VO/Odysseus_0026",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "You'll have your vengeance, Goddess. I am sure of it." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
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
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
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
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0325",
					Text = "Our Shades shall keep us well apprised of your progress." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},
			OdysseusChat31 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift04" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0326",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
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
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
				{ Cue = "/VO/Odysseus_0327",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "We'll back you on this every step of the way, as many nights as it requires, Goddess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.OdysseusGreeting,
			},

			OdysseusTavernaChat01 =
			{
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0477",
					-- PreLineAnim = "Odysseus_Drinking_LemonSpin_Full",
					-- PreLineAnim = "Odysseus_Drinking_LemonSpin_Start",
					-- PostLineAnim = "Odysseus_Drinking_LemonSpin_End",
					-- PreLineAnim = "Odysseus_Drinking_Sip",
					-- PreLineAnim = "Odysseus_Drinking_Toast",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Even I get a break from time to time, as should {#Emph}you!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusTavernaChat02 =
			{
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0478",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Just having a quick drink here with our fellow Shades." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusTavernaChat03 =
			{
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0479",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Turns out I can take reports in the taverna here, Goddess!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusTavernaChat04 =
			{
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0480",
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "Lively bunch we've got for a bunch of deadbeats, aye?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusTavernaChat05 =
			{
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 3 },
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0481",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "You see that, lads? I told you she'd turn up!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
			},
			OdysseusTavernaChat06 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				-- taverna
				SkipContextArt = true,
				TeleportToId = 589482,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = GameData.OdysseusTavernaEvents, Min = 3 },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "OdysseusAtTaverna",

				{ Cue = "/VO/Odysseus_0482",
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "Stick around a bit, Goddess! You've earned some rest." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Odysseus",
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
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey Odysseus? Got you something here I wanted you to have. For always keeping an eye out!" },
				{ Cue = "/VO/Odysseus_0087",
					PreLineAnim = "Odysseus_Explaining",
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
						-- PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01" },
					},
				},
				{ Cue = "/VO/Odysseus_0088",
					Text = "I'm most grateful, Goddess, and expect to knock this back at the taverna at the soonest opportunity." },
				{ Cue = "/VO/Melinoe_0473", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No rush! Just as long as you enjoy it when that opportunity presents itself!" },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift02" },
					},
				},
				{ Cue = "/VO/Odysseus_0089",
					Text = "Well, would you look at that! How could I possibly say no? It seems you've found my weakness here, Goddess." },
				{ Cue = "/VO/Melinoe_0474", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
						-- PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift03" },
					},
				},
				{ Cue = "/VO/Odysseus_0090",
					Text = "I ought to be the one honoring {#Emph}you{#Prev}, Goddess. My inclination is to save this for the moment of our victory, but it's good to have in reserve, in case of some emergency, you understand." },
				{ Cue = "/VO/Melinoe_0475", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I understand, indeed! And you already honor me with your friendship, Odysseus... as well as with your knowledge about how to deal swift death!" },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift04" },
					},
				},
				{ Cue = "/VO/Odysseus_0091",
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "Oh {#Emph}I see {#Prev}what you're up to, here, Goddess! If you continue to exploit my weakness to this stuff, I may yet learn to turn it to a strength. Good plan!" },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift05" },
					},
				},
				{ Cue = "/VO/Odysseus_0653",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "You know, I journeyed far and wide throughout my mortal days, meeting great mortals and even greater gods, but... never could I have imagined ending up here, only to receive such a handsome gift from one such as you." },
				{ Cue = "/VO/Melinoe_0477", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They say life takes strange turns, and so apparently does death, Odysseus. Whatever the Fates may have in store, I hope you'll always be nearby to lend your counsel." },
				{ Cue = "/VO/Odysseus_0654",
					PreLineAnim = "Odysseus_Pensive_End",
					Text = "Well I do like to travel, but... I think you'll always know where to find me. Cheers for the Nectar... should last me through whatever hard times are to come." },
			},
			OdysseusGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_OdysseusUnlockHint01",
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
						HasAll = { "OdysseusAboutAssistance01", "OdysseusGift06", "OdysseusBathHouse02", "OdysseusTaverna01", "OdysseusFishing01" },
					},
				},
				{ Cue = "/VO/Melinoe_5083", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey how about a visit to the taverna if you're not overly preoccupied right now? This Ambrosia here needs opening!" },

				{ Cue = "/VO/Odysseus_0545",
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "That it most certainly does, but, and this pains me to say, I've too many reports right now requiring verification. A lot's been going on. So... perhaps later?" },

				{ Cue = "/VO/Melinoe_5084", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about you hold onto the bottle then? {#Emph}Later {#Prev}can be whenever you desire. Your Shade informants could even come along!" },

				{ Cue = "/VO/Odysseus_0546",
					PreLineAnim = "Odysseus_Explaining",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Hah{#Prev}, there's a thought! I'd likely never hear from them again. Though that would {#Emph}also {#Prev}mean I could visit the taverna more often..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5085", Text = "The makings of a plan...!" },
					},
				},

			},
			OdysseusGift08 =
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusTaverna02", "OdysseusGift07" },
					},
				},
				{ Cue = "/VO/Melinoe_5092", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What would you say to a productive evening of inspiring more loyalty over at the taverna again? I enjoy our conversations there." },

				{ Cue = "/VO/Odysseus_0553",
					PreLineAnim = "Odysseus_Pensive_Start",
					Text = "I {#Emph}would {#Prev}say let's be off immediately, but I {#Emph}must {#Prev}say, I'm anticipating word from an informant soon and so need to stay put... I also mean... to visit the taverna somewhat less." },

				{ Cue = "/VO/Melinoe_5093", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh! {#Prev}I apologize. It's not been my intent to keep attempting to draw you away from your responsibilities." },

				{ Cue = "/VO/Odysseus_0554",
					PreLineAnim = "Odysseus_Pensive_End",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "It's nothing that you did, it's just... I knew the sorts who spent their days and nights feasting, taking leave of their senses. I swore never to be so indulgent. To always leave {#Emph}some {#Prev}of my desires unfulfilled." },

				{ Cue = "/VO/Melinoe_5094", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I understand the feeling. To yearn for something is a driving force. Though, how about we give this bottle to your informant? For a duty well-performed." },

				{ Cue = "/VO/Odysseus_0555",
					PreLineWait = 0.25,
					PreLineAnim = "Odysseus_KnifeToss",
					Text = "An excellent tactical choice. I'll tell them it was courtesy of the Princess of the Underworld herself!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5095", Text = "I'd rather it be from both of us." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0556", Text = "{#Emph}Hah. {#Prev}Fine." },
					},
				},

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
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3342", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If you're not too caught up in your reports right now, what do you say we put this bottle of Ambrosia to its proper use?" },

				{ Cue = "/VO/Odysseus_0280",
					PostLineRemoveContextArt = true,
					PreLineAnim = "Odysseus_Explaining",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					Text = "I {#Emph}am {#Prev}caught up in my reports, Goddess! Focused on what matters most... meet you at the taverna." },

				{ Cue = "/VO/Odysseus_0281",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineFunctionArgs = { IsOdysseus = true },
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "...We mortals had what we called {#Emph}wine{#Prev}, an acrid sort of drink made of crushed {#Emph}grapes{#Prev}. We'd sometimes say it tasted as good as Ambrosia, but... it most certainly did not." },

				{ Cue = "/VO/Melinoe_3343", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You speak of so many hardships from your mortal days and nights and yet, there's always this sense of longing there... you miss those times, don't you?" },

				{ Cue = "/VO/Odysseus_0282",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Drinking_Sip",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PreLineWait = 0.35,
					Text = "...Such moments and occasions do occur. I know a lot more {#Emph}now {#Prev}than I did then, and... sometimes I miss that feeling... knowing less. Or the camaraderie of sailing with my crew." },

				{ Cue = "/VO/Melinoe_3344", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But many of your crew are with you here now, right? Even the Shade of your old dog. How can you miss them if they're still around?" },

				{ Cue = "/VO/Odysseus_0283",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Drinking_Sip",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "We're Shades, Goddess, and... not all quite as whole as I. Besides, you still can miss your past with those you still know now! Remember when you used to play at hiding with our good witch, back when you were very small?" },

				{ Cue = "/VO/Melinoe_3345", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I never thought that we were playing; she was teaching me to hunt for unseen prey. But, I {#Emph}do {#Prev}see your point." },

				{ Cue = "/VO/Odysseus_0284",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Drinking_Toast",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "Well my original point was merely that this Ambrosia's {#Emph}really {#Prev}something else! Let us ensure it does not go to waste." },

				{ Cue = "/VO/Odysseus_0285",
					PreLineAnim = "Odysseus_Greet",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineFunctionArgs = { IsOdysseus = true },
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
			OdysseusTaverna02 =
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
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift07" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_5086", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How go the reports this evening, or rather, do you have occasion for a taverna break perhaps?" },

				{ Cue = "/VO/Odysseus_0547",
					PostLineRemoveContextArt = true,
					PreLineAnim = "Odysseus_KnifeToss",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					Text = "Reckon I could join you for just such an occasion, now that you raise the possibility, Goddess. You ready now?" },

				{ Cue = "/VO/Odysseus_0548",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineFunctionArgs = { IsOdysseus = true },
					PreLineWait = 0.35,
					PreLineAnim = "Odysseus_Drinking_Toast",
					Text = "...I fought alongside quite a number of these Shades, you know. Loyal in life as well as now in death... where do you suppose that comes from? Loyalty, I mean." },

				{ Cue = "/VO/Melinoe_5087", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Having a sense of purpose or a cause. And, a basic desire for stability and truth. Loyalty is consistency." },

				{ Cue = "/VO/Odysseus_0549",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Drinking_Sip",
					PreLineWait = 0.35,
					Text = "Aye to all that, but it is even simpler to me! Loyalty comes from individuals. It's like a form of love; some give it, some receive it, sometimes it's mutual, sometimes it's not." },

				{ Cue = "/VO/Melinoe_5088", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Headmistress always taught me never to demand loyalty. {#Emph}Loyalty wears thin if not for trust{#Prev}, she'd say. Did your fellow Shades follow you out of loyalty or obligation?" },

				{ Cue = "/VO/Odysseus_0550",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Drinking_Sip",
					Text = "{#Emph}Hm! {#Prev}A mix of each. The good witch is right that the best kind of loyalty is given. I reckon {#Emph}you {#Prev}inspire {#Emph}that {#Prev}sort, Goddess; the both of you. I'd not have stayed here this long otherwise." },

				{ Cue = "/VO/Melinoe_5089", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Chronos certainly could have used someone of your skill and experience. With all his promises of a new Golden Age, surely he commands quite a bit of loyalty himself." },

				{ Cue = "/VO/Odysseus_0551",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Drinking_Toast",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },
					Text = "I tried serving tyrants before; wasn't for me. Now, what do you say we inspire some more loyalty {#Emph}right now? {#Prev}Let's have these Shades come join us for a round." },

				{ Cue = "/VO/Odysseus_0552",
					PreLineAnim = "Odysseus_KnifeToss",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineFunctionArgs = { IsOdysseus = true },
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					Text = "How is it that we got so much done on what was meant to be a break? Anyhow, the Shades were grateful! As am I." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5091", Text = "We should do it again!" },
					},
				},

			},

			OdysseusFishing01 =
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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift02" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0470", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Got these Twin Lures, Odysseus, and I can't exactly use them on my own. You know the rules!" },

				{ Cue = "/VO/Odysseus_0066",
					PreLineAnim = "Odysseus_Greet",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					Emote = "PortraitEmoteFiredUp",
					PostLineRemoveContextArt = true,
					Text = "{#Emph}Fishing! {#Prev}My greatest weakness, Goddess! The waters and I haven't always mixed, but perhaps it'll go better for me now. Besides, I'm overdue for a short leave. Let's go!" },

				{ Cue = "/VO/Odysseus_0251",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					Text = "Used to be I fished out of necessity alone. The earth would oft be stingy with her bounties, whilst the sea would yield plenty to us mortals, if we knew where to look." },

				{ Cue = "/VO/Melinoe_3322", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineAnim = "MelTalkBrooding01", PostLineAnimTarget = "Hero",
					Text = "What's been the biggest difference for you since those times? Not having to eat for sustenance? Not having to watch your mortal body slowly fall apart as you grew older?" },

				{ Cue = "/VO/Odysseus_0252",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Greet",
					Text = "{#Emph}Heh{#Prev}, well! You already know a couple of those points if for some reason we were tasked to make a list, but... the biggest difference, if I had to choose, is that... I finally am free." },

				{ Cue = "/VO/Melinoe_3323", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
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
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "I thoroughly enjoyed our outing, though I still thoroughly hate fish." },
			},
			-- bond forged
			OdysseusFishing02 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				OnGiftTrack = true,
				CompletedHintId = "Codex_BondForgedOdysseus",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift08", "OdysseusTaverna02" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_5096", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Hey what if we stop by the fishing pier again? It's been a while, and standing patiently is far less indulgent than sipping Ambrosia, right?" },

				{ Cue = "/VO/Odysseus_0557",
					PreLineAnim = "Odysseus_KnifeToss",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "You make a compelling argument, Goddess! And, I ought to confront my {#Emph}discomfort {#Prev}with the waters more. Head on over and I'll be there soon." },

				{ Cue = "/VO/Odysseus_0558",
					PreLineWait = 0.4,
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					Text = "...Something I should tell you, by the way. These times we spend together, which I thoroughly enjoy, I... wouldn't want the other Shades to get the wrong impression." },

				{ Cue = "/VO/Melinoe_5097", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "And what impression would that be? {#Emph}Oh{#Prev}, you mean their mortal preconceptions. A man and a goddess together can only mean one thing. End up one way." },

				{ Cue = "/VO/Odysseus_0559",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Salute",
					Text = "Well yes, but it's a preconception rooted in events that have occurred... including to me. And even though our Shades are {#Emph}loyal{#Prev}, they {#Emph}do {#Prev}like to gossip, we know that." },

				{ Cue = "/VO/Melinoe_5098", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					SkipContextArt = true,
					Text = "I suppose. If anything they ought be gossiping about Headmistress and yourself, rather than us." },

				{ Cue = "/VO/Odysseus_0560",
					Emote = "PortraitEmoteSurprise",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Explaining",
					Text = "{#Emph}What? {#Prev}Oh come on, Goddess, the good witch and I... we're like... oh blast, there must be {#Emph}some {#Prev}appropriate analogy..." },

				{ Cue = "/VO/Melinoe_5099", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I didn't mean to overreach, it's just... well, I can think of many reasons that Headmistress would inspire loyalty in someone such as you. And you in her." },

				{ Cue = "/VO/Odysseus_0561",
					SkipContextArt = true,
					PreLineAnim = "Odysseus_Pensive_Start",
					PostLineAnim = "Odysseus_Pensive_End",
					Text = "{#Emph}Augh{#Prev}, you're as bad as those gossiping Shades, except I can't have {#Emph}you {#Prev}banished for your conduct. Now, what do you say we scoop some fish out of these waters, aye?",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Odysseus_0562",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFLegendary", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Odysseus_01", Icon = "Keepsake_Odysseus", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostFishingArgs },

					Text = "...{#Emph}Ah. {#Prev}It's been good to chat away a bit instead of having to give counsel all the time, so cheers for that, Goddess. But, don't tell the good witch or anyone what you told me...?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5100", Text = "I won't, I won't..." },
					},
				},
			},

			OdysseusBathHouse01 =
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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift04" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0462", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "I was just thinking nothing clears the mind like a refreshing, burning-hot soak. Care to accompany me?" },

				{ Cue = "/VO/Odysseus_0655",
					PreLineAnim = "Odysseus_Greet",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Oh, I do enjoy a good relaxing bath, even whilst dead, and who am I to say no to a goddess... so why not!" },

				{ Cue = "/VO/Odysseus_0656",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "I know your customs and mine aren't quite the same, but my eyes are going to remain averted here, if that's all right."
				},

				{ Cue = "/VO/Melinoe_0464", UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Would mortals often {#Emph}bathe{#Prev}, Odysseus?" },

				{ Cue = "/VO/Odysseus_0657", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "Oh, {#Emph}erm{#Prev}, well... perhaps once in a while, when they could. Though, seldomly both men and women at the same time. Doing so could seem... untoward." },

				{ Cue = "/VO/Melinoe_0465", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I see. We gods have no such shame, I realize. Have I made you uncomfortable?" },

				{ Cue = "/VO/Odysseus_0658", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Emote = "PortraitEmoteSurprise",
					Text = "Me? No, no, of course not! In fact I've bathed with goddesses before, it's just... it's been a little while." },

				{ Cue = "/VO/Melinoe_5242", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Oh that's all right, doubtless you'll recall the finer points. You mostly just have to try and let go your burdens." },

				{ Cue = "/VO/Odysseus_0659", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "Should be simple, as I've many of those! In fact no matter how many I let go, it seems some yet remain. Though being here does help." },

				{ Cue = "/VO/Melinoe_0466", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },
					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "Well... as long as it's agreeable for you." },

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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift05" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
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
					Text = "You've met many goddesses even in your mortal days, haven't you...?" },
				{ Cue = "/VO/Odysseus_0060", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Text = "In this I'm very fortunate, indeed. The lady Athena often watched over me. I'd never have survived the war if not for her. Then, on my travels home, there was Calypso... and Circe..." },
				{ Cue = "/VO/Melinoe_3217", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Circe used to study under Headmistress, always with her crystals. And Calypso... she's a Nymph, correct? A lesser goddess I suppose." },
				{ Cue = "/VO/Odysseus_0061", Portrait = "Portrait_Odysseus_Bath_01",
					PortraitExitAnimation = "Portrait_Odysseus_Bath_01_Exit",
					Emote = "PortraitEmoteSurprise",
					Text = "Nothing lesser about her, with respect. These goddesses, they... enthralled me each in their own right. Almost made me forget myself. Forget my family." },
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = GameData.OdysseusTavernaEvents, },
					},
				},
				{ Cue = "/VO/Melinoe_0460", UsePlayerSource = true,
					Text = "Odysseus, how about alleviating the rigors of all this tactical planning with a visit to the springs?" },
				{ Cue = "/VO/Odysseus_0046",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "{#Emph}Erm, {#Prev}I really do appreciate the offer, Goddess, just... I reckon your Headmistress would rather I stay here. You understand, don't you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},
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
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "PreviousDeathAreaRoom", "Name" },
						IsNone = { "Hub_PreRun" },
					},
					NamedRequirementsFalse = { "OdysseusWandering" },
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1156", Text = "Odysseus on leave..." },
				{ Cue = "/VO/Melinoe_2412", Text = "Odysseus out checking on reports...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2413", Text = "Odysseus must be needed elsewhere...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01", },
						},
					}
				},
				{ Cue = "/VO/Melinoe_1157", Text = "Odysseus is on assignment huh?",
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

-- Global Odysseus Lines
GlobalVoiceLines.OdysseusSongReactionVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 2.5,
	ObjectType = "NPC_Odysseus_01",
	PreLineAnim = "Odysseus_Drinking_Sip",
	RecheckRequirementsPostWait = true,
	GameStateRequirements =
	{
		{
			FunctionName = "RequiredQueuedTextLine",
			FunctionArgs = { IsAny = GameData.OdysseusTavernaEvents, },
		},
		{
			Path = { "AudioState", "AmbientTrackName" },
			IsAny = {
				-- "/Music/MusicPlayer/Iris/IrisMusicScylla1MusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla1bMusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla2MusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla2bMusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla3MusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla3bMusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla4MusicPlayer",
				"/Music/MusicPlayer/Iris/IrisMusicScylla4bMusicPlayer",
			},
		},
		{
			Path = { "ConfigOptionCache", "MusicVolume" },
			Comparison = ">",
			Value = 0.1,
		},
	},

	{ Cue = "/VO/Odysseus_0566", Text = "Scylla and the Sirens...", PlayFirst = true },
	{ Cue = "/VO/Odysseus_0312", Text = "Blast..." },
	{ Cue = "/VO/Odysseus_0475", Text = "{#Emph}Euuugh... " },
	{ Cue = "/VO/Odysseus_0476", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Odysseus_0504", Text = "{#Emph}Ooh {#Prev}good." },
}

GlobalVoiceLines.OdysseusPreDamageVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.75,
		Source = { LineHistoryName = "NPC_Odysseus_01", SubtitleColor = Color.OdysseusVoice },

		{ Cue = "/VO/Odysseus_0439", Text = "We play to {#Emph}win!", PlayFirst = true },
		{ Cue = "/VO/Odysseus_0440", Text = "Whatever it takes." },
		{ Cue = "/VO/Odysseus_0441", Text = "Let's even the odds." },
		{ Cue = "/VO/Odysseus_0442", Text = "Fight to survive!" },
		{ Cue = "/VO/Odysseus_0443", Text = "Seize victory!" },
		{ Cue = "/VO/Odysseus_0444", Text = "We {#Emph}never {#Prev}hesitate!" },
		{ Cue = "/VO/Odysseus_0445", Text = "Ahoy again, Scylla!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "G_Boss01", "G_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Odysseus_0446", Text = "Remember me, Cyclops?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Boss01", "N_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Odysseus_0447", Text = "{#Emph}Get him{#Prev}, Goddess!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Odysseus_0448", Text = "You have this, {#Emph}go!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
	},
	{ GlobalVoiceLines = "OdysseusLaughVoiceLines" },
}

GlobalVoiceLines.OdysseusLaughVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Odysseus_01", SubtitleColor = Color.OdysseusVoice },

	{ Cue = "/VO/Odysseus_0106", Text = "{#Emph}<Chuckle>" },
	{ Cue = "/VO/Odysseus_0107", Text = "{#Emph}<Chuckle>" },
	{ Cue = "/VO/Odysseus_0108", Text = "{#Emph}<Laugh>" },
	{ Cue = "/VO/Odysseus_0109", Text = "{#Emph}<Laugh>" },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Odysseus )