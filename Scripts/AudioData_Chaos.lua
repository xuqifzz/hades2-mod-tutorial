-- Global Chaos Lines
GlobalVoiceLines.ChaosSecretUnlockedVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "ChaosAboutSurfacePromptSpeech",
		RandomRemaining = true,
		PreLineWait = 1.13,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.2,
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeSurfacePenaltyCure" },
			},
			{
				PathFalse = { "GameState", "TextLinesRecord", "ChaosAboutSurface01" },
			},
			{
				Path = { "CurrentRun", "Hero", "MaxHealth" },
				Comparison = ">=",
				Value = 50,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "Chaos_01", "Chaos_02", "Chaos_03", "Chaos_04", "Chaos_05", "Chaos_06" },
			},
			RequiredMinHealthFraction = 0.5,
		},
		{ Cue = "/VO/Chaos_0059", Text = "Come, Spawn of Hades..." },
		{ Cue = "/VO/Chaos_0064", Text = "You are summoned...", PlayFirst = true },
		{ Cue = "/VO/Chaos_0066", Text = "Come enter the abyss..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.13,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.2,
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
			},
			{
				Path = { "CurrentRun", "Hero", "MaxHealth" },
				Comparison = ">=",
				Value = 30,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "Chaos_01", "Chaos_02", "Chaos_03", "Chaos_04", "Chaos_05", "Chaos_06" },
			},
			RequiredMinHealthFraction = 0.5,
		},
		{ Cue = "/VO/Chaos_0059", Text = "Come, Spawn of Hades...", PlayFirst = true },
		{ Cue = "/VO/Chaos_0060", Text = "The path to me is open..." },
		{ Cue = "/VO/Chaos_0061", Text = "Return to me again..." },
		{ Cue = "/VO/Chaos_0062", Text = "Come join me if you wish..." },
		{ Cue = "/VO/Chaos_0063", Text = "I offer you a different path..." },
		{ Cue = "/VO/Chaos_0064", Text = "You are summoned..." },
		{ Cue = "/VO/Chaos_0065", Text = "My gateway is opened..." },
		{ Cue = "/VO/Chaos_0066", Text = "Come enter the abyss..." },
	},
}
GlobalVoiceLines.ChaosHarvestReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	ChanceToPlay = 0.33,
	Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "TrialUpgrade", },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsAny = { "Chaos_01", "Chaos_02", "Chaos_03", "Chaos_04", "Chaos_05", "Chaos_06" },
		},
	},
	Cooldowns =
	{
		{ Name = "ChaosSpokeRecently", Time = 45 },
	},

	{ Cue = "/VO/Chaos_0191", Text = "You may have it." },
	{ Cue = "/VO/Chaos_0192", Text = "It is yours." },
	{ Cue = "/VO/Chaos_0193", Text = "A small gift." },
	{ Cue = "/VO/Chaos_0194", Text = "That is for you." },
	{ Cue = "/VO/Chaos_0195", Text = "Please enjoy." },
	{ Cue = "/VO/Chaos_0196", Text = "Do as you will." },
}