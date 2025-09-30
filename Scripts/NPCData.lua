PresetEventArgs =
{
	ChronosGreeting =
	{
		WithinDistance = 950,
		VoiceLines =
		{
			{
				PlayOnce = true,
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
					},
				},

				{ Cue = "/VO/MelinoeField_0116", Text = "Is that...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "ChronosFirstAppearance" },
				{ Cue = "/VO/MelinoeField_0113", Text = "He's there..." },
				{ Cue = "/VO/MelinoeField_0114", Text = "He's back..." },
				{ Cue = "/VO/Melinoe_0094", Text = "You!", PlayFirst = true,
					GameStateRequirements = 
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0115", Text = "The Titan...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0162", Text = "Chronos...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0165", Text = "Chronos...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3247", Text = "Just ignore him...", PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "UseRecord", "Chronos" },
							Comparison = ">=",
							Value = 6,
						},
						{
							PathTrue = { "GameState", "EnemyKills", "Chronos" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3248", Text = "Ignore him...", PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/MelinoeField_3247" },
						},
					}
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",

				{ Cue = "/VO/Chronos_0008", Text = "Greetings, little one." },
				{ Cue = "/VO/Chronos_0024", Text = "How fare you, little one?" },
				{ Cue = "/VO/Chronos_0025", Text = "You." },
				{ Cue = "/VO/Chronos_0027", Text = "There you are." },
				{ Cue = "/VO/Chronos_0028", Text = "Just in time." },
				{ Cue = "/VO/Chronos_0029", Text = "Greetings." },
				{ Cue = "/VO/Chronos_0033", Text = "Returned, have you?" },
				{ Cue = "/VO/Chronos_0783", Text = "Right on Time." },
				{ Cue = "/VO/Chronos_0784", Text = "Headed down?" },
				{ Cue = "/VO/Chronos_0785", Text = "Conspicuous." },
				{ Cue = "/VO/Chronos_0790", Text = "Out of the woods?" },
				{ Cue = "/VO/Chronos_0791", Text = "What a coincidence." },
				{ Cue = "/VO/Chronos_0007", Text = "A word, if you please?", PlayFirst = true,
					PlayOnce = true, PlayOnceContext = "ChronosFirstGreeting",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0009", Text = "{#Emph}Ah{#Prev}, there you are.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0907", Text = "Not quite as roomy here...",
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossSellTraitShops" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0782", Text = "Again?",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
						},
					},
				},
				{ Cue = "/VO/Chronos_0786", Text = "Scheming girl.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "Chronos" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0787", Text = "Do keep this up.",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
						},
					},
				},
				{ Cue = "/VO/Chronos_0788", Text = "How irritating.",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
						},
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Chronos_0789", Text = "{#Emph}<Scoff>",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
						},
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Chronos_0792", Text = "Wearing protective silk...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "Chronos" },
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0793", Text = "What a fine dress you have!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "UseRecord", "NPC_Chronos_01" },
							Comparison = ">=",
							Value = 6,
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0794", Text = "{#Emph}Ooh {#Prev}I like your dress.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "UseRecord", "NPC_Chronos_01" },
							Comparison = ">=",
							Value = 6,
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0795", Text = "A change of attire?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "UseRecord", "NPC_Chronos_01" },
							Comparison = ">=",
							Value = 6,
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0796", Text = "Not in your usual attire.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 6,
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0797", Text = "Enchanted silk again.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/Chronos_0792" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "Chronos" },
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0026", Text = "Granddaughter.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosPostBattleMeeting01" },
						},
					},
				},
			},
		},
	},
	ChronosNightmareGreeting =
	{
		WithinDistance = 1100,
		ScaleY = 0.75,
		LockToCharacter = true,

		VoiceLines =
		{
			{
				UsePlayerSource = true,
				{ Cue = "/VO/Hades_0020", Text = "No..." },
			},
			{
				PreLineWait = 0.5,
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				{ Cue = "/VO/Chronos_0055", Text = "Hello, Hades..." },
			},
		}
	},

	NeoChronosGreeting =
	{
		WithinDistance = 1150,
		FunctionName = "NeoChronosAppear",
		VoiceLines =
		{
			{
				SuccessiveChanceToPlayAll = 0.8,
				RandomRemaining = true,
				PreLineAnim = "NPC_Chronos_Enlightened_Greet",
				Cooldowns =
				{
					{ Name = "ChronosAnyQuipSpeech", Time = 8 },
				},

				{ Cue = "/VO/Chronos_1094", Text = "Just in time.", PlayFirst = true },
				{ Cue = "/VO/Chronos_1092", Text = "Granddaughter." },
				{ Cue = "/VO/Chronos_1093", Text = "There you are." },
				{ Cue = "/VO/Chronos_1095", Text = "Greetings." },
				{ Cue = "/VO/Chronos_1355", Text = "Good evening!" },
				{ Cue = "/VO/Chronos_1359", Text = "Oh good!" },
				{ Cue = "/VO/Chronos_1360", Text = "Onward!" },
				{ Cue = "/VO/Chronos_1363", Text = "Out of the woods!" },
				{ Cue = "/VO/Chronos_1091", Text = "How fare you, little one?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift04" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1356", Text = "{#Emph}Ah{#Prev}, hello!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift04" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1357", Text = "You return!",
					GameStateRequirements =
					{
						{
							SumPrevRuns = 3,
							Path = { "BiomesReached", "N" },
							IgnoreCurrentRun = true,
							CountPathTrue = true,
							Comparison = "==",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/Chronos_1358", Text = "You are back!",
					GameStateRequirements =
					{
						{
							SumPrevRuns = 3,
							Path = { "BiomesReached", "N" },
							IgnoreCurrentRun = true,
							CountPathTrue = true,
							Comparison = "==",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/Chronos_1361", Text = "{#Emph}Ooh {#Prev}I like your dress.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1094" },
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_1362", Text = "What a fine dress you have!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1094" },
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
			},
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 8 },
				},

				{ Cue = "/VO/MelinoeField_4193", Text = "Hello Grandfather..." },
				{ Cue = "/VO/MelinoeField_4194", Text = "Grandfather...", PlayFirst = true },
			},
		},
	},

	HecateFirstGreeting =
	{
		WithinDistance = 1300,
		ScaleY = 0.65,
		TriggerOnceThisRun = true,
		PostTriggerAnimation = "HecateHubGreet",
		LockToCharacter = true,
		VoiceLines =
		{
			{
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0618", Text = "There you are. Come here!" },
			},
		}
	},
	HecateGreeting =
	{
		WithinDistance = 1100,
		ScaleY = 0.65,
		TriggerOnceThisRun = true,
		PostTriggerAnimation = "HecateHubGreet",
		PostTriggerFunctionName = "LightRangedSalute",
		PostTriggerFunctionArgs = { WaitTime = 0.6 },
		GameStateRequirements =
		{
			-- leave space for Cauldron intro
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "~=",
				Value = 1,
			},
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsNone = { "ArtemisHubFirstMeeting01", "ArtemisHubAboutChronosBoss01" }, },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},
		VoiceLines =
		{
			BreakIfPlayed = true,
			Cooldowns =
			{
				{ Name = "HecateGreetingSpeech", Time = 400 },
				{ Name = "AnyGreetingSpeech", Time = 4 },
			},
			TriggerCooldowns = { "DoraAnyQuipSpeech" },
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"HecatePostTrueEnding02",
								},
							 },
						},
					},
					{ Cue = "/VO/Hecate_0817", Text = "Melinoë...?" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"HecateAboutTyphonFight01",
									"HecateAboutTyphonFight01_B",
								},
							 },
						},
					},
					{ Cue = "/VO/Hecate_0729", Text = "Here. Now." },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"HecateAboutAthena01",
								},
							 },
						},
					},
					{ Cue = "/VO/Hecate_0768", Text = "When you have a moment?" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"HecateAboutChronosBossW01",
									"HecateGrantsFamiliars01",
									"HecateGrantsWeaponUpgradeSystem01",
									"HecateGrantsShrineUpgrade01",
									"HecateAboutArachne03",
									"HecateAboutTyphonAltFightW01",
								},
							 },
						},
					},
					{ Cue = "/VO/Hecate_0764", Text = "Melinoë..." },
					{ Cue = "/VO/Hecate_0054", Text = "Come here." },
					{ Cue = "/VO/Hecate_0728", Text = "Melinoë...?" },
					{ Cue = "/VO/Hecate_0730", Text = "Over here." },
					{ Cue = "/VO/Hecate_0925", Text = "Over here." },
					{ Cue = "/VO/Hecate_0926", Text = "Here, Melinoë." },
					-- { Cue = "/VO/Hecate_0924", Text = "Here." },
					-- { Cue = "/VO/Hecate_0927", Text = "Come forth." },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"HecateAboutChronos01",
									"HecateAboutChronos02",
									"HecateAboutHades01",
								},
							 },
						},
					},
					{ Cue = "/VO/Hecate_0765", Text = "What transpired...?" },
					{ Cue = "/VO/Hecate_0766", Text = "What happened." },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "HecateAboutTask01" }, },
						},
					},
					{ Cue = "/VO/Hecate_0006", Text = "{#Emph}Ah! {#Prev}You're here." },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "HecateAboutCerberus02" }, },
						},
					},
					{ Cue = "/VO/Hecate_0673", Text = "You all right...?" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "HecateLostAgainstHer01" }, },
						},
					},
					{ Cue = "/VO/Hecate_0322", Text = "There you are." },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "HecateAboutTask02" }, },
						},
					},
					{ Cue = "/VO/Hecate_0326", Text = "What news?" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "HecateAboutWellness01", "HecateAboutErisFight01", }, },
						},
					},
					{ Cue = "/VO/Hecate_0478", Text = "Alas..." },
					{ Cue = "/VO/Hecate_0727", Text = "Melinoë?" },
				},
				{
					SuccessiveChanceToPlayAll = 0.85,
					-- PreLineAnim = "HecateIdleGreeting",
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Hecate_0680", Text = "The task unfolds.", PlayFirst = true },
					{ Cue = "/VO/Hecate_0473", Text = "Well done out there." },
					{ Cue = "/VO/Hecate_0474", Text = "One step closer..." },
					{ Cue = "/VO/Hecate_0475", Text = "Continue apace." },
					{ Cue = "/VO/Hecate_0472", Text = "You finally returned..." },
					{ Cue = "/VO/Hecate_0614", Text = "All part of the task." },
					{ Cue = "/VO/Hecate_0615", Text = "We missed you here..." },
					{ Cue = "/VO/Hecate_0617", Text = "Commendable result." },
					{ Cue = "/VO/Hecate_0332", Text = "Well done." },
					{ Cue = "/VO/Hecate_0681", Text = "We welcome you." },
					{ Cue = "/VO/Hecate_0683", Text = "Sisters, salute.",
						PreLineAnim = "Hecate_Hub_Salute",
					},
					{ Cue = "/VO/Hecate_0685", Text = "Good work." },
					{ Cue = "/VO/Hecate_0733", Text = "One more accomplishment." },
					{ Cue = "/VO/Hecate_0734", Text = "A positive outcome." },
					{ Cue = "/VO/Hecate_0771", Text = "Prevailed again." },
					{ Cue = "/VO/Hecate_0682", Text = "Our Princess." },
					{ Cue = "/VO/Hecate_0684", Text = "I salute you.",
						PreLineAnim = "Hecate_Hub_Salute",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0731", Text = "Scoured the surface...",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0732", Text = "Returned from on high.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0616", Text = "You showed that wretch again.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
							},
							{
								Path = { "GameState", "EnemyKills", "Chronos" },
								Comparison = ">",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/Hecate_0769", Text = "Back from the summit.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0770", Text = "Felled that monster...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
							{
								Path = { "GameState", "EnemyKills", "TyphonHead" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/Hecate_0772", Text = "Slowed Typhon down?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
							{
								Path = { "GameState", "EnemyKills", "TyphonHead" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/Hecate_0773", Text = "Olympus yet stands.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.75,
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "ActiveBounty" },
						},
						{
							Path = { "CurrentRun", "RoomsEntered" },
							HasAny = { "F_Boss01", "F_Boss02" },
						},
						{
							PathFalse = { "CurrentRun", "RoomsEntered", "F_PostBoss01" }
						},
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.33,
						},
					},

					{ Cue = "/VO/Hecate_0676", Text = "You fought well.", PlayFirst = true },
					{ Cue = "/VO/Hecate_0677", Text = "You were close." },
					{ Cue = "/VO/Hecate_0678", Text = "'Twas quite a fight." },
					{ Cue = "/VO/Hecate_0679", Text = "Fiercely fought." },
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					RandomRemaining = true,
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Hecate_0060", Text = "Rise and shine.", PlayFirst = true },
					{ Cue = "/VO/Hecate_0052", Text = "You're awake." },
					{ Cue = "/VO/Hecate_0053", Text = "Melinoë?" },
					{ Cue = "/VO/Hecate_0055", Text = "Good evening." },
					{ Cue = "/VO/Hecate_0056", Text = "Good morrow." },
					{ Cue = "/VO/Hecate_0059", Text = "You're returned." },
					{ Cue = "/VO/Hecate_0061", Text = "Together we shine." },
					{ Cue = "/VO/Hecate_0062", Text = "Moonlight guide you." },
					{ Cue = "/VO/Hecate_0321", Text = "Approach." },
					{ Cue = "/VO/Hecate_0323", Text = "Back amongst the living." },
					{ Cue = "/VO/Hecate_0928", Text = "Back amongst the dead." },
					{ Cue = "/VO/Hecate_0324", Text = "Back on your feet, I see." },
					{ Cue = "/VO/Hecate_0325", Text = "Melinoë." },
					{ Cue = "/VO/Hecate_0327", Text = "Returned again." },
					{ Cue = "/VO/Hecate_0328", Text = "Our wards are holding fast." },
					{ Cue = "/VO/Hecate_0470", Text = "Regained your strength, I see." },
					{ Cue = "/VO/Hecate_0471", Text = "From the shadows..." },
					{ Cue = "/VO/Hecate_0670", Text = "Recovered." },
					{ Cue = "/VO/Hecate_0673", Text = "You all right...?" },
					{ Cue = "/VO/Hecate_0674", Text = "Prepared for more?" },
					{ Cue = "/VO/Hecate_0675", Text = "Returned to us." },
					{ Cue = "/VO/Hecate_0767", Text = "Back at last..." },
					{ Cue = "/VO/Hecate_0006", Text = "{#Emph}Ah! {#Prev}You're here.",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Hecate_0006" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0671", Text = "'Tis a new moon.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "GamePhase" },
								Comparison = "==",
								Value = 5,
							},
						},
					},
					{ Cue = "/VO/Hecate_0672", Text = "Full moon tonight.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "GamePhase" },
								Comparison = "==",
								Value = 1,
							},
						},
					},
					{ Cue = "/VO/Hecate_0326", Text = "What news?",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Hecate_0326" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0322", Text = "There you are.",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Hecate_0322" },
							},
						},
					},

				},
			},
		},
	},
	HecateHiding01 =
	{
		PreTriggerWait = 0.1,
		WithinDistance = 440,
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Queue = "Interrupt",
				{ Cue = "/VO/Melinoe_2115", Text = "There...!" },
			},
			{
				ObjectType = "NPC_Hecate_Story_01",
				{ Cue = "/VO/Hecate_0527", Text = "{#Emph}Ah!", PreLineAnim = "Hecate_Hub_Hide_Fidget", },
			},
		}
	},
	HecateHiding02 =
	{
		PreTriggerWait = 0.1,
		WithinDistance = 440,
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Queue = "Interrupt",
				{ Cue = "/VO/Melinoe_2116", Text = "Over there..." },

			},
			{
				ObjectType = "NPC_Hecate_Story_01",
				PreLineWait = 0.2,
				{ Cue = "/VO/Hecate_0528", Text = "Perceptive!", PreLineAnim = "Hecate_Hub_Hide_Fidget",  },
			},
		}
	},
	HecateHiding03 =
	{
		PreTriggerWait = 0.1,
		WithinDistance = 420,
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Queue = "Interrupt",
				{ Cue = "/VO/Melinoe_2117", Text = "Ah-{#Emph}hah..." },
			},
			{
				ObjectType = "NPC_Hecate_Story_01",
				{ Cue = "/VO/Hecate_0526", Text = "{#Emph}<Chuckle>", PreLineAnim = "Hecate_Hub_Hide_Fidget",  },
			},
		}
	},

	OdysseusGreeting =
	{
		WithinDistance = 550,
		ScaleY = 0.75,
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
			},
			Cooldowns =
			{
				{ Name = "OdysseusGreetingSpeech", Time = 400 },
				{ Name = "AnyGreetingSpeech", Time = 4 },
			},
			TriggerCooldowns = { "DoraAnyQuipSpeech" },
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "OdysseusAboutScylla02", "OdysseusAboutPrometheus01" }, },
					},
				},
				{
					PlayOnce = true,
					PlayOnceContext = "OdysseusReturnVO",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny =
								{
									"OdysseusAboutReturn01",
								},
							},
						},
					},
					{
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5107", Text = "Odysseus!" },
					},
					{
						{ Cue = "/VO/Odysseus_0584", Text = "Good to see you, Goddess!", PreLineAnim = "Odysseus_Greet", BreakIfPlayed = true, },
					},
				},
				{
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny =
								{
									"OdysseusPostTrueEnding01",
								},
							},
						},
					},
					{ Cue = "/VO/Odysseus_0595", Text = "All hail the Princess of the Underworld...!", PreLineAnim = "Odysseus_Greet" },
				},
				{
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny =
								{
									"OdysseusAboutTyphonDeath01",
								},
							},
						},
					},
					{ Cue = "/VO/Odysseus_0591", Text = "All hail the monster-slayer!", PreLineAnim = "Odysseus_Greet" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny =
								{
									"OdysseusAboutChronosBossL01",
								},
							},
						},
					},

					{ Cue = "/VO/Odysseus_0345", Text = "Back in one piece.", PreLineAnim = "Odysseus_Greet" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny =
								{
									"OdysseusAboutChronosBossW01",
								},
							},
						},
					},
					{ Cue = "/VO/Odysseus_0450", Text = "You did it...!" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny =
								{
									"OdysseusAboutChronosBossW01",
									"OdysseusAboutErisCurse01",
									"OdysseusAboutPoseidon01",
									"OdysseusAboutPressure02",
									-- "OdysseusAboutChronosBossL01",
									"OdysseusAboutErisBoss01",
									"OdysseusAboutOlympus01",
									"OdysseusAboutTyphon01",
									"OdysseusAboutChronosBossTactics01",
									"OdysseusAboutErisBossTactics01",
									"OdysseusAboutScyllaTactics01",
								},
							},
						},
					},

					{ Cue = "/VO/Odysseus_0119", Text = "A moment, Goddess?", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0120", Text = "If I may, Goddess?", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0121", Text = "Beg pardon, Goddess...", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0122", Text = "Hey, {#Emph}erm..." },
					{ Cue = "/VO/Odysseus_0461", Text = "A moment?", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0094", Text = "May we talk?", PreLineAnim = "Odysseus_Greet" },
					-- @ add to resource giving lines
					-- { Cue = "/VO/Odysseus_0094", Text = "May I assist you, Goddess?", PreLineAnim = "Odysseus_Greet" },
				},
				{
					PreLineAnim = "Odysseus_Greet",
					SuccessiveChanceToPlayAll = 0.66,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs =
							{
								IsAny = GameData.OdysseusResourceEvents,
							},
						},
					},
					{ Cue = "/VO/Odysseus_0691", Text = "Over here." },
					{ Cue = "/VO/Odysseus_0692", Text = "Look what I have." },
					{ Cue = "/VO/Odysseus_0693", Text = "Something for you." },
					{ Cue = "/VO/Odysseus_0694", Text = "Got something here." },
					{ Cue = "/VO/Odysseus_0695", Text = "See this here?" },
					{ Cue = "/VO/Odysseus_0696", Text = "Come see this." },
				},
				{
					SuccessiveChanceToPlayAll = 0.5,
					-- PreLineAnim = "HecateIdleGreeting",
					RandomRemaining = true,
					PreLineAnim = "Odysseus_Greet",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Odysseus_0116", Text = "Good show that time.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0117", Text = "Hello there.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0334", Text = "Impressive work.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0202", Text = "Good hunting!", PreLineAnim = "Odysseus_Greet" },
					-- { Cue = "/VO/Odysseus_0118", Text = "Fine work there!" },
					{ Cue = "/VO/Odysseus_0449", Text = "The Nightmare Goddess...!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "BadgeRank" },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
					{ Cue = "/VO/Odysseus_0450", Text = "You did it...!" },
					{ Cue = "/VO/Odysseus_0451", Text = "You got him." },
					{ Cue = "/VO/Odysseus_0452", Text = "Did it again!" },
					{ Cue = "/VO/Odysseus_0453", Text = "Well done!" },
					{ Cue = "/VO/Odysseus_0454", Text = "Closer to victory." },
					{ Cue = "/VO/Odysseus_0455", Text = "The task proceeds..." },
					{ Cue = "/VO/Odysseus_0456", Text = "Excellent stuff...!" },
					{ Cue = "/VO/Odysseus_0457", Text = "Success...!" },
					{ Cue = "/VO/Odysseus_0697", Text = "Excellent work!" },
					{ Cue = "/VO/Odysseus_0698", Text = "Glowing reports." },
					{ Cue = "/VO/Odysseus_0584", Text = "Good to see you, Goddess!", PreLineAnim = "Odysseus_Greet",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpawnRecord", "NPC_Odysseus_01" },
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "OdysseusAboutReturn01" }, Min = 9 },
							},
						},
					},
					{ Cue = "/VO/Odysseus_0591", Text = "All hail the monster-slayer!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" }
							},
							{
								PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
							},
							{
								SumPrevRuns = 8,
								Path = { "SpeechRecord", "/VO/Odysseus_0591" },
								CountPathTrue = true,
								Comparison = "==",
								Value = 0,
							},
						},
					},
					{ Cue = "/VO/Odysseus_0595", Text = "All hail the Princess of the Underworld...!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "EnemyKills", "Chronos" }
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
							},
						},
					},
					{ Cue = "/VO/Odysseus_0458", Text = "Back from Tartarus.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						}
					},
					{ Cue = "/VO/Odysseus_0459", Text = "Scoured the surface?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						}
					},
					{ Cue = "/VO/Odysseus_0460", Text = "Showed that monster, aye?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						}
					},

				},
				{
					RandomRemaining = true,
					PreLineAnim = "Odysseus_Greet",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "AnyMailboxReady" },
						},
						{
							PathFalse = { "CurrentRun", "UseRecord", "Mailbox" }
						},
					},

					{ Cue = "/VO/Odysseus_0340", Text = "New shipment there for you." },
					{ Cue = "/VO/Odysseus_0341", Text = "Shipment came for you.", PlayFirst = true },
					{ Cue = "/VO/Odysseus_0342", Text = "New shipment over there." },
					{ Cue = "/VO/Odysseus_0343", Text = "Shipment for you back there." },
					{ Cue = "/VO/Odysseus_0483", Text = "Something from Charon there." },
					{ Cue = "/VO/Odysseus_0484", Text = "Shipment's here!" },
					{ Cue = "/VO/Odysseus_0485", Text = "See the shipment yet?" },
					{ Cue = "/VO/Odysseus_0486", Text = "Lord Charon brought something." },
					{ Cue = "/VO/Odysseus_0487", Text = "You get the new shipment?" },
					{ Cue = "/VO/Odysseus_0488", Text = "Lord Charon's here." },
				},
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.75,
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Odysseus_0111", Text = "Goddess." },
					{ Cue = "/VO/Odysseus_0112", Text = "{#Emph}Ah." },
					{ Cue = "/VO/Odysseus_0114", Text = "Let's see..." },
					{ Cue = "/VO/Odysseus_0347", Text = "{#Emph}Hmm..." },
					{ Cue = "/VO/Odysseus_0350", Text = "Up and about?" },
					{ Cue = "/VO/Odysseus_0351", Text = "You have this." },
					{ Cue = "/VO/Odysseus_0110", Text = "Goddess.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0113", Text = "Hail.", PlayFirst = true, PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0344", Text = "Greetings.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0346", Text = "Something to report?", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0345", Text = "Back in one piece.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0348", Text = "Evening!", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0349", Text = "Evening... I think.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Odysseus_0348" },
							},
						},
					},
					{ Cue = "/VO/Odysseus_0463", Text = "Hail, Goddess.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0464", Text = "Hello." },
					{ Cue = "/VO/Odysseus_0465", Text = "You're up!" },
					{ Cue = "/VO/Odysseus_0466", Text = "Rest well?" },
					{ Cue = "/VO/Odysseus_0467", Text = "Good to go?" },
					{ Cue = "/VO/Odysseus_0699", Text = "How did it go...?" },
					{ Cue = "/VO/Odysseus_0700", Text = "Good to see you." },
					{ Cue = "/VO/Odysseus_0468", Text = "Up for more?", PreLineAnim = "Odysseus_Greet" },
				},
			},
		},
	},
	OdysseusFeasting =
	{
		WithinDistance = 750,
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			Cooldowns =
			{
				{ Name = "OdysseusGreetingSpeech", Time = 400 },
			},
			{
				{
					RandomRemaining = true,
					-- SuccessiveChanceToPlay = 0.75,
					PreLineAnim = "Odysseus_Drinking_Sip",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"OdysseusAboutMood01",
									"OdysseusAboutScylla03",
									"OdysseusLooseEndsQuest01",
									"OdysseusAboutAssistance01",
								},
							},
						},
					},
					{ Cue = "/VO/Odysseus_0475", Text = "{#Emph}Euuugh... " },
					{ Cue = "/VO/Odysseus_0476", Text = "{#Emph}<Sigh>" },
				},
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.85,
					PreLineAnim = "Odysseus_Drinking_Toast",
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Odysseus_0106", Text = "{#Emph}<Chuckle>" },
					{ Cue = "/VO/Odysseus_0107", Text = "{#Emph}<Chuckle>" },
					{ Cue = "/VO/Odysseus_0108", Text = "{#Emph}<Laugh>", PlayFirst = true },
					{ Cue = "/VO/Odysseus_0109", Text = "{#Emph}<Laugh>" },
					{ Cue = "/VO/Odysseus_0469", Text = "Come join us here, Goddess!" },
					{ Cue = "/VO/Odysseus_0470", Text = "Join us a bit, Goddess?" },
					{ Cue = "/VO/Odysseus_0471", Text = "There she is, lads!" },
					{ Cue = "/VO/Odysseus_0472", Text = "That you, Goddess?" },
					{ Cue = "/VO/Odysseus_0473", Text = "Come on over!" },
					{ Cue = "/VO/Odysseus_0474", Text = "Hey over here!" },
				},
			},
		},
	},
	OdysseusHideAndSeek =
	{
		WithinDistance = 360,
		VoiceLines =
		{
			{ Cue = "/VO/Odysseus_0203", Text = "You'll find her yet." },
		}
	},

	NemesisGreeting =
	{
		WithinDistance = 500,
		ScaleY = 0.75,
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
			},
			Cooldowns =
			{
				{ Name = "NemesisGreetingSpeech", Time = 400 },
				{ Name = "AnyGreetingSpeech", Time = 4 },
			},
			{
				-- Nemesis field greetings
				{
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "NemesisFieldFirstMeeting" }, },
						},
					},

					-- { Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
				},
				-- hub greetings
				{
					PlayOnce = true,
					PlayOnceContext = "NemesisTrueEndingVOGreeting",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
					{ Cue = "/VO/Nemesis_0406", Text = "It's done...?" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "NemesisAboutTyphon01" }, },
						},
					},

					{ Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
				},
				{
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"NemesisAboutEris01",
									"NemesisAboutTraining01",
									"NemesisAboutSurface02",
									"NemesisAboutRelationship02",
									"NemesisPostEpilogue01,"
								},
							},
						},
					},

					{ Cue = "/VO/Nemesis_0113", Text = "Hey, {#Emph}uh..." },
					{ Cue = "/VO/Nemesis_0114", Text = "Um..." },
					{ Cue = "/VO/Nemesis_0115", Text = "Come here..." },
					{ Cue = "/VO/Nemesis_0356", Text = "{#Emph}<Scoff>" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "NemesisAboutTask01" }, },
						},
					},

					{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Huh!" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "NemesisAboutErisFightW01", "NemesisAboutTyphonDeath01" }, },
						},
					},

					{ Cue = "/VO/Nemesis_0280", Text = "Hey." },
				},
				{
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "NemesisAboutRelationship01", "NemesisAboutRelationship01_B", "NemesisAboutRelationship02", "NemesisAboutRelationship03" }, },
						},
					},
					{ Cue = "/VO/Nemesis_0360", Text = "{#Emph}Hm." },
					{ Cue = "/VO/Nemesis_0364", Text = "{#Emph}Hrm?" },
					{ Cue = "/VO/Nemesis_0365", Text = "{#Emph}Hrm..." },
					{ Cue = "/VO/Nemesis_0367", Text = "{#Emph}Huh." },
					{ Cue = "/VO/Nemesis_0369", Text = "{#Emph}Mm..." },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.75,
					-- PreLineAnim = "HecateIdleGreeting",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Nemesis_0272", Text = "Oh, look..." },
					{ Cue = "/VO/Nemesis_0273", Text = "You..." },
					{ Cue = "/VO/Nemesis_0274", Text = "Well, well." },
					{ Cue = "/VO/Nemesis_0276", Text = "Did it again." },
					{ Cue = "/VO/Nemesis_0277", Text = "How did you...?" },
					{ Cue = "/VO/Nemesis_0280", Text = "Hey." },
					{ Cue = "/VO/Nemesis_0281", Text = "{#Emph}Hm." },
					{ Cue = "/VO/Nemesis_0475", Text = "You made it." },
					{ Cue = "/VO/Nemesis_0476", Text = "You got there." },
					{ Cue = "/VO/Nemesis_0275", Text = "You got there...?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
					{ Cue = "/VO/Nemesis_0474", Text = "Got him, huh?",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
					{ Cue = "/VO/Nemesis_0278", Text = "Got him, huh.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
					{ Cue = "/VO/Nemesis_0279", Text = "Got him again?",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.75,
					PreLineAnim = "Nemesis_Hub_Greet",
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Nemesis_0102", Text = "What." },
					{ Cue = "/VO/Nemesis_0103", Text = "Yeah?" },
					{ Cue = "/VO/Nemesis_0110", Text = "Again?" },
					{ Cue = "/VO/Nemesis_0112", Text = "Tough times." },
					{ Cue = "/VO/Nemesis_0117", Text = "What is it?" },
					{ Cue = "/VO/Nemesis_0118", Text = "Yeah, what?" },
					{ Cue = "/VO/Nemesis_0282", Text = "Up and about." },
					{ Cue = "/VO/Nemesis_0283", Text = "Up late." },
					{ Cue = "/VO/Nemesis_0284", Text = "Try again?" },
					{ Cue = "/VO/Nemesis_0285", Text = "Again, huh?" },
					{ Cue = "/VO/Nemesis_0286", Text = "Still at it?" },
					{ Cue = "/VO/Nemesis_0287", Text = "All clear." },
					{ Cue = "/VO/Nemesis_0288", Text = "All clear..." },
					{ Cue = "/VO/Nemesis_0289", Text = "'Bout time." },
					{ Cue = "/VO/Nemesis_0107", Text = "Back early.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								UseLength = true,
								Comparison = "<",
								Value = 20,
							},
						},
					},
					{ Cue = "/VO/Nemesis_0116", Text = "What now?",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "NemesisGift08" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0104", Text = "{#Emph}Urgh...",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "NemesisGift05" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "NemesisGift06" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Huh!",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "TextLinesRecord", "NemesisAboutTask01" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0108", Text = "Death to Chronos.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0109", Text = "Death to Chronos...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift02" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0477", Text = "Melinoë.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisBathHouse03" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0478", Text = "Hey...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift09" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0479", Text = "You're up.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift06" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0111", Text = "Oh, Mother...",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "NemesisGift08" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0290", Text = "Oh...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
							},
						}
					},
					{ Cue = "/VO/Nemesis_0291", Text = "Princess." },

				},
			},
		},
	},
	NemesisRandomEventGreeting = 
	{
		WithinDistance = 1000,
		NotifyName = "NemesisRandomEventGreeting",
		SetupFunctions =
		{
			{
				Name = "OverwriteSelf",
				Args =
				{
					PostTriggerFunctionName = "NemesisFieldsApproachPresentation",	
					PostTriggerFunctionArgs = { SecretMusicSection = 1, MusicTransitionTime = 1.0, },
					WithinDistance = 1300,
					ScaleY = 0.5,
					Repeat = true,
					RepeatBufferDistance = 500,
					OnRepeatFunctionName = "NemesisFieldsBackAwayFromPresentation",
					OnRepeatFunctionArgs = { MusicTransitionTime = 1.0, },
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
		
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.75,
				SuccessiveChanceToPlay = 0.25,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
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
				-- SuccessiveChanceToPlay = 0.75,
				-- PreLineAnim = "HecateIdleGreeting",
				RandomRemaining = true,
				PreLineWait = 0.75,
				-- RequiresNullAmbientMusicId = true,
				Cooldowns =
				{
					{ Name = "NemesisGreetingSpeech", Time = 90 },
				},

				{ Cue = "/VO/NemesisField_0197", Text = "Well, well.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0198", Text = "You." },
				{ Cue = "/VO/NemesisField_0199", Text = "You again." },
				{ Cue = "/VO/NemesisField_0200", Text = "Again?" },
				{ Cue = "/VO/NemesisField_0201", Text = "Evening." },
				{ Cue = "/VO/NemesisField_0202", Text = "What a coincidence." },
				{ Cue = "/VO/NemesisField_0203", Text = "Thank the Fates." },
				{ Cue = "/VO/NemesisField_0204", Text = "Yeah?" },
				{ Cue = "/VO/NemesisField_0205", Text = "What do you want." },
				{ Cue = "/VO/NemesisField_0206", Text = "Move along." },
				{ Cue = "/VO/NemesisField_0207", Text = "There you are." },
				{ Cue = "/VO/NemesisField_0208", Text = "Princess." },
				{ Cue = "/VO/NemesisField_0209", Text = "May I help you?" },
			},
		},
	},
	MedeaHubGreeting =
	{
		WithinDistance = 650,
		ScaleY = 0.75,
		TriggerOnceThisRun = true,
		-- PostTriggerAnimation = "HecateHubGreet",
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				{ Cue = "/VO/Melinoe_3035", Text = "Lady Medea...!" },
			},
			{
				PreLineWait = 0.2,
				{ Cue = "/VO/Medea_0071", Text = "Good evening!" },
			},
		}
	},
	ArachneHubGreeting =
	{
		WithinDistance = 650,
		ScaleY = 0.75,
		TriggerOnceThisRun = true,
		-- PostTriggerAnimation = "HecateHubGreet",
		VoiceLines =
		{
			{
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1092", Text = "Arachne!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Arachne_Home_01",

				{ Cue = "/VO/Arachne_0144", Text = "Good evening!" },
			}
		}
	},

	MorosGreeting =
	{
		WithinDistance = 490,
		GameStateRequirements =
		{
			{
				-- PathEmpty = { "GameState", "ActiveLitter" },
			},
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		VoiceLines =
		{
			BreakIfPlayed = true,
			Cooldowns =
			{
				{ Name = "MorosGreetingSpeech", Time = 400 },
				{ Name = "MorosBeingPolite", Time = 2 },
				{ Name = "AnyGreetingSpeech", Time = 4 },
			},
			{
				{
					PlayOnce = true,
					PlayOnceContext = "MorosPostTrueEndingGreetingVO",
					PreLineAnim = "Moros_Attention",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
					{ Cue = "/VO/Moros_0450", Text = "What an accomplishment..." },
				},
				{
					PreLineAnim = "Moros_Attention",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "MorosAboutEpilogueProgress01" }, },
						},
					},
					{ Cue = "/VO/Moros_0580", Text = "Wait, Princess..." },
				},
				{
					PreLineAnim = "Moros_Attention",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" },
						},
					},
					{ Cue = "/VO/Moros_0459", Text = "You found them...!" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "MorosFirstMeeting" }, },
						},
					},
					{ Cue = "/VO/Moros_0363", Text = "A brief word?", PreLineAnim = "Moros_Salute" },
					-- { Cue = "/VO/Moros_0364", Text = "Beg pardon?" },
				},
				{
					PreLineAnim = "Moros_Attention",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "MorosAboutRelationship03", "MorosAboutRelationship03_B" }, },
						},
					},
					{ Cue = "/VO/Moros_0576", Text = "{#Emph}Whew..." },
				},
				{
					PreLineAnim = "Moros_Salute",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = {
								IsAny = {
									"MorosAboutQuestLog01",
									"MorosAboutRelationship01",
									"MorosAboutArrangement01",
									"MorosAboutRelationship02",
									"MorosGrantsMixer6Common",
								},
							},
						},
					},
					{ Cue = "/VO/Moros_0093", Text = "Princess?" },
					{ Cue = "/VO/Moros_0583", Text = "If I may..." },
					{ Cue = "/VO/Moros_0095", Text = "Do you have a moment?" },
					{ Cue = "/VO/Moros_0577", Text = "Princess...?" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "MorosAboutRelationship02" }, },
						},
					},

					{ Cue = "/VO/Moros_0577", Text = "Princess...?", PreLineAnim = "Moros_Attention" },
				},
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "MorosAboutQuestLog02", "MorosAboutTyphon01" }, },
						},
					},

					{ Cue = "/VO/Moros_0094", Text = "If I may?", PreLineAnim = "Moros_Salute" },
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					PreLineAnim = "Moros_Salute",
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Moros_0559", Text = "The Fates were generous!" },
					{ Cue = "/VO/Moros_0560", Text = "Thank the Fates..." },
					{ Cue = "/VO/Moros_0561", Text = "As Fate would have it..." },
					{ Cue = "/VO/Moros_0564", Text = "You did it..." },
					{ Cue = "/VO/Moros_0565", Text = "A step toward your goal." },
					{ Cue = "/VO/Moros_0090_B", Text = "To your success." },
					{ Cue = "/VO/Moros_0091_B", Text = "To victory." },
					{ Cue = "/VO/Moros_0213", Text = "It's an auspicious night!" },
					{ Cue = "/VO/Moros_0214", Text = "It's an auspicious night.", PlayFirst = true },
					{ Cue = "/VO/Moros_0558", Text = "You prevailed...!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpentShrinePointsCache" },
								Comparison = ">=",
								Value = 12,
							},
						},
					},
					{ Cue = "/VO/Moros_0562", Text = "Once again...!",
						GameStateRequirements =
						{
							{
								SumPrevRuns = 2,
								Path = { "Cleared" },
								CountPathTrue = true,
								Comparison = ">=",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/Moros_0092", Text = "Heard the good news.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "ClearedRunsCache" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/Moros_0450", Text = "What an accomplishment...",
						GameStateRequirements =
						{
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
							},
							OrRequirements =
							{
								{
									{
										PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
									},
									{
										PathTrue = { "GameState", "LastBossDifficultyRecord", "Chronos" },
									},
								},
								{
									{
										PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
									},
									{
										PathTrue = { "GameState", "LastBossDifficultyRecord", "TyphonHead" },
									},
								},
							},
						},
					},
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					PreLineAnim = "Moros_Salute",
					RandomRemaining = true,
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Moros_0563", Text = "Welcome back." },
					{ Cue = "/VO/Moros_0567", Text = "Heading out?" },
					{ Cue = "/VO/Moros_0083", Text = "Princess." },
					{ Cue = "/VO/Moros_0084", Text = "Princess...!" },
					{ Cue = "/VO/Moros_0085", Text = "Hm.", PreLineAnim = "Moros_Attention" },
					{ Cue = "/VO/Moros_0086", Text = "Mm.", PreLineAnim = "Moros_Attention" },
					{ Cue = "/VO/Moros_0087", Text = "Fates protect you." },
					{ Cue = "/VO/Moros_0088", Text = "My greetings.", PlayFirst = true },
					{ Cue = "/VO/Moros_0089", Text = "You're back..." },
					{ Cue = "/VO/Moros_0082", Text = "Good evening." },
					{ Cue = "/VO/Moros_0208", Text = "Greetings." },
					-- { Cue = "/VO/Moros_0209", Text = "Oh!" },
					{ Cue = "/VO/Moros_0210", Text = "Hello.", PreLineAnim = "Moros_Attention" },
					-- { Cue = "/VO/Moros_0211", Text = "Oh hello." },
					{ Cue = "/VO/Moros_0212", Text = "Ready for more?" },


					{ Cue = "/VO/Moros_0566", Text = "You look well." },

				},
			},
		},
	},

	ErisCrying =
	{
		WithinDistance = 450,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
		},
		PreTriggerAnimation = "Enemy_Eris_Hub_Cry_FireLoop",
		PostTriggerAnimation = "Enemy_Eris_Hub_Eat_End",
		VoiceLines =
		{
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },
			Cooldowns =
			{
				{ Name = "ErisGreetingSpeech", Time = 400 },
			},
			{
				{
					ObjectType = "NPC_Eris_01",
					{ Cue = "/VO/Eris_0254", Text = "{#Emph}<Sniff> {#Prev}Oh, it's you..." },
				},
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_4361", Text = "Hey..." },
				},
			},
		},

	},

	ErisGreeting =
	{
		WithinDistance = 559,
		ScaleX = 0.85,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		SetupFunctions =
		{
			{
				Name = "OverwriteSelf",
				Args =
				{
					WithinDistance = 1100,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
			},
		},

		-- PostTriggerAnimation = "Eris_Salute",
		VoiceLines =
		{
			{
				-- curse greetings
				{
					{
						RandomRemaining = true,
						PreLineAnim = "Enemy_Eris_Hub_Greet",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" },
							},
						},
						Cooldowns =
						{
							{ Name = "ErisSpokeRecently", Time = 2 },
						},

						{ Cue = "/VO/Eris_0077", Text = "Hey babe!" },
						{ Cue = "/VO/ErisField_0050", Text = "Hiya babe!" },
						{ Cue = "/VO/ErisField_0051", Text = "Hey hey!" },
						{ Cue = "/VO/ErisField_0052", Text = "Thought that was you." },
						{ Cue = "/VO/ErisField_0053", Text = "Look who!", PlayFirst = true },
						{ Cue = "/VO/ErisField_0054", Text = "Got here {#Emph}first!", PlayFirst = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "SpeechRecord", "/VO/ErisField_0053" },
								},
							},
						},
						{ Cue = "/VO/ErisField_0055", Text = "You made it!" },
						{ Cue = "/VO/ErisField_0056", Text = "Trouble!" },
						{ Cue = "/VO/ErisField_0057", Text = "Trouble." },
					},
					{
						PreLineWait = 0.3,
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" },
							},
						},			

						{ Cue = "/VO/Melinoe_3064", Text = "Oh, no...", PlayFirst = true },
						{ Cue = "/VO/Melinoe_3065", Text = "Her again." },
						{ Cue = "/VO/Melinoe_3066", Text = "Oh great." },
						{ Cue = "/VO/Melinoe_3067", Text = "Eris...!" },
						{ Cue = "/VO/Melinoe_3068", Text = "Hello, Eris..." },
						{ Cue = "/VO/Melinoe_3069", Text = "Hello, Eris..." },
					},
				},
				-- hub greetings
				{
					BreakIfPlayed = true,
					Cooldowns =
					{
						{ Name = "ErisSpokeRecently", Time = 3 },
						{ Name = "AnyGreetingSpeech", Time = 4 },
					},
					{
						ObjectType = "NPC_Eris_01",
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisFirstMeeting", "ErisFirstMeeting_B", }, },
							},
						},
						{ Cue = "/VO/Eris_0072", Text = "Lookee who!" },
						{ Cue = "/VO/Eris_0082", Text = "{#Emph}Aw{#Prev}, what's wrong?", PlayFirst = true,
							GameStateRequirements = 
							{
								{
									Path = { "CurrentRun", "RoomsEntered" },
									HasAny = { "O_Boss01", "O_Boss02" },
								},
							}
						},
					},
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisPostTrueEnding01", }, },
							},
						},

						{ Cue = "/VO/Eris_0422", Text = "{#Emph}Eugh..." },
						{ Cue = "/VO/Eris_0435", Text = "Hey babe..." },
					},
					{
						ObjectType = "NPC_Eris_01",
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "NemesisWithEris01", }, },
							},
						},
						{ Cue = "/VO/Eris_0138", Text = "{#Emph}Yes{#Prev}, ma'am!" },
					},
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisAboutPurpose01", }, },
							},
						},
						{ Cue = "/VO/Eris_0076", Text = "What're you looking at?" },
					},
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisPostGift01", "ErisBecomingCloser01" }, },
							},
						},
						{ Cue = "/VO/Eris_0071", Text = "C'mere." },
						{ Cue = "/VO/Eris_0434", Text = "{#Emph}Psst!" },
					},
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisAboutWeaponGun01", }, },
							},
						},
						{ Cue = "/VO/Eris_0132", Text = "{#Emph}Wha?" },
					},
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisAboutAltFight01", }, },
							},
						},
						{ Cue = "/VO/Eris_0158", Text = "{#Emph}Ehh..." },
					},
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "ErisBecomingCloser01" }, },
							},
						},
						{ Cue = "/VO/Eris_0428", Text = "Oh {#Emph}baaabe?" },
					},	
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.5,
						SuccessiveChanceToPlayAll = 0.5,
						-- PreLineAnim = "HecateIdleGreeting",
						GameStateRequirements =
						{
							{
								Path = { "AudioState", "AmbientTrackName" },
								IsAny = { "/Music/ArtemisSong_MC" },
							},
						},

						{ Cue = "/VO/Eris_0372", Text = "{#Emph}Moonlight guide us home tonight...!" },
						{ Cue = "/VO/Eris_0373", Text = "{#Emph}Moonlight guide you home tonight...!" },
						{ Cue = "/VO/Eris_0374", Text = "{#Emph}The Sisters wait...!" },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.75,
						-- PreLineAnim = "HecateIdleGreeting",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" }
							},
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
							},
						},

						{ Cue = "/VO/Eris_0083", Text = "{#Emph}Ohh {#Prev}it's you..." },
						{ Cue = "/VO/Eris_0084", Text = "Hooray..." },
						{ Cue = "/VO/Eris_0085", Text = "{#Emph}Tsch..." },
						{ Cue = "/VO/Eris_0086", Text = "What did you do now...?" },
						{ Cue = "/VO/Eris_0087", Text = "Stop {#Emph}getting {#Prev}somewhere...!" },
						{ Cue = "/VO/Eris_0128", Text = "Oh, hey..." },
						{ Cue = "/VO/Eris_0129", Text = "What's all the commotion?" },
						{ Cue = "/VO/Eris_0130", Text = "Hi..." },
						{ Cue = "/VO/Eris_0131", Text = "Blood and darkness..." },
						{ Cue = "/VO/Eris_0147", Text = "{#Emph}Kh!" },
						{ Cue = "/VO/Eris_0148", Text = "{#Emph}Ngh." },
						{ Cue = "/VO/Eris_0154", Text = "What?" },
						{ Cue = "/VO/Eris_0420", Text = "{#Emph}Again...?" },
						{ Cue = "/VO/Eris_0421", Text = "Oh great." },
						{ Cue = "/VO/Eris_0423", Text = "Haven't you done {#Emph}enough?" },
						{ Cue = "/VO/Eris_0426", Text = "Again?" },
						{ Cue = "/VO/Eris_0427", Text = "Come {#Emph}on...." },
						{ Cue = "/VO/Eris_0424", Text = "Still sore you know!",
							GameStateRequirements =
							{
								{
									PathFalse = { "CurrentRun", "EnemyKills", "Eris" }
								},
							},
						},
						{ Cue = "/VO/Eris_0425", Text = "Go pick on someone else.",
							GameStateRequirements =
							{
								{
									PathFalse = { "CurrentRun", "EnemyKills", "Eris" }
								},
							},
						},
						{ Cue = "/VO/Eris_0231", Text = "How's it going?",
							GameStateRequirements =
							{
								{
									PathFalse = { "CurrentRun", "EnemyKills", "Eris" }
								},
							},
						},
						{ Cue = "/VO/Eris_0422", Text = "{#Emph}Eugh...",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "ReachedTrueEnding" },
								},
								{
									FunctionName = "RequireRunsSinceTextLines",
									FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
								},
							},
						},
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.85,
						-- PreLineAnim = "HecateIdleGreeting",
						-- RequiresNullAmbientMusicId = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "IsDead" },
							},
						},

						{ Cue = "/VO/Eris_0428", Text = "Oh {#Emph}baaabe?",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
									IsAny = { "Choice_ErisAccept" },
								},
							},
						},

						{ Cue = "/VO/Eris_0429", Text = "Looking for me?",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
								},
							},
						},
						{ Cue = "/VO/Eris_0430", Text = "D'you miss me?",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
									IsAny = { "Choice_ErisAccept" },
								},
							},
						},
						{ Cue = "/VO/Eris_0437", Text = "Crawling back?",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
									IsAny = { "Choice_ErisAccept" },
								},
							},
						},
						{ Cue = "/VO/Eris_0431", Text = "What's good?",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "ErisGift08", },
								},
							},
						},
						{ Cue = "/VO/Eris_0432", Text = "Found me!",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "ErisGift08", },
								},
							},
						},
						{ Cue = "/VO/Eris_0433", Text = "I'm here!",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "ErisGift06", },
								},
							},
						},
						{ Cue = "/VO/Eris_0436", Text = "Yeah?" },
						{ Cue = "/VO/Eris_0438", Text = "You dropped this!" },
						{ Cue = "/VO/Eris_0439", Text = "Got a problem?" },
						{ Cue = "/VO/Eris_0070", Text = "Here comes Trouble...!" },
						{ Cue = "/VO/Eris_0071", Text = "C'mere." },
						{ Cue = "/VO/Eris_0072", Text = "Lookee who!" },
						{ Cue = "/VO/Eris_0073", Text = "{#Emph}Yoo-hoo!", PlayFirst = true },
						{ Cue = "/VO/Eris_0074", Text = "{#Emph}Ahh, heh!" },
						{ Cue = "/VO/Eris_0075", Text = "Hi, hi!" },
						{ Cue = "/VO/Eris_0077", Text = "Hey babe!" },
						{ Cue = "/VO/Eris_0078", Text = "{#Emph}Heh!" },
						{ Cue = "/VO/Eris_0080", Text = "May I help you?" },
						{ Cue = "/VO/Eris_0081", Text = "What's the matter?" },
						{ Cue = "/VO/Eris_0082", Text = "{#Emph}Aw{#Prev}, what's wrong?" },
						{ Cue = "/VO/Eris_0160", Text = "{#Emph}Huh..." },
						{ Cue = "/VO/Eris_0161", Text = "{#Emph}Oh..." },
						{ Cue = "/VO/Eris_0428", Text = "Oh {#Emph}baaabe?",
							GameStateRequirements =
							{
								{
									FunctionName = "RequireRunsSinceTextLines",
									FunctionArgs = { TextLines = { "ErisBecomingCloser01" }, Min = 8 },
								},
							},
						},
						{ Cue = "/VO/Eris_0076", Text = "What're you looking at?",
							GameStateRequirements =
							{
								{
									FunctionName = "RequireRunsSinceTextLines",
									FunctionArgs = { TextLines = { "ErisAboutPurpose01" }, Min = 8 },
								},
							},
						},
					},
				},
			},
		},
	},

	ApplyErisCurse =
	{
		TraitName = "ErisCurseTrait",
	},

	IcarusGreeting =
	{
		WithinDistance = 850,
		ScaleY = 0.75,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},
		PostTriggerAnimation = "Icarus_Salute",
		VoiceLines =
		{
			{
				{
					-- BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.5,
					-- PreLineAnim = "HecateIdleGreeting",
					-- RequiresNullAmbientMusicId = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
						},
					},

					{ Cue = "/VO/Icarus_0268", Text = "Hello...!", PlayFirst = true },
					{ Cue = "/VO/Icarus_0269", Text = "Your Grace." },
					{ Cue = "/VO/Icarus_0270", Text = "Hi, Meli...!" },
					{ Cue = "/VO/Icarus_0271", Text = "Oh, you're up...!" },
					{ Cue = "/VO/Icarus_0272", Text = "Oh...!" },
					{ Cue = "/VO/Icarus_0273", Text = "You all right?" },
					{ Cue = "/VO/Icarus_0274", Text = "You did it...!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" },
							},
						},
					},
					{ Cue = "/VO/Icarus_0275", Text = "You're all right!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" },
							},
						},
					},
					{ Cue = "/VO/Icarus_0276", Text = "Congratulations...!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" },
							},
						},
					},
					{ Cue = "/VO/Icarus_0277", Text = "Amazing work.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" },
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny = { "IcarusBecomingCloser01" }, },
						},
					},

					{ Cue = "/VO/Melinoe_4827", Text = "Icarus...?" },
				},
				{
					UsePlayerSource = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.25,
					SuccessiveChanceToPlayAll = 0.25,

					{ Cue = "/VO/Melinoe_4828", Text = "Icarus...!" },
					{ Cue = "/VO/Melinoe_4516", Text = "Icarus...!" },
					{ Cue = "/VO/Melinoe_4517", Text = "Hey you!" },
					{ Cue = "/VO/Melinoe_4518", Text = "Hey there." },
					{ Cue = "/VO/Melinoe_4519", Text = "You're here!" },
				},
			},
		},
	},

	ArtemisGreeting =
	{
		WithinDistance = 650,
		TriggerOnceThisRun = true,
		-- PostTriggerAnimation = "Artemis_Salute",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		VoiceLines =
		{
			TriggerCooldowns = { "AnyGreetingSpeech" },
			{
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1094", Text = "Artemis!" },
			},
			{
				ObjectType = "NPC_Artemis_01",
				PreLineAnim = "Artemis_Salute",
				RandomRemaining = true,
				BreakIfPlayed = true,

				{ Cue = "/VO/Artemis_0094", Text = "Fancy running into {#Emph}you {#Prev}again!", PlayFirst = true },
				{ Cue = "/VO/Artemis_0091", Text = "Hail, Sister." },
				{ Cue = "/VO/Artemis_0092", Text = "Hail, Sister!" },
				{ Cue = "/VO/Artemis_0093", Text = "Good evening." },
			},
		},
	},

	ArtemisSinging =
	{
		TrackName = "/Music/ArtemisSong_MC",
		TrackOffsetMin = 10.0,
		TrackOffsetMax = 120.0,
	},
	ArtemisSinging_FromStart =
	{
		TrackName = "/Music/ArtemisSong_MC",
	},

	ArtemisSingingEndTheme =
	{
		TrackName = "/Music/IrisEndThemeCrossroads_MC",
		TrackOffsetMin = 0.0,
		TrackOffsetMax = 120.0,
	},
	ArtemisSingingEndTheme_FromStart =
	{
		TrackName = "/Music/IrisEndThemeCrossroads_MC",
	},

	ArtemisSingingRandom =
	{
		DefaultTrackName = "/Music/ArtemisSong_MC",
		EndThemeTrackName = "/Music/IrisEndThemeCrossroads_MC",
		TrackOffsetMin = 10.0,
		TrackOffsetMax = 120.0,
	},
	ArtemisSingingRandom_FromStart =
	{
		DefaultTrackName = "/Music/ArtemisSong_MC",
		EndThemeTrackName = "/Music/IrisEndThemeCrossroads_MC",
	},

	CharonGreeting =
	{
		WithinDistance = 650,
		SetupFunctions =
		{
			{
				Name = "OverwriteSelf",
				Args =
				{
					WithinDistance = 1000,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1580" },
					},
				},
			},
		},
		GameStateRequirements =
		{
			{
				-- PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},		
		VoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
				{
					Path = { "PreviousDeathAreaRoom", "Name" },
					IsNone = { "Hub_PreRun" }
				},
			},
			{
				BreakIfPlayed = true,				
				UsePlayerSource = true,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_1580", Text = "That breathing...",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Charon_01", SubtitleColor = Color.CharonVoice },
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "CharonGrantsMailbox01", }, },
					},
				},
				Cooldowns =
				{
					{ Name = "CharonSpokeRecently", Time = 10 },
				},
				{ Cue = "/VO/Charon_0058", Text = "{#Emph}Nrrrghh..." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.66,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2278", Text = "You're here, Lord Charon!" },
				{ Cue = "/VO/Melinoe_2279", Text = "Welcome, Lord Charon!" },
			},
			-- tartarus greeting
			{
				{
					PlayOnce = true,
					PlayOnceContext = "CharonTartarusPostTrueEndingGreetingVO",
					BreakIfPlayed = true,
					UsePlayerSource = true,
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "I" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_4192", Text = "Welcome back, Lord Charon!" },
				},
				{
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.33,
					SuccessiveChanceToPlayAll = 0.05,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "I" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = ">=", Value = 0.2, },
						},
					},
					SkipCooldownCheckIfNonePlayed = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_1297", Text = "You made it here in all the clamor, Lord.",
						PlayFirst = true },
					{ Cue = "/VO/MelinoeField_1298", Text = "Remain unseen, my lord." },
					{ Cue = "/VO/MelinoeField_4192", Text = "Welcome back, Lord Charon!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								SumPrevRuns = 8,
								Path = { "SpeechRecord", "/VO/MelinoeField_4192" },
								CountPathTrue = true,
								Comparison = "<=",
								Value = 0,
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					Cooldowns =
					{
						{ Name = "CharonSpokeRecently", Time = 10 },
					},
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1297", "/VO/MelinoeField_1298" },
						},
					},

					{ Cue = "/VO/Charon_0031", Text = "{#Emph}Sshhh..." },
				},
			},
			-- fields & later greeting
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.25,
					SuccessiveChanceToPlayAll = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "H", "I", "O" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Nemesis_01", "NPC_Heracles_01", }, Alive = false },
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = ">=", Value = 0.2, },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_1371", Text = "Good to see you here, my lord!" },
					{ Cue = "/VO/MelinoeField_1372", Text = "The Boatman on the River Styx...!" },
					{ Cue = "/VO/MelinoeField_1373", Text = "Gone all this way, my lord...?" },
					{ Cue = "/VO/MelinoeField_1374", Text = "Lord Charon, thank the gods..." },
				},
			},
			-- misc. greetings
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.5,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Nemesis_01", "NPC_Heracles_01", }, Alive = false, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1229", Text = "Lord Charon...?" },
				{ Cue = "/VO/Melinoe_1230", Text = "Lord Charon...!" },
				{ Cue = "/VO/Melinoe_1231", Text = "Hail, Boatman." },
				{ Cue = "/VO/Melinoe_1233", Text = "Good evening, Boatman." },
				{ Cue = "/VO/Melinoe_2418", Text = "Night protect you, my lord." },
				{ Cue = "/VO/Melinoe_1232", Text = "Lord Charon, I've returned.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsAny = { "F_Shop01", "F_PreBoss01" },
						},
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsNone = { "CharonAboutMoros02" }, },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1674", Text = "It's Charon...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1675", Text = "Lord Charon's set up shop...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1676", Text = "What do we have in stock?",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2414", Text = "You are a welcome sight, my lord.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.33, },
						},
					}
				},
				{ Cue = "/VO/Melinoe_2415", Text = "I sure could use your aid...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1230" },
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.33, },
						},
						{
							PathFalse = { "CurrentRun", "CurrentRoom", "StoreItemsPurchased" }
						},
					},
				},
				{ Cue = "/VO/Melinoe_2416", Text = "I've little coin to trade...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							PathFalse = { "CurrentRun", "CurrentRoom", "StoreItemsPurchased" }
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1230" },
						},
						{
							Path = { "GameState", "Resources", "Money" },
							Comparison = "<",
							Value = 80,
						},
					}
				},
				{ Cue = "/VO/Melinoe_2417", Text = "I haven't much right now...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							PathFalse = { "CurrentRun", "CurrentRoom", "StoreItemsPurchased" }
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1230" },
						},
						{
							Path = { "GameState", "Resources", "Money" },
							Comparison = "<",
							Value = 80,
						},
					}
				},
			},
			{
				SuccessiveChanceToPlay = 0.33,
				-- PreLineAnim = "HecateIdleGreeting",
				RandomRemaining = true,
				-- RequiresNullAmbientMusicId = true,
				-- PreLineAnim = "Charon_Fierce",
				-- PreLineAnim = "Charon_Greeting",
				PreLineAnim = "Charon_Thanking",

				{ Cue = "/VO/Charon_0030", Text = "{#Emph}Mehhh...", PlayFirst = true },
				{ Cue = "/VO/Charon_0031", Text = "{#Emph}Sshhh..." },
				{ Cue = "/VO/Charon_0032", Text = "{#Emph}Ohhh..." },
				{ Cue = "/VO/Charon_0033", Text = "{#Emph}Kkrrrr..." },
				{ Cue = "/VO/Charon_0034", Text = "{#Emph}Hrrm..." },
				{ Cue = "/VO/Charon_0059", Text = "{#Emph}Nnggh..." },
				{ Cue = "/VO/Charon_0060", Text = "{#Emph}Rrnn..." },
				{ Cue = "/VO/Charon_0061", Text = "{#Emph}Grrhh..." },
				{ Cue = "/VO/Charon_0062", Text = "{#Emph}Mmm..." },
				{ Cue = "/VO/Charon_0063", Text = "{#Emph}Haah..." },				
			},
		},
	},

	SeleneGreeting =
	{
		WithinDistance = 930,
		VoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			Cooldowns =
			{
				{ Name = "SeleneGreetingSpeech", Time = 400 },
			},
			{
				{
					RandomRemaining = true,

					{ Cue = "/VO/Selene_0398", Text = "Hail to you." },
					{ Cue = "/VO/Selene_0400", Text = "Hail, Sister." },
					{ Cue = "/VO/Selene_0401", Text = "Sister." },
					{ Cue = "/VO/Selene_0399", Text = "There you are.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "TrueEnding01" },
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "TrueEnding01" }, Min = 8 },
							},
						},
					},
					{ Cue = "/VO/Selene_0105", Text = "Hail to you, Witch of the Crossroads.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "SeleneWithHecate01", }, },
							},
						},
					},
					{ Cue = "/VO/Selene_0396", Text = "Little star...!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "SeleneGift03" },
							},
						},
					},
					{ Cue = "/VO/Selene_0397", Text = "Little star...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "SeleneHome01", }, },
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.33,
					SkipCooldownCheckIfNonePlayed = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
					},

					{ Cue = "/VO/Melinoe_0027", Text = "Sister Selene..." },
				},
			},
		},
	},
	SeleneTrueEndingGreeting =
	{
		WithinDistance = 880,
		VoiceLines =
		{
			{
				{
					UsePlayerSource = true,

					{ Cue = "/VO/MelinoeField_4972", Text = "Sister Selene... Great Nyx..." },
					-- { Cue = "/VO/MelinoeField_3901", Text = "Sister Selene!" },
				},
			},
		},
	},

	ArachneMuttering =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "ArachneInterrupt",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "ArachneGreetingLines" },
		},
		VoiceLines =
		{
			[1] = { GlobalVoiceLines = "ArachneMutteringLines" },
		},
	},
	ArachneMutteringRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "ArachneInterrupt",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "ArachneGreetingLines" },
		},
		VoiceLines =
		{
			[1] = { GlobalVoiceLines = "ArachneMutteringLines" },
		},
	},

	ArachneCostumeChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},

		DefaultGroup = "Combat_Menu_Overlay_Backing",
		ButtonGroupName = "Combat_Menu_Overlay_Backing",
		PurchaseAnimationGroupName = "Combat_Menu_Overlay_Additive",
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "VitalityCostume",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ManaCostume",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "AgilityCostume",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "IncomeCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
				},
			},
			{
				Type = "Trait",
				ItemName = "CastDamageCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
				},
			},
			{
				Type = "Trait",
				ItemName = "HighArmorCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaFabric" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
				},
			},
			{
				Type = "Trait",
				ItemName = "SpellCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
				},
			},
			{
				Type = "Trait",
				ItemName = "EscalatingCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGrantsReward01" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceNew",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsSeen", "EscalatingCostume" },
					},
				},
			},
		},
	},

	NarcissusMuttering =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "NarcissusInterrupt",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "NarcissusGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "NarcissusMutteringLines" },
		},
	},
	NarcissusMutteringContinuous =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		VoiceLines =
		{
			{ GlobalVoiceLines = "NarcissusMutteringLines" },
		},
	},
	NarcissusMutteringRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "NarcissusInterrupt",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "NarcissusGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "NarcissusMutteringLines" },
		},
	},
	NarcissusMutteringContinuousRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		VoiceLines =
		{
			{ GlobalVoiceLines = "NarcissusMutteringLines" },
		},
	},
	NarcissusFieldsGreeting =
	{
		WithinDistance = 1111, ScaleY = 0.75,
		FunctionName = "FieldsBridgeEchoMusic",
		VoiceLines =
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			{ Cue = "/VO/MelinoeField_1172", Text = "Is that...? It's him... Narcissus!",
				GameStateRequirements = 
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "NarcissusWithEcho01" }, },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2855", Text = "Narcissus, he came back...",
				GameStateRequirements = 
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "NarcissusWithEcho02" }, },
					},
				},
			},
		},
	},
	NarcissusBenefitChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},

		DefaultGroup = "Combat_Menu_Overlay_Backing",
		ButtonGroupName = "Combat_Menu_Overlay_Backing",
		PurchaseAnimationGroupName = "Combat_Menu_Overlay_Additive",
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "NarcissusA",
				Rarity = "Common",
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolShovel" },
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusB",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusC",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolPickaxe" },
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusD",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusE",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusF",
				Rarity = "Common",
				GameStateRequirements =
				{
					NamedRequirements = { "RerollAvailable", },
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusG",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGrantsReward01" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceNew",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsSeen", "NarcissusG" },
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusH",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "LifetimeResourcesGained", "PlantGLotus" },
					},
					NamedRequirements = { "MissingLastStand", },
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusI",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "BlindBoxLoot" },
					},
					{
						PathTrue = { "GameState", "LifetimeResourcesGained", "SeedMystery" },
					},
					NamedRequirements = { "BlindBoxLootRequirements" },
				},
			},

		},
	},
		
	EchoBenefitChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},

		DefaultGroup = "Combat_Menu_Overlay_Backing",
		ButtonGroupName = "Combat_Menu_Overlay_Backing",
		PurchaseAnimationGroupName = "Combat_Menu_Overlay_Additive",
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "EchoLastReward",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoLastRunBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoDeathDefianceRefill",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "DiminishingDodgeBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "DiminishingHealthAndManaBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoDoubleLevelBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoDoubleShop",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoRepeatKeepsakeBoon",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus07" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceNew",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsSeen", "EchoRepeatKeepsakeBoon" },
					},
				},
			},
		},
	},

	HadesPersephoneGreeting =
	{
		WithinDistance = 950,
		VoiceLines =
		{
			{ GlobalVoiceLines = "PersephoneGreetingVoiceLines" },
			{
				RandomRemaining = true,
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Hades_Field_01",
				PreLineAnim = "Hades_Hello",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				Cooldowns =
				{
					{ Name = "HadesSpokeRecently", Time = 1.5 },
				},

				{ Cue = "/VO/Hades_0230", Text = "Daughter." },
				{ Cue = "/VO/Hades_0232", Text = "Melinoë." },
				{ Cue = "/VO/Hades_0233", Text = "You're here." },
				{ Cue = "/VO/Hades_0234", Text = "It's her." },
				{ Cue = "/VO/Hades_0235", Text = "It's you." },
				{ Cue = "/VO/Hades_0236", Text = "Welcome." },
				{ Cue = "/VO/Hades_0237", Text = "There she is." },
				{ Cue = "/VO/Hades_0238", Text = "Is that you?" },
				{ Cue = "/VO/Hades_0231", Text = "Our daughter.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01", }, Alive = true },
						},
					},
				},
				{ Cue = "/VO/Hades_0239", Text = "Heel, Cerberus!",
					PreLineFunctionName = "CerberusReaction",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 506405 } },
						},
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "HoundFamiliar" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "PersephoneGreetingVoiceLines" },
		},
	},

	HadesGreeting =
	{
		WithinDistance = 700,
		VoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Hades_Field_01",
				PreLineAnim = "Hades_Hello",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				Cooldowns =
				{
					{ Name = "HadesSpokeRecently", Time = 1.5 },
				},

				{ Cue = "/VO/Hades_0081", Text = "{#Emph}Hrrnn?", PlayFirst = true, BreakIfPlayed = true },
				{ Cue = "/VO/Hades_0073", Text = "Who goes? ...You.",
					PlayFirst = true, BreakIfPlayed = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Hades_0081" },
						},
					},
				},
				{ Cue = "/VO/Hades_0074", Text = "It's you...", PlayFirst = true, },
				{ Cue = "/VO/Hades_0075", Text = "Daughter..." },
				{ Cue = "/VO/Hades_0076", Text = "Daughter...?" },
				{ Cue = "/VO/Hades_0077", Text = "Melinoë..." },
				{ Cue = "/VO/Hades_0078", Text = "Melinoë...?" },
				{ Cue = "/VO/Hades_0079", Text = "Is that you...?" },
				{ Cue = "/VO/Hades_0080", Text = "Back again?" },
				{ Cue = "/VO/Hades_0082", Text = "Wha...?" },
				{ Cue = "/VO/Hades_0083", Text = "Greetings..." },
				{ Cue = "/VO/Hades_0187", Text = "Returned..." },
				{ Cue = "/VO/Hades_0190", Text = "Who... {#Emph}ah." },
				{ Cue = "/VO/Hades_0204", Text = "Heel, Cerberus...!",
					PreLineFunctionName = "CerberusReaction",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 506405 } },
						},
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "HoundFamiliar" },
						},
					},
				},
				{ Cue = "/VO/Hades_0188", Text = "Back again...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomsEntered", "I_Story01" }
						}
					}
				},
				{ Cue = "/VO/Hades_0189", Text = "Back already...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomsEntered", "I_Story01" }
						}
					}
				},
				{ Cue = "/VO/Hades_0084", Text = "Cerberus, look who it is...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids =  { 506405 }, },
						},
					},
				},
				{ Cue = "/VO/Hades_0150", Text = "Cerberus... look who it is.",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids =  { 506405 }, },
						},
					},
				},
				{ Cue = "/VO/Hades_0151", Text = "She's back already, Cerberus...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids =  { 506405 }, },
						},
					},
				},
			},
		},
	},

	ZeusHeraFinalGreeting =
	{
		WithinDistance = 1250,
		VoiceLines =
		{
			{
				PlayOnce = true,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_5021", Text = "Grandfather, with the King and Queen..." },
			},
		}
	},

	ZeusHeraGreeting =
	{
		WithinDistance = 1050,
		VoiceLines =
		{
			GameStateRequirements =
			{
				{
					--
				},
			},
			{
				{
					PlayOnce = true,
					PlayOnceContext = "HeraIntialGreetingVO",
					-- SuccessiveChanceToPlay = 0.75,
					ObjectType = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet",

					{ Cue = "/VO/Hera_0219", Text = "Look, Husband!" },
				},
				{
					RandomRemaining = true,
					-- SuccessiveChanceToPlay = 0.75,
					ObjectType = "NPC_Zeus_Story_01",
					PreLineAnim = "Zeus_Greet",
					SkipCooldownCheckIfNonePlayed = true,

					{ Cue = "/VO/Zeus_0296", Text = "Greetings!" },
					{ Cue = "/VO/Zeus_0297", Text = "Young lady!" },
					{ Cue = "/VO/Zeus_0300", Text = "She arrives!", PlayFirst = true },
					{ Cue = "/VO/Zeus_0302", Text = "My niece!" },
					{ Cue = "/VO/Zeus_0303", Text = "We salute you." },
					{ Cue = "/VO/Zeus_0298", Text = "Welcome!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAny = { "/VO/Zeus_0300" },
							},
						}
					},
					{ Cue = "/VO/Zeus_0299", Text = "Welcome back.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAny = { "/VO/Zeus_0300" },
							},
						}
					},
					{ Cue = "/VO/Zeus_0301", Text = "Come forth!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAny = { "/VO/Zeus_0299" },
							},
						}
					},
				},
				{
					PlayOnce = true,
					PlayOnceContext = "HeraIntialGreetingVO",
					-- SuccessiveChanceToPlay = 0.75,
					ObjectType = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet",
					SuccessiveChanceToPlayAll = 0.66,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Hera_0219" }
						},
					},

					{ Cue = "/VO/Hera_0216", Text = "We welcome you.", PlayFirst = true },
					{ Cue = "/VO/Hera_0217", Text = "Don't be shy!" },
					{ Cue = "/VO/Hera_0218", Text = "Blessings to you!" },

				},
			},
		},
	},

	DemeterGreeting =
	{
		WithinDistance = 850,
		VoiceLines =
		{
			GameStateRequirements =
			{
				{
					--
				},
			},
			{
				{
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.33,

					{ Cue = "/VO/MelinoeField_4252", Text = "Grandmother...!" },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "DemeterPalaceGreetingVO",
					BreakIfPlayed = true,
					-- SuccessiveChanceToPlay = 0.75,
					ObjectType = "NPC_Demeter_Story_01",
					PreLineAnim = "Demeter_Moved",
					SkipCooldownCheckIfNonePlayed = true,

					{ Cue = "/VO/Demeter_0195", Text = "Melinoë...!", PlayFirst = true },
					{ Cue = "/VO/Demeter_0199", Text = "Flower...!" },
					{ Cue = "/VO/Demeter_0202", Text = "Granddaughter.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
				},
			},
		},
	},

	HadesZagreusChatting =
	{
		StartDistance = 1250,
		DistanceTrigger =
		{
			WithinDistance = 350,
			Name = "HadesZagreusInterrupt",
			VoiceLines = { GlobalVoiceLines = "HadesZagreusGreeting" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "HadesZagreusChattingLines" },
		},
	},

	ZagreusEndingGreeting =
	{
		WithinDistance = 520,
		VoiceLines =
		{
			{
				ObjectType = "NPC_Zagreus_01",
				-- PreLineAnim = "Hades_Hello",

				{ Cue = "/VO/Zagreus_0084", Text = "Hey..." },
			},
		},
	},

	NyxGreeting =
	{
		WithinDistance = 900,
		ScaleY = 0.65,
		VoiceLines =
		{
			{
				RandomRemaining = true,
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Nyx_Story_01",
				PreLineAnim = "Nyx_Greeting",
				SkipCooldownCheckIfNonePlayed = true,
				SuccessiveChanceToPlayAll = 0.5,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				Cooldowns =
				{
					{ Name = "NyxSpokeRecently", Time = 3.5 },
				},
				{ Cue = "/VO/Nyx_0092", Text = "The Princess of the Unseen I.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 50,
						},
					},
				},
				{ Cue = "/VO/Nyx_0025", Text = "{#Emph}Ah." },
				{ Cue = "/VO/Nyx_0026", Text = "It is you." },
				-- { Cue = "/VO/Nyx_0029", Text = "Hold." },
				{ Cue = "/VO/Nyx_0031", Text = "Here." },
				{ Cue = "/VO/Nyx_0030", Text = "A moment.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"NyxInChaosAboutShrine02",
								},
							},
						},
					},
				},
				{ Cue = "/VO/Nyx_0027", Text = "A word?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"NyxInChaosPostEpilogue01",
								},
							},
						},
					},
				},
				{ Cue = "/VO/Nyx_0028", Text = "A word, please.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsAny =
								{
									"NyxInChaosAboutHypnosWakeUp01",
								},
							},
						},
					},
				},
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_5113", Text = "Great Night...!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_5114", Text = "Great Nyx..." },
				{ Cue = "/VO/Melinoe_5115", Text = "Hail, O Nyx..." },
				{ Cue = "/VO/Melinoe_5116", Text = "Sorry to interrupt..." },
			},
		},
	},

	MedeaCurseChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},

		DefaultGroup = "Combat_Menu_Overlay_Backing",
		ButtonGroupName = "Combat_Menu_Overlay_Backing",
		PurchaseAnimationGroupName = "Combat_Menu_Overlay_Additive",
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "HealingOnDeathCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "MoneyOnDeathCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ManaOverTimeCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "SpawnDamageCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ArmorPenaltyCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "SlowProjectileCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "DeathDefianceRetaliateCurse",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = ">",
						Value = 0,
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "NewStatusDamage",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaAboutConcoctionQuestComplete01" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceNew",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsSeen", "NewStatusDamage" },
					},
				},
			},
		},
	},

	MedeaResearching =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "MedeaInterrupt",
			PostTriggerAnimation = "Medea_Greet",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "MedeaGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronWrapUpLines" },
		},
	},
	MedeaResearchingRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "MedeaInterrupt",
			PostTriggerAnimation = "Medea_Greet",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "MedeaGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronLines" },
			{ GlobalVoiceLines = "MedeaCauldronWrapUpLines" },
		},
	},
	MedeaWitchcraft =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "MedeaInterrupt",
			PreTriggerAnimation = "Medea_Casting_Start",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "MedeaGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "MedeaIncantationLines" },
		},
	},

	CirceChanting =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "CirceInterrupt",
			PreTriggerAnimation = "Circe_Casting_Start",
			WithinDistance = 500,
			VoiceLines = { GlobalVoiceLines = "CirceGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "CirceChanting" },
			{ GlobalVoiceLines = "CirceChanting" },
			{ GlobalVoiceLines = "CirceChanting" },
			{ GlobalVoiceLines = "CirceChantingWrapUp" },
		},
	},
	CirceChantingRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "CirceInterrupt",
			PreTriggerAnimation = "Circe_Casting_Start",
			WithinDistance = 500,
			VoiceLines = { GlobalVoiceLines = "CirceGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "CirceChanting" },
			{ GlobalVoiceLines = "CirceChanting" },
			{ GlobalVoiceLines = "CirceChanting" },
			{ GlobalVoiceLines = "CirceChantingWrapUp" },
		},
	},

	CirceBlessingChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},

		DefaultGroup = "Combat_Menu_Overlay_Backing",
		ButtonGroupName = "Combat_Menu_Overlay_Backing",
		PurchaseAnimationGroupName = "Combat_Menu_Overlay_Additive",
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "RandomArcanaTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "RemoveShrineTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						FunctionName = "HasAnyCirceRemovableShrineUpgrade",
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "DoubleFamiliarTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "MapState", "FamiliarUnit" },
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "HealAmplifyTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ArcanaRarityTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeCostCache" },
						Comparison = ">",
						Value = 0,
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "CirceEnlargeTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "CirceShrinkTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "CirceSorceryDamageBoon",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = 
						{
							"SpellLaserTrait",
							"SpellLeapTrait",
							"SpellSummonTrait",
							"SpellMeteorTrait",
							"SpellTransformTrait",
							"SpellMoonBeamTrait",
							"SpellPolymorphTrait"
						},
					}
				},
			},
			{
				Type = "Trait",
				ItemName = "ExPolymorphBoon",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutScyllaQuestComplete01" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceNew",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsSeen", "ExPolymorphBoon" },
					},
				},
			},
		},
	},

	IcarusBenefitChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},

		DefaultGroup = "Combat_Menu_Overlay_Backing",
		ButtonGroupName = "Combat_Menu_Overlay_Backing",
		PurchaseAnimationGroupName = "Combat_Menu_Overlay_Additive",
		
		PortraitShift = { Distance = 150, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "FocusAttackDamageTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "SlottedTraits", "Melee" },
					},
				}
			},
			{
				Type = "Trait",
				ItemName = "FocusSpecialDamageTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "SlottedTraits", "Secondary" },
					},
				}
			},
			{
				Type = "Trait",
				ItemName = "OmegaExplodeBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "CastHazardBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "BreakInvincibleArmorBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "BreakExplosiveArmorBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "SupplyDropBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "UpgradeHammerBoon",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "UpgradableHammerCount" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGrantsReward01" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceNew",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsSeen", "UpgradeHammerBoon" },
					},
				},
			},
		},
	},

	DionysusFeasting =
	{
		DistanceTrigger =
		{
			Name = "DionysusInterrupt",
			WithinDistance = 450,
			VoiceLines = { GlobalVoiceLines = "DionysusGreetingLines" },
		},
		VoiceLines =
		{
			{ GlobalVoiceLines = "DionysusFeastingLines" },
		},
	},

	NemesisGetFreeItemArgs =
	{
		Interval = 0.5,
		Force = 200,
		Consumables =
		{
			RandomSelection = true,
			{ Name = "EmptyMaxHealthDrop", },
			{ Name = "HealDrop" },
			{ Name = "LastStandDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "MissingLastStand", },
				},
			},
			{ Name = "ArmorBoost"},
		},
		SourceThreadedVoiceLines = "GivingItemVoiceLines",
		ConsumablePreDropFunctionName = "NemesisDropPresentation",
		ConsumablePreDropFunctionDelay = 0.7,
		ConsumableDropFunctionName = "NemesisPostDropPresentation",
	},
	NemesisGetFreeItemPremiumArgs =
	{
		Interval = 0.5,
		Force = 200,
		Consumables =
		{
			RandomSelection = true,
			{
				Name = "LastStandDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "MissingLastStand", },
				},
				IgnoreSpawnRewardOnId = true,
			},
			{
				Name = "StackUpgradeBig",
				IgnoreLootPoints = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
				},
				IgnoreSpawnRewardOnId = true,
			},
			{ Name = "MaxHealthDropBig" },
			{ Name = "MaxManaDropBig"},
		},
		SourceThreadedVoiceLines = "GivingItemVoiceLines",
		ConsumablePreDropFunctionName = "NemesisDropPresentation",
		ConsumablePreDropFunctionDelay = 0.7,
		ConsumableDropFunctionName = "NemesisPostDropPresentation",
	},

	NemesisDamageContestArgs =
	{
		Interval = 0.5,
		Force = 200,
		Timer = 5,
		DamageGoal = 1000,
		ExcessDamageGoal = 2000,
		SuccessConsumables =
		{
			RandomSelection = true,
			{ Name = "MaxHealthDrop", },
			{ Name = "MaxManaDrop", },
			{ Name = "StackUpgrade",
				IgnoreLootPoints = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
				},
			},
			{ Name = "RoomMoneyDrop", },
			{ Name = "TalentDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "TalentLegal", },
				},
			},
		},
		FailConsumables =
		{
			RandomSelection = true,
			{ Name = "RoomRewardConsolationPrize", },
		},
		ConsumablePreDropFunctionName = "NemesisDropPresentation",
		ConsumablePreDropFunctionDelay = 0.7,
		ConsumableDropFunctionName = "NemesisPostDropPresentation",
	},

	NemesisBuyItemChoices =
	{
		GetItemForce = 200,
		GetItemUpwardForce = 700,
		GiveOptions =
		{
			{
				UseGetCost = true,
			},
		},
		GetOptions =
		{
			{ Name = "MaxHealthDrop", CostResourceName = "Money", CostResourceMin = 105, CostResourceMax = 130,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxHealthDropBig", CostResourceName = "Money", CostResourceMin = 230, CostResourceMax = 255,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MaxManaDrop", CostResourceName = "Money", CostResourceMin = 80, CostResourceMax = 105,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxManaDropBig", CostResourceName = "Money", CostResourceMin = 180, CostResourceMax = 205,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "StackUpgrade", CostResourceName = "Money", CostResourceMin = 80, CostResourceMax = 105,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },

					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "StackUpgradeBig", CostResourceName = "Money", CostResourceMin = 280, CostResourceMax = 305,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
				},
			},

			{ Name = "WeaponUpgrade", CostResourceName = "Money", CostResourceMin = 180, CostResourceMax = 205,
				GameStateRequirements =
				{
					NamedRequirements = { "HammerLootRequirements", },
				},
			},
			{ Name = "WeaponUpgrade", CostResourceName = "Money", CostResourceMin = 180, CostResourceMax = 205,
				GameStateRequirements =
				{
					NamedRequirements = { "LateHammerLootRequirements", },
				},
			},

		},
		TradePostCostFunctionName = "NemesisTradePostCostPresentation",
	},

	NemesisTakeDamageForItemChoices =
	{
		GetItemForce = 200,
		GetItemUpwardForce = 700,
		GiveOptions =
		{
			{
				UseGetDamage = true,
				Icon = "TradeScreenFreeHit",
			},
		},
		GetOptions =
		{
			{ Name = "MaxHealthDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxHealthDropBig", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MaxManaDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxManaDropBig", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "StackUpgrade", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "StackUpgradeBig", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
				},
			},

			{ Name = "RoomMoneyDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "RoomMoneyDrop", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
				},
			},

			{ Name = "TalentDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					NamedRequirements = { "TalentLegal", },
				},
			},
		},

		TradePreCostFunctionName = "NemesisTakeDamagePreCostPresentation",
		TradePostCostFunctionName = "NemesisTakeDamagePostCostPresentation",
		AcceptSourceVoiceLines = "HitAcceptedVoiceLines",
		DeclineSourceVoiceLines = "HitDeclinedVoiceLines",
	},

	NemesisGiveTraitForItemChoices =
	{
		GetItemForce = 200,
		GetItemUpwardForce = 700,
		GiveOptions =
		{
			{
				SellTrait = true,
			},
		},
		GetOptions =
		{
			--[[
			{
				Name = "StackUpgradeTriple",
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
				},
			},
			]]
			{
				Name = "RoomMoneyTripleDrop",
			},
			--[[
			{
				Name = "WeaponUpgrade",
				GameStateRequirements =
				{
					NamedRequirements = { "HammerLootRequirements" },
				},
			},
			{
				Name = "WeaponUpgrade",
				GameStateRequirements =
				{
					NamedRequirements = { "LateHammerLootRequirements" },
				},
			},
			{
				Name = "SpellDrop",
				DisplayName = "SpellDrop_Store",
				GameStateRequirements =
				{
					NamedRequirements = { "SpellDropRequirements" },
				},
			},
			{
				Name = "TalentBigDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "TalentLegal", },
				},
			},
			]]

		},		
		TradePostCostFunctionName = "NemesisTradePostCostPresentation",
	},

	RejectionBoonInteract =
	{
		PreLineWait = 1.0, -- currently unused
		SkipAnim = true,
	},

}

