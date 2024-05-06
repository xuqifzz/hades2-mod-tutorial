-- Global Circe Lines
GlobalVoiceLines.CirceGreetingLines =
{
	Queue = "Interrupt",
	{
		{
			RandomRemaining = true,
			ObjectType = "NPC_Circe_01",
			Cooldowns =
			{
				{ Name = "CirceSpokeRecently", Time = 9 },
			},

			{ Cue = "/VO/Circe_0078", Text = "Is that who I think it is?", PlayFirst = true },
			{ Cue = "/VO/Circe_0079", Text = "Oh, hullo!" },
			{ Cue = "/VO/Circe_0080", Text = "Oh, you're back!" },
			{ Cue = "/VO/Circe_0081", Text = "Welcome back!" },
			{ Cue = "/VO/Circe_0082", Text = "I knew you would arrive." },
			{ Cue = "/VO/Circe_0083", Text = "You're just in time!" },
			{ Cue = "/VO/Circe_0084", Text = "Little miss!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift02" },
					},
				},
			},
			{ Cue = "/VO/Circe_0085", Text = "Piggies, look who's back!" },
			{ Cue = "/VO/Circe_0086", Text = "How very fortunate!" },
			{ Cue = "/VO/Circe_0087", Text = "Come, don't be shy!" },
			{ Cue = "/VO/Circe_0088", Text = "It's you!" },
			{ Cue = "/VO/Circe_0089", Text = "There you are!" },
		},
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.2,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1887", Text = "{#Emph}Erm{#Prev}, pardon...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1888", Text = "Madame Circe!" },
			{ Cue = "/VO/MelinoeField_1889", Text = "Hail, Madame." },
		},
	},
}

GlobalVoiceLines.CirceChanting =
{
	{
		PreLineWait = 0.35,
		RandomRemaining = true,
		ObjectType = "NPC_Circe_01",
		-- SubtitleMinDistance = 1200,

		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "CirceInterrupt" },
			},
		},

		{ Cue = "/VO/Circe_0062", Text = "{#Emph}Fang and feather, tuft of wool, \n {#Emph}Dusky wing and horn of bull," },
		{ Cue = "/VO/Circe_0063", Text = "{#Emph}Little seeds and bigger fronds, \n {#Emph}Stones from rivers, moss from ponds," },
		{ Cue = "/VO/Circe_0064", Text = "{#Emph}Bubble, tea leaves, ocean breeze, \n {#Emph}Briar thorns, and wax of bees," },
		{ Cue = "/VO/Circe_0065", Text = "{#Emph}Gust of wind, and spray of sea, \n	{#Emph}Clump of soil, branch of tree," },

		{ Cue = "/VO/Circe_0066", Text = "{#Emph}Apple pieces, olives, figs, \n {#Emph}Ginger roots and cypress twigs," },
		{ Cue = "/VO/Circe_0067", Text = "{#Emph}Lichen, garlic, bark of pine, \n {#Emph}Dash of oil, drop of wine," },
		{ Cue = "/VO/Circe_0068", Text = "{#Emph}Cap of mushroom, skin of snake, \n {#Emph}Lemon juice and sand of lake," },
		{ Cue = "/VO/Circe_0069", Text = "{#Emph}Coiled vine and peat of fens, \n {#Emph}Sugar beets and egg of hens," },

		{ Cue = "/VO/Circe_0070", Text = "{#Emph}Onyx crystal, Python scale, \n {#Emph}Morning dew, and fingernail," },
		{ Cue = "/VO/Circe_0071", Text = "{#Emph}Silk of spider, tooth of shark, \n {#Emph}Ray of light, and mote of dark," },
		{ Cue = "/VO/Circe_0072", Text = "{#Emph}Heap of soil, chip of stone, \n {#Emph}Harpy feather, knuckle bone," },
		{ Cue = "/VO/Circe_0073", Text = "{#Emph}Cotton-plant and shard of flint, \n {#Emph}Cherry pit and sprig of mint," },
	},
}
GlobalVoiceLines.CirceChantingWrapUp =
{
	{
		PreLineWait = 0.4,
		RandomRemaining = true,
		ObjectType = "NPC_Circe_01",
		-- SubtitleMinDistance = 1200,

		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "CirceInterrupt" },
			},
		},

		{ Cue = "/VO/Circe_0074", Text = "{#Emph}Bit of toadstool, claw of cat, \n {#Emph}Heat it, stir it, that is that!" },
		{ Cue = "/VO/Circe_0075", Text = "{#Emph}Hoof of pig, and fur of hound, \n {#Emph}Brew a potion, safe and sound!" },
		{ Cue = "/VO/Circe_0076", Text = "{#Emph}Moly petals, I've a lot! \n {#Emph}Boil, simmer, in my pot!" },
		{ Cue = "/VO/Circe_0077", Text = "{#Emph}Bask in Moonlight, all of you, \n	{#Emph}Till you be this witch's brew!" },
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Circe =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Circe_01",
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Circe_0090", Text = "So mote it be!" },
		{ Cue = "/VO/Circe_0091", Text = "So mote it be." },
		{ Cue = "/VO/Circe_0092", Text = "Then very well!" },
		{ Cue = "/VO/Circe_0093", Text = "Then you shall have it." },
		{ Cue = "/VO/Circe_0094", Text = "Then you shall have it!" },
		{ Cue = "/VO/Circe_0095", Text = "Bless you, poppet." },
		{ Cue = "/VO/Circe_0096", Text = "That is your will!" },
		{ Cue = "/VO/Circe_0097", Text = "Go now with grace." },
		{ Cue = "/VO/Circe_0098", Text = "Isn't it marvelous?" },
		{ Cue = "/VO/Circe_0099", Text = "Be safe!" },
		{ Cue = "/VO/Circe_0100", Text = "It is done!" },
		{ Cue = "/VO/Circe_0101", Text = "Our Lady protect you." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.68,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "CirceEnlargeTrait", "CirceShrinkTrait" },
			},
		},

		{ Cue = "/VO/MelinoeField_2049", Text = "Did it work...?", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2050", Text = "Am I...? Oh." },
		{ Cue = "/VO/MelinoeField_2051", Text = "I feel a little off..." },
		{ Cue = "/VO/MelinoeField_2052", Text = "What have I done..." },
		{ Cue = "/VO/MelinoeField_2053", Text = "Everything looks so big...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CirceShrinkTrait" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2054", Text = "I'm Titan-sized...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CirceEnlargeTrait" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.25,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/MelinoeField_1894", Text = "Thank you, Madame.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1895", Text = "That's potent..." },
		{ Cue = "/VO/MelinoeField_1896", Text = "{#Emph}Ooh..." },
		{ Cue = "/VO/MelinoeField_1897", Text = "Felt that for sure..." },
	},
	[3] = GlobalVoiceLines.ThankingCharacterVoiceLines,
}