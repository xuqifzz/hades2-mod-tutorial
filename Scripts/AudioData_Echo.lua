-- Global Echo Lines
GlobalVoiceLines.EchoKeepsakeLines =
{
	RandomRemaining = true,
	PreLineWait = 0.5,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Echo_01", SubtitleColor = Color.EchoVoice },
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

	{ Cue = "/VO/Echo_0005_B", Text = "Have this... {#Echo1}have this... {#Prev}{#Echo2}have this..."
	},
	{ Cue = "/VO/Echo_0012_B", Text = "Echo... {#Echo1}Echo... {#Prev}{#Echo2}Echo...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0012" },
			},
		},
	},
	{ Cue = "/VO/Echo_0015_B", Text = "Won't forget... {#Echo1}forget... {#Prev}{#Echo2}forget...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0015" },
			},
		},
	},
	{ Cue = "/VO/Echo_0037_B", Text = "Grateful... {#Echo1}grateful... {#Prev}{#Echo2}grateful...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0037" },
			},
		},
	},
	{ Cue = "/VO/Echo_0038_B", Text = "Power... {#Echo1}power... {#Prev}{#Echo2}power...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0038" },
			},
		},
	},
	{ Cue = "/VO/Echo_0039_B", Text = "The best... {#Echo1}the best... {#Prev}{#Echo2}the best...!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0039" },
			},
		},
	},
	{ Cue = "/VO/Echo_0042_B", Text = "Take care... {#Echo1}care... {#Prev}{#Echo2}care...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0042" },
			},
		},
	},
	{ Cue = "/VO/Echo_0043_B", Text = "Be strong... {#Echo1}strong... {#Prev}{#Echo2}strong...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0043" },
			},
		},
	},
	{ Cue = "/VO/Echo_0045_B", Text = "My friend... {#Echo1}friend... {#Prev}{#Echo2}friend...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0045" },
			},
		},
	},
	{ Cue = "/VO/Echo_0046_B", Text = "Help... {#Echo1}help... {#Prev}{#Echo2}help...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0046" },
			},
		},
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Echo =
{
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "NarcissusWithEcho01" },
			}
		},
		{
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Narcissus_Field_01",
				{ Cue = "/VO/Narcissus_0079", Text = "Be seeing you, Laurel!" },
			},
			{
				UsePlayerSource = true,
				PreLineWait = 0.4,
				{ Cue = "/VO/MelinoeField_1174", Text = "It's Melinoë! Forget it..." },
			},
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Echo_01",
				{ Cue = "/VO/Echo_0057", Text = "Melinoë, forget it... {#Echo1}forget it... {#Prev}{#Echo2}forget it..." },
			}
		},
	},

	{
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Echo_01" },
				Comparison = "==",
				Value = 1,
			}
		},
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,

			{ Cue = "/VO/MelinoeField_0741", Text = "I don't know who you are, but thanks..." },
		},
		{
			ObjectType = "NPC_Echo_01",

			{ Cue = "/VO/Echo_0006", Text = "Thanks... {#Echo1}thanks... {#Prev}{#Echo2}thanks...", BreakIfPlayed = true },
		}
	},
	{
		RandomRemaining = true,
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "MelinoeField_0741" }
				},
			},
			{
				PreLineWait = 0.4,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0740", Text = "I can have this?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0005", Text = "Have this... {#Echo1}have this... {#Prev}{#Echo2}have this..." },
			},
		},
		{
			{
				PreLineWait = 0.4,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1001", Text = "Please take care." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0026", Text = "Take care... {#Echo1}take care... {#Prev}{#Echo2}take care...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0745", Text = "For me? You sure?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0009", Text = "Sure... {#Echo1}sure... {#Prev}{#Echo2}sure...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
				},
			},
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0748", Text = "Thank you, Echo." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0012", Text = "Echo... {#Echo1}Echo... {#Prev}{#Echo2}Echo...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
				},
			},
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0751", Text = "I won't forget this, Echo." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0015", Text = "Won't forget... {#Echo1}forget... {#Prev}{#Echo2}forget...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1012", Text = "I'm grateful." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0037", Text = "Grateful... {#Echo1}grateful... {#Prev}{#Echo2}grateful...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1013", Text = "Such a power..." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0038", Text = "Power... {#Echo1}power... {#Prev}{#Echo2}power...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
			},
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1014", Text = "You're the best!" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0039", Text = "The best... {#Echo1}the best... {#Prev}{#Echo2}the best...!", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1015", Text = "See you next time?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0040", Text = "Next time... {#Echo1}next time... {#Prev}{#Echo2}next time...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
				},
			},
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1016", Text = "Farewell, Echo." },
			},
			{
				ObjectType = "NPC_Echo_01",
				{ Cue = "/VO/Echo_0041", Text = "Farewell... {#Echo1}farewell... {#Prev}{#Echo2}farewell...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1017", Text = "Take care now..." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0042", Text = "Take care... {#Echo1}care... {#Prev}{#Echo2}care...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1018", Text = "Be strong, OK?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0043", Text = "Be strong... {#Echo1}strong... {#Prev}{#Echo2}strong...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
				{
					Path = { "GameState", "UseRecord", "NPC_Echo_01", },
					Comparison = ">=",
					Value = 3,
				},
			},
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1019", Text = "Please don't give in." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0044", Text = "Don't give in... {#Echo1}give in... {#Prev}{#Echo2}give in...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
				{
					Path = { "GameState", "UseRecord", "NPC_Echo_01", },
					Comparison = ">=",
					Value = 3,
				},
			},
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1020", Text = "Thank you, my friend." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0045", Text = "My friend... {#Echo1}friend... {#Prev}{#Echo2}friend...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1021", Text = "This shall help." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0046", Text = "Help... {#Echo1}help... {#Prev}{#Echo2}help...", BreakIfPlayed = true },
			}
		},

	},
	-- [3] = GlobalVoiceLines.ThankingCharacterVoiceLines,
}