UnitSetData.NPCs =
{
	NPC_Neutral =
	{
		InheritFrom = { "IsNeutral" },
		OnUsedFunctionName = "UseNPC",
		ManualRecordUse = true,
		PostTextLineEvents =
		{
			{
				FunctionName = "PartnersChattingPresentation",
				Threaded = true,
			},
		},
	},

	NPC_Giftable =
	{
		UsePromptOffsetX = 50,
		UsePromptOffsetY = -80,
		CanReceiveGift = true,
		RequireUseToGift = true,
	},

	NPC_Zeus_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		SubtitleColor = Color.ZeusVoice,
		SpeakerName = "Zeus",
		LoadPackages = { "Zeus", },

		TyphonAttackEnterAnimation = "Zeus_TyphonAttack_Start",
		TyphonAttackExitAnimation = "Zeus_TyphonAttack_End",

		TyphonAttackArrivalLines =
		{
			{
				PreLineWait = 0.25,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },

				{ Cue = "/VO/Zeus_0200", Text = "That's quite enough, Typhon!" },
				{ Cue = "/VO/Zeus_0241", Text = "It's {#Emph}me {#Prev}you want, monster!" },
				{ Cue = "/VO/Zeus_0201", Text = "I have another lightning bolt for you, Typhon!" },
				{ Cue = "/VO/Zeus_0202", Text = "I have something for you as well, Typhon!" },
				{ Cue = "/VO/Zeus_0204", Text = "How dare you show your face again, Typhon?!" },
				{ Cue = "/VO/Zeus_0206", Text = "I have more lightning bolts to spare, Typhon!" },
				{ Cue = "/VO/Zeus_0207", Text = "You want vengeance, Typhon? Come {#Emph}take {#Prev}it!" },
				{ Cue = "/VO/Zeus_0210", Text = "Let's see how you like {#Emph}this{#Prev}, you monster!" },
				{ Cue = "/VO/Zeus_0211", Text = "Behold the wrath of Olympus, monstrous wretch!" },
				{ Cue = "/VO/Zeus_0212", Text = "You called for me, you misbegotten brute?!" },
				{ Cue = "/VO/Zeus_0213", Text = "Hark, for it is I, you contemptible fiend!" },
				{ Cue = "/VO/Zeus_0214", Text = "I have arrived, Melinoë! Now stand aside!" },
				{ Cue = "/VO/Zeus_0215", Text = "Young lady, I'll take this from here!" },
				{ Cue = "/VO/Zeus_0216", Text = "Our entire family is behind you, young lady!" },
				{ Cue = "/VO/Zeus_0217", Text = "That monster shall not climb another stone!" },
				{ Cue = "/VO/Zeus_0218", Text = "{#Emph}Everyone{#Prev}, lend me your strength!", PlayFirst = true },
				{ Cue = "/VO/Zeus_0219", Text = "Olympians, let's give him everything we've got!" },
				{ Cue = "/VO/Zeus_0360", Text = "Looking for me, Typhon?" },
				{ Cue = "/VO/Zeus_0361", Text = "Remember my old lightning-bolt, Typhon?" },
				{ Cue = "/VO/Zeus_0356", Text = "We've done this before, we shall do it again!" },
				{ Cue = "/VO/Zeus_0357", Text = "This mountaintop belongs only to gods!" },
				{ Cue = "/VO/Zeus_0355", Text = "Come, remnant of monstrosity, I see you there!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0358", Text = "We shall be rid of you in time, monster!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0359", Text = "We'll destroy even the mere possibility of you!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0362", Text = "Typhon! We'll leave no trace of you behind!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0205", Text = "Have you not had enough of this, Typhon?!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0203", Text = "You never seem to learn a thing, Typhon!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0208", Text = "We shall defeat you every single time, monster!",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "Cleared" },
						},
						{
							Path = { "PrevRun", "RoomsEntered" },
							HasAny = { "Q_Boss01", "Q_Boss02" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0209", Text = "Already forget about last night, monster?!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "Cleared" },
						},
						{
							Path = { "PrevRun", "RoomsEntered" },
							HasAny = { "Q_Boss01", "Q_Boss02" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0236", Text = "Are you all right?!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<", Value = 0.3, },
						},
						NamedRequirements = { "MissingLastStand", },
					},
				},
				{ Cue = "/VO/Zeus_0237", Text = "Hold on, Melinoë!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<", Value = 0.4, },
						},
						NamedRequirements = { "MissingLastStand", },
					},
				},
				{ Cue = "/VO/Zeus_0238", Text = "Do not give in!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<", Value = 0.4, },
						},
						NamedRequirements = { "MissingLastStand", },
					},
				},
				{ Cue = "/VO/Zeus_0239", Text = "Keep fighting!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "TyphonHead" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
				{ Cue = "/VO/Zeus_0240", Text = "Keep him occupied!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "TyphonHead" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
			},
		},

	},

	-- Nyx, -- Night, -- Mother Nyx, Id = 370010
	NPC_Nyx_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Nyx_Default_01",
		SubtitleColor = Color.NyxVoice,
		-- AnimOffsetZ = 270,
		AnimOffsetZ = 220,
		Groups = { "NPCs" },
		LoadPackages = { "Nyx", },

		ActivateRequirements =
		{
			--
		},

		InteractTextLineSets =
		{
			NyxNightmare01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				UseText = "CannotUseObject",

				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				InteractDistance = 400,
				{ Cue = "/EmptyCue", Portrait = "Portrait_Nyx_Frozen_01",
					Text = ". . . ." },
				{ Cue = "/VO/Hades_0018", Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					PreLineWait = 0.35,
					Text = "...Nyx?" },
				{ Cue = "/EmptyCue", Portrait = "Portrait_Nyx_Frozen_01",
					Text = ". . . ." },
				{ Cue = "/VO/Hades_0019", Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					UsePlayerSource = true,
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "FlashbackExpandClamps",
					Text = "Nyx? {#Emph}Nyx! Answer me! {#Prev}Blast...." },
			},
		},
	},

	-- Nyx
	NPC_Nyx_Story_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		Portrait = "Portrait_Nyx_Default_01",
		SubtitleColor = Color.NyxVoice,
		Groups = { "NPCs" },
		InvincibubbleScale = 1.1,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		LoadPackages = { "Nyx", },
		SpeakerName = "Nyx",

		ActivateRequirements =
		{
			--
		},
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			--
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				
				{ Cue = "/VO/Melinoe_5068", Text = "By your will." },
				{ Cue = "/VO/Melinoe_5069", Text = "I am at your service." },
				{ Cue = "/VO/Melinoe_5070", Text = "I salute you." },
				{ Cue = "/VO/Melinoe_5071", Text = "Be well, O Night." },
				{ Cue = "/VO/Melinoe_5072", Text = "I am honored, O Night." },
				{ Cue = "/VO/Melinoe_5073", Text = "Thank you for everything." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				-- PreLineAnim = "Hades_Hello",
				ObjectType = "NPC_Nyx_Story_01",

				{ Cue = "/VO/Nyx_0018", Text = "{#Emph}Hmm." },
				{ Cue = "/VO/Nyx_0019", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Nyx_0020", Text = "I accept it.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5069" },
						},
					},
				},
				{ Cue = "/VO/Nyx_0021", Text = "You in kind.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5070" },
						},
					},
				},
				{ Cue = "/VO/Nyx_0022", Text = "I shall.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5071" },
						},
					},
				},
				{ Cue = "/VO/Nyx_0023", Text = "I am grateful.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5072" },
						},
					},
				},
				{ Cue = "/VO/Nyx_0024", Text = "You are welcome.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5073" },
						},
					},
				},

			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			Cooldowns =
			{
				{ Name = "NyxSpokeRecently", Time = 8 },
			},

			{ Cue = "/VO/Nyx_0099", Text = "Yes?" },
			{ Cue = "/VO/Nyx_0100", Text = "{#Emph}Hm?" },
			{ Cue = "/VO/Nyx_0101", Text = "Descura...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
				},
			},
			{ Cue = "/VO/Nyx_0102", Text = "Lim and Oros...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
				},
			},
			{ Cue = "/VO/Nyx_0103", Text = "Ygnium...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
			},
			{ Cue = "/VO/Nyx_0104", Text = "Zorephet...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
			},
			{ Cue = "/VO/Nyx_0105", Text = "Revaal...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
			},
			{ Cue = "/VO/Nyx_0106", Text = "Xinth...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSut" },
					},
				},
			},
		},

		InteractTextLineSets =
		{
			NyxInChaos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0042",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "How unusual to see you here. My great ancestor and I have much to discuss, and shall resume after you take your leave." },

				{ Cue = "/VO/MelinoeField_4234", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh... forgive my rudeness having interrupted. Shall you come visit us at the Crossroads again soon, O Night?" },

				{ Cue = "/VO/Nyx_0043",
					PreLineAnim = "Nyx_Greeting",
					Text = "Sporadic visits are a possibility, especially after the House of Hades is entirely restored. Although my wish is for my children to be wholly independent of my influence." },

				{ Cue = "/VO/MelinoeField_4235", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "DeathAreaRestoredUpdateHallwayBlocks",
					Text = "Many mothers must feel the same way." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.39,
						ObjectType = "NPC_Nyx_Story_01",
						{ Cue = "/VO/Nyx_0044", Text = "I do not know their feelings, only mine." },
					},
				},

			},
			NyxInChaosAboutChaos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChaosGift07" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0045",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "Chaos typically avoids involvement in matters concerning the Underworld or the surface realms, so this was an exception. At some point we grew closer as a family, perhaps because we learned from yours." },

				{ Cue = "/VO/MelinoeField_4669", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My family always seems to be on the verge of falling apart. This ordeal may have strengthened our bonds, but... sometimes I fear they shall not hold forever." },

				{ Cue = "/VO/Nyx_0046",
					PreLineAnim = "Nyx_Greeting",
					Text = "Weakened bonds may be reforged. That is the reason I am here with Chaos, to start with the eldest of my kin, and work my way down... a lengthy process, but a necessary one." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4670", Text = "To a successful outcome." },
					},
				},

			},

			NyxInChaosAboutPersephone01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NyxGift01", "HadesWithPersephoneGift01" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0047",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "I have many children, but your mother, she does not. Therefore it saddens me that she was not available to witness to your initial growth. She would have nurtured you." },

				{ Cue = "/VO/MelinoeField_4671", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Thank you, though at least we're back in one another's lives. She must be fortunate to have the guidance of the most experienced mother that the world has ever known." },

				{ Cue = "/VO/Nyx_0048",
					PreLineAnim = "Nyx_Greeting",
					PreLineWait = 0.35,
					Text = "It is a learning process even still, though I impart what knowledge I possess. But your mother's intuition for it often is superior to mine." },

				{ Cue = "/VO/MelinoeField_4672", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I look forward to getting to know her better myself. Have the two of you always been close?" },

				{ Cue = "/VO/Nyx_0049",
					PreLineAnim = "Nyx_Greeting",
					Text = "Always is a long time. Though, Queen Persephone and I, we have been close since prior to your brother's birth, and ever since." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4673", Text = "Thank you for looking out for her." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nyx_Story_01",

						{ Cue = "/VO/Nyx_0050", Text = "I always shall." },
						-- { Cue = "/VO/Nyx_0051", Text = "Of course." },
					},
				},
			},
			NyxInChaosAboutHades01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NyxGift02", "HadesWithPersephoneGift06" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0057",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "You know, perhaps, I once presided solely over all the Underworld. There came a point when this exceeded my ability, and so my daughters the Three Fates selected someone to assist with governing the realm: Your father." },

				{ Cue = "/VO/MelinoeField_4677", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That was when he split off from his own brothers and foster-sisters... who became the Olympians. It must have been a turbulent time." },

				{ Cue = "/VO/Nyx_0058",
					PreLineAnim = "Nyx_Greeting",
					Text = "It was a time of change. I did not expect for Hades to take to his role as readily, for it was difficult. Or for Persephone to bring life to this place in a welcome way. And now {#Emph}you {#Prev}and your brother... the realm is better off because of you." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4678", Text = "Thank you, O Nyx." },
					},
				},
			},

			NyxInChaosAboutNyxAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0052",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "You bear my Aspect of the Black Coat. Long has it been since I last wielded it myself. I solve most conflicts indirectly now, but I do think at times about the power of Xinth." },

				{ Cue = "/VO/MelinoeField_4674", UsePlayerSource = true,
					Text = "I am deeply honored to have been entrusted with that power, O Night. Most of the conflicts {#Emph}I've {#Prev}encountered recently... only direct approaches seemed to work." },

				{ Cue = "/VO/Nyx_0053",
					PreLineAnim = "Nyx_Greeting",
					Text = "I understand how that may be, or how it may appear. Thus far, the six Nocturnal Arms have served us well. When I myself could not safeguard the realm, they did." },
			},
			NyxInChaosAboutThanatosAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0055",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "That scythe... that must be Zorephet in the Aspect designated to my Thanatos. He may soon desire its return." },

				{ Cue = "/VO/MelinoeField_4675", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineWait = 0.35,
					Text = "...I had not considered that. Well if the time has come for Zorephet to be with Thanatos once more, then I am grateful for the time we had, and entrust it to you now, O Night." },

				{ Cue = "/VO/Nyx_0056",
					PreLineAnim = "Nyx_Greeting",
					Text = "I did not mean {#Emph}this {#Prev}soon. The Underworld is not yet ready for my son to carry out his work. You are to remain bearer of the Moonstone Axe till then." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/MelinoeField_4676", Text = "{#Emph}Oh... {#Prev}good." },
					},
				},

			},

			NyxInChaosAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = ">=",
						Value = 15,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0064",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "Your service to the realm may go unseen, but has not gone unnoticed, O Melinoë, Princess. As Fear spreads, so does our influence." },

				{ Cue = "/VO/MelinoeField_4683", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "In shadow, I serve; to shadow I return, O Night. And may your will be done." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nyx_Story_01",

						{ Cue = "/VO/Nyx_0065", Text = "If that is your own will." },
					},
				},

			},
			NyxInChaosAboutShrine02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = ">=",
						Value = 42,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0066",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "My testaments within the Oath, enacted to the very last. Despite your demonstrated skill, I was uncertain whether you had the capacity." },

				{ Cue = "/VO/MelinoeField_4684", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was uncertain whether I had the capacity either, O Night. If ever my confidence is unwavering, then there's nothing for me to prove. And nothing to strive for." },

				{ Cue = "/VO/Nyx_0067",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "Well then, it seems you may require something new to strive for now. I trust more Fear may always spread..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/MelinoeField_4685", Text = "Always." },
					},
				},

			},

			NyxInChaosAboutTrophyQuestComplete01 =
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
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/MelinoeField_4690", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wished to thank you for the Gifts of the Veil, O Night. To have earned the title of your Champion is perhaps the greatest honor of my life." },

				{ Cue = "/VO/Nyx_0072",
					PreLineWait = 0.25,
					-- PreLineAnim = "Nyx_Greeting",
					Text = "You possess the Gifts of the Veil. Then, that is good. How did you come about them, and who bestowed the title?" },

				{ Cue = "/VO/MelinoeField_4691", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... completed the trials you put forth, that Commander Schelemeus put forth on your behalf... unless..." },

				{ Cue = "/VO/Nyx_0073",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "Oh yes, the skeleton, of course. I knew him by a different title once. I trust that he administered my {#Emph}trials{#Prev}, as you call them, capably?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4692", Text = "Well, I should think so... yes..." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nyx_Story_01",

						{ Cue = "/VO/Nyx_0074", Text = "Then, good, my champion." },
					},
				},

			},

			NyxInChaosAboutChildren01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--				
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0075",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "Some of my children residing in your Crossroads... we have not always interacted in the most productive way. I once thought that this failing was solely mine. But, I see the pattern frequently; a curse of sorts our families share." },

				{ Cue = "/VO/MelinoeField_4693", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Even a single child seems very difficult to rear. I could not have been an easy one, for all my moods. I scarce imagine how it must have been for you with Nemesis, or Eris..." },

				{ Cue = "/VO/Nyx_0076",
					PreLineAnim = "Nyx_Greeting",
					Text = "Amongst others, yes. I was the constant in most of my children's lives, yet each has been a mystery. May Queen Persephone's relationship with you not be as tenuous as so many of mine." },

				{ Cue = "/VO/MelinoeField_4694", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps you could visit your children more often... smooth things over..." },

				{ Cue = "/VO/Nyx_0077",
					PreLineWait = 0.35,
					PreLineAnim = "Nyx_Greeting",
					Text = "My children tend to need their space. But as I learned with Chaos, we have eternity to reconvene, if we so desire." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/MelinoeField_4695", Text = "Something to look forward to." },
					},
				},

			},

			NyxInChaosAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutFates01" }
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0059",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "My many children dwell in darkness, yet I know where most of them reside. But not my daughters the Three Fates. They were cast into exile, to your knowledge?" },

				{ Cue = "/VO/MelinoeField_4679", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Yes... Chronos sought to get them out of the way, as part of his conquest. I think he feels quite badly about it now, but that hasn't helped us find them. What can we do?" },

				{ Cue = "/VO/Nyx_0060",
					PreLineAnim = "Nyx_Greeting",
					PreLineWait = 0.25,
					Text = "We look for signs. If the Fated List has been revealing prophecies to you, then some traces of their power to communicate remain." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4680", Text = "We'll look for signs." },
					},
				},
			},

			NyxInChaosAboutHypnosWakeUp01 =
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
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0070",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "I trust you are to thank for having shaken my son Hypnos from his slumber and compelled him to return. He had been doing fairly well in his responsibilities, up to a certain point." },

				{ Cue = "/VO/MelinoeField_4688", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please forgive him, O Night. He must have fallen into such a state as a defensive response when the Titan Chronos struck. I am relieved he's well... assuming that he is?" },

				{ Cue = "/VO/Nyx_0071",
					PreLineAnim = "Nyx_Greeting",
					PreLineWait = 0.35,
					Text = "He is himself. His brother Thanatos is pleased to have him back, as is your own. Thank you for looking after him." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/MelinoeField_4689", Text = "Of course." },
					},
				},
			},

			NyxInChaosAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0078",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "How has my daughter Eris been? I regret that Hecate had to contend with her whilst I was unavailable. I did not think that Strife would choose to stay in any given place." },

				{ Cue = "/VO/MelinoeField_4696", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh{#Prev}, Strife. While Eris has been difficult now and again, despite our differences, we have an understanding. She's... exciting to be around, if nothing else." },

				{ Cue = "/VO/Nyx_0079",
					Text = "That is more than I can say. Yet I have learned from her." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4697", Text = "As have I." },
					},
				},

			},

			NyxInChaosAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift09" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0090",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "You have a blessing from my faithful Eye of Night. She is dependable; a quality that I have come to prize above all else. The two of you are close?" },

				{ Cue = "/VO/MelinoeField_4706", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She was always watching over me since I was very small. I am proud to call her Sister now, and to have worked with her directly in all this." },

				{ Cue = "/VO/Nyx_0091",
					PreLineAnim = "Nyx_Greeting",
					Text = "From what I gather, the Moon herself feels very much the same. Long may the two of you illuminate each other's greatest strengths." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4707", Text = "You honor us." },
					},
				},

			},

			NyxInChaosAboutAres01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift07" },
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0087",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "I sense the blessings of the god of war. I have not visited with him or the Olympians since I was indisposed." },

				{ Cue = "/VO/MelinoeField_4704", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think they know that you have much to do right now, O Night. Did you use to travel to the surface very much?" },

				{ Cue = "/VO/Nyx_0088",
					PreLineAnim = "Nyx_Greeting",
					Text = "My influence extends across the realms. And I have had occasion to interact with Lord Ares and the goddess Athena, amongst others. But it is not habitual." },

				{ Cue = "/VO/MelinoeField_4705", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm certain they'll look forward to when next you meet." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Nyx_Story_01",

						{ Cue = "/VO/Nyx_0089", Text = "Some of them fear me, I should think, but yes." },
					},
				},

			},

			NyxInChaosAboutBadgeProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "BadgeRank" },
						Comparison = "==",
						Value = 50,
					},
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0093",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "The notoriety of the Unseen has spread throughout the realms. As a result of your efforts, few remain who would so much as dare to stand against the Underworld now." },

				{ Cue = "/VO/MelinoeField_4708", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We have many loyal Shades in every region keeping watch for us, even as we eliminate remaining traces of the threats that caused us so much harm. But there is more to do." },

				{ Cue = "/VO/Nyx_0094",
					PreLineAnim = "Nyx_Greeting",
					Text = "There always is, Melinoë, Princess. Which is why it can be valuable to take such moments to reflect on how far we have come, regardless of how far we have to go." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4709", Text = "Thank you, O Night." },
					},
				},

			},

			-- partner conversations
			NyxWithNemesis01 =
			{
				Partner = "NPC_Nemesis_01",
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
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 2 },
					},
				},
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566621,
				TeleportOffsetX = 0,
				TeleportOffsetY = 0,
				AngleTowardTargetId = 590204,
				InteractDistance = 450,

				{ Cue = "/VO/Nyx_0038",
					PreLineAnim = "Nyx_Greeting",
					PortraitExitAnimation = "Portrait_Nyx_Default_01_Exit",
					Text = "...I see you all appear to be pursuing your responsibilities with diligence. Each child of mine, a valuable asset to the Witch of the Crossroads in my absence." },

				{ Cue = "/VO/Nemesis_0428",
					Portrait = "Portrait_Nemesis_Averted_01", Speaker = "NPC_Nemesis_01", PreLineWait = 0.35,
					Text = "...Whatever she says goes, Mother. We did what we could." },

				{ Cue = "/VO/Nyx_0039",
					PortraitExitAnimation = "Portrait_Nyx_Default_01_Exit",
					Text = "And Hypnos, he was here throughout this whole ordeal as well. Be certain to pay due respect to Hecate. You may remain here for the time, so long as more is to be done, and that you all continue to cooperate. Are we understood?" },

				{ Cue = "/VO/Nemesis_0429",
					Portrait = "Portrait_Nemesis_Averted_01", Speaker = "NPC_Nemesis_01", PreLineWait = 0.35,
					Text = "...Of course, Mother. We cooperate here all the time." },

				{ Cue = "/VO/Nyx_0040",
					PreLineAnim = "Nyx_Greeting",
					PostLineThreadedFunctionName = "NyxExitPresentation",
					Text = "Of that, I am now certain. But I cannot remain to see it with my own eyes, for the realm has need of me below. Farewell, and may darkness guide you where moonlight cannot." },

				EndVoiceLines =
				{
					PreLineWait = 0.46,
					ObjectType = "NPC_Nemesis_01",
					PreLineAnim = "Nemesis_Hub_Greet",
					{ Cue = "/VO/Nemesis_0430", Text = "Bye, Mother..." },
				},
			},
			NyxWithHecate01 =
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
						HasAll = { "NyxWithNemesis01", "NemesisWithHecate02" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NyxWithNemesis01" }, Min = 2 },
					},
				},
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 556921,
				InteractDistance = 450,

				{ Cue = "/VO/Nyx_0035",
					PreLineAnim = "Nyx_Greeting",
					Text = "Hecate, you have done all I could have asked, and more. My wayward children here were safe within your care. And by the wisdom of your counsel, I am free." },

				{ Cue = "/VO/Hecate_0872",
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "You always have been generous, O Nyx. Above all, I am grateful you returned to us. What of your children, are they heading back with you?" },

				{ Cue = "/VO/Nyx_0036",
					Text = "They are grown, and I have much to do. If it is their wish to remain within these Crossroads, then I ask that you comply. I trust they have not been a burden?" },

				{ Cue = "/VO/Hecate_0873",
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "HecateHubGreet", PreLineAnimTarget = 556921,
					Text = "...Oh, no, of course not." },

				{ Cue = "/VO/Nyx_0037",
					PreLineAnim = "Nyx_Greeting",
					PostLineThreadedFunctionName = "NyxExitPresentation",
					Text = "Then good. I cannot say when next I shall return. Farewell." },

				EndVoiceLines =
				{
					PreLineWait = 0.46,
					ObjectType = "NPC_Hecate_01",
					PreLineAnim = "HecateHubGreet",
					{ Cue = "/VO/Hecate_0874", Text = "Farewell, O Nyx." },
				},
			},

			NyxInChaosPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0061",
					-- PreLineAnim = "Nyx_Greeting",
					Text = "My daughters have returned to us. Knowing them, they gave you the impression that they did so on their own. However, if not for your efforts with the Fated List, they might have never found their way." },

				{ Cue = "/VO/MelinoeField_4681", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Each prophecy fulfilled, a signal to the Fates... a beacon in the darkness of their exile, something of the sort?" },

				{ Cue = "/VO/Nyx_0062",
					PreLineAnim = "Nyx_Greeting",
					PreLineWait = 0.25,
					Text = "That is a reasonable way to think of it. You have done my family a great service, O Melinoë, Princess. The depth of my gratitude is beyond my means to describe." },

				{ Cue = "/VO/MelinoeField_4682", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You honor me, O Night. May all of us cease losing family members for a while." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Nyx_Story_01",
						{ Cue = "/VO/Nyx_0063", Text = "May that be so." },
					},
				},
			},

			-- repeatable
			NyxInChaosChat01 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0107",
					Text = "We welcome you unto the solitude of the abyss, Melinoë, Princess." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat02 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0108",
					Text = "The House of Hades is beginning to grow even stronger than it always was." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat03 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0109",
					Text = "Chaos imagined that you would arrive, and now you stand before us." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat04 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0110",
					Text = "Your father's House can grow quite boisterous, so I seek solace in these depths." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat05 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0111",
					Text = "Your brother has been doing well, and often wonders how you fare." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat06 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0112",
					Text = "Hypnos asked about you recently, as though I had not already told him." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat07 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0113",
					Text = "I trust that Eris has not been {#Emph}too {#Prev}much of an impediment of late." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat08 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "NemesisTakeExitRecord", "TrialUpgrade" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0114",
					Text = "Not long ago I had encountered Nemesis whilst here, and we each spoke of you." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat09 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0115",
					Text = "The Fated List remains within your care, and you have Moros to watch over it." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat10 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0116",
					Text = "May the Nocturnal Arms continue to make manifest your will and wrath." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat11 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0117",
					Text = "Chaos and I have aeons of history to discuss, so please do not wait up." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat12 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0118",
					Text = "This is a very fearsome night, and we have you and all your Vows to thank for it." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat13 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0119",
					Text = "May the blessing of faithful Selene guide you well beyond this point." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat14 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0120",
					Text = "Persephone the Queen is often filled with joy that you have reunited finally." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},
			NyxInChaosChat15 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NyxGreeting,

				{ Cue = "/VO/Nyx_0121",
					Text = "In our obscurity lies strength. Seek to be valuable, not to be known." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Nyx",
			},

			-- @ ending
			SeleneTrueEnding01 =
			{
				Partner = "NPC_Selene_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false, -- played via script
			},
		},

		GiftTextLineSets =
		{
			NyxGift01 =
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
						PathTrue = { "GameState", "TextLinesRecord", "NyxInChaos01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4710", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Empathetic_01",
					Text = "I wish to make an offering to you, O Night. For always concealing the Crossroads where I grew up, for the Nocturnal Arms, and all the many other gifts you bestowed." },
				{ Cue = "/VO/Nyx_0095",
					-- PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					PreLineAnim = "Nyx_Greeting",
					Text = "I thank you for this, child. And may the Nocturnal Arms long serve you as a Keepsake of sorts from me. The Witch of the Crossroads says you wield them with skill and grace." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_4711", Text = "She does, does she..." },
					},
				},
			},
			NyxGift02 =
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
						PathTrue = { "GameState", "TextLinesRecord", "NyxGift01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4712", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Empathetic_01",
					Text = "I wished to give you something more, O Night. For caring for Sister Selene, who is a dear friend, along with your wonderful children whom I've come to know." },
				{ Cue = "/VO/Nyx_0096",
					PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					PreLineAnim = "Nyx_Greeting",
					Text = "Your family's custom is not mine, child. Nor do I wish to accept such gratitude whilst there is so much to be done before the realm is at full strength again. You have my thanks, as well as that request." },
			},
		},

	},

	-- Other NPCs
	NPC_LightRanged =
	{
		InheritFrom = { "NPC_Neutral" },

		Groups = { "NPCS", "3DGhosts" },

		ActivateRequirements =
		{
		},

		InteractTextLineSets = {},

		PostActivateEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetAnimation = "Enemy_LightRanged_Idle",
					AnimationSpeedMultiplierMin = 0.5,
					AnimationSpeedMultiplierMax = 1.0,
				},
				GameStateRequirements =
				{
					-- None
				},
			},
		},
	},
	NPC_3DGhostAlt =
	{
		InheritFrom = { "NPC_Neutral" },

		Groups = { "NPCS", "3DGhosts" },

		ActivateRequirements =
		{
		},

		InteractTextLineSets = { }
	},
	NPC_LeopardGuest =
	{
		InheritFrom = { "NPC_Neutral" },

		Groups = { "NPCS", },
	},

	-- @ ending

	-- Zagreus
	NPC_Zagreus_Past_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		SubtitleColor = Color.ZagreusVoice,

		Portrait = "Portrait_Zag_Default_01",
		AnimOffsetZ = 30,
		Groups = { "NPCs" },
		LoadPackages = { "Zagreus", },

		OnUsedFunctionArgs = 
		{
			AngleTowardTargetId = 772208,
		},

		ActivateRequirements =
		{
			--
		},

		PostActivateEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { SetAlpha = 0.3, },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_PostBoss01" },
					},
				},
			},
		},

		InteractTextLineSets =
		{
			ZagreusPastFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreusAlt",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",

				{ Cue = "/VO/Zagreus_0008",
					Portrait = "Portrait_Zag_Defiant_01",
					-- Portrait = "Portrait_Zag_Empathetic_01",
					-- Portrait = "Portrait_Zag_Serious_01",
					PreLineWait = 0.35,
					-- PreLineAnim = "Zagreus_Greet",
					-- PreLineAnim = "Zagreus_Talk_Start",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "{#Emph}Erm... {#Prev}is my hair getting lighter and my features getting fairer, or did I consume something that really isn't sitting well...?" },

				{ Cue = "/VO/MelinoeField_3425", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Prince Zagreus, please listen to my voice! Can you hear me? Can you {#Emph}hear {#Prev}me?" },

				{ Cue = "/VO/Zagreus_0009",
					Portrait = "Portrait_Zag_Empathetic_01",
					PreLineWait = 0.35,
					Text = "...Definitely something I consumed, then. Or else... {#Emph}oh {#Prev}this is just a dream...! Hypnos has been growing rather bold with these! Is that {#Emph}you {#Prev}in there, mate?" },

				{ Cue = "/VO/MelinoeField_3426", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, I... look, yes, technically this is a dream. But it's the only way I could reach out to you across the span of Time! Now, {#Emph}please! {#Prev}Our family is in danger, and I need your aid!" },

				{ Cue = "/VO/Zagreus_0010",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "All right, all right, slow down! It's fortunate I rather {#Emph}like {#Prev}such realistic dreams. And what do you mean {#Emph}our family? {#Prev}Who {#Emph}are {#Prev}you? Probably one of Mother's many cousins. Wouldn't explain the eyes, though. Or my father's sigil on your outfit..." },

				{ Cue = "/VO/MelinoeField_3427", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Let me speak! Look, this is going to be difficult for you to accept, but... I'm Melinoë... your sister. From another time; a future time, not all that distant from your own!" },

				{ Cue = "/VO/Zagreus_0011",
					Text = "...See, that was going to be my next guess. Well, dream-sister-from-a-future-time? I would never want to snap awake before hearing you out, so what's the situation? What do you want me to do...?" },

				{ Cue = "/VO/MelinoeField_3428", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "I want you to find our grandfather Chronos, and destroy him! Because there's only so much I can do here myself. He's taken over your entire House...! Imprisoned our father, Mother, you, {#Emph}everybody...! {#Prev}And now he threatens Olympus. All as vengeance for what the gods once did." },

				{ Cue = "/VO/Zagreus_0012",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineWait = 0.5,
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "...Right. When you say {#Emph}what the gods once did{#Prev}, you mean the part where they got rid of Chronos permanently, long before I was ever born? Or you for that matter. But in the not-all-that-distant future, he returns, and single-handedly takes over everything..." },

				{ Cue = "/VO/MelinoeField_3429", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Yes. Please believe me! I myself was very little when the Titan struck, and have been training all my life in preparation for this very moment! But I cannot stop Chronos on my own. Will you aid me?" },

				{ Cue = "/VO/Zagreus_0013",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineWait = 0.25,
					Text = "I'm guessing not? Since this is a dream, and I'll likely just forget about it soon as I wake up! Also, you look and sound just like a figment of my imagination would probably look and sound. Can you {#Emph}prove {#Prev}anything you've said?" },

				{ Cue = "/VO/MelinoeField_3430", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You won't forget me when you wake, I promise you. As for the proof you seek... you must know of Hecate, our Mother's handmaiden! She trained me for this. Seek her, and tell her what I've said — but no one else!" },

				{ Cue = "/VO/Zagreus_0014",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 9.15, UseChronosSound = true },
					PreLineWait = 0.35,
					Text = "{#Emph}Erm{#Prev}, Sister, I'm afraid our mother {#Emph}has {#Prev}no such handmaiden... although, in some strange way you mentioning a name I've never heard is better proof than anything you've said to me thus far. Wait, what's the matter...?" },

				{ Cue = "/VO/MelinoeField_3431", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					SecretMusic = "/Music/MusicHadesReset2_MC", SecretMusicSection = 0, SecretMusicActiveStems = { "Guitar", }, SecretMusicMutedStems = { "Drums", "Bass" },
					Text = "It's Chronos! I've incapacitated him, but he'll return... just as he will eventually in your own time. I need to go... before he finds me here, I need to go!" },

				{ Cue = "/VO/Zagreus_0015",
					Portrait = "Portrait_Zag_Empathetic_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "But you just got here! Look... Melinoë, was it? Will I ever see you again, or was this more of a one-off?" },

				{ Cue = "/VO/MelinoeField_3432", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I found you across dreams and time, Brother. I'll stop at nothing to do it again! Until then, please, let this remain a secret between us." },

				{ Cue = "/VO/Zagreus_0016",
					Portrait = "Portrait_Zag_Empathetic_01",
					PreLineWait = 0.35,
					Text = "...Great, I can't even tell Hypnos. Well, suit yourself! See you another day, Sister. Or night...?",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3433", Text = "Till then!" },
					},
				},
			},

			ZagreusPastMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",

				{ Cue = "/VO/Zagreus_0019",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Zag_Default_01", WaitTime = 4 },
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "...Just as I'm about to get my hair under control! Who are you, and what have you done with my reflection...? Only joking. I remembered everything just as you said. Particularly since you're here again so soon. Where were we?" },

				{ Cue = "/VO/MelinoeField_3437", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Vulnerable_01",
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I was trying to persuade you to take me at my word that I'm your sister from a future time, in which the Titan Chronos has usurped the House of Hades. I mean to stop him, and require your assistance." },

				{ Cue = "/VO/Zagreus_0020",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "I have a wide variety of questions first, even knowing that our time apparently is limited. First off, why {#Emph}me? {#Prev}Although I {#Emph}am {#Prev}the designated Security Specialist around here, so perhaps I know the answer to that one." },

				{ Cue = "/VO/MelinoeField_3438", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Some Security Specialist. Chronos caught the House entirely off guard! But you're my closest kin, you've subverted the will of the Fates before, and slain gods, if not Titans... I also lack the means of reaching anybody else this way." },

				{ Cue = "/VO/Zagreus_0021",
					Portrait = "Portrait_Zag_Empathetic_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Well, great! I feel that strong kinship between us already. Next question: Where even is this Chronos, and what would you have me do if and when I locate him? A two-parter for you." },

				{ Cue = "/VO/MelinoeField_3439", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I don't know where Chronos is exactly in your time, though I mean to find out. I know only that his remains were scattered to the deepest pits of Tartarus, which means... he's probably recovering somewhere near where you reside. As for what to do if you locate him... I can't yet say either." },

				{ Cue = "/VO/Zagreus_0022",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "{#Emph}Erm{#Prev}, I hate to break it to you, Melinoë, but this isn't all that comprehensive a plan. Especially for something you've been planning all your life. Do I just wait for you to work through the details, or...?" },

				{ Cue = "/VO/MelinoeField_3440", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No! Look. You're Security Specialist! Begin an investigation, though in absolute secrecy. Is anything amiss anywhere in the House, or in Tartarus? Any unusual activity from Satyrs, for example?" },

				{ Cue = "/VO/Zagreus_0023",
					Portrait = "Portrait_Zag_Defiant_01",
					Text = "We've had our share of Satyr problems, though not anywhere nearby. But I can have a look around. What about you...? Wait, are you in my {#Emph}bedchambers?" },

				{ Cue = "/VO/MelinoeField_3441", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 8.65, UseChronosSound = true },

					Text = "What's left of them, yes! I can only reach you like this while we're in the same location across Time. At any rate... I have to find the means for you to destroy the Titan there before he regains his full strength. But... blast." },

				{ Cue = "/VO/Zagreus_0024",
					Portrait = "Portrait_Zag_Serious_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "What is it, do you have to go again? Then don't wait up on my account. I'll see what I can do and speak to you when next you haunt my dreams. Take care, Sister! We'll sort this out." },

				{ Cue = "/VO/MelinoeField_3442", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "You make it sound so effortless... farewell, Brother. Until we see each other next.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			-- on the critical path between 02 and 03
			ZagreusPastMeeting02_2 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",

				{ Cue = "/VO/Zagreus_0424",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Default_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					PreLineAnim = "Zagreus_Talk_Start",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Zag_Empathetic_01", WaitTime = 7 },

					Text = "Hi there, Melinoë! My investigation into our grandfather's scheming is underway, though difficult to make good progress without telling anybody what I'm up to. Don't take this the wrong way, but... this truly is your only idea?" },

				{ Cue = "/VO/MelinoeField_5046", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Vulnerable_01",
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Yes. I don't think I can stop Chronos here. Even Olympus is stuck trying to keep his forces at bay. And he's far too hateful and hard-headed to stop on his own." },

				{ Cue = "/VO/Zagreus_0425",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "That's our family for you. Father certainly has no love for Chronos but he never speaks of him. Do you... happen to know what went over between them, to have made things this bad?" },

				{ Cue = "/VO/MelinoeField_5047", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're in a better position to ask our father about that than I am. Chronos was a tyrant, and his children wouldn't have it! The Fates themselves deemed that the gods should rule! But that apparently wasn't enough for him." },

				{ Cue = "/VO/Zagreus_0426",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "So now you want me to stop him for you. I mean, for {#Emph}us. {#Prev}I've had mixed experiences vanquishing certain members of our family before, but... that wasn't {#Emph}forever. {#Prev}And you've said next to nothing about how you expect me to do it." },

				{ Cue = "/VO/MelinoeField_5048", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Look... I have knowledge of an incantation known as Dissolution of Time. It requires several complicated steps I shall explain along the way. If it works... it should unravel him." },

				{ Cue = "/VO/Zagreus_0427",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "{#Emph}Unravel him. {#Prev}That's a little vague for me, unless Chronos turns out to be a spool of yarn. Can you be more specific?" },

				{ Cue = "/VO/MelinoeField_5049", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Unmake him. {#Prev}Destroy his ambitions along with him. Undo all the harm he caused. A threefold family bond is required: you, me, and Chronos. Then we shall infuse a special weapon with the negation of his very being... I'll get into that later." },

				{ Cue = "/VO/Zagreus_0428",
					Portrait = "Portrait_Zag_Defiant_01",
					Text = "...Well great I think you cleared everything up. Though I'll admit I don't like having to kill off family members just because Father doesn't know how to get along with them." },

				{ Cue = "/VO/MelinoeField_5050", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					-- Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 2.0, UseChronosSound = true },

					Text = "You would blame Father in all this? {#Emph}Ungh{#Prev}, blast... Chronos is starting to revive. I have to go. Keep searching for any sign of him! And remember, this is for all of us!" },

				{ Cue = "/VO/Zagreus_0429",
					Portrait = "Portrait_Zag_Serious_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "I will, and... I understand, I think. We didn't ask to be born into this but it's what we got. We'll handle it as best we can." },

				{ Cue = "/VO/MelinoeField_5051", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "That's right. Thank you, brother. Take care of yourself... and be kind to Mother, Father, Cerberus, and all, for me.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			ZagreusPastMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
					},
				},

				{ Cue = "/VO/Zagreus_0028",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					PreLineAnim = "Zagreus_Greet",
					Text = "Hello again, Sister. You wanted me to search for signs of Chronos preparing for a big surprise, and... while it isn't much... I {#Emph}did {#Prev}locate machinery in Tartarus that seemed a little out-of-place." },

				{ Cue = "/VO/MelinoeField_3443", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Machinery... you mean the gears that turn the ever-shifting chambers. In my time, that machinery has spread through Tartarus as far as I can see. What do you make of it?" },

				{ Cue = "/VO/Zagreus_0029",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "Well... normally I wouldn't have made anything of it, but perhaps it's connected to what you're saying. I'm working on tracing where it leads. What about you, any word about how we ought to proceed?" },

				{ Cue = "/VO/MelinoeField_3444", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We need a weapon. The problem is that Chronos can resist the Arms once used to vanquish him. On top of that, it needs to be available both to you in your time, and to me in mine. The closer to our family the better. Can you think of something suitable?" },

				{ Cue = "/VO/Zagreus_0030",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineWait = 0.35,
					Text = "...Nothing immediately comes to mind. I have some mortal weapons in my chambers but they hardly worked at any point. A weapon both in my time and in yours... and none of the Infernal Arms will do..." },

				{ Cue = "/VO/MelinoeField_3445", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "Give it some thought, but please make haste. Chronos shall realize what I am up to here eventually, and this connection weakens every night. For now I'd better go." },

				{ Cue = "/VO/Zagreus_0031",
					Portrait = "Portrait_Zag_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Hold on! What happened to the servants of this House... to my friends? You said Chronos took everybody. Did you mean {#Emph}everybody{#Prev}-everybody, or...?" },

				{ Cue = "/VO/MelinoeField_3446", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well... no, {#Emph}erm{#Prev}, Hypnos is with us, but fast asleep. Commander Schelemeus, too; he's marshaling the Shades still loyal to our father. Poor Cerberus has been cast out into the Mourning Fields. But as for all the rest..." },

				{ Cue = "/VO/Zagreus_0032",
					Portrait = "Portrait_Zag_Defiant_01",
					Text = "Oh, at least the good {#Emph}Commander Schelemeus {#Prev}made it out. But Nyx, Achilles, Thanatos, Megaera, Dusa, Orpheus... our grandfather has all of them locked up?" },

				{ Cue = "/VO/MelinoeField_3447", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "He has our father bound in chains in Tartarus. I understand he's trapped the others... frozen them in Time. But we can break his hold on them. I'm certain that we can. Goodbye for now, Brother! Think of a weapon we can use to set this right.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			ZagreusPastMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" },
					},
				},

				{ Cue = "/VO/Zagreus_0036",
					Portrait = "Portrait_Zag_Serious_01",
					PreLineWait = 0.35,
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "...{#Emph}Gigaros. {#Prev}My father's spear. You said that we would need a weapon that's available in both our times, is close to our family, and not been used to slay Chronos before. That one should do. It's big... and it hurts." },

				{ Cue = "/VO/MelinoeField_3448", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Huh... {#Prev}I see how that may work. The only problem is I've no idea where to find this Gigaros. Chronos likely got a hold of it. But that's in {#Emph}my {#Prev}time... while in {#Emph}yours..." },

				{ Cue = "/VO/Zagreus_0037",
					Portrait = "Portrait_Zag_Defiant_01",
					Text = "{#Emph}Eh{#Prev}, Father doesn't often let me use it anyway, and it's sealed off in his chambers. There must be something else. Though, at least I found the place where Chronos probably is piecing himself back together little by little!" },

				{ Cue = "/VO/MelinoeField_3449", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "You did? Where, what happened? How do you know it's the correct location?" },

				{ Cue = "/VO/Zagreus_0038",
					Portrait = "Portrait_Zag_Serious_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Well for one thing, it appears to be directly underneath this House! Odd place to bury one's predecessor, but Father {#Emph}can {#Prev}be quite particular with punishments. Anyway when I descended deeper into Tartarus, I found a Satyr infestation that led me to some sort of cave. I went no farther for now." },

				{ Cue = "/VO/MelinoeField_3450", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Good. And do not enter until everything's prepared. But let's go back a moment to our father's spear. Is there some way you could procure it?" },

				{ Cue = "/VO/Zagreus_0039",
					TextLimit = 300,
					Text = "Sure. Father's chambers may be strictly off limits, though no Security Specialist of any worth would be so easily deterred! I'll likely suffer an eternity of torment, but sounds like Chronos has that in store for me regardless. So... what shall I do with Gigaros assuming I can get my hands on it?" },

				{ Cue = "/VO/MelinoeField_3451", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Keep it someplace secure. Could you persuade our father to {#Emph}give {#Prev}it to you, without letting him know exactly why? If we tamper too much with Time, Chronos shall find out. I suppose there's also the problem of how to transfer Gigaros across an astral-psychic pathway..." },

				{ Cue = "/VO/Zagreus_0040",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Details, details, Sister! I like this plan, and Father owes me anyway. So are you some sort of oracle, gathering up ancient artifacts, speaking to me in dreams and such? Perhaps these count as nightmares, what with the terrible future to look forward to." },

				{ Cue = "/VO/MelinoeField_3452", UsePlayerSource = true,
					Text = "We'll change that future. And I'm no oracle; I'm what you call a Witch. We're getting closer to our goal, Brother. Claim Father's spear, and I have more to do myself. I'll see you again soon.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			-- Gigaros procured here, needed for StopTyphon
			ZagreusPastMeeting05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
					},
				},

				{ Cue = "/VO/MelinoeField_3861", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "Zagreus, you did it...! I found Gigaros waiting for me. So then it's true... your choices and actions in the past..." },

				{ Cue = "/VO/Zagreus_0045",
					Text = "...affect the future. Don't see how come {#Emph}you're {#Prev}so surprised! I figured you expected this result. If I'm able to destroy Chronos in {#Emph}my {#Prev}time, before he takes control in yours, then everything will be all right... won't it?" },

				{ Cue = "/VO/MelinoeField_3862", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well I assume so, yes. Any outcome would be better than to be subjected to his reign! He's taken our family, thrown open the gates of the Underworld, struck Olympus...! He deserves death in the mortal sense." },

				{ Cue = "/VO/Zagreus_0046",
					Portrait = "Portrait_Zag_Empathetic_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "...I'll take your word for it. Though, tell me something, let's say I go destroy the Titan Chronos as we planned... what happens to you? You're here because of everything he did. But the past will have changed your present..." },

				{ Cue = "/VO/MelinoeField_3863", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No! If Chronos hadn't taken Father's throne, we'd be together as a family! He denied me a father, a mother, a three-headed dog... {#Emph}you! {#Prev}And some evening he'll deny you that and more if you don't do exactly as I ask." },

				{ Cue = "/VO/Zagreus_0047",
					Portrait = "Portrait_Zag_Empathetic_01",
					PreLineAnim = "Zagreus_Greet",
					Text = "{#Emph}OK! {#Prev}OK. It's just... it turns out I have a sister and I don't want to lose her over this, is all. Though I suppose we'd meet again eventually. Anyway this hurts my head, which is strange considering I'm in this nightmare-sort-of-thing." },

				{ Cue = "/VO/MelinoeField_3864", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "I understand. Communicating across Time like this should not be possible... not even Chronos thinks it can be done. But he is old and arrogant. He doesn't know the limits of his capability, which is our only chance." },

				{ Cue = "/VO/Zagreus_0048",
					Portrait = "Portrait_Zag_Defiant_01",
					Text = "So now I wait for you to contact me again, once you've infused our father's spear with some temporal nightmare curse, and I'll descend into Grandfather's fetid lair, where I'll drive said spear into his heart? Something like that?" },

				{ Cue = "/VO/MelinoeField_3865", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Yes, something very much like that. Preparing Gigaros may take a little while, and... I may have some difficulty reaching you until such time. But I promise you I shall return. Till then, be careful, Zagreus. Big brother.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			-- Requires Entropy from completing StopTyphon
			ZagreusPastMeeting06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeTimeStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},

				{ Cue = "/VO/Zagreus_0052",
					-- Portrait = "Portrait_Zag_Serious_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Melinoë! You've returned. You've no idea how much difficulty I had falling asleep so I could see you here again. So what's the word, have you prepared the spear?" },

				{ Cue = "/VO/MelinoeField_3883", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Take hold of Gigaros, and we'll find out. A couple of points first. One, you'll have to go immediately to where Chronos resides. And two, our connection with each other shall probably be lost. I'll be counting on you to succeed." },

				{ Cue = "/VO/Zagreus_0053",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "Don't worry, I'll take care of it. But, before we do this... you're certain there's no other way? You've nicely asked Grandfather to stand down, that sort of thing?" },

				{ Cue = "/VO/MelinoeField_4974", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We're far past level-headed conversation here. I can't imagine he'll be more amenable to persuasion in your time than mine. And as I understand, nicely asking our father if you could leave the Underworld had mixed results for you." },

				{ Cue = "/VO/Zagreus_0400",
					Portrait = "Portrait_Zag_Serious_01",
					PreLineFunctionName = "ZagreusSpearEquipPresentation",
					Text = "Fair point. You really think this spear of Father's has the power to destroy a deathless Titan?" },

				{ Cue = "/VO/MelinoeField_4270", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineThreadedFunctionName = "GigarosSpellPresentation", PreLineThreadedFunctionArgs = { SetAnimation = "Melinoe_GigarosSpell", PreWait = 2.5, WaitTime = 8.0 },
					Text = "It shall in just a moment, so hold it close. {#Emph}May Earth and Night and Darkness hear me now: Bring true death for the deathless by my vow. Dissolution of Time!" },

				{ Cue = "/VO/Zagreus_0055",
					PreLineWait = 0.85,
					Portrait = "Portrait_Zag_Empathetic_01",
					--PreLineAnim = "Zagreus_Talk_Start",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },
					Text = "...Gigaros... it's grown hot to the touch... but feels much lighter than before as well! I suppose I should be careful not to prod somebody with it... besides Chronos." },

				{ Cue = "/VO/MelinoeField_3886", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PortraitExitAnimation = "Portrait_Mel_Vulnerable_01_Exit",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Go, Zagreus. I've done everything I can here. And we'll see each other again. Some other time than this, perhaps, but still. For now, farewell.",
					PostLineFunctionName = "BedroomToChronosSanctumPresentation",
				},

				-- Chronos Sanctum
				{ Cue = "/VO/Chronos_0967",
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Who goes there?! You lack the clopping of the Satyr's hooves, and have a countenance which I know not." },

				{ Cue = "/VO/Zagreus_0077",
					Portrait = "Portrait_Zag_Defiant_02",
					Speaker = "NPC_Zagreus_Past_01",
					PreLineWait = 0.35,
					Text = "You must be Grandfather. I don't believe we've had the pleasure, I'm called Zagreus. I got a tip about your quite-suspicious cavern here and had to go take a look. What are you doing here, if I may ask?" },

				{ Cue = "/VO/Chronos_0968",
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "{#Emph}Recuperating! {#Prev}What else would I possibly be doing in a place such as this? So I suppose Hades is to thank for this new grandchild of mine. I never thought that I would see the age when he became a father for himself." },

				{ Cue = "/VO/Zagreus_0078",
					Portrait = "Portrait_Zag_Empathetic_02",
					Speaker = "NPC_Zagreus_Past_01",
					Text = "Oh, he's a {#Emph}wonderful {#Prev}father, if you must know! So much so I have a little sister, too! {#Emph}Melinoë! {#Prev}Looks more like our dear mother Persephone the Underworld Queen, though has a bit of your son's prickly personality I think. You'd {#Emph}love {#Prev}her!" },

				{ Cue = "/VO/Chronos_0969",
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					PreLineWait = 0.35,
					Text = "Why are you telling me all this? Answer immediately, lest my Satyrs tear you to shreds! Where {#Emph}are {#Prev}those blasted Satyrs anyhow...?" },

				{ Cue = "/VO/Zagreus_0079",
					Portrait = "Portrait_Zag_Defiant_02",
					Speaker = "NPC_Zagreus_Past_01",
					Text = "Grandfather... I'm telling you all this because I thought I'd make a little small talk here before I do you in. You would bring pain and suffering upon my House, and as our designated Security Specialist, I cannot allow that." },

				{ Cue = "/VO/Chronos_0970",
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Pah! {#Prev}What would you know of my intent? You dare speak to me of pain and suffering? Here I have rotted since an aeon prior to when you were but a twinkle in your father's eye! He and his brothers, traitors and usurpers!" },

				{ Cue = "/VO/Zagreus_0080",
					Portrait = "Portrait_Zag_Defiant_02",
					Speaker = "NPC_Zagreus_Past_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Zag_Empathetic_02", WaitTime = 5.0 },

					Text = "They're your children. Look, you don't have to like them all the time, I know {#Emph}I {#Prev}don't, but... what of Melinoë and me? Are you prepared to sweep {#Emph}us {#Prev}into your old grudge?" },

				{ Cue = "/VO/Chronos_0971",
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Why would I not? Your father surely has already poisoned you against me. You and your {#Emph}little sister {#Prev}both!" },

				{ Cue = "/VO/Zagreus_0081",
					Portrait = "Portrait_Zag_Serious_02",
					PortraitExitAnimation = "Portrait_Zag_Serious_02_Exit",
					Speaker = "NPC_Zagreus_Past_01",
					Text = "Would I be speaking to you if that were the case? Here's the arrangement: Either take pity on your grandchildren... or take this spear repeatedly. And you won't soon recuperate, I swear. Which is it going to be?" },

				{ Cue = "/VO/Chronos_1303",
					PreLineWait = 0.85,
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "...You, who threaten me with annihilation, have not experienced a world without Time. You would come to dearly miss my influence! Nor would my {#Emph}pity {#Prev}do you any good... how exactly would you see it manifest?" },

				{ Cue = "/VO/Zagreus_0109",
					Portrait = "Portrait_Zag_Empathetic_02",
					Speaker = "NPC_Zagreus_Past_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Zag_Defiant_02", WaitTime = 6.0 },

					Text = "Oh I don't know, perhaps just by being our grandfather, rather than sneaking underneath the House in some sort of profane chamber I ought have known about? You're Time. Why don't you extrapolate a bit?" },

				{ Cue = "/VO/Chronos_1304",
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Extrapolate {#Emph}what... {#Prev}a joy-filled life in which Grandfather Time is there to coddle the spoiled children of my rancorous son? Hades shall drive that accursed spear through me on sight if you do not!" },

				{ Cue = "/VO/Zagreus_0110",
					Portrait = "Portrait_Zag_Defiant_02",
					PortraitExitAnimation = "Portrait_Zag_Defiant_01_Exit",
					Speaker = "NPC_Zagreus_Past_01",
					Text = "No, because you'll be under my protection. And also, no, it won't just be a joy-filled life, especially if you keep on. But it'll probably be better than whatever {#Emph}this {#Prev}is! Now make your choice already. I don't have all day or night." },

				{ Cue = "/VO/Chronos_1305",
					PreLineWait = 0.5,
					Source = "NPC_Chronos_Story_01",
					Portrait = "Portrait_Chronos_Averted_01",
					PortraitExitAnimation = "Portrait_Chronos_Averted_01_Exit",
					PostLineFunctionName = "ChronosSanctumExitPresentation",
					Text = "{#Emph}<Scoff> {#Prev}So then, a future with such grandchildren as you, or the eternal void... how can I possibly decide...?" },
			},

			-- optional; after a clear if StormStop has not been cast yet
			ZagreusPastMeeting07 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},

				{ Cue = "/VO/Zagreus_0059",
					Portrait = "Portrait_Zag_Empathetic_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "Is that {#Emph}you{#Prev}, Melinoë? I can hardly see you anymore. Blast..." },

				{ Cue = "/VO/MelinoeField_3909", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Zagreus, can you hear me? {#Emph}Answer me! {#Prev}Zagreus!" },

				{ Cue = "/VO/Zagreus_0060",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "...I don't know what's going on with you, but I'm prepared to do my part as soon as you're prepared." },

				{ Cue = "/VO/MelinoeField_3910", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's no use. He can't hear me anymore. I have an incantation to complete, and mustn't remain here.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			ZagreusPastMeeting08 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},

				{ Cue = "/VO/Zagreus_0064",
					Portrait = "Portrait_Zag_Defiant_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "Is that...? That's her, I think. Melinoë? Is that you? Can you hear me?" },

				{ Cue = "/VO/MelinoeField_3911", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can hear you, but can you hear {#Emph}me? {#Prev}Hello, Zagreus? {#Emph}Hello?" },

				{ Cue = "/VO/Zagreus_0065",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Defiant_01",
					Text = "...Blast. There has to be a more dependable means of communicating across dreams and time." },

				{ Cue = "/VO/MelinoeField_3912", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is pointless. Until my incantation is complete, I don't think I'll get through to him again.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},

			-- repeatable
			ZagreusPastMeetingRepeatable01 =
			{
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",

				{ Cue = "/VO/Zagreus_0069",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Empathetic_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "Melinoë, where are you? It's me your brother! I'm just... standing around, apparently in a dream, waiting for you to show up... {#Emph}anytime?" },

				{ Cue = "/VO/MelinoeField_3913", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Just hold on a little while longer, Brother...",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},
			ZagreusPastMeetingRepeatable02 =
			{
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Zagreus_0050" },
					},
				},

				{ Cue = "/VO/Zagreus_0071",
					Portrait = "Portrait_Zag_Empathetic_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "What if something happened to her... but then I wouldn't have this dream again, would I? Unless I'm {#Emph}not. {#Prev}And I'm just standing around, staring at a mirror..." },

				{ Cue = "/VO/MelinoeField_3914", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He senses me but I'm unable to get through... just, wait a little while longer, Zagreus.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},
			ZagreusPastMeetingRepeatable03 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},

				{ Cue = "/VO/Zagreus_0073",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Empathetic_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "Am I really going to do this? Destroy our grandfather... surely it's what Father would want, and this sister of mine, too, but... {#Emph}eh{#Prev}, where is she anyway? Melinoë? Sister?" },

				{ Cue = "/VO/MelinoeField_3915", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm here, it's just... we can't communicate like this at all, until... I have to rebuild our connection.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},
			ZagreusPastMeetingRepeatable04 =
			{
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",

				{ Cue = "/VO/Zagreus_0076",
					PreLineWait = 0.35,
					Portrait = "Portrait_Zag_Empathetic_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Portrait = "Portrait_Zag_Empathetic_01",
					Text = "{#Emph}Hm{#Prev}, what to do... what's keeping her? Is she all right? {#Emph}Hello...? {#Prev}Are you all right out there?" },

				{ Cue = "/VO/MelinoeField_3917", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am, it's just... I need a bit more time! Just don't lose hope, and... be ready.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},
			ZagreusPastMeetingRepeatable05 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				UseText = "NPCUseTextZagreus",
				InteractDistance = 300,
				PreEventFunctionName = "DreamSpeechPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/Zagreus_0072", "/VO/Zagreus_0075" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeetingRepeatable01" }
					},
				},

				{ Cue = "/VO/Zagreus_0074",
					Portrait = "Portrait_Zag_Empathetic_01",
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "Keep having this odd dream... or {#Emph}nightmare{#Prev}, I don't know. Not heard from her in quite a while..." },

				{ Cue = "/VO/MelinoeField_3916", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'll be back for you, Brother, I swear... just not tonight.",
					PostLineThreadedFunctionName = "KillHero",
					PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
				},
			},
		},
		Using =
		{
			"LaurelBurnIrisZagMirror",
			"LaurelBurnIrisZag"
		},
	},

	NPC_Zagreus_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		SubtitleColor = Color.ZagreusVoice,

		EmoteOffsetY = -280,
		EmoteOffsetX = 15,

		Portrait = "Portrait_ZagPresent_Default_01",
		Groups = { "NPCs" },

		ActivateRequirements =
		{
			--
		},

		UseTextSpecial = "ZagreusUseTextSpecial",
		SpecialInteractFunctionName = "HugZagreus",
		SpecialInteractCooldown = 10,
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZagreusTrueEnding01" },
			},
		},
		InteractVoiceLines =
		{
			{
				PlayOnceThisRun = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				--SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_5059", Text = "Be well, Brother." },
				{ Cue = "/VO/Melinoe_5060", Text = "Thank you for everything." },
				{ Cue = "/VO/Melinoe_5061", Text = "Good to see you!" },
				{ Cue = "/VO/Melinoe_5062", Text = "Prince Zagreus.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_5063", Text = "Your Highness." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.31,
				--PreLineAnim = "Zagreus_Greet",
				ObjectType = "NPC_Zagreus_01",

				{ Cue = "/VO/Zagreus_0091", Text = "Cheers.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0092", Text = "I'll take it.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0093", Text = "Why not!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0094", Text = "We do need help.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0096", Text = "Princess Melinoë.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5062" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0097", Text = "No {#Emph}Your {#Prev}Highness.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5063" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0089", Text = "You too.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5059" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0090", Text = "No need.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5060" },
						},
					},
				},
			},
		},

		InteractTextLineSets =
		{
			ZagreusTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZagreusEndingGreeting,

				{ Cue = "/VO/Zagreus_0085",
					-- Portrait = "Portrait_Zag_Empathetic_01",
					-- Portrait = "Portrait_Zag_Serious_01",
					PreLineAnim = "Zagreus_Talk_Start",
					AngleTowardHero = true,
					Text = "Well, I think we can fix up the rest of this place on our own. Thank you for all your help. Especially the part where you liberated us from our temporal prisons and whatnot!" },

				{ Cue = "/VO/MelinoeField_4981", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Believe me, I had nothing better to do! Anyhow, we'll have to find a way to cross paths out there. And each keep an eye on Chronos as we tie up some loose ends." },

				{ Cue = "/VO/Zagreus_0403",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					-- Portrait = "Portrait_Zag_Serious_01",
					Text = "You're not still angry with me, are you? For, you know, not murdering our grandfather in an utterly defenseless state? I wish you could remember growing up with him. You got on rather well! He made you laugh more than I did." },

				{ Cue = "/VO/MelinoeField_4982", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "In this dream-past only you and he recall! I'm still uncertain how to feel about this possibility of a more-pleasant life. Right now, I'd simply settle for a calmer one." },

				{ Cue = "/VO/Zagreus_0404",
					-- Portrait = "Portrait_Zag_Empathetic_01",
					-- Portrait = "Portrait_Zag_Serious_01",
					PreLineAnim = "Zagreus_Greet",
					Text = "You don't seem like the settling sort. Anyway I know this isn't goodbye, and we'll be seeing each other... though, still... I'll miss you, Little Sister. And do send Hypnos back if he can't wake up on his own." },

				{ Cue = "/VO/MelinoeField_4983", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PostLineFunctionName = "DeathAreaRestoredUpdateHallwayBlocks",
					PostLineThreadedFunctionName = "HugZagreus",
					PostLineThreadedFunctionArgs = { Silent = true },
					Text = "He'll wake up. I'm going to miss you too, Big Brother. Take care of everyone, all right?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.1,
						ObjectType = "NPC_Zagreus_01",
						{ Cue = "/VO/Zagreus_0087", Text = "I will. You take care, too." },
					},
				},

			},
		}
	},

	-- Zeus
	NPC_Zeus_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "ZeusUpgrade",
		SubtitleColor = Color.ZeusVoice,
		EmoteOffsetY = -280,
		EmoteOffsetX = 30,
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Zeus_InPerson_Pleased_01",
		PortraitEnterSound = "/EmptyCue",
		SpeakerName = "Zeus",
		LoadPackages = { "Zeus", },
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		-- TurnInPlaceAnimation = "Artemis_Turn",

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},

		AnimOffsetZ = 0,
		Groups = { "NPCs" },

		ActivateRequirements =
		{
			--
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			--
		},
		SpecialInteractCooldown = 90,
		InteractVoiceLines =
		{
			{
				PlayOnceThisRun = true,
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					-- { Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				-- { Cue = "/VO/MelinoeField_1566", Text = "Be well, Lord Father." },
				-- { Cue = "/VO/MelinoeField_1567", Text = "In shadow, I serve!" },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				-- PreLineAnim = "Hades_Hello",
				ObjectType = "NPC_Zeus_Story_01",
				PreLineFunctionName = "OlympianSaluteResponse",

				{ Cue = "/VO/Zeus_0313", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Zeus_0310", Text = "Yes, thank you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0311", Text = "Indeed.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Zeus_0312", Text = "We need no guide.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705" },
						},
					},
				},
			},
		},

		InteractTextLineSets =
		{
			ZeusPalaceFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0275",
					-- PreLineAnim = "Zeus_Greet",
					-- PreLineAnim = "Zeus_Explaining",

					Text = "Welcome, young lady, to our family's glorious abode! You have our thanks for seeing to it that the monster Typhon failed to reach us here." },

				{ Cue = "/VO/Hera_0196",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					-- PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					-- PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					Text = "And you have our regrets that my Lord Husband left you to confront that horrid creature on your own. Most of the others are still fortifying the Palace; forgive our rudeness." },

				{ Cue = "/VO/MelinoeField_3828", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There's nothing to forgive, Queen Hera. I am honored to have met you and King Zeus face to face, and seen the glory of Olympus firsthand. I owe it to your generous support these many nights." },

				{ Cue = "/VO/Zeus_0276",
					PreLineAnim = "Zeus_Explaining",
					Text = "Come now, Melinoë, we have a shared objective after all! And so long as Chronos sits upon your father's throne, that objective remains incomplete." },

				{ Cue = "/VO/Hera_0197",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "Hurrying her off when she only just arrived, Husband? Although we've little here for entertainment other than Apollo's plucking. At least our enemies shall be back at our gates before long!" },

				{ Cue = "/VO/MelinoeField_3829", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't think I can remain anyhow. I need to consult with the Witch of the Crossroads; she may have thoughts on how to rid ourselves of both our great foes at once." },

				{ Cue = "/VO/Zeus_0277",
					Text = "We shall find a means, of that I have no doubt! And until then, we shall be better prepared to meet their charge." },

				{ Cue = "/VO/Hera_0198",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PostLineFunctionName = "ActivateApollo",

					Text = "Go on, my dear. We're unaccustomed to expressing gratitude as you can plainly see. Until such time as your Lord Father and his own Queen are restored, there's little cause for cheer, I think." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3830", Text = "Perhaps soon enough." },
					},
				},
			},

			ZeusPalaceMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0278",
					Text = "We got that monstrous fiend once more, young lady, thanks most certainly to you! Such courage in the face of catastrophe, and our Palace remains safe and secure... and further reinforced, should Typhon try for us again." },

				{ Cue = "/VO/Hera_0199",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					Text = "You were splendid, my dear! Had things grown any more dire, we were preparing for a last resort a son of ours developed. But the cost of it is high indeed. Thus, you have saved us in more ways than one." },

				{ Cue = "/VO/MelinoeField_3840", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's my pleasure to have been of service to our family, Queen Hera, and to see the wonders of these halls once more. Perhaps we may yet permanently dissuade Typhon soon." },

				{ Cue = "/VO/Zeus_0279",
					Portrait = "Portrait_Zeus_InPerson_01",
					PreLineAnim = "Zeus_Explaining",
					Text = "And what do you have in mind on that account? Our own research has yet to yield a force that could take Typhon without also taking this entire mountain down! He's even fiercer now than when he first attacked us long ago." },

				{ Cue = "/VO/MelinoeField_3841", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've gathered useful specimens of Typhon's flesh, and we've been studying how we can use it in our craft. But we don't yet have meaningful progress to share..." },

				{ Cue = "/VO/Hera_0200",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "Oh, come now. Driving back that monster more than once is progress meaningful enough! My Lord Husband thought that your first such victory could have simply been a fluke." },

				{ Cue = "/VO/Zeus_0280",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "Now, what I said, dear wife, was that a single victory against Typhon did not prove more such victories could be achieved! But now you've demonstrated otherwise, Melinoë, and spurred our hope that we shall rid ourselves of this foul menace soon enough." },

				{ Cue = "/VO/MelinoeField_3842", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "ActivateApollo",

					Text = "King Zeus, Queen Hera, by your leave I ought return with what I found, in case it leads to new discoveries about how we can do just that. Thank you all for your continued aid." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Zeus_Story_01",
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/Zeus_0281", Text = "You have our gratitude, in kind." },
					},
				},
			},

			-- alts below
			-- major progress in the Underworld
			ZeusPalaceMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							-- "ZeusPalaceMeeting03",
							"ZeusPalaceMeeting03_A",
							"ZeusPalaceMeeting03_B",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Hera_0201",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					-- PreLineAnim = "Zeus_Greet",
					-- PreLineAnim = "Zeus_Explaining",
					-- PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "How my Lord Husband scoffed when first I brought forth that perhaps this {#Emph}deadly witch-niece {#Prev}of his, raised from infancy to vanquish Time itself, could also be of benefit against the Titan's siege! Glad I won {#Emph}that {#Prev} out." },

				{ Cue = "/VO/Zeus_0282",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "Hera dear, {#Emph}of course {#Prev}we reached agreement on that matter, else my good niece would not be here now! Though tell us, Melinoë, what news of a lasting solution to our predicament? Typhon shows no interest in turning away." },

				-- this line changes
				{ Cue = "/VO/MelinoeField_3845", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're getting closer to something. It's very likely that the means we use to rid ourselves of one of our great foes shall be the key to ridding ourselves of the other. Though we have not achieved those means as yet." },

				{ Cue = "/VO/Hera_0202",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					Text = "You hear that, Zeus? The greatest inconveniences we face may be resolved at once. We so like doing things efficiently." },

				{ Cue = "/VO/Zeus_0283",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "You need but tell us what else must be done to facilitate this outcome, Melinoë. Olympus stands at your disposal here." },

				-- this line also changes
				{ Cue = "/VO/MelinoeField_4268", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please hold out as long as possible, for your blessings and support are invaluable. One way or another, I'll be back as soon as I can. Chronos may have reawakened Typhon, but that same power could unravel him." },

				{ Cue = "/VO/Hera_0203",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PostLineFunctionName = "ActivateApollo",

					Text = "May it be thus. We'd ask you take your time, my dear, but there's no telling how much we can spare. Nevertheless, tread carefully and we shall be awaiting your return." },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},

			-- minor progress in the Underworld
			ZeusPalaceMeeting03_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"ZeusPalaceMeeting03",
							-- "ZeusPalaceMeeting03_A",
							"ZeusPalaceMeeting03_B",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Hera_0201",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					-- PreLineAnim = "Zeus_Greet",
					-- PreLineAnim = "Zeus_Explaining",
					-- PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "How my Lord Husband scoffed when first I brought forth that perhaps this {#Emph}deadly witch-niece {#Prev}of his, raised from infancy to vanquish Time itself, could also be of benefit against the Titan's siege! Glad I won {#Emph}that {#Prev} out." },

				{ Cue = "/VO/Zeus_0282",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "Hera dear, {#Emph}of course {#Prev}we reached agreement on that matter, else my good niece would not be here now! Though tell us, Melinoë, what news of a lasting solution to our predicament? Typhon shows no interest in turning away." },

				-- this line changes
				{ Cue = "/VO/MelinoeField_3845", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're getting closer to something. It's very likely that the means we use to rid ourselves of one of our great foes shall be the key to ridding ourselves of the other. Though we have not achieved those means as yet." },

				{ Cue = "/VO/Hera_0202",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					Text = "You hear that, Zeus? The greatest inconveniences we face may be resolved at once. We so like doing things efficiently." },

				{ Cue = "/VO/Zeus_0283",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "You need but tell us what else must be done to facilitate this outcome, Melinoë. Olympus stands at your disposal here." },

				-- this line also changes
				{ Cue = "/VO/MelinoeField_3847", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please hold out as long as possible, for your blessings and support are invaluable. I may be gone for some nights as I turn my attention to Chronos; his power reawakened Typhon, and that same power could unravel {#Emph}him." },

				{ Cue = "/VO/Hera_0203",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PostLineFunctionName = "ActivateApollo",

					Text = "May it be thus. We'd ask you take your time, my dear, but there's no telling how much we can spare. Nevertheless, tread carefully and we shall be awaiting your return." },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},

			-- no progress in the Underworld
			ZeusPalaceMeeting03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"ZeusPalaceMeeting03",
							"ZeusPalaceMeeting03_A",
							-- "ZeusPalaceMeeting03_B",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Hera_0201",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					-- PreLineAnim = "Zeus_Greet",
					-- PreLineAnim = "Zeus_Explaining",
					-- PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					SecretMusicMutedStems = { "Drums" },
					PreContentSound = "/SFX/Menu Sounds/MirrorFlash",
					Text = "How my Lord Husband scoffed when first I brought forth that perhaps this {#Emph}deadly witch-niece {#Prev}of his, raised from infancy to vanquish Time itself, could also be of benefit against the Titan's siege! Glad I won {#Emph}that {#Prev} out." },

				{ Cue = "/VO/Zeus_0282",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "Hera dear, of course we reached agreement on that matter, else my good niece would not be here at all! Though tell us, Melinoë, what news of a lasting solution to our predicament? Typhon shows no interest in turning away." },

				-- this line changes
				{ Cue = "/VO/MelinoeField_3846", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is but a theory at the moment, though we believe it's likely that the means we use to rid ourselves of one of our great foes shall be the key to ridding ourselves of the other. Unfortunately, we have not achieved those means as yet." },

				{ Cue = "/VO/Hera_0202",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					Text = "You hear that, Zeus? The greatest inconveniences we face may be resolved at once. We so like doing things efficiently." },

				{ Cue = "/VO/Zeus_0283",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "You need but tell us what else must be done to facilitate this outcome, Melinoë. Olympus stands at your disposal here." },

				-- this line also changes
				{ Cue = "/VO/MelinoeField_3847", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please hold out as long as possible, for your blessings and support are invaluable. I may be gone for some nights as I turn my attention to Chronos; his power reawakened Typhon, and that same power could unravel {#Emph}him." },

				{ Cue = "/VO/Hera_0203",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PostLineFunctionName = "ActivateApollo",

					Text = "May it be thus. We'd ask you take your time, my dear, but there's no telling how much we can spare. Nevertheless, tread carefully and we shall be awaiting your return." },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},

			-- if the critical path needs more space / if player hasn't cleared Chronos enough
			-- alt below
			ZeusPalaceMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01", "ZeusPalaceMeeting04_B" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
					},
					{
						Path = { "GameState", "Resources", "HadesSpearPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0284",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "Typhon is not backing down, though we shall drive him back each night he deigns to threaten us, if that is what it takes!" },

				{ Cue = "/VO/Hera_0204",
					Portrait = "Portrait_Hera_InPerson_Displeased_01",
					Source = "NPC_Hera_Story_01",
					Text = "Either that, or we could probably destroy him, along with this mountain and a good portion of the surrounding countryside... although, where would we live thereafter?" },

				{ Cue = "/VO/Zeus_0285",
					PreLineAnim = "Zeus_Explaining",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "We needn't weigh that possibility at all, Hera my dear! Best not to even speak of it. Melinoë assured us Typhon could be dealt with in a different way." },

				{ Cue = "/VO/MelinoeField_3850", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'd not intended to make promises on that account, Lord Uncle, though I shall do everything in my power to ensure Olympus stands while Typhon falls... I just need to concentrate on Chronos for a while." },

				{ Cue = "/VO/Hera_0205",
					Portrait = "Portrait_Hera_InPerson_Displeased_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					Text = "Well then, pardon my bluntness, my dear, but why aren't you in your Underworld? We now can hold our own, you've seen. But we cannot reach the Titan ourselves." },

				{ Cue = "/VO/Zeus_0286",
					PostLineFunctionName = "ActivateApollo",
					Text = "Do as you must, Melinoë. We shall be waiting to hear word of your success in Tartarus. And you can count on all our blessings on the way!" },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},
			-- can afford StormStop
			ZeusPalaceMeeting04_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01", "ZeusPalaceMeeting04" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
					},
					{
						Path = { "GameState", "Resources", "HadesSpearPoints" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0284",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "Typhon is not backing down, though we shall drive him back each night he deigns to threaten us, if that is what it takes!" },

				{ Cue = "/VO/Hera_0204",
					Portrait = "Portrait_Hera_InPerson_Displeased_01",
					Source = "NPC_Hera_Story_01",
					Text = "Either that, or we could probably destroy him, along with this mountain and a good portion of the surrounding countryside... although, where would we live thereafter?" },

				{ Cue = "/VO/Zeus_0285",
					PreLineAnim = "Zeus_Explaining",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "We needn't weigh that possibility at all, Hera my dear! Best not to even speak of it. Melinoë assured us Typhon could be dealt with in a different way." },

				{ Cue = "/VO/MelinoeField_3850_B", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'd not intended to make promises on that account, Lord Uncle, though I shall do everything in my power to ensure Olympus stands while Typhon falls..." },

				{ Cue = "/VO/Zeus_0286_B",
					PostLineFunctionName = "ActivateApollo",
					Text = "Do as you must, Melinoë. We shall be waiting to hear word of your success. And you can count on all our blessings on the way!" },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},

			-- after Typhon is destroyed
			-- requires ZagreusPastMeeting05 & WorldUpgradeStormStop
			-- player will be required to cast WorldUpgradeTimeStop in the next Hub visit
			-- player cannot do Surface runs after this until another Underworld clear & the True Ending
			ZeusPalaceAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
					},
					-- stopgap just in case
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0287",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Zeus_Explaining",
					Text = "Oh, my good niece, you were extraordinary, truly! So far as we can tell, no trace of that monstrosity remains! The deed is {#Emph}done! {#Prev}Typhon is {#Emph}dead!" },

				{ Cue = "/VO/Hera_0206",
					Portrait = "Portrait_Hera_InPerson_Displeased_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "My Lord Husband has been premature to declare victory before, so I shall not believe a {#Emph}word {#Prev}of this until I hear it from your lips; perhaps not even then!" },

				{ Cue = "/VO/MelinoeField_3866", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Father of All Monsters is undone... not merely dead, but eradicated, using the power of the Titan of Time, and a bit of assistance from Father's favored spear, Gigaros." },

				{ Cue = "/VO/Zeus_0288",
					PreLineAnim = "Zeus_Greet",
					Text = "You hear {#Emph}that{#Prev}, Hera dear? I {#Emph}told {#Prev}you young Melinoë was certain to prevail on our behalf! Our family always triumphs when we stand together with a common purpose." },

				{ Cue = "/VO/Hera_0207",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineWait = 0.35,
					Text = "...I remain utterly in shock. Well now, girl, if you have {#Emph}truly {#Prev}quashed that {#Emph}monstrous {#Prev}threat, then do prepare yourself for all of us to claim we never doubted you at any point. My Lord Husband is already starting." },

				{ Cue = "/VO/MelinoeField_3867", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If you had not believed in me, Queen Hera, then perhaps Typhon would have been here in my stead. So thank you all... and now an even greater victory is within reach." },

				{ Cue = "/VO/Zeus_0289",
					Portrait = "Portrait_Zeus_InPerson_01",
					Text = "The Titan Chronos... you mean to likewise destroy him using the methods you employed this very night?" },

				{ Cue = "/VO/MelinoeField_3868", UsePlayerSource = true,
					Text = "If necessary. Though this power that you witnessed was for Typhon alone, and likewise what we plan for Chronos is fit only for him. The deathless cannot be destroyed unless they threaten the very fabric of the weavings of the Fates." },

				{ Cue = "/VO/Hera_0208",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PostLineFunctionName = "ActivateApollo",

					Text = "No time for feasting till the other deed is done, then, yes? That's fine. The Titan's forces may grow far more desperate now, a possibility for which we ought prepare. We shall lend you all the strength we can for your own final assault." },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},

			-- one last visit after True Ending
			ZeusPalacePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				Partner = "NPC_Chronos_02",
				StatusAnimation = false,
				UseText = "UseListenNPC",
				InteractDistance = 350,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraFinalGreeting,

				{ Cue = "/VO/Chronos_1077",
					Source = "NPC_Chronos_02",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					PreLineAnimTarget = 798319,
					Text = "...Now do you see, my son? Although the Typhon with whom you already clashed is gone, there could have been certain circumstances under which he remained. One fewer {#Emph}now{#Prev}, of course!" },

				{ Cue = "/VO/Zeus_0290",
					Portrait = "Portrait_Zeus_InPerson_01",
					PreLineAnim = "Zeus_Greet",
					Text = "And how many of these circumstances {#Emph}are {#Prev}there, would you say, Father? For we cannot expect Melinoë to battle to our mountaintop for all eternity..." },

				{ Cue = "/VO/Hera_0209",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					Text = "Speaking of which, welcome again, my dear! We were just having ourselves a bit of a chat with your grandfather. We've not decided what to do with him as yet, you see." },

				{ Cue = "/VO/Chronos_1078",
					Source = "NPC_Chronos_02",
					PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnimTarget = 798319,
					Text = "Oh, hello, Granddaughter! I had assured the King and Queen that you would be victorious again, for you had been victorious before! Thank you for validating my theories." },

				{ Cue = "/VO/MelinoeField_5076", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Default_01", WaitTime = 3 },

					Text = "Oh, you're welcome. King Zeus, Queen Hera... I can attest these possibilities of Typhon do appear to exist, having just found one with Grandfather's assistance and eradicated it." },

				{ Cue = "/VO/Chronos_1079",
					Source = "NPC_Chronos_02",
					PreLineWait = 0.35,
					Text = "Typhon is closer to a Shade of himself now. The possibility of his dominion over Olympus has grown faint, and fainter still with each of your successes. But how {#Emph}many {#Prev}are required, I unfortunately cannot calculate..." },

				{ Cue = "/VO/Hera_0210",
					Portrait = "Portrait_Hera_InPerson_Displeased_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "And why not? Perhaps if we persuaded you sufficiently, Titan, you'd be inclined to answer in a more-straightforward way." },

				{ Cue = "/VO/Chronos_1080",
					Source = "NPC_Chronos_02",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					PreLineAnimTarget = 798319,
					Text = "I have but recently learned of these possibilities myself. Time is flowing freely forth, for the most part; my granddaughter merely can ensure that there are no obstructions of concern, at her convenience of course." },

				{ Cue = "/VO/MelinoeField_5077", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And I would see to that, however long it takes. By your leave, of course, O King and Queen. I ask that you permit Grandfather to carry on. Thus far he's been true to his word." },

				{ Cue = "/VO/Zeus_0291",
					Portrait = "Portrait_Zeus_InPerson_01",
					PreLineAnim = "Zeus_Explaining",
					Text = "We do have something suitable for you in mind, Father. But due to matters of security, our Palace henceforth is to be sealed off. Melinoë, perhaps when your mother resumes her yearly travels here, you may, {#Emph}erm{#Prev}, come visit again." },

				{ Cue = "/VO/Hera_0211",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineWait = 0.35,
					PostLineFunctionName = "ActivateApollo",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,

					Text = "We've been such awful hosts to you, my dear. We never intended for any of this to occur! But we have pledged you our support before, and you shall have it for as long as you require. Even if we bicker over it now and again." },
				EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
			},

			-- repeatable events
			ZeusPalaceMeetingRepeatable01 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0292",
					Portrait = "Portrait_Zeus_InPerson_01",
					PreLineAnim = "Zeus_Explaining",
					Text = "We've rid ourselves of Typhon for the time, but not for good. If Chronos stands between us and that outcome, then we urge you to pursue {#Emph}him {#Prev}next." },

				{ Cue = "/VO/Hera_0212",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					PostLineFunctionName = "ActivateApollo",

					Text = "My Lord Husband does not mean to pressure you, I'm sure, my dear. But do feel free to leave the defense of the mountain to us whilst tending to any other matters." },
				EndVoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "ZeusPalaceFarewellVO",
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3853", Text = "Your Majesty." },
					},
				},
			},
			ZeusPalaceMeetingRepeatable02 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Zeus_0293",
					Text = "Another victory is ours! We are most grateful for your continued service to our family, Melinoë. May your defeat of Chronos be as swift." },

				{ Cue = "/VO/Hera_0213",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Greet", PreLineAnimTarget = 723554,
					PostLineFunctionName = "ActivateApollo",

					Text = "And may we soon discover how to put that monstrous Typhon back into the earth where he belongs. Do keep us well-apprised!" },
				EndVoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "ZeusPalaceFarewellVO",
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3854", Text = "Yes, Queen Hera." },
					},
				},
			},
			ZeusPalaceMeetingRepeatable03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Hera_0214",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					PreLineAnim = "Hera_Pensive", PreLineAnimTarget = 723554,
					Text = "Again you sent that Typhon howling to the base of our mountain, though he is likely to return. But perhaps one of these nights shall be his last." },

				{ Cue = "/VO/Zeus_0294",
					Portrait = "Portrait_Zeus_InPerson_01",
					PostLineFunctionName = "ActivateApollo",

					Text = "We appreciate all of your aid, young lady, though do not leave Chronos unattended! Especially if his defeat is key to our final victory." },
				EndVoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "ZeusPalaceFarewellVO",
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3855", Text = "Thank you all." },
					},
				},
			},
			ZeusPalaceMeetingRepeatable04 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ZeusHeraGreeting,

				{ Cue = "/VO/Hera_0215",
					Portrait = "Portrait_Hera_InPerson_01",
					Source = "NPC_Hera_Story_01",
					Text = "You're always welcome on these grounds, my dear, but we are {#Emph}never {#Prev}going to be at our finest so long as the threat of Typhon looms large." },

				{ Cue = "/VO/Zeus_0295",
					Portrait = "Portrait_Zeus_InPerson_01",
					PostLineFunctionName = "ActivateApollo",

					Text = "He's gone at least for now, but he'll be back. That is unless Melinoë is able to get rid of him entirely, as she suggested should be possible!" },
				EndVoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "ZeusPalaceFarewellVO",
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3856", Text = "We're getting closer." },
					},
				},
			},
		},

	},

	-- Hera
	NPC_Hera_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "HeraUpgrade",
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Hera_InPerson_01",
		PortraitEnterSound = "/EmptyCue",
		SubtitleColor = Color.HeraVoice,
		SpeakerName = "Hera",
		LoadPackages = { "Hera", },
		EmoteOffsetY = -280,
		EmoteOffsetX = 30,
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		-- TurnInPlaceAnimation = "Artemis_Turn",

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},

		AnimOffsetZ = 0,
		Groups = { "NPCs" },

		ActivateRequirements =
		{
			--
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			--
		},
		SpecialInteractCooldown = 90,
		InteractVoiceLines =
		{
			{
				PlayOnceThisRun = true,
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					-- { Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				-- { Cue = "/VO/MelinoeField_1566", Text = "Be well, Lord Father." },
				-- { Cue = "/VO/MelinoeField_1567", Text = "In shadow, I serve!" },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				PreLineWait = 0.28,
				PreLineAnim = "Hera_Pensive",
				ObjectType = "NPC_Hera_Story_01",
				PreLineFunctionName = "OlympianSaluteResponse",

				{ Cue = "/VO/Hera_0224", Text = "If you insist!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701" },
						},
					},
				},
				{ Cue = "/VO/Hera_0225", Text = "How fierce.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Hera_0226", Text = "To where?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704" },
						},
					},
				},
				{ Cue = "/VO/Hera_0227", Text = "Of course.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Hera_0228", Text = "{#Emph}Mm-hm.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705", "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
			},
		},

	},

	-- Apollo
	NPC_Apollo_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "ApolloUpgrade",
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Apollo_InPerson_01",
		PortraitEnterSound = "/EmptyCue",
		SubtitleColor = Color.ApolloVoice,
		SpeakerName = "Apollo",
		LoadPackages = { "Apollo", },
		EmoteOffsetY = -280,
		EmoteOffsetX = 30,
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		-- TurnInPlaceAnimation = "Artemis_Turn",

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},

		AnimOffsetZ = 30,
		Groups = { "NPCs" },

		ActivateRequirements =
		{
			--
		},

		PreEventFunctionName = "PauseApolloSinging",

		InteractTextLineSets =
		{
			ApolloPalaceFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0178",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "You did it, sunshine! I'd say I knew you would, but the truth is, I had an inkling of doubt... especially once I saw Typhon for myself.", },

				{ Cue = "/VO/MelinoeField_3831", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He was quite large, I'll give him that! It's a pleasure to finally meet you face-to-face like this, Cousin. You play most beautifully!" },

				{ Cue = "/VO/Apollo_0179",
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Oh, anything to take our minds off of what's happening. At least you bought us a bit of reprieve so I could play again at all. Typhon is going to be back, though, isn't he...?", },

				{ Cue = "/VO/MelinoeField_3832", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'd count on that. But I am going to be back as well. For now, please bolster your defenses, and make ready for the monster's next attack. Now I had better go... my headmistress is expecting my return." },

				{ Cue = "/VO/Apollo_0180",
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Can't you just contact her by Boon? I'll bring one forth for you in case that works. And thanks for everything, Cousin.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{ GlobalVoiceLines = "ApolloSendOffVoiceLines" },
				},
				-- see PalaceBoonExit01 =
			},

			-- talk about how other gods can't be there
			ApolloPalaceMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0182",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "It's good to see you again, Cousin. Just as I was beginning to fear my song would be tonight's sole source of cheer!", },

				{ Cue = "/VO/MelinoeField_3843", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Apollo, good to see you too. Please give my regards to the others... I would have liked to meet, but had best be getting back." },

				{ Cue = "/VO/Apollo_0183",
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Of course, you must be on your last legs. The others surely would have liked to see you too, especially your grandmother, but they couldn't leave their posts. Please accept our apologies, and let us help you to return.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_3844", Text = "Tell Lady Demeter and everyone I wish them well." },
					},
				},
			},

			ApolloPalaceMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0184",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "You truly think we'll soon get blasted Typhon well out of our way for good? That'd be a welcome change." },

				{ Cue = "/VO/MelinoeField_3848", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If we can rid ourselves of Chronos, then we should be able to rid ourselves of the Father of All Monsters, too. And I have not been training all my life for this only to fail now." },

				{ Cue = "/VO/Apollo_0185",
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Well! Remind me never to get on your bad side, sunshine. You ready to head home? Always good to see you, though I'd best get back to singing so that everyone stays calm.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{ GlobalVoiceLines = "ApolloSendOffVoiceLines" },
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3849", Text = "We have this." },
					},
				},
			},

			-- alt below
			-- cannot afford StormStop
			ApolloPalaceMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ApolloPalaceMeeting04_B" },
					},
					{
						Path = { "GameState", "Resources", "HadesSpearPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/MelinoeField_3851", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Your song is such a welcome sound after a hard night's climb, Cousin. It nearly makes me forget the troubles we're dealing with. All this light, however, I'm not used to yet..." },

				{ Cue = "/VO/Apollo_0186",
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "We're not much used to it here either for how dark it's been of late. Though let's get you back before it drains you more. Sounds like you have to pay Chronos a visit soon.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3852", Text = "That I do." },
					},
				},
			},
			-- can afford StormStop
			ApolloPalaceMeeting04_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ApolloPalaceMeeting04" },
					},
					{
						Path = { "GameState", "Resources", "HadesSpearPoints" },
						Comparison = ">=",
						Value = 1,
					},
				},

				{ Cue = "/VO/MelinoeField_3851", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Your song is such a welcome sound after a hard night's climb, Cousin. It nearly makes me forget the troubles we're dealing with. All this light, however, I'm not used to yet..." },

				{ Cue = "/VO/Apollo_0186_B",
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "We're not much used to it here either for how dark it's been of late. Though let's get you back before it drains you more.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						-- { Cue = "/VO/MelinoeField_3852", Text = "That I do." },
					},
					{ GlobalVoiceLines = "ApolloSendOffVoiceLines" },
				},
			},

			ApolloPalaceAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},

				{ Cue = "/VO/Apollo_0187",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "That monster, truly gone... you got him, forever! Not that my faith in you wavered since your initial victory, it's just... I still can't entirely believe it. So now for Chronos, then?" },

				{ Cue = "/VO/MelinoeField_3869", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Now for Chronos, then. One encouraging result can often spur another. And perhaps all of you shall have a brief reprieve. I'm certain you could use it." },

				{ Cue = "/VO/Apollo_0188",
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "With Prometheus and such still causing problems, we won't be getting all too comfortable just yet. Especially not while our main foe is out there still. Go get him, sunshine.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3870", Text = "On it." },
					},
					{ GlobalVoiceLines = "ApolloSendOffVoiceLines" },
				},
			},

			ApolloPalacePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "UseRecord" },
						HasAny = { "NPC_Zeus_Story_01", "NPC_Chronos_02" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Apollo_0189",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "We ought to be feasting in your name as far as I'm concerned, sunshine. But no sign of Dionysus still, and our new guest has drawn most of the attention. Soon we also won't be letting anybody in from the outside." },

				{ Cue = "/VO/MelinoeField_3920", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's all right, Cousin, as I'm not much for feasting anyhow. And we do need to find a place for this grandfather of ours. Do you know what Lord Uncle Zeus has in store for him?" },

				{ Cue = "/VO/Apollo_0190",
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "Not entirely, but my impression is he's sending Chronos back into the Underworld, to Lord Hades. Apparently they've reached some sort of bargain. So, you truly think our grandfather has changed?" },

				{ Cue = "/VO/MelinoeField_3921", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think he has a different outlook on things, yes. As for me, sounds like I may not be able to return anytime soon. This place truly is beyond compare, and with each visit you've made me feel welcome. Thank you for that and everything." },

				{ Cue = "/VO/Apollo_0191",
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Oh, come on, it's all of us who should be thanking you, and quite profusely I should add. Anyhow, not like this is a permanent farewell. I'll keep in touch by Boon, all right?",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_3922", Text = "All right." },
					},
					-- { GlobalVoiceLines = "ApolloSendOffVoiceLines" },
				},
			},

			-- post-Zeus repeatable
			ApolloPalacePostZeusChat01 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0192",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Ready to head back again? Here, let me light the way.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndGlobalVoiceLines = "ApolloSendOffVoiceLines",
			},
			ApolloPalacePostZeusChat02 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0193",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Splendid work as usual, sunshine. We're all grateful you made the trip.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndGlobalVoiceLines = "ApolloSendOffVoiceLines",
			},
			ApolloPalacePostZeusChat03 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0194",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "By now you'd probably much rather be where it isn't quite this bright.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndGlobalVoiceLines = "ApolloSendOffVoiceLines",
			},
			ApolloPalacePostZeusChat04 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0195",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "It's only thanks to you that I can sit and strum here at a time like this.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndGlobalVoiceLines = "ApolloSendOffVoiceLines",
			},
			ApolloPalacePostZeusChat05 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalk",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Zeus_Story_01" },
					},
				},

				{ Cue = "/VO/Apollo_0181",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Wish you could stay since you just got here, though I know it's not the time. Be safe out there.",
					PostLineFunctionName = "ResumeApolloSinging",
					PostLineThreadedFunctionName = "ActivatePalaceExitPoint",
				},
				EndGlobalVoiceLines = "ApolloSendOffVoiceLines",
			},

			-- pre-Zeus repeatable
			ApolloPalacePreZeusChat01 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "UseRecord" },
						HasNone = { "NPC_Zeus_Story_01", "NPC_Chronos_02" },
					},
				},

				{ Cue = "/VO/Apollo_0196",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "It's good to see you, sunshine, but you'd best speak to Father first.",
					PostLineFunctionName = "ResumeApolloSinging",
				},
			},
			ApolloPalacePreZeusChat02 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "UseRecord" },
						HasNone = { "NPC_Zeus_Story_01", "NPC_Chronos_02" },
					},
				},

				{ Cue = "/VO/Apollo_0197",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_01",
					Text = "Best not to keep your Lord Uncle waiting. I'll be right here.",
					PostLineFunctionName = "ResumeApolloSinging",
				},
			},
			ApolloPalacePreZeusChat03 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "UseRecord" },
						HasNone = { "NPC_Zeus_Story_01", "NPC_Chronos_02" },
					},
				},

				{ Cue = "/VO/Apollo_0198",
					PreLineWait = 0.35,
					Portrait = "Portrait_Apollo_InPerson_Serious_01",
					Text = "I, {#Emph}erm{#Prev}, think the King and Queen might like a word?",
					PostLineFunctionName = "ResumeApolloSinging",
				},
			},

		},

	},

	-- Demeter
	NPC_Demeter_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "DemeterUpgrade",
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Demeter_InPerson_Pleased_01",
		SubtitleColor = Color.DemeterVoice,
		PortraitEnterSound = "/EmptyCue",
		SpeakerName = "Demeter",
		LoadPackages = { "Demeter", },
		EmoteOffsetY = -280,
		EmoteOffsetX = 30,
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		-- TurnInPlaceAnimation = "Artemis_Turn",

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},

		AnimOffsetX = -20,
		AnimOffsetZ = 30,
		Groups = { "NPCs" },

		ActivateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceMeeting02" },
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Demeter_Story_01" },
			},
		},
		SpecialInteractCooldown = 90,
		InteractVoiceLines =
		{
			{
				PlayOnceThisRun = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_4326", Text = "So good to see you.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_4327", Text = "Hail, Lady Demeter!" },
				{ Cue = "/VO/MelinoeField_4328", Text = "Grandmother." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				-- PreLineAnim = "Demeter_Moved",
				ObjectType = "NPC_Demeter_Story_01",
				PreLineFunctionName = "OlympianSaluteResponse",

				{ Cue = "/VO/Demeter_0205", Text = "And you of course.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_4326" },
						},
					},
				},
				{ Cue = "/VO/Demeter_0206", Text = "Grandmother.",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Demeter_Story_01", }, Alive = false },
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_4327" },
						},
					},
				},
				{ Cue = "/VO/Demeter_0207", Text = "{#Emph}Hm.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698" },
						},
					},
				},
				{ Cue = "/VO/Demeter_0208", Text = "Let it be done.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Demeter_0209", Text = "I know the way.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Demeter_0210", Text = "As you say.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704" },
						},
					},
				},
				{ Cue = "/VO/Demeter_0211", Text = "Very well.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705" },
						},
					},
				},
			},
		},

		InteractTextLineSets =
		{
			DemeterPalaceFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceMeeting02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.DemeterGreeting,

				{ Cue = "/VO/Demeter_0196",
					-- PreLineAnim = "Demeter_Scoff",
					-- PreLineAnim = "Demeter_Moved",
					Text = "Oh, flower, it's truly {#Emph}you! {#Prev}Forgive me, I... we must maintain decorum here, but... I am very pleased to see you here before me, rather than within the dimness of a Boon." },

				{ Cue = "/VO/MelinoeField_4318", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lady Demeter, the honor is mine. I know that everyone's preoccupied contending with the siege, and it couldn't have been easy for you to be here now." },

				{ Cue = "/VO/Demeter_0197",
					PreLineAnim = "Demeter_Moved",
					Text = "Please, call me grandmother; although perhaps not here. I was furious to have missed you when you visited before, and was not about to let that reoccur. But you cannot stay can you...?" },

				{ Cue = "/VO/MelinoeField_4319", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Unfortunately not. With Typhon dealt with for the moment, I had best be getting back. I'm so grateful to have met you like this! Shall I see you again?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Demeter_Story_01",
						PreLineAnim = "Demeter_Scoff",

						{ Cue = "/VO/Demeter_0198", Text = "If the Fates have any mercy in their hearts, then yes." },
					},
				},
			},

			DemeterPalaceAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						-- fallback
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.DemeterGreeting,

				{ Cue = "/VO/Demeter_0200",
					-- PreLineAnim = "Demeter_Scoff",
					-- PreLineAnim = "Demeter_Moved",
					Text = "The storm has passed... that monster turned the weather such that not even Lord Zeus or I could stop it properly. But now he's gone, and we have you to thank." },

				{ Cue = "/VO/MelinoeField_4321", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Thanks are owed all around, Grandmother. Typhon gave in to the combined might of the gods. I merely concentrated our fell strength. Now to press this advantage." },

				{ Cue = "/VO/Demeter_0201",
					PreLineAnim = "Demeter_Scoff",
					Portrait = "Portrait_Demeter_InPerson_01",
					Text = "Perhaps not even Chronos can withstand what you unleashed. But be careful, Granddaughter. Make certain we shall meet again." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_4322", Text = "We will." },
					},
				},
			},

			DemeterPalacePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.DemeterGreeting,

				{ Cue = "/VO/MelinoeField_4323", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We did it, Grandmother! You've fought so hard for me... for all of us. But, it must be difficult, to see Chronos again." },

				{ Cue = "/VO/Demeter_0203",
					PreLineAnim = "Demeter_Scoff",
					-- PreLineAnim = "Demeter_Moved",
					Portrait = "Portrait_Demeter_InPerson_01",
					Text = "I shall not dignify him with so much as a passing glance, Melinoë. The Titan would have reached a different end were it for me to decide, but... I'm grateful that the outcome was not worse." },

				{ Cue = "/VO/MelinoeField_4324", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "From what I gathered, this may be farewell for a while. At least face-to-face! I'll still be seeing you most nights, if you'll be able to keep aiding me by Boon." },

				{ Cue = "/VO/Demeter_0204",
					Portrait = "Portrait_Demeter_InPerson_01",
					PreLineAnim = "Demeter_Moved",
					Text = "Of course. And there shall come a time again when your mother shall be visiting us half the year. Perhaps then you may come along, once every few seasons at least." },

				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "RecipeAdded", Text = "WorldUpgradeAmbrosia" },
				},

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/MelinoeField_5019", Text = "Grandmother, is this for me? Thank you..." },
						-- { Cue = "/VO/MelinoeField_4325", Text = "I would like that." },
					},
				},
			},

		}
	},

	-- Young Mel
	NPC_Melinoe_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		Groups = { "NPCs" },
		GrannyTexture = "Models/Melinoe/YoungMelRed_Color",
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Mel_Child_01",
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,

		LineHistoryName = "PlayerUnit",
		SubtitleColor = Color.White,
		NarrativeFadeInColor = Color.Teal,

		EmoteOffsetY = -100,
		EmoteOffsetX = 25,

		SetupEvents =
		{
			{
				FunctionName = "SwapAnimations",
				Args =
				{
					Melinoe_Young_Idle = "Melinoe_Young_Idle_Chronos",
				},
			},
		},

		InteractTextLineSets =
		{
			MelinoeHideAndSeek01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				PreEventFunctionName = "ChronosCrouchPresentation",

				{ Cue = "/VO/Chronos_1419",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					Portrait = "Portrait_Chronos_Flashback_01",
					Text = "There you are, at last! You might have kept me searching for a while yet, that you found such a secure hiding-point amid those shadows!" },

				{ Cue = "/VO/MelinoeField_5056",
					Portrait = "Portrait_Melinoe_Child_Ending_Defiant_01",
					PreLineAnim = "Melinoe_Young_Excited_End",

					Speaker = "PlayerUnit",
					Text = "It sure took you long enough! I was beginning to think I might never see you again!" },

				{ Cue = "/VO/Chronos_1420",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					Portrait = "Portrait_Chronos_Flashback_01",

					Text = "{#Emph}Hah! {#Prev}That is precisely what your father said when Zagreus first brought me here! Well, are we to suffer through another round?" },

				{ Cue = "/VO/MelinoeField_5057",
					Portrait = "Portrait_Melinoe_Child_Ending_Defiant_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Melinoe_Child_Ending_01", WaitTime = 3 },

					PreLineAnim = "Melinoe_Young_Pensive_Start",
					PostLineAnim = "Melinoe_Young_Pensive_End",

					Speaker = "PlayerUnit",
					Text = "No... this game is too easy. Tell me another one of your tales! About the Golden Age!" },

				{ Cue = "/VO/Chronos_1421",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					Portrait = "Portrait_Chronos_Flashback_01",

					Text = "Perhaps when you are older, lest your father be displeased. If {#Emph}you {#Prev}defy him, you merely get a mild reprimand. If {#Emph}I {#Prev}defy him, I get cut to little bite-sized bits, which then are sprinkled throughout Tartarus!" },

				{ Cue = "/VO/MelinoeField_5058",
					Portrait = "Portrait_Melinoe_Child_Ending_01",

					PreLineAnim = "Melinoe_Young_Excited_Start",
					PostLineAnim = "Melinoe_Young_Excited_End",

					Speaker = "PlayerUnit",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Haha, ew! {#Prev}Well if Father ever does that, I shall simply go find all the bits and put you back together again!" },

				{ Cue = "/VO/Chronos_1422",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					Portrait = "Portrait_Chronos_Flashback_01",

					Text = "Spoken with the generosity of youth. You are the only one around here who would say such things, Melinoë." },

				{ Cue = "/VO/MelinoeField_5059",
					Portrait = "Portrait_Melinoe_Child_Ending_Concerned_01",

					PreLineAnim = "Melinoe_Young_Brooding_Start",
					PostLineAnim = "Melinoe_Young_Brooding_End",

					Speaker = "PlayerUnit",
					Text = "Truly? But, don't the others like you, Grandfather?" },

				{ Cue = "/VO/Chronos_1423",
					EndSecretMusic = true,
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					Portrait = "Portrait_Chronos_Flashback_01",

					Text = "{#Emph}Oh{#Prev}, they can never get enough of me, my girl, except... we still have had our differences. But let me not concern you with the past. The only time that matters is right now. And right now... " },

				EndVoiceLines =
				{
					{
						SkipAnim = true,
						UsePlayerSource = true,
						PreLineAnim = "NPC_Chronos_Enlightened_Tag",

						{ Cue = "/VO/Chronos_1424", Text = "{#Emph}Tag! {#Prev}You are it!" },
					},
					{
						SkipAnim = true,
						ObjectType = "NPC_Melinoe_Story_01",
						PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",

						{ Cue = "/VO/MelinoeField_5060", Text = "{#Emph}Haha! Hey! {#Prev}No fair!" },
					}

				},					

				EndFunctionName = "MelBackToBedroomPresentation",
			},
		},
	},

}

