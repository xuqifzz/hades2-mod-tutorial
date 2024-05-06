GlobalVoiceLines.MiscEndVoiceLines_Chronos =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.5,
	GameStateRequirements =
	{
		--
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}Khh." },
	{ Cue = "/VO/Melinoe_1949", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
	{ Cue = "/VO/Melinoe_0322", Text = "{#Emph}Grr!" },
	{ Cue = "/VO/MelinoeField_0495", Text = "Coward..." },
	{ Cue = "/VO/MelinoeField_2023", Text = "{#Emph}Ungh..." },
}

-- Global Chronos Lines / Chronos Global Lines
GlobalVoiceLines.ChronosDeathTauntVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		SubtitleColor = Color.ChronosVoice,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01" },
			},
		},

		{ Cue = "/VO/Intercom_0083", Text = "Weakling! You shall never be her equal.", PlayFirst = true },
		{ Cue = "/VO/Intercom_0084", Text = "Your master cannot best me; how could you?" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		SubtitleColor = Color.ChronosVoice,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Boss01" },
			},
		},

		{ Cue = "/VO/Intercom_0088", Text = "Distracted by the Sirens' song, were you?" },
		{ Cue = "/VO/Intercom_0089", Text = "Like so many sailors sent to a watery grave..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		SubtitleColor = Color.ChronosVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		{ Cue = "/VO/Intercom_0090", Text = "The surface is no place for you, my girl.", PlayFirst = true },
		{ Cue = "/VO/Intercom_0091", Text = "Should you have reached Olympus, what then?" },
		{ Cue = "/VO/Intercom_0092", Text = "The age of gods is drawing to a close." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		SubtitleColor = Color.ChronosVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
			},
		},

		{ Cue = "/VO/Intercom_0065", Text = "You took everything from me, Hades. It's only fitting I should do the same." },
		{ Cue = "/VO/Intercom_0066", Text = "What happened to your daughter, Hades, {#Emph}hm? {#Prev}I'll ask nicely only one last time.", PlayFirst = true },
		{ Cue = "/VO/Intercom_0067", Text = "You gods are too unfit to rule this world. That is apparent from a single glance." },
		{ Cue = "/VO/Intercom_0068", Text = "You and my children stopped me once, Hades. But now, I've had plenty of time to prepare." },
		{ Cue = "/VO/Intercom_0069", Text = "You speak of justice, Hades? How many mortal souls have you cruelly tortured, for how long?" },
		{ Cue = "/VO/Intercom_0070", Text = "Fear not, the Fates are very safe. All three take my suggestions on their weavings well.",
			GameStateRequirements =
			{
				-- @ update with updated requirements
			},
		},
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0085", Text = "Shall you remain forever lost in Erebus?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
			},
		 },
		{ Cue = "/VO/Intercom_0093", Text = "I foresee every one of your useless attempts." },
		{ Cue = "/VO/Intercom_0086", Text = "So fiercely fought, yet so far from your goal." },
		{ Cue = "/VO/Intercom_0087", Text = "I have naught to fear from witches such as you." },
		{ Cue = "/VO/Intercom_0021", Text = "{#Emph}<Laughter>" },
		{ Cue = "/VO/Intercom_0022", Text = "{#Emph}<Laughter>" },
		{ Cue = "/VO/Intercom_0023", Text = "{#Emph}<Laughter>" },
		{ Cue = "/VO/Intercom_0036", Text = "You cannot stop Time." },
		{ Cue = "/VO/Intercom_0037", Text = "Give up, already, girl." },
		{ Cue = "/VO/Intercom_0038", Text = "You appear to be a slow learner." },
		{ Cue = "/VO/Intercom_0039", Text = "Another unsuccessful try." },
		{ Cue = "/VO/Intercom_0040", Text = "Are you becoming used to this result?" },
		{ Cue = "/VO/Intercom_0041", Text = "You struggle ceaselessly, but to what end?" },
		{ Cue = "/VO/Intercom_0042", Text = "I almost pity you your wasted efforts." },
		{ Cue = "/VO/Intercom_0043", Text = "All of your efforts, once again in vain." },
		{ Cue = "/VO/Intercom_0044", Text = "You are beginning to annoy me, girl." },
		{ Cue = "/VO/Intercom_0045", Text = "Never trifle with a Titan, girl." },
		{ Cue = "/VO/Intercom_0046", Text = "I ought to have you chained in Tartarus." },
		{ Cue = "/VO/Intercom_0047", Text = "Cease with these pointless attempts of yours." },
		{ Cue = "/VO/Intercom_0048", Text = "Your failure was inevitable." },
		{ Cue = "/VO/Intercom_0049", Text = "You are spirited, but not invincible." },
		{ Cue = "/VO/Intercom_0050", Text = "The Fates shall be no kinder to you next time." },
		{ Cue = "/VO/Intercom_0051", Text = "Was that the limit of your power, hm?" },
		{ Cue = "/VO/Intercom_0052", Text = "You could have done better than that." },
		-- { Cue = "/VO/Intercom_0053", Text = "How many further chambers can you stand?" },
		-- { Cue = "/VO/Intercom_0054", Text = "You were quite fortunate back there I think." },
	},
}

