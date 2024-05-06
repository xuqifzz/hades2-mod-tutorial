-- Global Heracles Lines
GlobalVoiceLines.HeraclesBoonReactionVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 1.65,
	ObjectType = "NPC_Heracles_01",
	RecheckRequirementsForSubLines = true,
	GameStateRequirements =
	{
		--
	},

	{ Cue = "/VO/Heracles_0152", Text = "Even the gods have their price." },
	{ Cue = "/VO/Heracles_0153", Text = "Olympus..." },
	{ Cue = "/VO/Heracles_0154", Text = "She's aiding {#Emph}you?", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentLootData", "Name" },
				IsAny = { "HeraUpgrade" },
			},
		},
	},
	{ Cue = "/VO/Heracles_0155", Text = "That's all it takes, huh." },
}
GlobalVoiceLines.HeraclesDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Heracles_01", SubtitleColor = Color.HeraclesVoice },

	{ Cue = "/VO/Heracles_0104", Text = "Blasted weaklings everywhere in sight..." },
	{ Cue = "/VO/Heracles_0105", Text = "The gods are poor at choosing champions...", PlayFirst = true },
	{ Cue = "/VO/Heracles_0106", Text = "I said to stay out of my blasted way..." },
	{ Cue = "/VO/Heracles_0107", Text = "No mercy for the weak out here, sister." },
}