GlobalVoiceLines.ApolloSendOffVoiceLines =
{
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		ObjectType = "NPC_Apollo_Story_01",
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Apollo_0199", Text = "That's for you.", PlayFirst = true },
		{ Cue = "/VO/Apollo_0200", Text = "Should help you get home." },
		{ Cue = "/VO/Apollo_0201", Text = "Take care now." },
		{ Cue = "/VO/Apollo_0202", Text = "That's your Boon." },
	},
	{
		PreLineWait = 0.35,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ApolloPalaceFirstMeeting" },
			},
		},

		{ Cue = "/VO/MelinoeField_3833", Text = "May I...?" },
	},
}
GlobalVoiceLines.ZeusSendOffVoiceLines =
{
	{ GlobalVoiceLines = "HeraSendOffVoiceLines" },
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		ObjectType = "NPC_Zeus_Story_01",
		-- Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "ZeusPalaceMeeting04" },
			},
		},

		{ Cue = "/VO/Zeus_0304", Text = "Farewell!" },
		{ Cue = "/VO/Zeus_0305", Text = "Till we meet again.", PlayFirst = true },
		{ Cue = "/VO/Zeus_0306", Text = "Be safe." },
		{ Cue = "/VO/Zeus_0307", Text = "You have our blessings." },
		{ Cue = "/VO/Zeus_0308", Text = "Onward!" },
		{ Cue = "/VO/Zeus_0309", Text = "Be well." },
	},
	{ GlobalVoiceLines = "HeraSendOffVoiceLines" },
}
GlobalVoiceLines.HeraSendOffVoiceLines =
{
	{
		PreLineWait = 0.35,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.33,
		ObjectType = "NPC_Hera_Story_01",
		-- Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasNone = { "/VO/Hera_0220", "/VO/Hera_0221", "/VO/Hera_0222", "/VO/Hera_0223" },
			},
		},

		{ Cue = "/VO/Hera_0220", Text = "Fare you well!" },
		{ Cue = "/VO/Hera_0221", Text = "Take care." },
		{ Cue = "/VO/Hera_0222", Text = "Goodbye." },
		{ Cue = "/VO/Hera_0223", Text = "Come back soon!" },
	},
}