GlobalVoiceLines.AnomalyLocatedVoiceLines =
{
	[1] = GlobalVoiceLines.AnomalyReactionVoiceLines,
	[2] =
	{
		PlayOnce = true,
		PlayOnceContext = "ChronosAnomalyReveal",
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0037", Text = "Give up, already, girl." },

		-- { Cue = "/VO/Intercom_0147", Text = "I know who you are. I know where you go. You shall not get there.", PlayFirst = true, PlayOnce = true },
	},
	[3] =
	{
		ThreadName = "RoomThread",
		RandomRemaining = true,
		PreLineWait = 0.8,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0100", Text = "Where do you think you are going?" },
		{ Cue = "/VO/Intercom_0101", Text = "Such mindless, flailing persistence on your part." },
		{ Cue = "/VO/Intercom_0102", Text = "You venture into {#Emph}my {#Prev}domain." },
		{ Cue = "/VO/Intercom_0103", Text = "I know what you are attempting to achieve." },
		{ Cue = "/VO/Intercom_0104", Text = "My tolerance for you grows very thin." },
		{ Cue = "/VO/Intercom_0105", Text = "You wish to see your father's domain, do you?" },
		{ Cue = "/VO/Intercom_0106", Text = "Your efforts have not gone unnoticed, Granddaughter." },
		{ Cue = "/VO/Intercom_0107", Text = "Perhaps you should return some other {#Emph}time." },
		{ Cue = "/VO/Intercom_0108", Text = "This never was your father's realm." },
		{ Cue = "/VO/Intercom_0109", Text = "You speak to me of nightmares; here is one.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting03" },
				},
			},
		},
	},
}
GlobalVoiceLines.AnomalyEnteredVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.15,
		SuccessiveChanceToPlay = 0.75,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		Cooldowns =
		{
			{ Name = "AnomalyVOPlayed", Time = 5 },
		},

		{ Cue = "/VO/Intercom_0148", Text = "You wish to traipse through this realm, then here! Bask in it.", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/Intercom_0110", Text = "Behold the splendor of your father's Underworld." },
		{ Cue = "/VO/Intercom_0111", Text = "This is your father's realm as once it was." },
		{ Cue = "/VO/Intercom_0112", Text = "The Underworld you never knew! But, you did not miss much..." },
		{ Cue = "/VO/Intercom_0113", Text = "A glimpse of the past, or one of your nightmares?" },
		-- { Cue = "/VO/Intercom_0114", Text = "Here then is glorious Elysium, before it fell on harder times." },
		-- { Cue = "/VO/Intercom_0115", Text = "The champions within Elysium were always eager for a fight." },
		-- { Cue = "/VO/Intercom_0116", Text = "So many glory-seekers such as you wound up within Elysium." },
		{ Cue = "/VO/Intercom_0117", Text = "Your father's wretches within Asphodel so hated trespassers." },
		{ Cue = "/VO/Intercom_0118", Text = "Welcome to the verdant meadows of Asphodel." },
		{ Cue = "/VO/Intercom_0119", Text = "Bask now in the intolerable heat of Asphodel." },
	},
	{
		PreLineWait = 0.35,
		UsePlayerSource = true,
		PlayOnce = true,
		GameStateRequirements = 
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Intercom_0148" },
			},
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasNone = { "/VO/MelinoeField_0206", "/VO/Intercom_0149" },
			},
		},
		{ Cue = "/VO/MelinoeField_0248", Text = "That old man... it was {#Emph}him..." },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		PreLineWait = 0.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasNone = { "/VO/MelinoeField_0206", "/VO/Intercom_0149" },
			},
		},

		{ Cue = "/VO/MelinoeField_0190", Text = "Where am I... or {#Emph}when...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0191", Text = "This isn't real..." },
		{ Cue = "/VO/MelinoeField_0192", Text = "Trapped..." },
		{ Cue = "/VO/MelinoeField_0193", Text = "This again..." },
		{ Cue = "/VO/MelinoeField_0194", Text = "He's trying to slow me down..." },
		{ Cue = "/VO/MelinoeField_0195", Text = "Is this really Asphodel...?" },
		-- { Cue = "/VO/MelinoeField_0196", Text = "This is Elysium..." },
	},
}
GlobalVoiceLines.AnomalyCombatBeginsVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Intercom_0149", Text = "What witchery is this...?", PlayFirst = true },
		{ Cue = "/VO/Intercom_0130", Text = "So, you can see a pathway out..." },
		{ Cue = "/VO/Intercom_0131", Text = "But you just got here..." },
		{ Cue = "/VO/Intercom_0132", Text = "Do you really have to go so soon?" },
		{ Cue = "/VO/Intercom_0133", Text = "Why do you so wish to wake from such a beautiful dream?" },
		{ Cue = "/VO/Intercom_0134", Text = "Who taught you to perform such trickery?" },
		{ Cue = "/VO/Intercom_0135", Text = "You know something of Time and Dream, do you?" },
	},
}
GlobalVoiceLines.AnomalySurvivedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.95,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0150", Text = "You knew how to resist my little spell...", PlayFirst = true },
		{ Cue = "/VO/Intercom_0120", Text = "So what if you withstood all that..." },
		{ Cue = "/VO/Intercom_0121", Text = "Is this truly that which you are fighting for?" },
		{ Cue = "/VO/Intercom_0122", Text = "You survive, but you do not learn." },
		{ Cue = "/VO/Intercom_0123", Text = "That was, of course, a very different time." },
		{ Cue = "/VO/Intercom_0124", Text = "The times can change, but often stay the same." },
		{ Cue = "/VO/Intercom_0125", Text = "You wish your nightmares to become reality?" },
		{ Cue = "/VO/Intercom_0126", Text = "Continue at your peril, Granddaughter." },
		{ Cue = "/VO/Intercom_0127", Text = "Such nightmares shall consume you, in the end." },
		{ Cue = "/VO/Intercom_0128", Text = "Cease this whilst you have the opportunity." },
		{ Cue = "/VO/Intercom_0129", Text = "Even still you rush headlong toward oblivion." },
	},
}
GlobalVoiceLines.AnomalyConcludedVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "G_Story01" },
		},
	},
	--[[
	{
		RandomRemaining = true,
		PreLineWait = 0.95,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Intercom_0151", Text = "Be very careful where you tread, my girl...", PlayFirst = true },
		{ Cue = "/VO/Intercom_0136", Text = "How interesting that you were able to resist..." },
		{ Cue = "/VO/Intercom_0137", Text = "Again you broke my little spell, I see..." },
		{ Cue = "/VO/Intercom_0138", Text = "Welcome back to harsh reality..." },
		{ Cue = "/VO/Intercom_0139", Text = "Bygone times, Granddaughter..." },
		{ Cue = "/VO/Intercom_0140", Text = "Mere witchcraft, nothing more..." },
		{ Cue = "/VO/Intercom_0141", Text = "You dispelled my wonderful illusion..." },
	},
	]]--
	{
		PlayOnce = true,
		PlayOnceContext = "MelReturnFromAnomalyVO",
		RandomRemaining = true,
		PreLineWait = 0.7,
		UsePlayerSource = true,
		--SuccessiveChanceToPlay = 0.5,

		{ Cue = "/VO/MelinoeField_0216", Text = "Made it back..." },
		{ Cue = "/VO/MelinoeField_0217", Text = "Like waking from a dream..." },
		{ Cue = "/VO/MelinoeField_0218", Text = "It'll take more than that, Chronos...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0219", Text = "Merely a vision..." },
		{ Cue = "/VO/MelinoeField_0220", Text = "Back to reality..." },
		{ Cue = "/VO/MelinoeField_1410", Text = "Just an illusion...!" },
	},
}
GlobalVoiceLines.ErisNotSightedVoiceLines =
{
	PlayOnce = true,
	PlayOnceContext = "ErisCurseGiverMIA",
	RandomRemaining = true,
	SuccessiveChanceToPlayAll = 0.5,
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

	{ Cue = "/VO/MelinoeField_1959", Text = "No Eris, thank the gods...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_1960", Text = "Eris didn't show at least..." },
}

