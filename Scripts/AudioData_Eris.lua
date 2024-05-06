-- Global Eris Lines
GlobalVoiceLines.ErisAttemptedExitVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "NPC_Eris_01",
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 6 },
	},

	{ Cue = "/VO/ErisField_0038", Text = "Excuse me?" },
	{ Cue = "/VO/ErisField_0039", Text = "Oh, no you {#Emph}don't!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0040", Text = "{#Emph}Aw{#Prev}, c'mon." },
	{ Cue = "/VO/ErisField_0041", Text = "Hold up, babe." },
	{ Cue = "/VO/Eris_0081", Text = "What's the matter?" },
	{ Cue = "/VO/Eris_0082", Text = "{#Emph}Aw{#Prev}, what's wrong?" },
}
GlobalVoiceLines.ErisInvulnerableVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.25,
	ObjectType = "NPC_Eris_01",
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "SourceProjectile", },
			IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 8 },
	},

	{ Cue = "/VO/ErisField_0043", Text = "Nu-{#Emph}uh!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0044", Text = "Not now." },
	{ Cue = "/VO/ErisField_0045", Text = "Nice try!" },
	{ Cue = "/VO/ErisField_0046", Text = "You wish!" },
	{ Cue = "/VO/ErisField_0047", Text = "{#Emph}Cute!" },
	{ Cue = "/VO/ErisField_0042", Text = "Maybe later?",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Boss01" },
			},
		},
	},
}
GlobalVoiceLines.ErisAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Eris",
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 8 },
	},

	{ Cue = "/VO/ErisField_0058", Text = "Here!" },
	{ Cue = "/VO/ErisField_0059", Text = "Run...!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0060", Text = "Got you!" },
	{ Cue = "/VO/ErisField_0061", Text = "Now..." },
	{ Cue = "/VO/ErisField_0062", Text = "Eat {#Emph}this!" },
	{ Cue = "/VO/ErisField_0063", Text = "Now...!" },
	{ Cue = "/VO/ErisField_0064", Text = "{#Emph}<Chuckle>" },
	{ Cue = "/VO/ErisField_0065", Text = "{#Emph}Boom!" },
	{ Cue = "/VO/ErisField_0066", Text = "Better {#Emph}hide!" },
	{ Cue = "/VO/ErisField_0067", Text = "How's this?" },
	{ Cue = "/VO/ErisField_0068", Text = "Want more?" },
	{ Cue = "/VO/ErisField_0069", Text = "All mine." },
}