GlobalVoiceLines.MirrorInitialInspectLines =
{
	GameStateRequirements =
	{
		{
			PathFalse = { "CurrentRun", "UseRecord", "DreamBed01" }
		},
	},

	{ Cue = "/VO/MelinoeField_3410", Text = "Not yet... In dream I shall remain Unseen.", PlayOnce = true, },
}

GlobalVoiceLines.DreamBedUsedLines =
{
	{
		PreLineWait = 0.35,
		PlayOnce = true,

		{ Cue = "/VO/MelinoeField_3411", Text = "So many dreams upon this very spot... then, one more." },
	},
	{
		PreLineWait = 0.75,
		RandomRemaining = true,
		GameStateRequirements =
		{
		},

		{ Cue = "/VO/MelinoeField_3412", Text = "{#Emph}To the abyss of the subconscious I descend...!" },
		{ Cue = "/VO/MelinoeField_3413", Text = "{#Emph}To the abyss of the subconscious I descend...!", PlayFirst = true },
	},
}
GlobalVoiceLines.DreamPresentationLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		GameStateRequirements =
		{
		},

		{ Cue = "/VO/MelinoeField_3414", Text = "A connection... step one..." },
		{ Cue = "/VO/MelinoeField_3415", Text = "Now the Mirror..." },
		{ Cue = "/VO/MelinoeField_3416", Text = "It worked..." },
		{ Cue = "/VO/MelinoeField_3409", Text = "Something beside the bed...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
				},
				{
					PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
				},
			},
		},
	},
}

