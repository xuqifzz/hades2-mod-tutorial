-- Tartarus
GlobalVoiceLines.PostBossHiddenExitUsedVoiceLines =
{
	{
		PreLineWait = 0.35,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "RoomsEntered", "I_Intro" },
			},
		},

		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/MelinoeField_1271", Text = "On my authority as Princess of the Underworld: {#Emph}Unseal...!", PreLineWait = 0.5 },
		{ Cue = "/VO/Melinoe_0204", Text = "Excellent.", PreLineWait = 1.3, BreakIfPlayed = true }
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "I_Intro" },
			},
		},
		{ Cue = "/VO/MelinoeField_1273", Text = "{#Emph}Unseal.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1274", Text = "{#Emph}Unseal...!" },
		{ Cue = "/VO/MelinoeField_1276", Text = "Going down..." },
		{ Cue = "/VO/MelinoeField_1277", Text = "Here goes..." },
		{ Cue = "/VO/MelinoeField_1278", Text = "One last drop..." },
	},
}
GlobalVoiceLines.RoomOpeningMainDoorVoiceLines =
{
	{
		PreLineWait = 0.35,
		{ Cue = "/VO/MelinoeField_1270", Text = "Please work..." },
		{ Cue = "/VO/MelinoeField_1272", Text = "On my authority as Princess of the Underworld: {#Emph}Unseal.", PreLineWait = 1.0 },

		{ Cue = "/VO/MelinoeField_1472", Text = "Blood and...", PreLineWait = 2.33, PreLineAnim = "MelTalkBroodingFull01" },
		{ Cue = "/VO/Melinoe_1633", Text = "Didn't work...", PreLineWait = 1.1 },
		{ Cue = "/VO/Melinoe_0215", Text = "How about...", PreLineWait = 1.25 },
	},
}