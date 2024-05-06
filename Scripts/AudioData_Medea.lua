-- Global Medea Lines
GlobalVoiceLines.MedeaGreetingLines =
{
	Queue = "Interrupt",
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		PreLineAnim = "Medea_Greet",
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Medea_0067", Text = "Sorceress!" },
		{ Cue = "/VO/Medea_0068", Text = "Peace, Sorceress." },
		{ Cue = "/VO/Medea_0069", Text = "Oh...!" },
		{ Cue = "/VO/Medea_0070", Text = "{#Emph}Ah{#Prev}, welcome." },
		{ Cue = "/VO/Medea_0071", Text = "Good evening!" },
		{ Cue = "/VO/Medea_0072", Text = "Returned to my abode." },
		{ Cue = "/VO/Medea_0073", Text = "A visitor!" },
		{ Cue = "/VO/Medea_0074", Text = "She returns." },
		{ Cue = "/VO/Medea_0075", Text = "By the dark...!", PlayFirst = true },
		{ Cue = "/VO/Medea_0076", Text = "Come closer..." },
		{ Cue = "/VO/Medea_0077", Text = "Fear not..." },
		{ Cue = "/VO/Medea_0078", Text = "You're back." },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{ Cue = "/VO/Melinoe_3296", Text = "Lady Medea..." },
		{ Cue = "/VO/Melinoe_3297", Text = "The Sorceress...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
					HasNone = { "/VO/Medea_0067", "/VO/Medea_0068" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3298", Text = "Greetings, Witch.", PlayFirst = true },
	},
}

GlobalVoiceLines.MedeaCauldronLines =
{
	{
		PreLineWait = 1.1,
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},

		{ Cue = "/VO/Medea_0120", Text = "...bone dust...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0121", Text = "...mandrake essence...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0122", Text = "...nightshade...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0123", Text = "...nettle-thorn...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0124", Text = "...sulfurous ash...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0125", Text = "...garlic...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0126", Text = "...moly...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0127", Text = "...a bit of flesh...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0128", Text = "...a drop of blood...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0129", Text = "...beetle-wing...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0130", Text = "...maggot...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0131", Text = "...dead coral...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0132", Text = "...air-bladder...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0133", Text = "...rotting wood...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0134", Text = "...barley...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0135", Text = "...splash of oil...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0136", Text = "...pennyroyal...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0137", Text = "...marrow...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0138", Text = "...silver...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0139", Text = "...onion...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0140", Text = "...grave-soil...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0141", Text = "...snakeskin...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0142", Text = "...tear-drops...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0143", Text = "...lizard tail...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0144", Text = "...charcoal...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0145", Text = "...fingernails...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0146", Text = "...one of these...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0147", Text = "...a bit of this...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0148", Text = "...just a dash...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0149", Text = "...give it a stir...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0150", Text = "...{#Emph}Mmm{#Prev}, let's see..." },
		{ Cue = "/VO/Medea_0151", Text = "...what else..." },
	},
}
GlobalVoiceLines.MedeaCauldronWrapUpLines =
{
	{
		PreLineWait = 0.66,
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		
		{ Cue = "/VO/Medea_0152", Text = "...and, there." },
		{ Cue = "/VO/Medea_0153", Text = "...and now we wait..." },
		{ Cue = "/VO/Medea_0154", Text = "...that should do it.", PreLineWait = 1.0 },
		{ Cue = "/VO/Medea_0155", Text = "...and, that's it...!" },
	},
}
GlobalVoiceLines.MedeaIncantationLines =
{
	RandomRemaining = true,
	-- SuccessiveChanceToPlay = 0.5,
	{
		PreLineWait = 0.6,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		--Actor = "DadOcclusion",
		ThreadName = "RoomThread",
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		TriggerCooldowns = { "MedeaIncantationSpeech" },
		RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Medea_0156", Text = "{#Emph}O wand'ring dead who cannot find your peace,", PreLineWait = 1.6 },
		{ Cue = "/VO/Medea_0157", Text = "{#Emph}I bid you listen closely to my voice." },
		{ Cue = "/VO/Medea_0158", Text = "{#Emph}The moment at which mortal life does cease" },
		{ Cue = "/VO/Medea_0159", Text = "{#Emph}Is not for your despair, but to rejoice!" },
		{ Cue = "/VO/Medea_0160", Text = "{#Emph}For I can lead you to where you belong," },
		{ Cue = "/VO/Medea_0161", Text = "{#Emph}Beneath the earth where Death and Sleep reside," },
		{ Cue = "/VO/Medea_0162", Text = "{#Emph}I bid you merely serve me for a song," },
		{ Cue = "/VO/Medea_0163", Text = "{#Emph}Unto the will of the Unseen, confide." },
		{ Cue = "/VO/Medea_0164", Text = "{#Emph}...So mote it be.", PreLineWait = 1.2, BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.6,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		--Actor = "DadOcclusion",
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
		},
		RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Medea_0165", Text = "{#Emph}To all the enemies of Hades, near and far,", PreLineWait = 1.6 },
		{ Cue = "/VO/Medea_0166", Text = "{#Emph}May ravens strip you of your flesh and eyes," },
		{ Cue = "/VO/Medea_0167", Text = "{#Emph}All your extremities sent to a pickle-jar," },
		{ Cue = "/VO/Medea_0168", Text = "{#Emph}And beetles spit up from your mouths of lies." },
		{ Cue = "/VO/Medea_0169", Text = "{#Emph}Whether you dwell upon the surface or below," },
		{ Cue = "/VO/Medea_0170", Text = "{#Emph}Your every step shall be with stabbing pain." },
		{ Cue = "/VO/Medea_0171", Text = "{#Emph}No peace or mercy you shall ever know," },
		{ Cue = "/VO/Medea_0172", Text = "{#Emph}Ere you repent, and die and die again." },
		{ Cue = "/VO/Medea_0173", Text = "{#Emph}...So mote it be.", PreLineWait = 1.2, BreakIfPlayed = true },
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Medea =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Medea_01",
		PreLineAnim = "Medea_Bless",
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Medea_0079", Text = "That they shall feel." },
		{ Cue = "/VO/Medea_0080", Text = "A curse upon them all." },
		{ Cue = "/VO/Medea_0081", Text = "Oh I like that one." },
		{ Cue = "/VO/Medea_0082", Text = "As you desire." },
		{ Cue = "/VO/Medea_0083", Text = "I thought you'd never ask." },
		{ Cue = "/VO/Medea_0084", Text = "So it shall be." },
		{ Cue = "/VO/Medea_0085", Text = "Most excellent...!" },
		{ Cue = "/VO/Medea_0086", Text = "It shall be my pleasure." },
		{ Cue = "/VO/Medea_0087", Text = "...There you have it." },
		{ Cue = "/VO/Medea_0090", Text = "{#Emph}Kataskion aski!" },
		{ Cue = "/VO/Medea_0091", Text = "{#Emph}Askion kataski!" },
		{ Cue = "/VO/Medea_0088", Text = "So mote it be.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Medea_0164", "/VO/Medea_0173" },
				},
			},
		},
		{ Cue = "/VO/Medea_0089", Text = "So mote it be...!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Medea_0164", "/VO/Medea_0173" },
				},
			},
		},
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.15,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/MelinoeField_0255", Text = "I'm grateful, milady." },
		{ Cue = "/VO/MelinoeField_0256", Text = "Night protect us...", PlayFirst = true },
	},
	[3] = GlobalVoiceLines.ThankingCharacterVoiceLines,
	-- [4] = GlobalVoiceLines.MedeaIncantationLines,
}