GlobalVoiceLines.MirrorUsedLines =
{
	{
		PreLineWait = 0.35,
		PlayOnce = true,
		PostLineWait = 0.4,

		{ Cue = "/VO/MelinoeField_3417", Text = "...And now step two." },
	},
	{
		PreLineWait = 0.35,
		RandomRemaining = true,
		GameStateRequirements =
		{
		},

		{ Cue = "/VO/MelinoeField_3418", Text = "{#Emph}Night and Darkness, guide me to my blood beyond the grasp of Time!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3419", Text = "{#Emph}Night and Darkness, guide me to my blood beyond the grasp of Time...!" },
	},
}
GlobalVoiceLines.TimeHallPresentationLines =
{
	{
		PlayOnce = true,
		PreLineWait = 1.35,

		{ Cue = "/VO/MelinoeField_3420", Text = "The mists of memory..." },
	},
	{
		{
			PlayOnce = true,
			PlayOnceContext = "ZagChamberEntranceVO",
			PreLineWait = 1.3,
			GameStateRequirements =
			{
				NamedRequirements = { "HecateMissing" },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_5041", Text = "All right, need to calm myself... can't make him more nervous than me..." },
			{ Cue = "/VO/MelinoeField_5042", Text = "{#Emph}Whew{#Prev}, OK... focus...", PreWait = 1.86 },
		},
	}
}

GlobalVoiceLines.ZagreusPastMirrorLines =
{
	{
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0002", Text = "{#Emph}Augh {#Prev}stay down blast you! I've tried water, oil, Nectar, Ambrosia, but no!" },
		{ Cue = "/VO/MelinoeField_3421", Text = "That voice, it's...", UsePlayerSource = true },
		{ Cue = "/VO/Zagreus_0003", Text = "What about blood? {#Emph}Ooh... {#Prev}not tried blood. Which would be utter madness but I'm running out of reasonable options here." },
		{ Cue = "/VO/Zagreus_0004", Text = "I could try asking nicely. {#Emph}Hair? {#Prev}Would you mind staying down a bit, please? This is supposed to be a special occasion." },
		{ Cue = "/VO/Zagreus_0005", Text = "You won't listen. You're mocking me! {#Emph}Fine! {#Prev}I see how it is. Well two can play at that you know!" },
		{ Cue = "/VO/Zagreus_0006", Text = "What if I simply chop you off? Would you like that? I'll go get Stygius again and cut you clean! You think on that a bit!", BreakIfPlayed = true },
	},

	{
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting02" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0017", Text = "Just... stay... {#Emph}down! {#Prev}No... {#Emph}augh{#Prev}, blast... I thought I had you there. I {#Emph}had {#Prev}you there! You're weakening. Perhaps?" },
		{ Cue = "/VO/MelinoeField_3422", Text = "Brother...?", UsePlayerSource = true, BreakIfPlayed = true },
	},

	{
		PlayOnce = true,
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting02_2" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0062", Text = "She looks a bit like Mother, doesn't she... which means... oh, blast... I never thought... I look just like {#Emph}him{#Prev}, then? Only without the beard? {#Emph}Augh...", BreakIfPlayed = true },
	},

	{
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		-- { Cue = "/VO/MelinoeField_1270", Text = "Please work...", PreLineWait = 0.1, UsePlayerSource = true },
		{ Cue = "/VO/Zagreus_0026", Text = "This is that dream... which means... she must be close... Melinoë? Melinoë... that's a nice name. Melinoë! Are you out there? No...?" },
		{ Cue = "/VO/MelinoeField_3423", Text = "Brother...!", UsePlayerSource = true, BreakIfPlayed = true },
	},

	{
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0034", Text = "Come on... come on, where is she... where is she? Don't leave me hanging like this Sister, come on... I want to get some proper sleep eventually..." },
		{ Cue = "/VO/MelinoeField_3424", Text = "Brother...", UsePlayerSource = true, BreakIfPlayed = true },
	},

	{
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0042", Text = "This has to work... it has to... I mean why wouldn't it? If everything she says has happened will happen." },
		{ Cue = "/VO/Zagreus_0043", Text = "I mean it just makes sense. Doesn't it? {#Emph}Augh. {#Prev}Well anyway we'll find out soon enough. If she shows up.", BreakIfPlayed = true },
	},

	{
		PlayOnce = true,
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting06" },
			},
			{
				PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0050", Text = "What if something happened... something must have happened... but then how am I still dreaming? If this even is a dream. Oh, blast, where is she... when is she...?", BreakIfPlayed = true },
	},

	{
		PlayOnce = true,
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting07" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0057", Text = "This old Mirror certainly has come in handy, I must say... and I would very much appreciate if it would come in handy again now. Or now? Anytime...?", BreakIfPlayed = true },
	},

	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.87,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Zagreus_Past_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting07" },
			},
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ZagreusInterrupt" },
			},
		},

		{ Cue = "/VO/Zagreus_0067", Text = "Where is she... where {#Emph}is {#Prev}she... {#Emph}hrm... {#Prev}well... this isn't the most interesting dream so far, I have to say... although she's never {#Emph}not {#Prev}showed up eventually...", PlayFirst = true },

		{ Cue = "/VO/Zagreus_0068", Text = "Hello...? {#Emph}Hello! {#Prev}Sister? Where did she go... I sense her, but..." },

		{ Cue = "/VO/Zagreus_0070", Text = "Hey, is that...? I think it's {#Emph}her... {#Prev}Melinoë, can you hear me out there? Say something, would you?" },

		{ Cue = "/VO/Zagreus_0072", Text = "All these dreams of looking in the Mirror recently... oh wait, I think that's {#Emph}her... {#Prev}Melinoë, you there?" },

		{ Cue = "/VO/Zagreus_0075", Text = "Another one of these recurring dreams, is it... where {#Emph}are {#Prev}you, Sister? Come on, I don't want to look at my reflection here all day... night. Whenever." },
	},
}

