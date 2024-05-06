
-- Mailbox
GlobalVoiceLines.OpenedMailboxVoiceLines =
{
	{
		SkipAnim = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		SuccessiveChanceToPlay = 0.05,
		PlayOnceFromTableThisRun = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_2601", Text = "Special-order privileges from Lord Charon himself...", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/Melinoe_2277", Text = "Lord Charon's Gold Rewards..." },
	},
}

GlobalVoiceLines.TradedMailboxItemVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
		},

		{ Cue = "/VO/Melinoe_2288", Text = "Now we wait..." },
		{ Cue = "/VO/Melinoe_2289", Text = "Could use this." },
		{ Cue = "/VO/Melinoe_2290", Text = "Order approved.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_2291", Text = "Ordering this." },
		{ Cue = "/VO/Melinoe_2292", Text = "Shouldn't be too long." },
		{ Cue = "/VO/Melinoe_2293", Text = "Should be here soon enough." },
	},
}
GlobalVoiceLines.CannotAffordMailboxItemVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_2294", Text = "Not eligible." },
		{ Cue = "/VO/Melinoe_2295", Text = "Not authorized." },
		{ Cue = "/VO/Melinoe_2296", Text = "I'll have to turn in more Gold.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2297", Text = "Can't redeem that yet." },
	},
}
GlobalVoiceLines.WaitingForMailboxItemVoiceLines =
{
	{
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		
		{ Cue = "/VO/Melinoe_2329", Text = "This'll take a little while..." },
		{ Cue = "/VO/Melinoe_2330", Text = "It'll be worth the wait." },
	},
}