-- Global Chronos Intercom Lines
GlobalVoiceLines.ChronosAlertVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.95,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Intercom_0473", Text = "You are trespassing on private property...", PlayFirst = true },
		{ Cue = "/VO/Intercom_0151", Text = "Be very careful where you tread, my girl..." },
		{ Cue = "/VO/Intercom_0136", Text = "How interesting that you are able to resist..." },
		{ Cue = "/VO/Intercom_0475", Text = "An infiltrator breached through our defenses...!" },
		{ Cue = "/VO/Intercom_0476", Text = "We seem to have a bit of an infestation here..." },
		{ Cue = "/VO/Intercom_0477", Text = "It seems we have an unscheduled visitor..." },
		{ Cue = "/VO/Intercom_0478", Text = "My worshipers shall soften you up, if not stop you outright!" },
		{ Cue = "/VO/Intercom_0479", Text = "She has returned. Muster our defenses!" },
		{ Cue = "/VO/Intercom_0481", Text = "Perhaps we cannot find you in the Fields, but {#Emph}here?" },
		{ Cue = "/VO/Intercom_0483", Text = "{#Emph}Ah{#Prev}, Granddaughter! How kind of you to visit us again!" },
		{ Cue = "/VO/Intercom_0484", Text = "We bid you a warm welcome to the depths of Tartarus." },
		{ Cue = "/VO/Intercom_0485", Text = "Whatever brings you to my doorstep once again, my girl?" },
		{ Cue = "/VO/Intercom_0487", Text = "As predictable as the turning of the gears throughout this place..." },
		{ Cue = "/VO/Intercom_0488", Text = "Did you perhaps forget something when last you interfered?" },
		{ Cue = "/VO/Intercom_0490", Text = "Anybody sensible would {#Emph}flee {#Prev}from Tartarus, not {#Emph}barge {#Prev}right in!" },
		{ Cue = "/VO/Intercom_0491", Text = "This place was once my tomb; shall it be yours?" },
		{ Cue = "/VO/Intercom_0492", Text = "I shall be anticipating your arrival, Granddaughter.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0474", Text = "Why must everybody in our family be such an irritant?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0480", Text = "Confound it, but you are a difficult one to pin down...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = ">=",
					Value = 5,
				},
			},
		},
		{ Cue = "/VO/Intercom_0482", Text = "Do tell Hades I said greetings if you happen to run into him!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Story01" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0486", Text = "We have not seen you in a little while, my girl.",
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "RoomsEntered", "I_Intro" },
				},
			},
		},
		{ Cue = "/VO/Intercom_0489", Text = "She is heading for the House again. Stop her!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},

	},
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.45,

		{ Cue = "/VO/MelinoeField_1538", Text = "No more hiding in shadows...!" },
		{ Cue = "/VO/MelinoeField_1539", Text = "Try and stop me...!" },
		{ Cue = "/VO/MelinoeField_1540", Text = "Out of my way!" },
		{ Cue = "/VO/MelinoeField_1541", Text = "I'm not finished with you!" },
		{ Cue = "/VO/MelinoeField_1542", Text = "I'll see you soon, Titan!" },
		{ Cue = "/VO/MelinoeField_1543", Text = "He hides behind these wretches!", PlayFirst = true },
	},

}

