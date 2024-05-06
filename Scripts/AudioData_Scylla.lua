-- Global Scylla Lines
GlobalVoiceLines.ScyllaShowStartVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.85,
	ObjectType = "Scylla",
	-- SuccessiveChanceToPlayAll = 0.2,
	Cooldowns =
	{
		{ Name = "ScyllaSpokeRecently", Time = 20 },
	},

	{ Cue = "/VO/Scylla_0005", Text = "We're {#Emph}Scylla and the Sirens!", PlayFirst = true, },
	{ Cue = "/VO/Scylla_0006", Text = "We are {#Emph}Scylla and the Sirens!", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Scylla_0005" },
			},
		},
	},
	{ Cue = "/VO/Scylla_0007", Text = "This song's called {#Emph}Coral Crown!", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "AudioState", "MusicName" },
				IsAny = { "/Music/IrisMusicScylla1_MC" },
			},
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Scylla_0005" },
			},
		},
	},
	{ Cue = "/VO/Scylla_0071", Text = "One, two, three, {#Emph}four!" },
	{ Cue = "/VO/Scylla_0072", Text = "And, here we {#Emph}go!" },
	{ Cue = "/VO/Scylla_0073", Text = "And, go!" },
	{ Cue = "/VO/Scylla_0074", Text = "...Go!", PreLineWait = 1.2 },	
}

GlobalVoiceLines.ScyllaSirenKOReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "Scylla",
	Cooldowns =
	{
		{ Name = "ScyllaSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Scylla_0158", Text = "{#Emph}Hey!" },
	{ Cue = "/VO/Scylla_0160", Text = "Our {#Emph}sound!" },
}

GlobalVoiceLines.ScyllaSirenRallyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.75,
	Source = { LineHistoryName = "NPC_Scylla_01", SubtitleColor = Color.ScyllaVoice },
	-- SuccessiveChanceToPlayAll = 0.75,
	TriggerCooldowns = { "ScyllaSpokeRecently" },

	{ Cue = "/VO/Scylla_0173", Text = "Free admission!" },
	{ Cue = "/VO/Scylla_0174", Text = "Here {#Emph}fishy-fishy!" },
	{ Cue = "/VO/Scylla_0175", Text = "This is it!", PlayFirst = true },
	{ Cue = "/VO/Scylla_0176", Text = "One last {#Emph}verse!" },
	{ Cue = "/VO/Scylla_0177", Text = "Feel the beat!" },
	{ Cue = "/VO/Scylla_0178", Text = "{#Emph}Encore!!" },

	{ Cue = "/VO/Scylla_0163", Text = "Get back in it, you two!" },
	{ Cue = "/VO/Scylla_0164", Text = "Back on your fins!" },
	{ Cue = "/VO/Scylla_0165", Text = "Roxy, Jetty, {#Emph}now!" },
	{ Cue = "/VO/Scylla_0166", Text = "Get it {#Emph}together{#Prev}, gals!" },
	{ Cue = "/VO/Scylla_0167", Text = "Get off your {#Emph}tails{#Prev}, gals!" },
	{ Cue = "/VO/Scylla_0168", Text = "Both of you get {#Emph}up!", PlayFirst = true },
	{ Cue = "/VO/Scylla_0169", Text = "{#Emph}Hah{#Prev}, show's not over {#Emph}yet!" },
	{ Cue = "/VO/Scylla_0170", Text = "{#Emph}Now{#Prev}, you two!" },
	{ Cue = "/VO/Scylla_0171", Text = "{#Emph}Come on{#Prev}, Sirens!" },
	{ Cue = "/VO/Scylla_0172", Text = "Come on, you {#Emph}Pinheads!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0171" }
			},
		}
	},
}

GlobalVoiceLines.ScyllaSirenDeathReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "Scylla",
	Cooldowns =
	{
		{ Name = "ScyllaSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Scylla_0183", Text = "{#Emph}Oh{#Prev}, come {#Emph}on!" },
	{ Cue = "/VO/Scylla_0184", Text = "That's {#Emph}not {#Prev}part of the {#Emph}act!" },
	{ Cue = "/VO/Scylla_0185", Text = "What did you {#Emph}do {#Prev}to her?" },
	{ Cue = "/VO/Scylla_0186", Text = "No {#Emph}fair!!" },
	{ Cue = "/VO/Scylla_0187", Text = "{#Emph}Damn it{#Prev}, Sirens!" },
	{ Cue = "/VO/Scylla_0188", Text = "Guess it's all up to me!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EnemyKills" },
				HasAll = { "SirenKeytarist", "SirenDrummer" },
			},
		},
	},
}