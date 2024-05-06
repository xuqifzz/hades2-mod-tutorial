-- ChallengeSwitch
GlobalVoiceLines.ChallengeEncounterActivatedLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.33,

		{ Cue = "/VO/Melinoe_1740", Text = "This was stolen from us." },
		{ Cue = "/VO/Melinoe_1741", Text = "By my Father's name." },
		{ Cue = "/VO/Melinoe_1742", Text = "I'm taking this back." },
		{ Cue = "/VO/Melinoe_1743", Text = "Confiscating stolen property.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1744", Text = "This is private property." },
	},
}
GlobalVoiceLines.ChallengeEncounterEnemySightedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.85,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.5,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "GeneratedAnomalyB", "ClockworkIntro", "GeneratedIChronosIntro", "GeneratedI_SmallChronosIntro" },
		},
	},

	{ Cue = "/VO/Melinoe_1745", Text = "You should have stayed in shadow." },
	{ Cue = "/VO/Melinoe_1746", Text = "Come, you thieves." },
	{ Cue = "/VO/Melinoe_1747", Text = "Interlopers...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_1748", Text = "This does not belong to you." },
	{ Cue = "/VO/Melinoe_1749", Text = "This will be over soon." },
}
GlobalVoiceLines.ChallengeEncounterClearedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.33,

	{ Cue = "/VO/Melinoe_1754", Text = "Enough of that." },
	{ Cue = "/VO/Melinoe_1755", Text = "Now, then..." },
	{ Cue = "/VO/Melinoe_1756", Text = "Now to the matter at hand..." },
	{ Cue = "/VO/Melinoe_1757", Text = "Thieving wretches...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_1758", Text = "They're gone." },
}
GlobalVoiceLines.ChallengeSwitchOpenedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlayAll = 0.5,

	{ Cue = "/VO/Melinoe_1759", Text = "Thank you, Father." },
	{ Cue = "/VO/Melinoe_1760", Text = "For safe-keeping." },
	{ Cue = "/VO/Melinoe_1761", Text = "That's everything." },
	{ Cue = "/VO/Melinoe_1762", Text = "Property recovered.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_1763", Text = "Mine now." },
	{ Cue = "/VO/Melinoe_0234", Text = "Open." },
	{ Cue = "/VO/Melinoe_0235", Text = "Open up." },
}
GlobalVoiceLines.ChallengeSwitchEmptyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.75,

	-- TKTK
}
GlobalVoiceLines.ExtraDoorEncounterStartVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Nemesis_01",

		{ Cue = "/VO/NemesisField_0378", Text = "One more round?" },
		{ Cue = "/VO/NemesisField_0379", Text = "Back on your guard." },
		{ Cue = "/VO/NemesisField_0380", Text = "Incoming." },
		{ Cue = "/VO/NemesisField_0381", Text = "More incoming." },
		{ Cue = "/VO/NemesisField_0382", Text = "What did you just do?" },
		{ Cue = "/VO/NemesisField_0383", Text = "What now." },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "ExtraDoorIntro", 
		PreLineWait = 0.25,
		{ Cue = "/VO/MelinoeField_0148", Text = "Open up..." },
		{ Cue = "/VO/MelinoeField_0149", Text = "...Oh great.", PreLineWait = 1.15, BreakIfPlayed = true, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.33,
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
		Cooldowns =
		{
			{ Name = "MelinoeExtraDoorOpenedSpeech", Time = 45 },
		},

		{ Cue = "/VO/Melinoe_1745", Text = "You should have stayed in shadow.", PreLineWait = 1.85 },
		{ Cue = "/VO/Melinoe_1747", Text = "Interlopers...", PreLineWait = 1.85 },
		{ Cue = "/VO/Melinoe_1749", Text = "This will be over soon.", PreLineWait = 1.85 },
		{ Cue = "/VO/MelinoeField_0150", Text = "What's in this one." },
		{ Cue = "/VO/MelinoeField_0151", Text = "Worth a shot." },
		{ Cue = "/VO/MelinoeField_0152", Text = "Why not." },
		{ Cue = "/VO/MelinoeField_0153", Text = "Let's try it." },
		{ Cue = "/VO/MelinoeField_0154", Text = "Let's see what's here.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0155", Text = "Might be a better path." },
		{ Cue = "/VO/MelinoeField_0148", Text = "Open up..." },
	},
}