GlobalVoiceLines.ChronosPreAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	ChanceToPlay = 0.2,
	ObjectType = "Chronos",
	Cooldowns =
	{
		{ Name = "ChronosSpokeRecently", Time = 20 },
	},

	{ Cue = "/VO/Chronos_0453", Text = "Now...!" },
	{ Cue = "/VO/Chronos_0454", Text = "Now then..." },
	{ Cue = "/VO/Chronos_0455", Text = "Perish!" },
	{ Cue = "/VO/Chronos_0457", Text = "Begone!" },
	{ Cue = "/VO/Chronos_0459", Text = "Prepare!" },
	{ Cue = "/VO/Chronos_0460", Text = "Observe!" },
	{ Cue = "/VO/Chronos_0461", Text = "Crumble!" },
	{ Cue = "/VO/Chronos_0462", Text = "Decay!" },
	{ Cue = "/VO/Chronos_0463", Text = "Watch this." },
	{ Cue = "/VO/Chronos_0464", Text = "Watch {#Emph}this!" },
	{ Cue = "/VO/Chronos_0465", Text = "Here!" },
	{ Cue = "/VO/Chronos_0466", Text = "Beware!" },
	{ Cue = "/VO/Chronos_0532", Text = "You..." },
	{ Cue = "/VO/Chronos_0533", Text = "Watch..." },
	{ Cue = "/VO/Chronos_0534", Text = "And now..." },
	{ Cue = "/VO/Chronos_0535", Text = "Now this!" },
	{ Cue = "/VO/Chronos_0536", Text = "Learn your place!" },
	{ Cue = "/VO/Chronos_0537", Text = "Expire!" },
	{ Cue = "/VO/Chronos_0538", Text = "More, then?" },
	{ Cue = "/VO/Chronos_0539", Text = "What now?" },
	{ Cue = "/VO/Chronos_0540", Text = "Here, then!" },
	{ Cue = "/VO/Chronos_0541", Text = "Poor girl..." },
	{ Cue = "/VO/Chronos_0542", Text = "Wretched girl..." },
	{ Cue = "/VO/Chronos_0543", Text = "You gods..." },
	{ Cue = "/VO/Chronos_0544", Text = "Have at you!" },
	{ Cue = "/VO/Chronos_0458", Text = "Begone, I say!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0457" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0456", Text = "Behold!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C", },
			},
		},
	},
}

