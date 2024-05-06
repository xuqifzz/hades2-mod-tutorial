-- Global Hermes Lines
GlobalVoiceLines.HermesFirstSpawnVoiceLines =
{
	{
		PreLineWait = 0.5,
		ObjectType = "NPC_Hermes_01",

		{ Cue = "/VO/Hermes_0070", Text = "{#Emph}Whew! {#Prev}Hey M! I'm back!" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "H" },
			},
		},
		{ Cue = "/VO/MelinoeField_2000", Text = "You are!" },
	},
}

GlobalVoiceLines.SpecialDeliverVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.42,
		Source = { LineHistoryName = "NPC_Hermes_01", SubtitleColor = Color.HermesVoice },
		Cooldowns =
		{
			{ Name = "HermesSpokeRecently", Time = 2 },
			{ Name = "HermesSpecialDeliveredRecently", Time = 10 },
		},

		{ Cue = "/VO/Hermes_0116", Text = "Special delivery!", PlayFirst = true, },
		{ Cue = "/VO/Hermes_0117", Text = "Special delivery...!" },
		{ Cue = "/VO/Hermes_0118", Text = "Coming through!" },
		{ Cue = "/VO/Hermes_0119", Text = "Here you go!" },
		{ Cue = "/VO/Hermes_0120", Text = "Hi M! Bye M!" },
		{ Cue = "/VO/Hermes_0121", Text = "Cheers M!" },
		{ Cue = "/VO/Hermes_0122", Text = "Package for you!" },
		{ Cue = "/VO/Hermes_0123", Text = "Got you this!" },
		{ Cue = "/VO/Hermes_0124", Text = "You called?" },
		{ Cue = "/VO/Hermes_0125", Text = "Package here!" },
		{ Cue = "/VO/Hermes_0126", Text = "Hermes, at your service!" },
		{ Cue = "/VO/Hermes_0127", Text = "Hey hey!" },
		{ Cue = "/VO/Hermes_0136", Text = "Cheers, M!" },
		{ Cue = "/VO/Hermes_0138", Text = "Enjoy!" },
	},
}