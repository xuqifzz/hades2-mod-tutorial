-- Shrine 
GlobalVoiceLines.ShrineUpgradeMaxedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "ShrineVOQuippedRecently", Time = 3 },
	},
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/Melinoe_2869", Text = "This goes no farther." },
		{ Cue = "/VO/Melinoe_2870", Text = "It's at the limit." },
		{ Cue = "/VO/Melinoe_2871", Text = "Can't vow any harder..." },
		{ Cue = "/VO/Melinoe_2872", Text = "This Vow is at its peak.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2873", Text = "Don't think I can." },
		{ Cue = "/VO/Melinoe_2874", Text = "Could take a different Vow..." },
	}
}
GlobalVoiceLines.ShrineUpgradePickedVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.7,
	SkipAnim = true,
	ChanceToPlay = 0.35,
	Cooldowns =
	{
		{ Name = "MelinoeShrineUpgradeSpeech", Time = 30 },
		{ Name = "ShrineVOQuippedRecently", Time = 4 },
	},

	{ Cue = "/VO/Melinoe_3511", Text = "...This I vow...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_3512", Text = "...That Fear may spread..." },
	{ Cue = "/VO/Melinoe_3513", Text = "...By my birthright..." },
	{ Cue = "/VO/Melinoe_3514", Text = "...For the realm..." },
	{ Cue = "/VO/Melinoe_3515", Text = "...I swear it, Nyx..." },
	{ Cue = "/VO/Melinoe_3516", Text = "...By will of Night..." },
}