GlobalVoiceLines.ChronosSummonVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	ObjectType = "Chronos",
	TriggerCooldowns = { "ChronosSpokeRecently" },
	Cooldowns =
	{
		{ Name = "ChronosSummonSpeech", Time = 45 },
	},

	{ Cue = "/VO/Chronos_0423", Text = "Come, my subjects, spill your blood for me!", PlayFirst = true },
	{ Cue = "/VO/Chronos_0424", Text = "{#Emph}Hellooo{#Prev}, reinforcements?" },
	{ Cue = "/VO/Chronos_0425", Text = "Reinforcements, {#Emph}now?" },
	{ Cue = "/VO/Chronos_0426", Text = "I call upon my subjects, {#Emph}now!" },
	{ Cue = "/VO/Chronos_0427", Text = "Let us invite some guests!" },
	{ Cue = "/VO/Chronos_0428", Text = "Oh, look! Company!" },
	{ Cue = "/VO/Chronos_0429", Text = "Come one, come all!" },
	{ Cue = "/VO/Chronos_0509", Text = "Legions of the Golden Age, come forth!" },
	{ Cue = "/VO/Chronos_0510", Text = "Legions of the Golden Age, answer my call!" },
	{ Cue = "/VO/Chronos_0511", Text = "Come, Legions of the Golden Age!" },
	{ Cue = "/VO/Chronos_0512", Text = "Come, my subjects, prove yourselves to me!" },
	{ Cue = "/VO/Chronos_0513", Text = "Come forth, my subjects!" },
	{ Cue = "/VO/Chronos_0514", Text = "I have strength in numbers, lest you forget!" },
	{ Cue = "/VO/Chronos_0515", Text = "My subjects have been waiting for this!" },
	{ Cue = "/VO/Chronos_0516", Text = "My forces are as numerous as grains of sand!" },
	{ Cue = "/VO/Chronos_0517", Text = "You cannot best my legions single-handedly!" },
	{ Cue = "/VO/Chronos_0518", Text = "Vast are the armies at my beck and call!" },
	{ Cue = "/VO/Chronos_0519", Text = "I have more guests I wish for you to meet!" },
}

