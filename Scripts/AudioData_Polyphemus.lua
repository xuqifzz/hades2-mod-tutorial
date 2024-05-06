
-- Global Polyphemus Lines
GlobalVoiceLines.PolyphemusSummonVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlayAll = 0.5,
	Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },
	TriggerCooldowns = { "CyclopsSpokeRecently" },
	Cooldowns =
	{
		{ Name = "CyclopsSummonSpeech", Time = 45 },
	},

	{ Cue = "/VO/Polyphemus_0264", Text = "I'll wake the dead!" },
	{ Cue = "/VO/Polyphemus_0265", Text = "Wake up down there!" },
	{ Cue = "/VO/Polyphemus_0266", Text = "Rise up you good-for-nothings!" },
	{ Cue = "/VO/Polyphemus_0267", Text = "Here's some of my pals." },
	{ Cue = "/VO/Polyphemus_0268", Text = "Having some {#Emph}friends {#Prev}over!" },
	{ Cue = "/VO/Polyphemus_0269", Text = "Some friends over for dinner!" },
	{ Cue = "/VO/Polyphemus_0270", Text = "This ought to keep you busy!", PlayFirst = true },
	{ Cue = "/VO/Polyphemus_0271", Text = "Wake up, sleepyheads!" },
}

GlobalVoiceLines.PolyphemusGrabbedPlayerVoiceLines =
{
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.75,
		Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },
		TriggerCooldowns = { "CyclopsSpokeRecently", "CyclopsLastStandReactionSpeech" },
		Cooldowns =
		{
			-- { Name = "CyclopsSpokeRecently", Time = 20 },
		},

		{ Cue = "/VO/Polyphemus_0033", Text = "{#Emph}Ah{#Prev}, there you are!" },
		{ Cue = "/VO/Polyphemus_0034", Text = "Got you." },
		{ Cue = "/VO/Polyphemus_0035", Text = "Got you!" },
		{ Cue = "/VO/Polyphemus_0036", Text = "Caught you." },
		{ Cue = "/VO/Polyphemus_0037", Text = "Caught out!" },
		{ Cue = "/VO/Polyphemus_0038", Text = "Found you!" },
		{ Cue = "/VO/Polyphemus_0039", Text = "Ah-{#Emph}ha!" },
		{ Cue = "/VO/Polyphemus_0042", Text = "There she is!" },
		{ Cue = "/VO/Polyphemus_0248", Text = "You're mine." },
		{ Cue = "/VO/Polyphemus_0249", Text = "What'd I tell you?" },
	},
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_0531", Text = "You... {#Emph}stink!" },
		{ Cue = "/VO/MelinoeField_0532", Text = "Get... {#Emph}off!" },
		{ Cue = "/VO/MelinoeField_0533", Text = "Let... {#Emph}go!" },
		{ Cue = "/VO/MelinoeField_0534", Text = "Not... {#Emph}this!" },
	}
}

GlobalVoiceLines.PolyphemusMiscGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Polyphemus",
	Cooldowns =
	{
		{ Name = "CyclopsSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Polyphemus_0272", Text = "What are you up to?" },
	{ Cue = "/VO/Polyphemus_0273", Text = "You disrespecting me?" },
	{ Cue = "/VO/Polyphemus_0275", Text = "I heard that..." },
	{ Cue = "/VO/Polyphemus_0278", Text = "Doing something sneaky huh..." },
}
GlobalVoiceLines.PolyphemusGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.05,
		ObjectType = "Polyphemus",
		Cooldowns =
		{
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Polyphemus_0274", Text = "Picking my plants?" },
	},
	[2] = GlobalVoiceLines.PolyphemusMiscGatherReactionVoiceLines,
}
GlobalVoiceLines.PolyphemusPickaxeReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "Polyphemus",
		Cooldowns =
		{
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Polyphemus_0279", Text = "I hear a pickaxe or something?",	PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0280", Text = "Clanking away again..." },
	},
	[2] = GlobalVoiceLines.PolyphemusMiscGatherReactionVoiceLines,
}
GlobalVoiceLines.PolyphemusShovelReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "Polyphemus",
		Cooldowns =
		{
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Polyphemus_0276", Text = "Are you... shoveling?", PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0277", Text = "You're digging your own grave." },
	},
	[2] = GlobalVoiceLines.PolyphemusMiscGatherReactionVoiceLines,
}
