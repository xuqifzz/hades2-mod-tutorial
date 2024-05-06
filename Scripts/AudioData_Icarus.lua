-- Global Icarus Lines
GlobalVoiceLines.MiscEndVoiceLines_Icarus =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Icarus_01",
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Icarus_0053", Text = "Let me know how it goes!" },
		{ Cue = "/VO/Icarus_0054", Text = "You won't be disappointed.", PlayFirst = true },
		{ Cue = "/VO/Icarus_0055", Text = "Good choice." },
		{ Cue = "/VO/Icarus_0056", Text = "Here you go." },
		{ Cue = "/VO/Icarus_0059", Text = "Careful, OK?" },
		{ Cue = "/VO/Icarus_0060", Text = "How did I know...?" },
		{ Cue = "/VO/Icarus_0109", Text = "All yours." },
		{ Cue = "/VO/Icarus_0110", Text = "Hope it helps." },
		{ Cue = "/VO/Icarus_0111", Text = "{#Emph}Ah{#Prev}, yes." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.15,
		AllowTalkOverTextLines = true,

		-- { Cue = "/VO/MelinoeField_0255", Text = "I'm grateful, milady." },
		-- { Cue = "/VO/MelinoeField_0256", Text = "Night protect us...", PlayFirst = true },
	},
	[3] = GlobalVoiceLines.ThankingCharacterVoiceLines,
	-- [4] = GlobalVoiceLines.MedeaIncantationLines,
}