GlobalVoiceLines.ZagreusPastFollowUpLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.8,
		AllowTalkOverTextLines = true,
		Source = { LineHistoryName = "NPC_Zagreus_Past_01", SubtitleColor = Color.ZagreusVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting06" },
			},
		},
		{ Cue = "/VO/Zagreus_0056", Text = "Goodbye, Melinoë! I hope this works..." },
	},
}

GlobalVoiceLines.ZagreusPastGreetingLines =
{
	Queue = "Interrupt",
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		ObjectType = "NPC_Zagreus_Past_01",
		SkipAnim = true,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsNone =
					{
						"ZagreusPastMeeting07",
						"ZagreusPastMeeting08",
						"ZagreusPastMeetingRepeatable01",
						"ZagreusPastMeetingRepeatable02",
						"ZagreusPastMeetingRepeatable03",
						"ZagreusPastMeetingRepeatable04",
						"ZagreusPastMeetingRepeatable05",
					},
				},
			},
		},
		{ Cue = "/VO/Zagreus_0007", Text = "...Wait, {#Emph}what...?" },
		{ Cue = "/VO/Zagreus_0018", Text = "...Oh...!" },
		{ Cue = "/VO/Zagreus_0027", Text = "Ah." },
		{ Cue = "/VO/Zagreus_0035", Text = "There." },
		{ Cue = "/VO/Zagreus_0044", Text = "Hey!" },
		{ Cue = "/VO/Zagreus_0058", Text = "Is that...?" },
		{ Cue = "/VO/Zagreus_0063", Text = "Wait..." },
		{ Cue = "/VO/Zagreus_0051", Text = "{#Emph}Whew.",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgrades", "WorldUpgradeTimeStop" },
				},
			},
		},
	},
}