GlobalVoiceLines.ChronosChronomancyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Chronos",
	TriggerCooldowns = { "ChronosSpokeRecently" },
	Cooldowns =
	{
		{ Name = "ChronosSpokeRecently", Time = 12 },
		{ Name = "ChronosChronomancySpeech", Time = 45 },
	},

	{ Cue = "/VO/Chronos_0430", Text = "Hold it right there..." },
	{ Cue = "/VO/Chronos_0431", Text = "Hold it." },
	{ Cue = "/VO/Chronos_0432", Text = "Hold it...!" },
	{ Cue = "/VO/Chronos_0433", Text = "Why the rush?" },
	{ Cue = "/VO/Chronos_0434", Text = "Be still." },
	{ Cue = "/VO/Chronos_0435", Text = "Stop." },
	{ Cue = "/VO/Chronos_0436", Text = "Stop, now." },
	{ Cue = "/VO/Chronos_0437", Text = "Stop right there...", PlayFirst = true },
	{ Cue = "/VO/Chronos_0438", Text = "Freeze." },
	{ Cue = "/VO/Chronos_0439", Text = "Freeze!" },
	{ Cue = "/VO/Chronos_0440", Text = "A moment, please?" },
	{ Cue = "/VO/Chronos_0441", Text = "Pardon a moment." },
	{ Cue = "/VO/Chronos_0520", Text = "Halt." },
	{ Cue = "/VO/Chronos_0521", Text = "Got you." },
	{ Cue = "/VO/Chronos_0522", Text = "Trapped." },
	{ Cue = "/VO/Chronos_0523", Text = "Caught." },
	{ Cue = "/VO/Chronos_0524", Text = "Caught out." },
	{ Cue = "/VO/Chronos_0525", Text = "Caught you." },
	{ Cue = "/VO/Chronos_0526", Text = "I have you." },
	{ Cue = "/VO/Chronos_0527", Text = "{#Emph}Heh." },
	{ Cue = "/VO/Chronos_0528", Text = "{#Emph}Hah!" },
	{ Cue = "/VO/Chronos_0529", Text = "Slow down." },
	{ Cue = "/VO/Chronos_0530", Text = "Time out." },
	{ Cue = "/VO/Chronos_0531", Text = "Time out...!" },
}

GlobalVoiceLines.ChronosUltimateVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	-- SuccessiveChanceToPlay = 0.5,
	ObjectType = "Chronos",
	Cooldowns =
	{
		{ Name = "ChronosSpokeUltimateRecently", Time = 30 },
	},
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0442", Text = "Your time is {#Emph}up!" },
	{ Cue = "/VO/Chronos_0443", Text = "The end is at hand!" },
	{ Cue = "/VO/Chronos_0444", Text = "I have {#Emph}had {#Prev}it with you!" },
	{ Cue = "/VO/Chronos_0445", Text = "This audience is {#Emph}over!" },
	{ Cue = "/VO/Chronos_0446", Text = "That {#Emph}does {#Prev}it!" },
	{ Cue = "/VO/Chronos_0447", Text = "Damnable girl!" },
	{ Cue = "/VO/Chronos_0448", Text = "{#Emph}All {#Prev}comes to an {#Emph}end!" },
	{ Cue = "/VO/Chronos_0449", Text = "Your final moments!" },
	{ Cue = "/VO/Chronos_0450", Text = "Enough is {#Emph}enough!" },
	{ Cue = "/VO/Chronos_0451", Text = "Granddaughter!!" },
	{ Cue = "/VO/Chronos_0452", Text = "Begone now from my {#Emph}sight!" },	
}

GlobalVoiceLines.ChronosSpellResistVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.15,
	ObjectType = "Chronos",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "ChronosSpellResistSpeech", Time = 20 },
	},	
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0339", Text = "How frightening." },
	{ Cue = "/VO/Chronos_0340", Text = "{#Emph}Ooh{#Prev}, how fierce." },
	{ Cue = "/VO/Chronos_0341", Text = "Oh dear." },
	{ Cue = "/VO/Chronos_0342", Text = "Oh no...!" },
	{ Cue = "/VO/Chronos_0343", Text = "Shall that be all?" },
	{ Cue = "/VO/Chronos_0346", Text = "That shall not work...", PlayFirst = true },
	{ Cue = "/VO/Chronos_0347", Text = "Embarrassing..." },
	{ Cue = "/VO/Chronos_0348", Text = "Are you quite done?" },
	{ Cue = "/VO/Chronos_0349", Text = "{#Emph}Uh-uh!" },
	{ Cue = "/VO/Chronos_0350", Text = "Alas..." },
	{ Cue = "/VO/Chronos_0014", Text = "I think not." },
	{ Cue = "/VO/Chronos_0094", Text = "Oh, please..." },
	{ Cue = "/VO/Chronos_0095", Text = "That shall not work." },
	{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
	{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance." },
}

GlobalVoiceLines.ChronosSurpriseReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.5,
	ObjectType = "Chronos",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "ChronosSurpriseReactionSpeech", Time = 20 },
	},
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0558", Text = "Surely you jest." },
	{ Cue = "/VO/Chronos_0559", Text = "Now why would you do {#Emph}that?", PlayFirst = true },
	{ Cue = "/VO/Chronos_0560", Text = "Am I supposed to be impressed?" },
	{ Cue = "/VO/Chronos_0561", Text = "Time slips away from you." },
}