GlobalVoiceLines.ChronosSanctumGreetingLines =
{
	{
		PlayOnce = true,
		ObjectTypes = { "NPC_Chronos_01", "NPC_Chronos_Story_01" },
		PreLineWait = 0.9,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Chronos_0962", Text = "{#Emph}Pah! {#Prev}What {#Emph}now...?" },
		{ Cue = "/VO/Chronos_0963", Text = "What is all that infernal {#Emph}racket?", },
		{ Cue = "/VO/Chronos_0964", Text = "Silence, fools, lest we be {#Emph}caught!", PreLineWait = 1.5 },
		{ Cue = "/VO/Chronos_0965", Text = "Guards! Guards...? {#Emph}Guards!!", PreLineWait = 1.2 },
		{ Cue = "/VO/Chronos_0966", Text = "{#Emph}Nrgh..." },
	},
	{
		PlayOnce = true,
		ObjectTypes = { "NPC_Zagreus_Past_01" },
		PreLineWait = 2.0,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Zagreus_0082", Text = "Oh, hello..." },
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPCs )

NPCVariantData =
{
	
}

PortraitPackages =
{
	"Aphrodite",
	"Apollo",
	"Arachne",
	"Ares",
	"Artemis",
	"Athena",
	"Bouldy",
	"Cerberus",
	"Chaos",
	"Charon",
	"Chronos",
	"Circe",
	"Demeter",
	"Dionysus",
	"Dora",
	"Echo",
	"Eris",
	"Fates",
	"Hades",
	"Hecate",
	"Hephaestus",
	"Hera",
	"Heracles",
	"Hermes",
	"Hestia",
	"Hypnos",
	"Icarus",
	"Medea",
	"Moros",
	"Narcissus",
	"Nemesis",
	"Nyx",
	"Odysseus",
	"Persephone",
	"Polyphemus",
	"Poseidon",
	"Prometheus",
	"Scylla",
	"Selene",
	"Skelly",
	"Zagreus",
	"Zeus",
}