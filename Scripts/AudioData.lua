-- Global Dora Lines / Dora Global Lines
PresetAudioArgs =
{
	DoraNormalAppearArgs =
	{
		SetModel = "Dora_Mesh",
		SetAnimation = "Dora_Appear",
	},

	DoraScaryAppearArgs =
	{
		SetModel = "ScaryDora_Mesh",
		SetAnimation = "DoraScary_Appear",
		CreateAnimation = "EnemyDeathFx_Dora",
	},
}

-- Global Mel Lines
GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.UsedFountainVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.2,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_PostBoss01", "G_PostBoss01", "H_PostBoss01", "N_PostBoss01", "O_PostBoss01", "P_PostBoss01" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 1.0, },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

		{ Cue = "/VO/Melinoe_1845", Text = "Not thirsty, but hey...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1846", Text = "Just a small sip..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.75,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "SurfacePenalty" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0251", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_0252", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0253", Text = "{#Emph}<Sigh>" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.75,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_PostBoss01", "G_PostBoss01", "N_PostBoss01", "O_PostBoss01" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "BarrierDownVoiceLines", Time = 4 },
		},

		{ Cue = "/VO/Melinoe_0250", Text = "{#Emph}Whew." },
		{ Cue = "/VO/Melinoe_0251", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_0252", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0253", Text = "{#Emph}<Sigh>" },
		{ Cue = "/VO/Melinoe_1122", Text = "Pure water...", PreLineWait = 0.9 },
		{ Cue = "/VO/Melinoe_1842", Text = "Clean..." },
		{ Cue = "/VO/Melinoe_1843", Text = "OK..." },
		{ Cue = "/VO/Melinoe_1844", Text = "That's good..." },
		{ Cue = "/VO/Melinoe_1841", Text = "Needed that...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = "<=", Value = 0.5, },
				},
			},
		},
	},
	{
		Queue = "Always",
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_PostBoss01" },
			},
		},

		{ Cue = "/VO/MelinoeField_1256", Text = "OK... let's see if this works.", PlayFirst = true, PlayOnce = true, PlayOnceContext = "HPostBossFirstVisitVO" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.35,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Chronos_02",
		Cooldowns =
		{
			{ Name = "ChronosAnyQuipSpeech", Time = 8 },
		},
		RequiredSourceValueFalse = "Hidden",

		{ Cue = "/VO/Chronos_1104", Text = "May you be well.", PlayFirst = true },
		{ Cue = "/VO/Chronos_1102", Text = "Refreshing, is it not?" },
		{ Cue = "/VO/Chronos_1103", Text = "The source of life..." },
		{ Cue = "/VO/Chronos_1105", Text = "For the road ahead." },
		{ Cue = "/VO/Chronos_1106", Text = "The water runs clear." },
		{ Cue = "/VO/Chronos_1107", Text = "Ready to go?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.35,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Chronos_01",
		Cooldowns =
		{
			{ Name = "ChronosAnyQuipSpeech", Time = 8 },
		},
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "SpawnedChronosForTaunt" },
			},
		},

		{ Cue = "/VO/Chronos_0078", Text = "Refreshing, is it not?" },
		{ Cue = "/VO/Chronos_0079", Text = "Please help yourself, my girl." },
		{ Cue = "/VO/Chronos_0080", Text = "How unsanitary." },
		{ Cue = "/VO/Chronos_0081", Text = "{#Emph}Ahem?", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Chronos_0081" },
				},
			},
		},
		{ Cue = "/VO/Chronos_0082", Text = "Please take your time.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Chronos_0082" },
				},
			},
		},
	}
}
GlobalVoiceLines.UsedTelescopeVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary" },
			HasNone = { "SurfacePenalty" },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeTelescopeSpeech", Time = 20 },
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	{ Cue = "/VO/MelinoeField_0610", Text = "Let's have a look around..." },
	{ Cue = "/VO/MelinoeField_0611", Text = "Let's see..." },
	{ Cue = "/VO/MelinoeField_0612", Text = "What else is here..." },
	{ Cue = "/VO/MelinoeField_0613", Text = "Let's get the lay of the land..." },
	{ Cue = "/VO/MelinoeField_0614", Text = "Show me the surroundings." },
	{ Cue = "/VO/MelinoeField_0615", Text = "Where else can we go.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	{ Cue = "/VO/MelinoeField_0616", Text = "Need a quick overview.", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_0617", Text = "What's left of Ephyra?" },
}

GlobalVoiceLines.CannotUseZoomOutVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				-- PathEmpty = { "RequiredKillEnemies" },
			}
		},
		Cooldowns =
		{
			{ Name = "MelinoeZoomOutSpeech", Time = 20 },
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_1364", Text = "A bat-cage, but no sign of any bats...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1063", Text = "Should try an incantation back home..." },
		{ Cue = "/VO/MelinoeField_1064", Text = "Can't do anything with this right now." },
	},
}
GlobalVoiceLines.CannotUseRewardFinderVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			}
		},
		Cooldowns =
		{
			{ Name = "MelinoeRewardFinderSpeech", Time = 20 },
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_1061", Text = "I'll have to use the cauldron first." },
		{ Cue = "/VO/MelinoeField_1062", Text = "I can't revive this yet." },
		{ Cue = "/VO/MelinoeField_1063", Text = "Should try an incantation back home...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1064", Text = "Can't do anything with this right now." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			}
		},

		{ Cue = "/VO/Melinoe_0127", Text = "I can't!" },
	}
}
GlobalVoiceLines.UsedRewardFinderVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.35,
	-- SuccessiveChanceToPlay = 0.8,
	GameStateRequirements =
	{
		--
	},
	Cooldowns =
	{
		{ Name = "MelinoeBoughSpeech", Time = 20 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/MelinoeField_0828", Text = "Flourish, and reveal my path...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_0829", Text = "Flourish..." },
	{ Cue = "/VO/MelinoeField_0830", Text = "Flourish...!" },
	{ Cue = "/VO/MelinoeField_0831", Text = "Show me the way..." },
	{ Cue = "/VO/MelinoeField_0832", Text = "Grow golden once again..." },
	{ Cue = "/VO/MelinoeField_0833", Text = "Illuminate my path!" },
}

GlobalVoiceLines.ErisNotSightedVoiceLines =
{
	Queue = "Always",
	PlayOnce = true,
	PlayOnceContext = "ErisCurseGiverMIA",
	RandomRemaining = true,
	SuccessiveChanceToPlayAll = 0.5,
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
	UsePlayerSource = true,
	GameStateRequirements =
	{
		{
			PathFalse = { "CurrentRun", "UseRecord", "NPC_Eris_01" },
		},
	},

	{ Cue = "/VO/MelinoeField_1959", Text = "No Eris, thank the gods...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_1960", Text = "Eris didn't show at least..." },
}

GlobalVoiceLines.BiomeStateChangeStartVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 1.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "WetState" },
			},
		},

		{ Cue = "/VO/Melinoe_1309", Text = "The rains return..." },
		{ Cue = "/VO/Melinoe_1310", Text = "Raining again...", PlayFirst = true },
	},

}
GlobalVoiceLines.TaskBegunVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelRunStartSpeech", Time = 12 },
	},

	-- potentially final underworld run
	{
		BreakIfPlayed = true,
		PreLineWait = 1.2,
		PlayOnce = true,
		PlayOnceContext = "FinalUnderworldRunStartVO",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				SumPrevRuns = 4,
				Path = { "SpeechRecord", "/VO/Melinoe_0115" },
				CountPathTrue = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		{ Cue = "/VO/Melinoe_0115", Text = "For my family." },
	},
	-- first surface visit
	{
		BreakIfPlayed = true,
		PreLineWait = 1.2,
		PlayOnce = true,
		PlayOnceContext = "FirstSurfaceRunStartVO",

		{ Cue = "/VO/Melinoe_0569", Text = "{#Emph}<Inhale>", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "RoomCountCache", "N_Opening01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N" },
				},
			},
		},
	},
	-- all other cases
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.2,
		SuccessiveChanceToPlay = 0.85,
		SuccessiveChanceToPlayAll = 0.25,

		-- surface route
		{ Cue = "/VO/MelinoeField_4353", Text = "No trace of Typhon shall remain.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "NeoChronosAboutOlympus01", "NeoChronosAboutOlympus01_B" },
				},
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0569", Text = "{#Emph}<Inhale>", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0121", Text = "Hold on, everyone.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0122", Text = "Cold up here...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N" },
				},
			},
		},

		-- underworld route
		{ Cue = "/VO/MelinoeField_4352", Text = "No trace of the old Chronos shall remain.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutTartarus01_B" },
				},
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0380", Text = "I'll get you, Chronos.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1670", Text = "To the House of Hades.",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0004_V3", Text = "Death to Chronos.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 7,
				},
				OrRequirements =
				{
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04_2" }
						},
					},
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_0402", Text = "Time is against us.",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},

		-- either route
		{ Cue = "/VO/MelinoeField_4351", Text = "Another possibility.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "PrevRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4350", Text = "Time shall freely flow.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutOlympus01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4348", Text = "Just like before.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "PrevRun", "Cleared" },
				},
				OrRequirements =
				{
					{
						{
							PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "N" }
						},
					},
					{
						{
							PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "F" }
						},
					},
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4349", Text = "Ensuring victory.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "PrevRun", "Cleared" },
				},
				OrRequirements =
				{
					{
						{
							PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "N" }
						},
					},
					{
						{
							PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "F" }
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_0003_V3", Text = "It's now or never.",
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_0114", Text = "Time to shine." },
		{ Cue = "/VO/Melinoe_0115", Text = "For my family." },
		{ Cue = "/VO/Melinoe_0116", Text = "Moonlight guide me." },
		{ Cue = "/VO/Melinoe_0117", Text = "Beginning assignment." },
		{ Cue = "/VO/Melinoe_0118", Text = "All right." },
		{ Cue = "/VO/Melinoe_0119", Text = "I was born for this." },
		{ Cue = "/VO/Melinoe_0120", Text = "No pressure." },
		{ Cue = "/VO/Melinoe_0382", Text = "No holding back." },
		{ Cue = "/VO/Melinoe_0383", Text = "I will not fail." },
		{ Cue = "/VO/Melinoe_0384", Text = "Headmistress guide me." },
		{ Cue = "/VO/Melinoe_0385", Text = "For the Silver Sisters." },
		{ Cue = "/VO/Melinoe_1666", Text = "Strength; knowledge; patience." },
		{ Cue = "/VO/Melinoe_0381", Text = "This is my path.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_0377" },
				},
			},
		},
	},
}

-- RunStartVoiceLines
GlobalVoiceLines.StartNewRunVoiceLines =
{
	-- underworld route
	{ GlobalVoiceLines = "StartPostTrueEndingRunIntroVoiceLines" },
	{
		PlayOnce = true,
		PlayOnceContext = "HecateMissingRunStartVO",
		BreakIfPlayed = true,
		PreLineWait = 0.3,
		UsePlayerSource = true,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			NamedRequirements = { "HecateMissing" },
		},

		{ Cue = "/VO/Melinoe_5158", Text = "I need to find Headmistress...!" },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "FinalUnderworldRunStartVO",
		BreakIfPlayed = true,
		PreLineWait = 0.3,
		UsePlayerSource = true,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
			},
			{
				PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_5694" },
			},
		},

		{ Cue = "/VO/Melinoe_5694", Text = "Done with Typhon. Chronos next.", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		UsePlayerSource = true,
		ThreadName = "RoomThread",
		SuccessiveChanceToPlay = 0.9,
		SuccessiveChanceToPlayAll = 0.8,

		{ Cue = "/VO/Melinoe_0107", Text = "I'm off." },
		{ Cue = "/VO/Melinoe_0108", Text = "I go.", },
		{ Cue = "/VO/Melinoe_0109", Text = "Heading out.", },
		{ Cue = "/VO/Melinoe_0110", Text = "Commencing.", },
		{ Cue = "/VO/Melinoe_0029", Text = "I'd best be off...", },
		{ Cue = "/VO/Melinoe_0375", Text = "Farewell, Commander.", },
		{ Cue = "/VO/Melinoe_0377", Text = "This is my path.", },
		{ Cue = "/VO/Melinoe_0378", Text = "I'll make this count." },
		{ Cue = "/VO/Melinoe_0379", Text = "My path is set.", },
		{ Cue = "/VO/Melinoe_1668", Text = "I was born for this." },
		{ Cue = "/VO/Melinoe_3058_B", Text = "Here we go." },
		{ Cue = "/VO/Melinoe_4302", Text = "Into the dark." },
		{ Cue = "/VO/Melinoe_4304", Text = "For the Unseen." },
		{ Cue = "/VO/Melinoe_4305", Text = "To the abyss." },
		{ Cue = "/VO/Melinoe_5695", Text = "Death to Chronos.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasNone = { "ZagreusPastMeeting04_2", "ZagreusPastMeeting05" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0376", Text = "Into Erebus.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "ActiveBounty" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1608", Text = "Find the Titan, slay the Titan.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "ActiveBounty" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasNone = { "ZagreusPastMeeting04_2", "ZagreusPastMeeting05" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0111", Text = "Once more.",
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							PathFromArgs = true,
							PathFalse = { "ActiveBounty" },
						},
					},
					{
						{
							PathFromArgs = true,
							Path = { "ActiveBountyAttempts" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_2482", Text = "Once more, then.",
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							PathFromArgs = true,
							PathFalse = { "ActiveBounty" },
						},
					},
					{
						{
							PathFromArgs = true,
							Path = { "ActiveBountyAttempts" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3390", Text = "Ready or not, hence I go.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3391", Text = "Hence I go...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4303", Text = "To Tartarus.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Intro" },
				},
				{
					PathFromArgs = true,
					PathFalse = { "ActiveBounty" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4306", Text = "Walk in the woods...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					SumPrevRuns = 2,
					Path = { "Cleared" },
					CountPathTrue = true,
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "GameState", "ClearedUnderworldRunsCache" },
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "GameState", "ClearedSurfaceRunsCache" },
					Comparison = ">=",
					Value = 2,
				},
				{
					PathFromArgs = true,
					PathFalse = { "ActiveBounty" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5721", Text = "Let's go kill Time.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift02" }
				},
			},
		},
		{ Cue = "/VO/Melinoe_4307", Text = "Now for Chronos.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
				},
				{
					Path = { "GameState", "ClearedUnderworldRunsCache" },
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "GameState", "ClearedSurfaceRunsCache" },
					Comparison = ">=",
					Value = 2,
				},
				{
					PathFromArgs = true,
					PathFalse = { "ActiveBounty" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
	},
	{ GlobalVoiceLines = "StartMiscRunVoiceLines" },
}
GlobalVoiceLines.StartSurfaceRunVoiceLines =
{
	-- surface route
	{ GlobalVoiceLines = "StartPostTrueEndingRunIntroVoiceLines" },
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.9,
		SuccessiveChanceToPlayAll = 0.8,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/Melinoe_0113", Text = "To the surface.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2480", Text = "Heading up." },
		{ Cue = "/VO/Melinoe_2483", Text = "Break the siege...",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2488", Text = "Unfinished business here..." },
		{ Cue = "/VO/Melinoe_2489", Text = "More to be done up here." },
		{ Cue = "/VO/Melinoe_1665", Text = "With the grace of the Moon." },
		{ Cue = "/VO/Melinoe_3568", Text = "Toward the gods..." },
		{ Cue = "/VO/Melinoe_3569", Text = "Going up..." },
		{ Cue = "/VO/Melinoe_4308", Text = "Into the cold." },
		{ Cue = "/VO/Melinoe_4311", Text = "For the family." },
		{ Cue = "/VO/Melinoe_4312", Text = "To higher ground." },
		{ Cue = "/VO/Melinoe_4309", Text = "Just wait, Typhon.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4310", Text = "Now for Typhon.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
				},
				{
					Path = { "GameState", "ClearedUnderworldRunsCache" },
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "GameState", "ClearedSurfaceRunsCache" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Melinoe_2481", Text = "Ephyra awaits.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
				{
					PathTrue = { "GameState", "RoomsEntered", "N_Hub" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3571", Text = "Olympus, here I come...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3572", Text = "To the mountaintop.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3570", Text = "Through Ephyra...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3567", Text = "All right, Eris...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "RoomsEntered" },
					HasAny = { "O_Boss01", "O_Boss02" },
				},
				{
					PathFalse = { "CurrentRun", "RoomsEntered", "P_Intro" },
				},
				{
					PathFalse = { "GameState", "TextLinesRecord", "ErisTaverna02" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0112", Text = "To Olympus.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2484", Text = "Olympus calls...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2485", Text = "Deep breath...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2486", Text = "This way this time...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2485" },
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
				-- the run has not yet reset before this plays
				{
					PathTrue = { "CurrentRun", "BiomesReached", "F" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2487", Text = "New night, new path.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2485" },
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
				-- the run has not yet reset before this plays
				{
					PathTrue = { "CurrentRun", "BiomesReached", "F" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.25,
		PlayOnce = true,
		PlayOnceContext = "SkellySurfaceRunReaction",
		ObjectType = "NPC_Skelly_01",
		ThreadName = "RoomThread",

		{ Cue = "/VO/Skelly_0123", Text = "Wait how did you—" ,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" }
				},
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
				},
			},
		},
	},
	{ GlobalVoiceLines = "StartMiscRunVoiceLines" },
}
GlobalVoiceLines.StartPostTrueEndingRunIntroVoiceLines =
{
	PlayOnce = true,
	PlayOnceContext = "PostTrueEndingRunStartIntroVO",
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.3,
	ThreadName = "RoomThread",
	GameStateRequirements =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
	},

	{ Cue = "/VO/Melinoe_5280", Text = "Let's see what happens...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_5281", Text = "Time to retrace my steps..." },
	{ Cue = "/VO/Melinoe_5282", Text = "Here we go again...!" },
	{ Cue = "/VO/Melinoe_5283", Text = "The task continues." },
	{ Cue = "/VO/Melinoe_5284", Text = "Always more to be done." },
	{ Cue = "/VO/Melinoe_5285", Text = "All part of our new phase." },
}
GlobalVoiceLines.StartMiscRunVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.3,
	SuccessiveChanceToPlayAll = 0.8,
	ThreadName = "RoomThread",
	GameStateRequirements =
	{
		{
		},
	},

	{ Cue = "/VO/Melinoe_4313", Text = "Till tomorrow." },
	{ Cue = "/VO/Melinoe_4314", Text = "Again." },
	{ Cue = "/VO/Melinoe_4315", Text = "Into the night." },
	{ Cue = "/VO/Melinoe_4318", Text = "From the shadows..." },
	{ Cue = "/VO/Melinoe_4319", Text = "Farewell, everyone." },
	{ Cue = "/VO/Melinoe_4325", Text = "Moonlight guide us." },
	{ Cue = "/VO/Melinoe_4326", Text = "Moonlight guide me." },
	{ Cue = "/VO/Melinoe_4316", Text = "{#Emph}Easy.",
		GameStateRequirements =
		{
			{
				SumPrevRuns = 3,
				-- CurrentRun hasn't 'turned over' yet so this isn't needed
				-- IgnoreCurrentRun = true,
				Path = { "Cleared" },
				CountPathTrue = true,
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	{ Cue = "/VO/Melinoe_4317", Text = "Let's keep this up.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" }
			},
		},
	},
	{ Cue = "/VO/Melinoe_4320", Text = "Frinos, with me.",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsAny = { "FrogFamiliar" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_4321", Text = "Raki, come on.",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsAny = { "RavenFamiliar" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_4322", Text = "Toula, ready?",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsAny = { "CatFamiliar" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_4323", Text = "Hecuba, let's go.",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsAny = { "HoundFamiliar" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_4324", Text = "Stay close, Gale.",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsAny = { "PolecatFamiliar" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_5280", Text = "Let's see what happens...", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_5281", Text = "Time to retrace my steps...", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_5282", Text = "Here we go again...!", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_5283", Text = "The task continues.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_5284", Text = "Always more to be done.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_5285", Text = "All part of our new phase.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
	},
}

GlobalVoiceLines.FamiliarFrogCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5415", Text = "Let's see it, Frinos!" },
	},
}
GlobalVoiceLines.FamiliarRavenCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5416", Text = "Raki, shapeshift!" },
	},
}
GlobalVoiceLines.FamiliarCatCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5417", Text = "Toula, transform!" },
	},
}
GlobalVoiceLines.FamiliarHoundCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5418", Text = "Switch it up, Hecuba!" },
	},
}
GlobalVoiceLines.FamiliarPolecatCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5419", Text = "Gale, makeover time!" },
	},
}
GlobalVoiceLines.FamiliarAngryCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5409", Text = "Show me your rage!" },
	},
}
GlobalVoiceLines.FamiliarCoolCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5410", Text = "Show me your discipline!" },
	},
}
GlobalVoiceLines.FamiliarCuteCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5412", Text = "Show me your whimsy!" },
	},
}
GlobalVoiceLines.FamiliarChillCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5411", Text = "Show me your serenity!" },
	},
}
GlobalVoiceLines.FamiliarDarkCostumeUnlocked =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5414", Text = "Show me your Dark Side!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_5414_B", Text = "Show me your Dark Side!" },
		{ Cue = "/VO/Melinoe_5414_C", Text = "Show me your Dark Side!" },
	},
}
GlobalVoiceLines.FamiliarMiscCostumeUnlocked =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		-- SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		Queue = "Always",

		{ Cue = "/VO/Melinoe_5408", Text = "Show me another side of you!" },
		{ Cue = "/VO/Melinoe_5413", Text = "Show me who you are!" },
	}
}

GlobalVoiceLines.FamiliarFrogSwitchCostumeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.5,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5428", Text = "Shapeshift, Frinos." },
		{ Cue = "/VO/Melinoe_5415", Text = "Let's see it, Frinos!" },
	},
}
GlobalVoiceLines.FamiliarRavenSwitchCostumeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.5,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5429", Text = "Shapeshift, Raki." },
		{ Cue = "/VO/Melinoe_5416", Text = "Raki, shapeshift!" },
	},
}
GlobalVoiceLines.FamiliarCatSwitchCostumeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.5,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5430", Text = "Shapeshift, Toula." },
		{ Cue = "/VO/Melinoe_5417", Text = "Toula, transform!" },
	},
}
GlobalVoiceLines.FamiliarHoundSwitchCostumeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.5,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5431", Text = "Shapeshift, Hecuba." },
		{ Cue = "/VO/Melinoe_5418", Text = "Switch it up, Hecuba!" },
	},
}
GlobalVoiceLines.FamiliarPolecatSwitchCostumeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.5,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5432", Text = "Shapeshift, Gale." },
		{ Cue = "/VO/Melinoe_5419", Text = "Gale, makeover time!" },
	},
}
GlobalVoiceLines.FamiliarMiscSwitchCostumeVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5420", Text = "Shapeshift." },
		{ Cue = "/VO/Melinoe_5421", Text = "Shapeshift!" },
		{ Cue = "/VO/Melinoe_5422", Text = "Now change." },
		{ Cue = "/VO/Melinoe_5423", Text = "Change." },
		{ Cue = "/VO/Melinoe_5424", Text = "Switch it up." },
	},
}
GlobalVoiceLines.FamiliarSwitchToDefaultCostumeVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeSwitchedFamiliarCostumeSpeech", Time = 18 },
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_5425", Text = "Back to normal." },
		{ Cue = "/VO/Melinoe_5426", Text = "Return." },
		{ Cue = "/VO/Melinoe_5427", Text = "Regain your outward form." },
	},
}
GlobalVoiceLines.FamiliarCostumeReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		Queue = "Always",
		SkipCooldownCheckIfNonePlayed = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5479", Text = "You look {#Emph}great!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_5480", Text = "{#Emph}Ooh{#Prev}, impressive." },
		{ Cue = "/VO/Melinoe_5481", Text = "I like it...!" },
		{ Cue = "/VO/Melinoe_5482", Text = "I love it." },
		{ Cue = "/VO/Melinoe_5483", Text = "You look fabulous." },
		{ Cue = "/VO/Melinoe_5484", Text = "It suits you!" },
		{ Cue = "/VO/Melinoe_5485", Text = "Well look at you." },
		{ Cue = "/VO/Melinoe_5486", Text = "...Perfect.", PreLineWait = 0.65 },
		{ Cue = "/VO/Melinoe_5487", Text = "...Yes.", PreLineWait = 0.65 },
		{ Cue = "/VO/Melinoe_5488", Text = "It's definitely you." },
	},
}

GlobalVoiceLines.BadgeUpgradedVoiceLines =
{
	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 0.65 },
	-- Tier 1
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 1,
			},
		},
		{ Cue = "/VO/Melinoe_5318", Text = "{#Emph}We are as Wraiths in the night. Let it thus be known!" },
	},
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 10,
			},
		},
		{ Cue = "/VO/Melinoe_5331", Text = "{#Emph}Hereby our rank is Wraith I. We shall be feared." },
	},
	-- Tier 2
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 11,
			},
		},
		{ Cue = "/VO/Melinoe_5319", Text = "{#Emph}We are as Specters drifting in the dark. Let it thus be known!" },
	},
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 20,
			},
		},
		{ Cue = "/VO/Melinoe_5332", Text = "{#Emph}Hereby our rank is Specter I. We are darkness." },
	},
	-- Tier 3
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 21,
			},
		},
		{ Cue = "/VO/Melinoe_5320", Text = "{#Emph}We are as Revenants of darkest shadow. Let it thus be known!" },
	},
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 30,
			},
		},
		{ Cue = "/VO/Melinoe_5333", Text = "{#Emph}Hereby our rank is Revenant I. We haunt our foes." },
	},
	-- Tier 4
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 31,
			},
		},
		{ Cue = "/VO/Melinoe_5321", Text = "{#Emph}We are as Nightmares that linger forever. Let it thus be known!" },
	},
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 40,
			},
		},
		{ Cue = "/VO/Melinoe_5334", Text = "{#Emph}Hereby our rank is Nightmare I. There's no escaping us." },
	},
	-- Tier 5
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 41,
			},
		},
		{ Cue = "/VO/Melinoe_5322", Text = "{#Emph}We are all Unseen, in status and in name. Let it thus be known!" },
	},
	-- Final Tier
	{
		BreakIfPlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "BadgeRank" },
				Comparison = "==",
				Value = 50,
			},
		},
		{ Cue = "/VO/Melinoe_5335", Text = "{#Emph}Hereby our rank is Unseen I. The eternal order." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,

		{ Cue = "/VO/Melinoe_5323", Text = "{#Emph}Hereby our rank is IX.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 2,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 12,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 22,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 32,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 42,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5324", Text = "{#Emph}Hereby our rank is VIII.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 3,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 13,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 23,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 33,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 43,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5325", Text = "{#Emph}Hereby our rank is VII.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 4,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 14,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 24,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 34,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 44,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5326", Text = "{#Emph}Hereby our rank is VI.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 5,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 15,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 25,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 35,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 45,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5327", Text = "{#Emph}Hereby our rank is V.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 6,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 16,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 26,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 36,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 46,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5328", Text = "{#Emph}Hereby our rank is IV.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 7,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 17,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 27,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 37,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 47,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5329", Text = "{#Emph}Hereby our rank is III.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 8,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 18,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 28,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 38,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 48,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5330", Text = "{#Emph}Hereby our rank is II.",
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 9,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 19,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 29,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 39,
						},
					},
					{
						{
							Path = { "GameState", "BadgeRank" },
							Comparison = "==",
							Value = 49,
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5302", Text = "{#Emph}We are the Unseen, and we shall be feared." },
		{ Cue = "/VO/Melinoe_5303", Text = "{#Emph}Let fear of the Unseen spread farther still!" },
		{ Cue = "/VO/Melinoe_5304", Text = "{#Emph}The tales of the Unseen shall grow." },
		{ Cue = "/VO/Melinoe_5305", Text = "{#Emph}Our exploits soon shall turn to terrifying tales." },
	},
}

GlobalVoiceLines.StartNewPackagedBountyVoiceLines =
{
	-- starting packaged bounties
	{
		-- retrying previous clears
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.21,
			SuccessiveChanceToPlay = 0.2,
			NoTarget = true,
			ThreadName = "RoomThread",
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "ActiveBountyClears" },
					Comparison = ">=",
					Value = 1,
				},
			},

			{ Cue = "/VO/Chaos_0115", Text = "Let us explore this facet of reality again." },
			{ Cue = "/VO/Chaos_0116", Text = "Here there is even more to be observed." },
			{ Cue = "/VO/Chaos_0117", Text = "Repetition is the key to certainty." },
			{ Cue = "/VO/Chaos_0118", Text = "Infinite possibility, even in a single facet.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0119", Text = "A familiar choice, but perhaps a different result." },
			{ Cue = "/VO/Chaos_0120", Text = "You choose a path familiar to you." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.75,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "ActiveBountyClears" },
					Comparison = ">=",
					Value = 1,
				},
			},

			{ Cue = "/VO/Melinoe_3491", Text = "Try this again." },
			{ Cue = "/VO/Melinoe_3492", Text = "One more time." },
			{ Cue = "/VO/Melinoe_3494", Text = "Again." },
			{ Cue = "/VO/Melinoe_3495", Text = "...Again." },
			{ Cue = "/VO/Melinoe_3498", Text = "Again...!" },
			{ Cue = "/VO/Melinoe_3848", Text = "Give this another go..." },
			{ Cue = "/VO/Melinoe_3849", Text = "I can do better." },
			{ Cue = "/VO/Melinoe_3850", Text = "Once more then." },
			{ Cue = "/VO/Melinoe_3851", Text = "Reattempting Trial.", PlayFirst = true },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.75,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "ActiveBountyAttempts" },
					Comparison = ">=",
					ValuePath = { "ActiveBountyClears" },
					ValuePathAddition = 2,
				},
			},

			{ Cue = "/VO/Melinoe_3491", Text = "Try this again." },
			{ Cue = "/VO/Melinoe_3492", Text = "One more time." },
			{ Cue = "/VO/Melinoe_3493", Text = "I can do this." },
			{ Cue = "/VO/Melinoe_3494", Text = "Again." },
			{ Cue = "/VO/Melinoe_3495", Text = "...Again." },
			{ Cue = "/VO/Melinoe_3498", Text = "Again...!" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlayAll = 0.75,

			{ Cue = "/VO/Melinoe_1421", Text = "I can overcome this." },
			{ Cue = "/VO/Melinoe_3058", Text = "Commencing Chaos Trial." },
			{ Cue = "/VO/Melinoe_1423", Text = "Into the abyss." },
			{ Cue = "/VO/Melinoe_3059", Text = "Next Trial, coming up..." },
			{ Cue = "/VO/Melinoe_1425", Text = "This loadout's worth a shot..." },
			{ Cue = "/VO/Melinoe_1426", Text = "For the realm." },
			{ Cue = "/VO/Melinoe_2628", Text = "I see what needs to be done.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2629", Text = "This vision I accept." },
			{ Cue = "/VO/Melinoe_0047", Text = "I'll do my best." },
			{ Cue = "/VO/Melinoe_1669", Text = "I can do this." },
			{ Cue = "/VO/Melinoe_5499", Text = "Chaos take me..." },
			{ Cue = "/VO/Melinoe_5500", Text = "Very well, then." },
			{ Cue = "/VO/Melinoe_5501", Text = "I accept this Trial." },
			{ Cue = "/VO/Melinoe_5502", Text = "Trial set." },
		},
	},
	{ GlobalVoiceLines = "StartNewRunVoiceLines" },
}

GlobalVoiceLines.CombatBeginsVoiceLines =
{
	GameStateRequirements =
	{
		{
			PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" }
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.85,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "GeneratedNSubRoom", "GeneratedNSubRoom_Bigger", "GeneratedQ" },
			},
		},
		Cooldowns =
		{
			{ Name = "CombatBeginsLinesPlayedRecently", Time = 500 },
		},

		{ Cue = "/VO/MelinoeField_0535", Text = "Wha...?", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0536", Text = "What?!" },
		{ Cue = "/VO/MelinoeField_0537", Text = "Oh...!" },
		{ Cue = "/VO/MelinoeField_0538", Text = "Ah...!" },
		{ Cue = "/VO/MelinoeField_0539", Text = "Blast!" },
		{ Cue = "/VO/MelinoeField_0540", Text = "Hi!" },
		{ Cue = "/VO/MelinoeField_0541", Text = "You!" },
		{ Cue = "/VO/MelinoeField_0542", Text = "Oh good...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.2,
		PreLineWait = 2.0,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "FIntroFight", "GeneratedAnomalyB", "BossHecate01", "BossHecate02", "BossScylla01", "BossScylla02", "BossPolyphemus01", "BossPolyphemus02", "BossEris01", "BossEris02", "BossPrometheus01", "BossPrometheus02", "BossTyphonTail01", "BossTyphonHead01", "BossTyphonHead02", "MiniBossTreant", "MiniBossFogEmitter", "MiniBossWaterUnit", "MiniBossCrawler", "FishmanIntro", "FishSwarmerIntro", "WaterUnitIntro", "RadiatorIntro", "ScreamerIntro", "SiegeVineIntro", "TurtleIntro", "ZombieAssassinIntro", "ZombieHeavyRangedIntro", "ZombieSpawnerIntro", "MudmanIntro", "OlympusIntro", },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Story01", "G_Story01", "I_Story01", "I_Boss01", "N_Opening01", "N_Story01", "O_Story01", "P_Intro", "P_Story01", "N_Hub" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "Q" },
			},
			NamedRequirements = { "PastTartarusIntroFight" },
		},
		Cooldowns =
		{
			{ Name = "CombatBeginsLinesPlayedRecently", Time = 500 },
		},

		{ Cue = "/VO/Melinoe_0261", Text = "Begone...!" },
		{ Cue = "/VO/Melinoe_0263", Text = "For my father!" },
		{ Cue = "/VO/Melinoe_0267", Text = "You'll regret this!" },
		{ Cue = "/VO/Melinoe_0271", Text = "Come on!" },
		{ Cue = "/VO/Melinoe_0273", Text = "Face me!" },
		{ Cue = "/VO/Melinoe_0275", Text = "Come!" },
		{ Cue = "/VO/MelinoeField_4822", Text = "Come on then." },
		{ Cue = "/VO/MelinoeField_4824", Text = "This'll be quick." },
		{ Cue = "/VO/MelinoeField_4826", Text = "You're in my way." },
		{ Cue = "/VO/MelinoeField_4828", Text = "I have you." },
		{ Cue = "/VO/Melinoe_1776", Text = "Let's begin." },
		{ Cue = "/VO/Melinoe_1778", Text = "You dare?" },
		{ Cue = "/VO/Melinoe_1784", Text = "Come." },
		{ Cue = "/VO/MelinoeField_4820", Text = "Come on." },
		{ Cue = "/VO/MelinoeField_4830", Text = "Remnant forces...",
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "I", "N", "O", "P" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4832", Text = "You hungry, Zorephet...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4834", Text = "Face Zorephet!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4836", Text = "Flames take you.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4838", Text = "Burn, Ygnium...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4840", Text = "Why look, Revaal.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4842", Text = "Face the Argent Skull.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4844", Text = "Ready, Xinth?",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4846", Text = "I bear the Black Coat...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4587", Text = "More steps to be retraced...!",
			PlayFirst = true,
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", "O", "P" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1774", Text = "This is the Titan's fault.",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "Q" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4821", Text = "Who first?" },
		{ Cue = "/VO/MelinoeField_4823", Text = "Face me." },
		{ Cue = "/VO/Melinoe_0257", Text = "Traitors!",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", "N" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0259", Text = "You wretches...",
			GameStateRequirements = 
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Melinoe_0265", Text = "I'll slay you all!",
			GameStateRequirements = 
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 3,
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_0269", Text = "You again.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 4,
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1780", Text = "You again.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/Melinoe_1259", Text = "Lost Souls, I'll lead you to your graves.",
			GameStateRequirements = 
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 8,
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1772" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1772", Text = "I'll send you to your graves.",
			GameStateRequirements = 
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "G" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1259" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1782", Text = "They never learn.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 6,
				},
			},
		},
		{ Cue = "/VO/Melinoe_1786", Text = "You test my patience.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 15,
				},
			},
		},
		{ Cue = "/VO/Melinoe_1788", Text = "Descura take you all.",
			GameStateRequirements =
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1794" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAny = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1790", Text = "I'll crush you.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1794" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAny = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1792", Text = "A feast for Lim and Oros.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1794" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1794", Text = "I'll cut you to shreds.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1794" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
				},
			},
		},

	},
}

GlobalVoiceLines.KillingEnemyVoiceLines =
{
	-- one foe remaining
	{
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "WaveCount" },
				Comparison = ">=",
				Value = 2,
			},
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "FinalWave" },
			},
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsComplete" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "F" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone =
				{
					"ArtemisCombatIntro",
					"ArtemisCombatF",
					"ArtemisCombatF2",
					"ArtemisCombatG",
					"ArtemisCombatG2",
					"ArtemisCombatN",
					"ArtemisCombatN2",
					"HeraclesCombatIntro",
					"HeraclesCombatN",
					"HeraclesCombatN2",
					"HeraclesCombatO",
					"HeraclesCombatO2",
					"HeraclesCombatP",
					"HeraclesCombatP2",
					"NemesisCombatF",
					"NemesisCombatG",
					"NemesisCombatH",
					"NemesisCombatI",
					"IcarusCombatIntro",
					"IcarusCombatO",
					"IcarusCombatO2",
					"IcarusCombatP",
					"IcarusCombatP2",
					"BossHecate01",
					"BossHecate02",
					"BossScylla01",
					"BossScylla02",
					"BossInfestedCerberus01",
					"BossInfestedCerberus02",
					"BossChronos01",
					"BossChronos02",
					"BossPolyphemus01",
					"BossPolyphemus02",
					"BossEris01",
					"BossEris02",
					"BossPrometheus01",
					"BossPrometheus02",
					"BossTyphonTail01",
					"BossTyphonHead01",
					"BossTyphonHead02",
					"DevotionTestF",
					"DevotionTestG",
					"DevotionTestH",
					"DevotionTestI",
					"DevotionTestN",
					"DevotionTestO",
					"DevotionTestP",
				},
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Athena_01", }, Alive = false },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.05, -- +0.3 KillVoiceLinesQueue
		RecheckRequirementsPostWait = true,
		Cooldowns =
		{
			{ Name = "MelinoeCombatQuipPlayed", Time = 180 },
			{ Name = "MelinoeFinalEnemyQuipPlayed", Time = 360 },
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_0594", Text = "Last one..." },
		{ Cue = "/VO/MelinoeField_0595", Text = "Now for the last one..." },
		{ Cue = "/VO/MelinoeField_0596", Text = "One left..." },
		{ Cue = "/VO/MelinoeField_0597", Text = "One remains..." },
		{ Cue = "/VO/MelinoeField_0598", Text = "Almost finished..." },
		{ Cue = "/VO/MelinoeField_0599", Text = "And now for you..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2", "ArtemisCombatN", "ArtemisCombatN2" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			-- @ hacky fix to these lines sometimes playing before her intro lines
			{
				Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
				HasAny = { "/VO/Artemis_0036", "/VO/Artemis_0037", "/VO/Artemis_0038", "/VO/Artemis_0039", "/VO/Artemis_0040", "/VO/Artemis_0041", "/VO/Artemis_0042", "/VO/Artemis_0043", "/VO/Artemis_0044", "/VO/Artemis_0045", "/VO/Artemis_0046", "/VO/Artemis_0047", "/VO/Artemis_0048", "/VO/Artemis_0049", "/VO/Artemis_0409" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35, -- +0.3 KillVoiceLinesQueue
		SuccessiveChanceToPlay = 0.35,
		Cooldowns =
		{
			{ Name = "ArtemisAnyQuipSpeech", Time = 12 },
		},
		TriggerCooldowns =
		{
			"MelinoeAnyQuipSpeech",
		},
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },

		{ Cue = "/VO/Artemis_0064", Text = "Good shot." },
		{ Cue = "/VO/Artemis_0065", Text = "Nice shot." },
		{ Cue = "/VO/Artemis_0066", Text = "Nice!" },
		{ Cue = "/VO/Artemis_0067", Text = "{#Emph}Oof!" },
		{ Cue = "/VO/Artemis_0068", Text = "Well done." },
		{ Cue = "/VO/Artemis_0069", Text = "Look at you." },
		{ Cue = "/VO/Artemis_0070", Text = "Clean kill." },
		{ Cue = "/VO/Artemis_0071", Text = "You got 'em." },
		{ Cue = "/VO/Artemis_0350", Text = "Good." },
		{ Cue = "/VO/Artemis_0351", Text = "Perfect." },
		{ Cue = "/VO/Artemis_0352", Text = "Clean." },
		{ Cue = "/VO/Artemis_0353", Text = "Keep going!" },
		{ Cue = "/VO/Artemis_0354", Text = "Just like that." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.05, -- +0.3 KillVoiceLinesQueue
		SuccessiveChanceToPlay = 0.65,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01" },
			},
		},
		ObjectType = "NPC_Arachne_01",
		Cooldowns =
		{
			{ Name = "ArachneSpokeRecently", Time = 10 },
		},
		TriggerCooldowns =
		{
			"MelinoeAnyQuipSpeech",
		},

		{ Cue = "/VO/Arachne_0238", Text = "You did it!", PlayFirst = true },
		{ Cue = "/VO/Arachne_0239", Text = "Got them!", PlayFirst = true },
		{ Cue = "/VO/Arachne_0240", Text = "Wow..." },
		{ Cue = "/VO/Arachne_0241", Text = "Thank you!" },
		{ Cue = "/VO/Arachne_0242", Text = "Much obliged." },
		{ Cue = "/VO/Arachne_0243", Text = "{#Emph}Whew!" },
		{ Cue = "/VO/Arachne_0244", Text = "Amazing.", PlayFirst = true },
		{ Cue = "/VO/Arachne_0245", Text = "Showed them!", PlayFirst = true },
		{ Cue = "/VO/Arachne_0246", Text = "Hooray!", PlayFirst = true },
		{ Cue = "/VO/Arachne_0247", Text = "You're so... {#Emph}ugh...!" },
		{ Cue = "/VO/Arachne_0248", Text = "Every time." },
		{ Cue = "/VO/Arachne_0249", Text = "So exciting...!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35, -- +0.3 KillVoiceLinesQueue
		SuccessiveChanceToPlay = 0.1,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "H" },
			},
		},
		Cooldowns =
		{
			{ Name = "NemesisAnyQuipSpeech", Time = 12 },
		},
		TriggerCooldowns =
		{
			"MelinoeAnyQuipSpeech",
		},

		{ Cue = "/VO/NemesisField_0284", Text = "{#Emph}Hrm." },
		{ Cue = "/VO/NemesisField_0285", Text = "{#Emph}Grr." },
		{ Cue = "/VO/NemesisField_0286", Text = "{#Emph}Augh." },
		{ Cue = "/VO/NemesisField_0287", Text = "{#Emph}Rngh." },
		{ Cue = "/VO/NemesisField_0288", Text = "You..." },
		{ Cue = "/VO/NemesisField_0289", Text = "{#Emph}Khh..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35, -- +0.3 KillVoiceLinesQueue
		SuccessiveChanceToPlay = 0.1,
		ObjectType = "NPC_Heracles_01",
		Cooldowns =
		{
			{ Name = "HeraclesAnyQuipSpeech", Time = 12 },
		},
		TriggerCooldowns =
		{
			"MelinoeAnyQuipSpeech",
		},

		{ Cue = "/VO/Heracles_0071", Text = "Good work." },
		{ Cue = "/VO/Heracles_0072", Text = "Not bad.", PlayFirst = true },
		{ Cue = "/VO/Heracles_0073", Text = "Saved me the trouble." },
		{ Cue = "/VO/Heracles_0074", Text = "Easy, sister." },
		{ Cue = "/VO/Heracles_0475", Text = "Yours." },
		{ Cue = "/VO/Heracles_0476", Text = "Your kill." },
		{ Cue = "/VO/Heracles_0477", Text = "Getting there." },
		{ Cue = "/VO/Heracles_0478", Text = "Not bad!" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
			},
			{
				PathTrue = { "SessionMapState", "IcarusPlayedEncounterStartLines" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35, -- +0.3 KillVoiceLinesQueue
		SuccessiveChanceToPlay = 0.35,
		ObjectType = "NPC_Icarus_01",
		Cooldowns =
		{
			{ Name = "IcarusAnyQuipSpeech", Time = 9 },
		},
		TriggerCooldowns =
		{
			"MelinoeAnyQuipSpeech",
		},

		{ Cue = "/VO/Icarus_0131", Text = "You got 'em!" },
		{ Cue = "/VO/Icarus_0132", Text = "{#Emph}Wha...!" },
		{ Cue = "/VO/Icarus_0133", Text = "{#Emph}Hah...!" },
		{ Cue = "/VO/Icarus_0134", Text = "Good night!" },
		{ Cue = "/VO/Icarus_0135", Text = "Wow...!" },
		-- { Cue = "/VO/Icarus_0136", Text = "Whew...!" },
		{ Cue = "/VO/Icarus_0137", Text = "Amazing..." },
		{ Cue = "/VO/Icarus_0138", Text = "Getting there...!" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Opening01", "N_Boss01", "N_Boss02", "N_MiniBoss01", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = GameData.CombatUniqueEncounters,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = GameData.CombatNPCEncounters,
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Athena_01", }, Alive = false },
			},
			ChanceToPlay = 0.045,
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.05, -- +0.3 KillVoiceLinesQueue
		Cooldowns =
		{
			{ Name = "MelinoeCombatQuipPlayed", Time = 400 },
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0303", Text = "Traitor!",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "I", "N" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0304", Text = "Suffer!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", "O", "P", "Q" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0305", Text = "Out!" },
		{ Cue = "/VO/Melinoe_0306", Text = "There." },
		{ Cue = "/VO/Melinoe_0307", Text = "There!" },
		{ Cue = "/VO/Melinoe_0308", Text = "Next." },
		{ Cue = "/VO/Melinoe_0309", Text = "Next!" },
		{ Cue = "/VO/Melinoe_0310", Text = "More?" },
		{ Cue = "/VO/Melinoe_0311", Text = "Well?" },
		{ Cue = "/VO/Melinoe_0312", Text = "Not a chance." },
		{ Cue = "/VO/Melinoe_0313", Text = "Out of my sight." },
		{ Cue = "/VO/Melinoe_0314", Text = "{#Emph}Tsch!" },
		{ Cue = "/VO/Melinoe_0315", Text = "{#Emph}Hah!" },
		{ Cue = "/VO/Melinoe_0316", Text = "No." },
		{ Cue = "/VO/Melinoe_0317", Text = "Begone!" },
		{ Cue = "/VO/Melinoe_0318", Text = "Foolish." },
		{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
		{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh!" },
		{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
		{ Cue = "/VO/MelinoeField_0600", Text = "Fall." },
		{ Cue = "/VO/MelinoeField_0601", Text = "Denied." },
		{ Cue = "/VO/MelinoeField_0602", Text = "Laughable." },
		{ Cue = "/VO/MelinoeField_0603", Text = "Pathetic." },
		{ Cue = "/VO/MelinoeField_0604", Text = "Out." },
		{ Cue = "/VO/MelinoeField_0605", Text = "Predictable." },
		{ Cue = "/VO/MelinoeField_0606", Text = "Back." },
		{ Cue = "/VO/MelinoeField_0607", Text = "Perish." },
		{ Cue = "/VO/MelinoeField_0608", Text = "Back to dust." },
		{ Cue = "/VO/MelinoeField_0609", Text = "{#Emph}Heh." },
	},
}
GlobalVoiceLines.RevengeKillingEnemyVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.15,-- +0.3 KillVoiceLinesQueue
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1796", Text = "For what you did to me.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_1797", Text = "Vengeance." },
	{ Cue = "/VO/MelinoeField_0698", Text = "Remember me?", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_0699", Text = "That was for before." },
	{ Cue = "/VO/MelinoeField_0700", Text = "Retribution." },
	{ Cue = "/VO/MelinoeField_0701", Text = "For last time." },
	{ Cue = "/VO/MelinoeField_0702", Text = "Got you back." },
	{ Cue = "/VO/MelinoeField_0703", Text = "That's for last time." },
}

GlobalVoiceLines.SteamTrapKillVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Health" },
				Comparison = ">=",
				Value = 15,
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeTrapKillSpeech", Time = 80 },
		},
		TriggerCooldowns = { "MelinoeCombatQuipPlayed" },

		{ Cue = "/VO/MelinoeField_0570", Text = "Burn." },
		{ Cue = "/VO/MelinoeField_0571", Text = "Breathe it in." },
		{ Cue = "/VO/MelinoeField_0572", Text = "Vaporized...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0573", Text = "Too hot for you?" },
		{ Cue = "/VO/MelinoeField_0574", Text = "Drown in it." },
		{ Cue = "/VO/MelinoeField_0575", Text = "Cooked fish..." },
	},
}

GlobalVoiceLines.OddSheepSightedVoiceLines =
{
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.2,
		SuccessiveChanceToPlayAll = 0.1,
		GameStateRequirements = 
		{
			-- None
		},
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_2186", Text = "Those sheep...!" },
		{ Cue = "/VO/MelinoeField_2187", Text = "What's with those..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "Medea",
		GameStateRequirements =
		{
			--
		},
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 16 },
		},

		{ Cue = "/VO/Medea_0440", Text = "Livestock..." },
		{ Cue = "/VO/Medea_0441", Text = "The shepherd's flock...", PlayFirst = true },
		{ Cue = "/VO/Medea_0442", Text = "More livestock..." },
		{ Cue = "/VO/Medea_0443", Text = "Part of your flock, Cyclops...?" },
	},
}
GlobalVoiceLines.SatyrsSightedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	UsePlayerSource = true,
	GameStateRequirements = 
	{
		{
		},
	},
	Cooldowns =
	{
		{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
		{ Name = "SatyrVoiceLinesPlayedRecently", Time = 600 },
		{ Name = "OlympusEnemiesSightedVO", Time = 12 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
	SuccessiveChanceToPlay = 0.1,

	{ Cue = "/VO/MelinoeField_1635", Text = "Satyrs...!" },
	{ Cue = "/VO/MelinoeField_1636", Text = "Satyrs..." },
	{ Cue = "/VO/MelinoeField_1637", Text = "More Satyrs." },
	{ Cue = "/VO/MelinoeField_1638", Text = "Come, Satyrs...!" },
}
GlobalVoiceLines.ChronosLegionsSightedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	UsePlayerSource = true,
	GameStateRequirements = 
	{
		{
			FunctionName = "RequiredAlive",
			FunctionArgs = { Units = { "SentryBot", "SentryBot_Elite", "AutomatonBeamer", "AutomatonBeamer_Elite", "AutomatonEnforcer", "AutomatonEnforcer_Elite" }, Alive = false },
		},
	},
	Cooldowns =
	{
		{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
		{ Name = "ChronosLegionSightedLinesPlayedRecently", Time = 600 },
		{ Name = "OlympusEnemiesSightedVO", Time = 12 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
	SuccessiveChanceToPlay = 0.1,

	{ Cue = "/VO/MelinoeField_2865", Text = "The Titan's legions!" },
	{ Cue = "/VO/MelinoeField_2866", Text = "The Titan's followers..." },
	{ Cue = "/VO/MelinoeField_2867", Text = "Assault forces..." },
	{ Cue = "/VO/MelinoeField_2869", Text = "Legions of Chronos..." },
}
GlobalVoiceLines.AutomatonsSightedLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	UsePlayerSource = true,
	GameStateRequirements = 
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "OlympusIntro" },
		},
	},
	Cooldowns =
	{
		{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
		{ Name = "AutomatonVoiceLinesPlayedRecently", Time = 600 },
		{ Name = "OlympusEnemiesSightedVO", Time = 12 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
	SuccessiveChanceToPlay = 0.1,

	{ Cue = "/VO/MelinoeField_2684", Text = "Automatons..." },
	{ Cue = "/VO/MelinoeField_2685", Text = "Automatons...!" },
	{ Cue = "/VO/MelinoeField_2686", Text = "More Automatons..." },
	{ Cue = "/VO/MelinoeField_2687", Text = "Mindless Automatons..." },
	{ Cue = "/VO/MelinoeField_2688", Text = "Automatons going to attack on sight...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_2689", Text = "Olympian defenses..." },
}

GlobalVoiceLines.SatyrGuestSmallTalkVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Story01" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeSatyrSmallTalkSpeech", Time = 40 },
		},

		{ Cue = "/VO/MelinoeField_4495", Text = "Oh, {#Emph}erm{#Prev}, hello.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_4496", Text = "I, {#Emph}erm{#Prev}, like your horns?" },
		{ Cue = "/VO/MelinoeField_4497", Text = "Hello, I'm... going." },
		{ Cue = "/VO/MelinoeField_4498", Text = "Fine feast, right?" },
		{ Cue = "/VO/MelinoeField_4499", Text = "Hi there..." },
		{ Cue = "/VO/MelinoeField_4500", Text = "So, {#Emph}erm... {#Prev}yes." },
	},
}
GlobalVoiceLines.SatyrGuestOnHitVoiceLines =
{
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Story01" },
			},
			ChanceToPlay = 0.33,
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeSatyrAttackSpeech", Time = 40 },
		},

		{ Cue = "/VO/MelinoeField_4501", Text = "Only a jest!" },
		{ Cue = "/VO/MelinoeField_4502", Text = "Just mingling!" },
		{ Cue = "/VO/MelinoeField_4503", Text = "Great feast, isn't it?" },
		{ Cue = "/VO/MelinoeField_4504", Text = "Just checking!", PlayFirst = true },
	},
	{ GlobalVoiceLines = "DionysusGuestHitReactionVoiceLines" },
}

GlobalVoiceLines.LeavingArenaVoiceLines =
{
	{
		PreLineWait = 0.5,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.5,
		SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "C_Boss01" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeRoomExitVoiceLines", Time = 25 },
		},

		{ Cue = "/VO/MelinoeField_4244", Text = "Enjoy the rest of your evening, everyone!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_4319", Text = "Farewell, everyone." },
		{ Cue = "/VO/MelinoeField_4993", Text = "Was that enough of a good show?" },
		{ Cue = "/VO/MelinoeField_4994", Text = "No one crosses the Unseen!" },
		{ Cue = "/VO/MelinoeField_4995", Text = "It's impolite to stare you know!" },
		{ Cue = "/VO/MelinoeField_4996", Text = "Remember to comply with all the stated rules!" },
		{ Cue = "/VO/MelinoeField_4997", Text = "Glory to Elysium!" },
		{ Cue = "/VO/MelinoeField_4998", Text = "Had enough glory for one night?" },
	},
}
GlobalVoiceLines.ReturnedFromElysiumVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	RandomRemaining = true,
	PreLineWait = 0.7,
	UsePlayerSource = true,
	SuccessiveChanceToPlayAll = 0.5,
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "RoomsEntered", "C_Boss01" },
		},
	},

	{ Cue = "/VO/MelinoeField_4290", Text = "...I'm back...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_4291", Text = "...And I'm back." },
	{ Cue = "/VO/MelinoeField_4293", Text = "...Where were we...?" },
	{ Cue = "/VO/MelinoeField_4292", Text = "{#Emph}...Ow.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = "<=", Value = 0.66, },
			},
		},
	},
}

GlobalVoiceLines.MonstersSightedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	UsePlayerSource = true,
	-- SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements = 
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" }
		},
	},
	Cooldowns =
	{
		{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
		{ Name = "MonsterVoiceLinesPlayedRecently", Time = 600 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
	SuccessiveChanceToPlay = 0.1,

	{ Cue = "/VO/MelinoeField_2951", Text = "What are these... {#Emph}things?", PlayFirst = true, PlayOnce = true },
	-- { Cue = "/VO/Melinoe_1954", Text = "What...?" },
	{ Cue = "/VO/MelinoeField_2958", Text = "Monsters..." },
	{ Cue = "/VO/MelinoeField_2959", Text = "Monsters...!" },
	{ Cue = "/VO/MelinoeField_2960", Text = "More monsters..." },
	{ Cue = "/VO/MelinoeField_2961", Text = "Come, you monsters..." },
}

GlobalVoiceLines.CombatResolvedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelCombatResolvedSpeech", Time = 300 },
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	-- Selene reactions
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
				IsAny = { "SpellDrop" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.75, },
			},
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 1.0,
		Queue = "Always",
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },

		{ Cue = "/VO/Selene_0139", Text = "Gracefully fought." },
		{ Cue = "/VO/Selene_0140", Text = "Your foes lie vanquished." },
		{ Cue = "/VO/Selene_0141", Text = "You fought beautifully.", PlayFirst = true },
		{ Cue = "/VO/Selene_0142", Text = "That was spectacular." },
		{ Cue = "/VO/Selene_0143", Text = "You were remarkable." },
		{ Cue = "/VO/Selene_0144", Text = "Impressive as always." },
		{ Cue = "/VO/Selene_0137", Text = "Excellent." },
		{ Cue = "/VO/Selene_0247", Text = "Excellently done." },
		{ Cue = "/VO/Selene_0248", Text = "To greater victories." },
		{ Cue = "/VO/Selene_0249", Text = "This is our charge." },
		{ Cue = "/VO/Selene_0250", Text = "A decisive outcome." },
		{ Cue = "/VO/Selene_0251", Text = "They stood no chance." },
		{ Cue = "/VO/Selene_0252", Text = "Onward to your goal." },
		{ Cue = "/VO/Selene_0253", Text = "I witnessed everything." },
		{ Cue = "/VO/Selene_0254", Text = "Surpassing strength." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "FIntroFight", "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
		},
		{ Cue = "/VO/Melinoe_0258", Text = "Traitors...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0257" },
				},
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "N", "I" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0260", Text = "Return to dust.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0259" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0262", Text = "That's settled.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0261" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0264", Text = "Vengeance.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0263" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0266", Text = "What did I say?",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0265" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0268", Text = "You see?",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0267" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0270", Text = "Vanquished.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0269" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0272", Text = "Done here.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0271" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0274", Text = "Weak.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0273" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1773", Text = "Rest for now in peace.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1772" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1775", Text = "Death to Chronos...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1774" },
				},
				OrRequirements =
				{
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_1777", Text = "Satisfactory.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1776" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1779", Text = "Out with you all.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1778" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1781", Text = "Begone from here.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1780" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1783", Text = "Let that be a lesson.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1782" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1785", Text = "Is that all?",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1784" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1787", Text = "Enough of this.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1786" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1789", Text = "Thank you, Descura.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1788" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1791", Text = "This is quite a staff.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1790" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1793", Text = "Well done my Sister Blades.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1792" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1795", Text = "All to pieces.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1794" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1432", Text = "No traitor to the House shall go unpunished.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
					HasAny = { "/VO/Melinoe_0257", "/VO/Melinoe_0263" }
				},
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "I" },
				},
			}
		},
		{ Cue = "/VO/MelinoeField_4825", Text = "...It's over.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4824" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4827", Text = "Clear path.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4826" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4829", Text = "All mine.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4828" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4831", Text = "All gone.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4830" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4833", Text = "Merely a snack.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4832" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4835", Text = "That was the Moonstone Axe.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4834" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4837", Text = "Ashes.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4836" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4839", Text = "Incinerated.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4838" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4841", Text = "Scorched Earth.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4840" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4843", Text = "Destroyed.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4842" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4845", Text = "Threats eliminated.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4844" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4847", Text = "No escape.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_4846" },
				},
			},
		},
	},
	-- misc reactions
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = GameData.CombatNPCEncounters,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestN", "DevotionTestO", "DevotionTestP", "Empty", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Athena_01", }, Alive = false },
			},
		},
		ThreadName = "RoomThread",

		{ Cue = "/VO/Melinoe_0007_V3", Text = "As expected." },
		{ Cue = "/VO/Melinoe_0136", Text = "Acceptable." },
		{ Cue = "/VO/Melinoe_0137", Text = "Onward." },
		{ Cue = "/VO/Melinoe_0138", Text = "All right." },
		{ Cue = "/VO/Melinoe_0139", Text = "That's that." },
		{ Cue = "/VO/Melinoe_0140", Text = "All done." },
		{ Cue = "/VO/Melinoe_0141", Text = "Clear." },
		{ Cue = "/VO/Melinoe_0276", Text = "I think not." },
		{ Cue = "/VO/Melinoe_0277", Text = "Enough of this." },
		{ Cue = "/VO/Melinoe_0278", Text = "You shouldn't have crossed me." },
		{ Cue = "/VO/Melinoe_0280", Text = "Foes eliminated." },
		{ Cue = "/VO/Melinoe_0281", Text = "Area clear." },
		{ Cue = "/VO/Melinoe_0282", Text = "{#Emph}Whew." },
		{ Cue = "/VO/Melinoe_0689", Text = "Enough." },
		{ Cue = "/VO/Melinoe_2993", Text = "All right." },
		{ Cue = "/VO/MelinoeField_0554", Text = "...OK." },
		{ Cue = "/VO/MelinoeField_0555", Text = "...There." },
		{ Cue = "/VO/MelinoeField_0556", Text = "...Silence." },
		{ Cue = "/VO/MelinoeField_0557", Text = "...Good." },
		{ Cue = "/VO/MelinoeField_0558", Text = "...All clear." },
		{ Cue = "/VO/MelinoeField_0559", Text = "It's done." },
		{ Cue = "/VO/MelinoeField_0560", Text = "All quiet." },
		{ Cue = "/VO/MelinoeField_0561", Text = "{#Emph}Huh!" },
		{ Cue = "/VO/MelinoeField_0562", Text = "{#Emph}Whew..." },
		{ Cue = "/VO/MelinoeField_0563", Text = "Straightforward." },
		{ Cue = "/VO/MelinoeField_2063", Text = "We did it, Frinos.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2064", Text = "Got them, Frinos.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_2065", Text = "We showed them, Toula.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_2066", Text = "All right, Toula.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3070", Text = "You saved me there, Toula...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "LastStandsUsed", },
					HasAny = { "LastStandFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3071", Text = "I owe you one, Toula.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "LastStandsUsed", },
					HasAny = { "LastStandFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3066", Text = "We did it, Raki.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3067", Text = "Good work, Raki!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3068", Text = "Good girl, Hecuba.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "HoundFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3069", Text = "Well done there, Hecuba.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "HoundFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3072", Text = "Got them, Gale.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "PolecatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_3073", Text = "Good fight, Gale.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "PolecatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Melinoe_0279", Text = "Rest now, all of you.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "N" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0564", Text = "...I'm soaked.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0565", Text = "...What a stench.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G", "N" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0566", Text = "...Rest again for now.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "Anomaly", "N" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0567", Text = "All laid to rest.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "Anomaly", "N" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0568", Text = "Suffer no more.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "Anomaly", "N" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0569", Text = "Be again at peace.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "Anomaly", "N" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0166", Text = "This is my father's realm.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "I", "Anomaly" },
				}
			},
		},
		{ Cue = "/VO/Melinoe_1129", Text = "We got them, Homer.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
				},
				{
					Path = { "PrevRun", "SpeechRecord" },
					HasAny = { "/VO/Melinoe_0861", "/VO/Melinoe_0862", "/VO/Melinoe_0863", "/VO/Melinoe_1133" },
				}
			},
		},
	},
	-- Storyteller Reactions
	--[[
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		Queue = "Always",
		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_1129" },
			},
		},
		Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },

		{ Cue = "/VO/Storyteller_0060", Text = "{#Emph}Splendid was the Princess in her fight." },
		{ Cue = "/VO/Storyteller_0061", Text = "{#Emph}Fearless Melinoë continues undeterred." },
		{ Cue = "/VO/Storyteller_0062", Text = "{#Emph}Her foes, all vanquished to the last." },
		{ Cue = "/VO/Storyteller_0065", Text = "{#Emph}The Princess brings her many foes to heel." },
		{ Cue = "/VO/Storyteller_0071", Text = "{#Emph}Though Time cannot be stopped, neither can she." },
		{ Cue = "/VO/Storyteller_0073", Text = "{#Emph}A victory, yet Time our foe remains!" },
		{ Cue = "/VO/Storyteller_0074", Text = "{#Emph}Sing, O Muse." },
		{ Cue = "/VO/Storyteller_0076", Text = "{#Emph}Such wondrous spectacle." },
	},
	]]--
}

GlobalVoiceLines.CombatResolvedLowHealthVoiceLines =
{
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
				IsAny = { "SpellDrop" },
			},
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.9,
		Queue = "Always",
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },

		{ Cue = "/VO/Selene_0293", Text = "Are you all right...?" },
		{ Cue = "/VO/Selene_0294", Text = "That was difficult to watch." },
		{ Cue = "/VO/Selene_0295", Text = "A costly victory." },
		{ Cue = "/VO/Selene_0296", Text = "You persevered." },
		{ Cue = "/VO/Selene_0297", Text = "You did not give in." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		ChanceToPlay = 0.75,
		PreLineWait = 1.0,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatP", "HeraclesCombatP2", "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Athena_01" }, Alive = false },
			},
		},

		{ Cue = "/VO/Melinoe_0283", Text = "Lost too much blood..." },
		{ Cue = "/VO/Melinoe_0284", Text = "That was careless." },
		{ Cue = "/VO/Melinoe_0285", Text = "{#Emph}Ungh..." },
		{ Cue = "/VO/Melinoe_0286", Text = "Not good enough." },
		{ Cue = "/VO/Melinoe_0287", Text = "Spilled half my blood back there..." },
		{ Cue = "/VO/Melinoe_0288", Text = "Mistakes were made..." },
		{ Cue = "/VO/Melinoe_0290", Text = "Keep going..." },
		{ Cue = "/VO/Melinoe_0291", Text = "I can still fight." },
		{ Cue = "/VO/Melinoe_0292", Text = "{#Emph}Ungh{#Prev}, that hurt." },
		{ Cue = "/VO/Melinoe_0289", Text = "One more chamber...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G", "I", "P", "Q" },
				},
			},
		},
	},
}
GlobalVoiceLines.BarelySurvivedBossFightVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "Hero", "LastStands" },
			UseLength = true,
			Comparison = "<=",
			Value = 0,
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "I_Boss01" },
		},
		{
			FunctionName = "RequiredHealthFraction",
			FunctionArgs = { Comparison = "<=", Value = 0.25, },
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 7.1,
		SuccessiveChanceToPlayAll = 0.33,
		UsePlayerSource = true,

		{ Cue = "/VO/MelinoeField_0548", Text = "...Survived all that..." },
		{ Cue = "/VO/MelinoeField_0549", Text = "...A bit too close..." },
		{ Cue = "/VO/MelinoeField_0550", Text = "...Pulled through, somehow..." },
		{ Cue = "/VO/MelinoeField_0551", Text = "...Oh, thank the gods..." },
		{ Cue = "/VO/MelinoeField_0552", Text = "...A narrow victory, but still..." },
		{ Cue = "/VO/MelinoeField_0553", Text = "...Somehow managed that..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 7.1,
		SuccessiveChanceToPlay = 0.33,
		SuccessiveChanceToPlayAll = 0.33,

		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
		ThreadName = "RoomThread",

		{ Cue = "/VO/Storyteller_0443", Text = "{#Emph}She stands victorious, yet hardly stands at all." },
		{ Cue = "/VO/Storyteller_0444", Text = "{#Emph}A hard-earned victory..." },
		{ Cue = "/VO/Storyteller_0445", Text = "{#Emph}Defeat seemed certain for a moment there..." },
		{ Cue = "/VO/Storyteller_0446", Text = "{#Emph}A victory paid for with ample blood." },
		{ Cue = "/VO/Storyteller_0447", Text = "{#Emph}A narrow victory, but still." },
		{ Cue = "/VO/Storyteller_0448", Text = "{#Emph}Her adversary almost did her in." },
	},
}

GlobalVoiceLines.CocoonRewardFoundVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.35,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			{
				PathNotEmpty = { "MapState", "RoomRequiredObjects" },
			},
		},
		Cooldowns =
		{
			{ Name = "CocoonRewardSpeechPlayedRecently", Time = 240 },
		},

		{ Cue = "/VO/Melinoe_2158", Text = "Found it." },
		{ Cue = "/VO/Melinoe_2159", Text = "There you are." },
		{ Cue = "/VO/Melinoe_2160", Text = "{#Emph}Ah-hah." },
		{ Cue = "/VO/Melinoe_2161", Text = "There it is." },
	}
}

GlobalVoiceLines.OutOfManaVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelOutOfManaSpeech", Time = 30 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionState", "InFlashback" },
			},
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},

		{ Cue = "/VO/Melinoe_0386", Text = "I can't." },
		{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
		{ Cue = "/VO/Melinoe_2385", Text = "Can't right now." },
		{ Cue = "/VO/Melinoe_2386", Text = "Can't do it." },
		{ Cue = "/VO/Melinoe_2389", Text = "Need to recharge." },
		{ Cue = "/VO/Melinoe_3084", Text = "No use." },
		{ Cue = "/VO/Melinoe_3085", Text = "{#Emph}Ngh." },
		{ Cue = "/VO/Melinoe_3086", Text = "I wish." },
		{ Cue = "/VO/Melinoe_3087", Text = "Can't do it." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionState", "InFlashback" },
			},
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_Boss01", "Q_Boss02" },
			},
		},

		{ Cue = "/VO/Melinoe_0127", Text = "I can't!" },
		{ Cue = "/VO/Melinoe_0128", Text = "Not now!" },
		{ Cue = "/VO/Melinoe_0131", Text = "It's no use!" },
		{ Cue = "/VO/Melinoe_2391", Text = "Can't right now!" },
		{ Cue = "/VO/Melinoe_2392", Text = "Can't do it!" },
		{ Cue = "/VO/Melinoe_2395", Text = "Need to recharge!" },
		{ Cue = "/VO/Melinoe_2396", Text = "Damn it...!" },
		{ Cue = "/VO/Melinoe_3090", Text = "Can't go full blast...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellMeteorTrait", "SpellLaserTrait" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3091", Text = "Couldn't do it..." },
		{ Cue = "/VO/Melinoe_3092", Text = "{#Emph}Argh..." },
	},
}

-- item interaction lines
GlobalVoiceLines.UsedHealDropVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_1940", Text = "Thank you!", PlayFirst = true, PreLineWait = 0.4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SpellPotionTrait" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1941", Text = "You're the best!", PlayFirst = true, PreLineWait = 0.4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SpellPotionTrait" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1942", Text = "That hit the spot!", PlayFirst = true, PreLineWait = 0.4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0767", Text = "Thanks...", PlayFirst = true, PreLineWait = 0.4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SpellPotionTrait" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0842", Text = "Why thank you...!", PlayFirst = true, PreLineWait = 0.4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SpellPotionTrait" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0250", Text = "{#Emph}Whew!" },
		{ Cue = "/VO/Melinoe_0251", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_0252", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0253", Text = "{#Emph}Whew." },
		{ Cue = "/VO/Melinoe_1837", Text = "Better..." },
		{ Cue = "/VO/Melinoe_1838", Text = "{#Emph}Whew{#Prev}, good." },
		{ Cue = "/VO/Melinoe_1839", Text = "Vitality..." },
		{ Cue = "/VO/Melinoe_1840", Text = "Life..." },
	},
}
GlobalVoiceLines.UsedManaDropVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Story01" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_1768", Text = "Clarity..." },
		{ Cue = "/VO/Melinoe_1769", Text = "Greater focus.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1770", Text = "There..." },
		{ Cue = "/VO/Melinoe_1771", Text = "Felt that." },
		{ Cue = "/VO/MelinoeField_0676", Text = "Focus, Mel..." },
		{ Cue = "/VO/MelinoeField_0677", Text = "Steady now..." },
		{ Cue = "/VO/MelinoeField_0678", Text = "{#Emph}<Exhale>" },
		{ Cue = "/VO/MelinoeField_0679", Text = "This feeling..." },
		{ Cue = "/VO/MelinoeField_0680", Text = "I can do this..." },
		{ Cue = "/VO/MelinoeField_0681", Text = "All is possible..." },
	},
	{ GlobalVoiceLines = "MiscUpgradePickedVoiceLines" },
}
GlobalVoiceLines.UsedShieldDropVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Nemesis_01", }, Alive = false },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_0729", Text = "Shored up." },
		{ Cue = "/VO/MelinoeField_0730", Text = "Protected." },
		{ Cue = "/VO/MelinoeField_0731", Text = "Reinforced." },
		{ Cue = "/VO/MelinoeField_0732", Text = "Shielded up." },
	},
}
GlobalVoiceLines.UsedLastStandDropVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0250", Text = "{#Emph}Whew!" },
		{ Cue = "/VO/Melinoe_0251", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_0252", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0253", Text = "{#Emph}Whew." },
		{ Cue = "/VO/Melinoe_1837", Text = "Better..." },
		{ Cue = "/VO/Melinoe_1838", Text = "{#Emph}Whew{#Prev}, good." },
		{ Cue = "/VO/Melinoe_1839", Text = "Vitality..." },
		{ Cue = "/VO/Melinoe_1840", Text = "Life..." },
	},
}

GlobalVoiceLines.UsedMoneyDropVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.25,
	GameStateRequirements =
	{
		{
			PathNotEmpty = { "RequiredKillEnemies" },
		},
		{
			FunctionName = "RequiredAlive",
			FunctionArgs = { Units = { "NPC_Nemesis_01", "NPC_Heracles_01", "NPC_Icarus_01", "NPC_Athena_01" }, Alive = false },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1289", Text = "Chronos so loves his Gold..." },
	{ Cue = "/VO/Melinoe_1290", Text = "Lord Charon will want this.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" }
			},
		},
	},
	{ Cue = "/VO/Melinoe_1291", Text = "More of this tainted Gold." },
	{ Cue = "/VO/Melinoe_1292", Text = "Some of these golden coins...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_1293", Text = "Pure Gold..." },
	{ Cue = "/VO/Melinoe_0694", Text = "Gold..." },
}

GlobalVoiceLines.UsedPowerDrinkVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.25,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
		{ Name = "UsedPowerDrinkRecentlyLines", Time = 60 },
	},
	{ Cue = "/VO/MelinoeField_0381", Text = "Whoa...!" },
	{ Cue = "/VO/MelinoeField_0382", Text = "{#Emph}Whew...!", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_0383", Text = "{#Emph}Hyah!" },
}

GlobalVoiceLines.UsedCharonPointsDropVoiceLines =
{
	{
		PlayOnce = true,
		UsePlayerSource = true,
		PreLineWait = 0.75,
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_0734", Text = "Redeem this at the Crossroads, is that it...?" },
	},
	{
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.33,
		ObjectType = "NPC_Charon_01",

		{ Cue = "/VO/Charon_0029", Text = "{#Emph}Kohh..." },
	},
}
GlobalVoiceLines.ClaimedContractItemVoiceLines =
{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_4294", Text = "I earned this." },
		{ Cue = "/VO/MelinoeField_4295", Text = "My entitlement.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_4296", Text = "From the Contract." },
		{ Cue = "/VO/MelinoeField_4297", Text = "Contract-approved." },
		{ Cue = "/VO/MelinoeField_4298", Text = "For besting Zagreus." },
}

GlobalVoiceLines.PickedMoonSpellVoiceLines =
{
	-- in opening rooms
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		-- SuccessiveChanceToPlay = 0.66,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
			},
		},
		Cooldowns =
		{
			{ Name = "SeleneAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Selene_0277", Text = "Now, little star." },
		{ Cue = "/VO/Selene_0278", Text = "Now..." },
		{ Cue = "/VO/Selene_0279", Text = "Remember me..." },
		{ Cue = "/VO/Selene_0280", Text = "Your Hex..." },
		{ Cue = "/VO/Selene_0281", Text = "Prepared..." },
		{ Cue = "/VO/Selene_0282", Text = "My light..." },
		{ Cue = "/VO/Selene_0283", Text = "Ready..." },
		{ Cue = "/VO/Selene_0284", Text = "There..." },
	},
	-- in other rooms
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.2,

		{ Cue = "/VO/Melinoe_0025", Text = "Together we shine.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0573", Text = "Together we shine..." },
		{ Cue = "/VO/Melinoe_0574", Text = "Together we shine...!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.66,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		Cooldowns =
		{
			{ Name = "SeleneAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Selene_0124", Text = "It is yours." },
		{ Cue = "/VO/Selene_0150", Text = "Please accept this gift." },
		{ Cue = "/VO/Selene_0120", Text = "As you require." },
		{ Cue = "/VO/Selene_0125", Text = "So mote it be." },
		{ Cue = "/VO/Selene_0209", Text = "Thus are we bound." },
		{ Cue = "/VO/Selene_0210", Text = "You have my light." },
		{ Cue = "/VO/Selene_0211", Text = "You have it." },
		{ Cue = "/VO/Selene_0212", Text = "Then, shine." },
		{ Cue = "/VO/Selene_0213", Text = "You shall be feared." },
		{ Cue = "/VO/Selene_0214", Text = "My light is yours." },
		{ Cue = "/VO/Selene_0376", Text = "Let us be off." },
		{ Cue = "/VO/Selene_0380", Text = "Now we Silver Sisters ride.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
				},
			},
		},
		{ Cue = "/VO/Selene_0121", Text = "Together we shine.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_0025", "/VO/Melinoe_0573", "/VO/Melinoe_0574" },
				},
			},
		},
		{ Cue = "/VO/Selene_0122", Text = "Together we shine...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_0025", "/VO/Melinoe_0573", "/VO/Melinoe_0574" },
				},
			},
		},

	},
}

GlobalVoiceLines.FieldsRewardClaimedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.25,
	UsePlayerSource = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "H" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "H_Bridge01", "H_MiniBoss01", "H_MiniBoss02", "H_PreBoss01", "H_Boss01", "H_Boss02", "H_Combat15" },
		},
		{
			PathNotEmpty = { "MapState", "RoomRequiredObjects" },
		},
		{
			PathEmpty = { "MapState", "AggroedUnits" },
		},
	},
	TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/MelinoeField_1565", Text = "Could try the nearest exit just in case...",
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFieldsRewardFinder" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "EncountersCleared" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	{ Cue = "/VO/MelinoeField_1082", Text = "Two more to go I think.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1083", Text = "Another two remain.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1084", Text = "Two left.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1085", Text = "Two more.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1086", Text = "Two more to go.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1087", Text = "Now two remain.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1088", Text = "Should be two more.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1089", Text = "Where are the other two...",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1091", Text = "Two to go?",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 2,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1090", Text = "That's one down.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "EncountersCleared" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathNotEmpty = { "MapState", "RoomRequiredObjects" },
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1099", Text = "Two down.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "EncountersCleared" },
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1100", Text = "That's two down.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "EncountersCleared" },
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1092", Text = "Just one more.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1093", Text = "One more left.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1094", Text = "One more.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1095", Text = "One left.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1096", Text = "One to go.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1097", Text = "One remains.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1098", Text = "Should be one left.",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1101", Text = "Where's the last one?", PlayFirst = true,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredRewardCountInRoom",
				FunctionArgs =
				{
					ExcludeNames = { "NPC_Nemesis_01", "NPC_Athena_01" },
					Value = 1,
				},				
			},
		}
	},
}
GlobalVoiceLines.FieldsExitsUnlockedVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "H", },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01", "H_PreBoss01" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeFieldsExitsUnlockedSpeech", Time = 240 },
		},
		TriggerCooldowns ={ "MelinoeAnyQuipSpeech" },
		ThreadName = "RoomThread",

		{ Cue = "/VO/MelinoeField_1102", Text = "Think I can finally go...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1103", Text = "That was all of them." },
		{ Cue = "/VO/MelinoeField_1104", Text = "I can get out now..." },
		{ Cue = "/VO/MelinoeField_1105", Text = "I think I'm finished here." },
		{ Cue = "/VO/MelinoeField_1106", Text = "That should have done it." },
		{ Cue = "/VO/MelinoeField_1107", Text = "I should be able to get out I think." },
		{ Cue = "/VO/MelinoeField_1108", Text = "Could get going now..." },
	},
}

GlobalVoiceLines.MiscUpgradePickedVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary" },
			HasNone = { "SurfacePenalty" },
		}
	},
	Cooldowns =
	{
		{ Name = "MelinoeRewardPickUpSpeech", Time = 60 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN" },
			},
		},
		PlayOnce = true,
		PlayOnceContext = "ArachneCombatExitHintVO",
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_1934", Text = "The exit wards are down..." },
		{ Cue = "/VO/Melinoe_1935", Text = "Sounds like I can get out." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "Shop" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01", "I_Story01" },
			},
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.75,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0764", Text = "Thank you!" },
		{ Cue = "/VO/Melinoe_0765", Text = "Thank you." },
		-- { Cue = "/VO/Melinoe_0766", Text = "For me?" },
		{ Cue = "/VO/Melinoe_0767", Text = "Thanks..." },
	},	
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "Shop", "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestN", "DevotionTestO", "DevotionTestP", "ArtemisCombatIntro",
					"ArtemisCombatF", "ArtemisCombatF2",
					"ArtemisCombatG", "ArtemisCombatG2",
					"ArtemisCombatN", "ArtemisCombatN2",
					"HeraclesCombatN", "HeraclesCombatN2",
					"HeraclesCombatO", "HeraclesCombatO2",
					"HeraclesCombatP", "HeraclesCombatP2",
					"NemesisCombatF", "NemesisCombatG", "NemesisCombatI",
					"NemesisCombatH", "IcarusCombatO",
					"IcarusCombatO2", "IcarusCombatP",
					"IcarusCombatP2", },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "TestAllThings", "F_Story01", "G_Story01", "H_Bridge01", "I_Story01", "N_Story01", "O_Story01", "P_Story01" },
			},
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscRewardSpeech", Time = 60 },
		},

		{ Cue = "/VO/Melinoe_0200", Text = "Greater strength." },
		{ Cue = "/VO/Melinoe_0201", Text = "I accept this gift." },
		{ Cue = "/VO/Melinoe_0203", Text = "Yes." },
		{ Cue = "/VO/Melinoe_0204", Text = "Excellent." },
		{ Cue = "/VO/Melinoe_0205", Text = "Better." },
		{ Cue = "/VO/Melinoe_0206", Text = "Good." },
		{ Cue = "/VO/Melinoe_0207", Text = "Adequate." },
		{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0209", Text = "There." },
		{ Cue = "/VO/Melinoe_0211", Text = "Right." },
		{ Cue = "/VO/Melinoe_0212", Text = "I grow strong." },
		{ Cue = "/VO/Melinoe_0213", Text = "Greater might..." },
		{ Cue = "/VO/Melinoe_0243", Text = "Sure..." },
		{ Cue = "/VO/Melinoe_0244", Text = "Very well..." },
		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0179", Text = "All right." },
		{ Cue = "/VO/Melinoe_0180", Text = "Set." },
		{ Cue = "/VO/Melinoe_5587", Text = "Stronger." },
		{ Cue = "/VO/Melinoe_5588", Text = "Felt that." },
		{ Cue = "/VO/Melinoe_5590", Text = "Yes." },
	},
}

GlobalVoiceLines.FieldsPassiveEnemiesSpottedVoiceLines =
{
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelinoeReloadEncounterVoiceLines", Time = 240 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.2,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"CorruptedShadeSmall",
					"CorruptedShadeSmall_Elite",
					"CorruptedShadeMedium",
					"CorruptedShadeMedium_Elite",
					"CorruptedShadeLarge",
					"CorruptedShadeLarge_Elite",
				},
			}
		},
		{ Cue = "/VO/MelinoeField_1022", Text = "No need to engage..." },
		{ Cue = "/VO/MelinoeField_1023", Text = "Corrupted Shades...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1024", Text = "More of those Shades..." },
		{ Cue = "/VO/MelinoeField_1025", Text = "Those poor Shades..." },
		{ Cue = "/VO/MelinoeField_1026", Text = "More Corrupted..." },
		{ Cue = "/VO/MelinoeField_1027", Text = "More Shades..." },
		{ Cue = "/VO/MelinoeField_1028", Text = "Shades there..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"DespairElemental",
					"DespairElemental_Elite",
				},					
			}
		},
		SuccessiveChanceToPlay = 0.1,

		{ Cue = "/VO/MelinoeField_1039", Text = "A Bawlder.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1040", Text = "Bawlder...!" },
		{ Cue = "/VO/MelinoeField_1041", Text = "Bawlder there..." },
		{ Cue = "/VO/MelinoeField_1042", Text = "Best stay out of its way..." },
	},
}
GlobalVoiceLines.FieldsEnemiesSpottedVoiceLines =
{
	UsePlayerSource = true,
	SuccessiveChanceToPlay = 0.1,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
	},
	GameStateRequirements = 
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "NemesisCombatH", "MiniBossLamia", "MiniBossVampire" },
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"BrokenHearted",
					"BrokenHearted_Elite",
				},
			}
		},
		{ Cue = "/VO/MelinoeField_1029", Text = "Smackers.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1030", Text = "Smackers!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"Lovesick",
					"Lovesick_Elite",
				},
			}
		},

		{ Cue = "/VO/MelinoeField_1031", Text = "Holehearts.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1032", Text = "Holehearts...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"Lycanthrope",
					"Lycanthrope_Elite",
				},
			}
		},

		{ Cue = "/VO/MelinoeField_1033", Text = "Lycaons.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1034", Text = "Lycaons...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"Mourner",
					"Mourner_Elite",
				},
			}
		},

		{ Cue = "/VO/MelinoeField_1035", Text = "Mourners.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1036", Text = "Mourners...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"Lamia",
					"Lamia_Elite",
				},
			}
		},

		{ Cue = "/VO/MelinoeField_1037", Text = "Lamiai.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1038", Text = "Lamiai...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"FogEmitter2",
					"FogEmitter2_Elite",
				},
			}
		},

		{ Cue = "/VO/MelinoeField_1661", Text = "A Sorrow-Spiller." },
		{ Cue = "/VO/MelinoeField_1662", Text = "Sorrow-Spiller...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1043", Text = "A Spiller!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements = 
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny =
				{
					"Treant2",
				},
			}
		},
		{ Cue = "/VO/MelinoeField_1659", Text = "A Brush-Stalker." },
		{ Cue = "/VO/MelinoeField_1660", Text = "Brush-Stalker...!", PlayFirst = true },
	},

}

GlobalVoiceLines.HarvestPointFoundVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary" },
			HasNone = { "SurfacePenalty" },
		},
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.1,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Story01", "G_Story01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "NemesisRandomEvent" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech", "MelinoeRewardPickUpSpeech" },

		{ Cue = "/VO/MelinoeField_1046", Text = "My Reagent-Sensing incantation took effect..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.33,
		PreLineWait = 0.75,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
			},
			{
				Path = { "CurrentRun", "BiomesReached" },
				HasNone = { "G", "Q" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Story01", "F_PostBoss01", "G_Story01", "I_Story01", "N_Story01", "O_Story01", "P_Story01" },
			},
			{
				Path = { "GameState", "GamePhase", },
				Comparison = "~=",
				Value = 5,
			},
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "HecateBossKidnapped01" },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Artemis_Field_01", "NPC_Nemesis_01", "NPC_Heracles_01", "NPC_Icarus_01", "NPC_Athena_01" }, Alive = false },
			},
		},
		Cooldowns =
		{
			{ Name = "SeleneAnyQuipSpeech", Time = 10 },
			{ Name = "SeleneRewardSpottedSpeech", Time = 300 },
		},

		{ Cue = "/VO/Selene_0145", Text = "I see something for you.", PlayFirst = true },
		{ Cue = "/VO/Selene_0146", Text = "I see something of use." },
		{ Cue = "/VO/Selene_0147", Text = "Look to my light nearby." },
		{ Cue = "/VO/Selene_0148", Text = "Something of value there." },
		{ Cue = "/VO/Selene_0239", Text = "I located something." },
		{ Cue = "/VO/Selene_0240", Text = "I found something..." },
		{ Cue = "/VO/Selene_0241", Text = "Look carefully about." },
		{ Cue = "/VO/Selene_0242", Text = "Look at what I found..." },
		{ Cue = "/VO/Selene_0243", Text = "A valuable is near." },
		{ Cue = "/VO/Selene_0244", Text = "Observe nearby..." },
		{ Cue = "/VO/Selene_0245", Text = "A small discovery..." },
		{ Cue = "/VO/Selene_0246", Text = "Something nearby..." },
		{ Cue = "/VO/Selene_0404", Text = "Look there." },
		{ Cue = "/VO/Selene_0405", Text = "Observe." },
		{ Cue = "/VO/Selene_0406", Text = "There." },
		{ Cue = "/VO/Selene_0407", Text = "A valuable for you." },
		{ Cue = "/VO/Selene_0408", Text = "Allow me." },
		{ Cue = "/VO/Selene_0409", Text = "Do you see?" },
		{ Cue = "/VO/Selene_0411", Text = "I am your guide." },
		{ Cue = "/VO/Selene_0412", Text = "Something to procure." },
		{ Cue = "/VO/Selene_0416", Text = "I see everything." },
		{ Cue = "/VO/Selene_0418", Text = "Follow your senses." },
		{ Cue = "/VO/Selene_0415", Text = "Your attention?",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAutoHarvestOnExit" },
				},
			},
		},
		{ Cue = "/VO/Selene_0413", Text = "Before you go...",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAutoHarvestOnExit" },
				},
			},
		},
		{ Cue = "/VO/Selene_0410", Text = "Follow my light.",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAutoHarvestOnExit" },
				},
			},
		},
		{ Cue = "/VO/Selene_0414", Text = "Do not depart just yet.",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAutoHarvestOnExit" },
				},
			},
		},
		{ Cue = "/VO/Selene_0417", Text = "Search there.",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAutoHarvestOnExit" },
				},
			},
		},
		{ Cue = "/VO/Selene_0419", Text = "A digging spot.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasShovelPoint" },
			},
		},
		{ Cue = "/VO/Selene_0420", Text = "I see a digging spot.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasShovelPoint" },
			},
		},
		{ Cue = "/VO/Selene_0421", Text = "Something in the Earth...",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasShovelPoint" },
			},
		},
		{ Cue = "/VO/Selene_0422", Text = "A fishing point.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
		{ Cue = "/VO/Selene_0423", Text = "A fishing point is near.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
		{ Cue = "/VO/Selene_0424", Text = "In the waters...",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
		{ Cue = "/VO/Selene_0425", Text = "An outcropping.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasPickaxePoint" },
			},
		},
		{ Cue = "/VO/Selene_0426", Text = "I see an outcropping.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasPickaxePoint" },
			},
		},
		{ Cue = "/VO/Selene_0427", Text = "The glint of valuables.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasPickaxePoint" },
			},
		},
		{ Cue = "/VO/Selene_0428", Text = "Some flora there.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasHarvestPoint" },
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "O", "Q" },
				},
			},
		},
		{ Cue = "/VO/Selene_0429", Text = "Some flora.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasHarvestPoint" },
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "O", "Q" },
				},
			},
		},
		{ Cue = "/VO/Selene_0430", Text = "Reagent located.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasHarvestPoint" },
			},
		},
		{ Cue = "/VO/Selene_0431", Text = "A Lost Shade.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasExorcismPoint" },
			},
		},
		{ Cue = "/VO/Selene_0432", Text = "I see a Lost Shade.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasExorcismPoint" },
			},
		},
		{ Cue = "/VO/Selene_0433", Text = "A Shade needs you.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasExorcismPoint" },
			},
		},
		{ Cue = "/VO/Selene_0434", Text = "I see a Shade in need...",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasExorcismPoint" },
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.1,
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Story01", "G_Story01", "I_Story01", "N_Story01", "O_Story01", "P_Story01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "NemesisRandomEvent" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeRewardPickUpSpeech", Time = 60 },
		},

		{ Cue = "/VO/Melinoe_0423", Text = "Oh." },
		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0824", Text = "There's something." },
		{ Cue = "/VO/Melinoe_0825", Text = "Over there." },
		{ Cue = "/VO/Melinoe_0826", Text = "That's something." },
		{ Cue = "/VO/Melinoe_0827", Text = "Something there." },
		{ Cue = "/VO/Melinoe_0828", Text = "I see it." },
		{ Cue = "/VO/Melinoe_0829", Text = "There." },
		{ Cue = "/VO/Melinoe_0751", Text = "A fishing point.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
		{ Cue = "/VO/Melinoe_0752", Text = "Fishing point there.",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
		{ Cue = "/VO/MelinoeField_1340", Text = "A fish is near...",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
		{ Cue = "/VO/MelinoeField_1341", Text = "I sense a fish...",
			GameStateRequirements =
			{
				NamedRequirements = { "RoomOnlyHasFishingPoint" },
			},
		},
	},
}
GlobalVoiceLines.ResourceFoundVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "TestAllThings", "H_Bridge01", "I_Boss01", "Q_Boss01", "Q_Boss02" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "NemesisRandomEvent", "Story_Hades_01" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0716", Text = "Got it." },
		{ Cue = "/VO/Melinoe_0717", Text = "I can use this." },
		{ Cue = "/VO/Melinoe_0718", Text = "There." },
		{ Cue = "/VO/Melinoe_0719", Text = "In you go." },
		{ Cue = "/VO/Melinoe_0720", Text = "In we go." },
		{ Cue = "/VO/Melinoe_0721", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_0722", Text = "Mine." },
		{ Cue = "/VO/Melinoe_0723", Text = "Tucked away." },
		{ Cue = "/VO/Melinoe_0724", Text = "Into the purse." },
		{ Cue = "/VO/Melinoe_0725", Text = "Always use more..." },
		{ Cue = "/VO/Melinoe_0726", Text = "Good find..." },
		{ Cue = "/VO/Melinoe_0829", Text = "There." },
		{ Cue = "/VO/Melinoe_0830", Text = "Oh." },
	},
	{ GlobalVoiceLines = "HecateGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "ArachneGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "NemesisGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "ArtemisGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "IcarusGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "CharonGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "HadesHarvestReactionVoiceLines" },
	{ GlobalVoiceLines = "HermesHarvestReactionVoiceLines" },
	{ GlobalVoiceLines = "ChronosGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "HeraclesGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "MedeaGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "PolyphemusGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "ErisGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "PrometheusGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "AthenaGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "DionysusGatherReactionVoiceLines" },
	{ GlobalVoiceLines = "ChaosHarvestReactionVoiceLines" },
}
GlobalVoiceLines.FoundSeedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" }
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0709", Text = "Seeds." },
		{ Cue = "/VO/Melinoe_0710", Text = "Some seeds." },
	},
}
GlobalVoiceLines.BreakableHighValueDestroyedVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.8,
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone =
				{
					"Story_Chronos01",
					"Story_Narcissus_01",
					"Story_Hades_01",
					"NemesisCombatIntro",
					"NemesisCombatF",
					"NemesisCombatG",
					"NemesisCombatH",
					"NemesisCombatI",
					"TyphonShop",
				},
			},
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeHighValueUrnSpeech", Time = 360 }
		},

		{ Cue = "/VO/Melinoe_2154", Text = "Gold coins..." },
		{ Cue = "/VO/Melinoe_2155", Text = "Coin for Charon...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2156", Text = "Coinage..." },
		{ Cue = "/VO/Melinoe_2157", Text = "Some coins..." },
	},
}
GlobalVoiceLines.HarvestBonusResourceVoiceLines =
{
	Cooldowns =
	{
		{ Name = "OdysseusHarvestVO", Time = 2 },
	},
	{
		PlayOnce = true,
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "HarvestBountyVO",
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.45,
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
		},

		{ Cue = "/VO/Melinoe_4703", Text = "Gaia's Secrets..." },
		{ Cue = "/VO/Melinoe_4704", Text = "Gaia's Bounty..." },
	},
	{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
}
GlobalVoiceLines.PositiveReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.45,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "TestAllThings" },
		},
		{
			PathEmpty = { "RequiredKillEnemies" },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
	},

	{ Cue = "/VO/Melinoe_0184", Text = "{#Emph}Ah." },
	{ Cue = "/VO/Melinoe_0185", Text = "There." },
	{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
	{ Cue = "/VO/Melinoe_0220", Text = "{#Emph}Heh." },
	{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
	{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
	{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh." },
	{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
	{ Cue = "/VO/Melinoe_1960", Text = "Oh..." },
	{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
	{ Cue = "/VO/Melinoe_1962", Text = "{#Emph}Ooh!" },
	{ Cue = "/VO/Melinoe_1964", Text = "{#Emph}Hmm!" },	
}
GlobalVoiceLines.CatReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.55,
	PlayOnce = true,
	PlayOnceContext = "CatSightedVO",
	GameStateRequirements =
	{
		--
	},

	{ Cue = "/VO/Melinoe_1958", Text = "Oh?" },
}
GlobalVoiceLines.RavenReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.55,
	PlayOnce = true,
	PlayOnceContext = "RavenSightedVO",
	GameStateRequirements =
	{
		--
	},

	{ Cue = "/VO/Melinoe_1958", Text = "Oh?" },
}
GlobalVoiceLines.HoundReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.33,
	GameStateRequirements =
	{
		--
	},

	{ Cue = "/VO/Melinoe_3870", Text = "I know that hound...!", PlayFirst = true, PlayOnce = true, PlayOnceContext = "HoundSightedVO" },
	{ Cue = "/VO/Melinoe_3871", Text = "It's Hecuba the Hound...!" },
	{ Cue = "/VO/Melinoe_3872", Text = "Hecuba on watch." },
	{ Cue = "/VO/Melinoe_3873", Text = "Hecuba!" },
}
GlobalVoiceLines.PolecatReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.33,
	GameStateRequirements =
	{
		--
	},

	{ Cue = "/VO/MelinoeField_3049", Text = "Gale, is that you?", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_3050", Text = "Gale!" },
}

GlobalVoiceLines.NegativeReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.45,
	GameStateRequirements =
	{
		--
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}<Scoff>" },
	{ Cue = "/VO/Melinoe_1948", Text = "{#Emph}Ngh." },
	{ Cue = "/VO/Melinoe_1949", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_1950", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_1951", Text = "{#Emph}<Gasp>" },
	{ Cue = "/VO/Melinoe_1952", Text = "{#Emph}Huh?" },
	{ Cue = "/VO/Melinoe_1953", Text = "{#Emph}Ah!" },
	{ Cue = "/VO/Melinoe_1955", Text = "{#Emph}Rngh!" },
	{ Cue = "/VO/Melinoe_0576", Text = "{#Emph}Mmm..." },
	{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
	{ Cue = "/VO/Melinoe_0579", Text = "{#Emph}Hm!" },
	{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
}
GlobalVoiceLines.AnomalyReactionVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.45,
	GameStateRequirements =
	{
		--
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/MelinoeField_1683", Text = "{#Emph}<Gasp>" },
	{ Cue = "/VO/MelinoeField_1684", Text = "{#Emph}Huh?" },
	{ Cue = "/VO/MelinoeField_1685", Text = "{#Emph}Ah!" },
	{ Cue = "/VO/MelinoeField_1686", Text = "{#Emph}Rngh!" },
	{ Cue = "/VO/MelinoeField_1687", Text = "{#Emph}Wha—?" },
}
GlobalVoiceLines.NemesisDealDeclineVoiceLines =
{
	UsePlayerSource = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/Melinoe_2143", Text = "...I said I don't need your aid. Watch yourself, Nem.",
		PlayOnce = true, PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "NemesisGift06" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_2146", Text = "You need it more than I." },
	{ Cue = "/VO/Melinoe_2147", Text = "I'm all right, thanks." },
	{ Cue = "/VO/MelinoeField_0072", Text = "Not tonight." },
	{ Cue = "/VO/MelinoeField_0073", Text = "I'm good, thanks." },
	{ Cue = "/VO/MelinoeField_0074", Text = "{#Emph}Mmm{#Prev}, no." },
	{ Cue = "/VO/MelinoeField_0075", Text = "Not now, Nem." },
	{ Cue = "/VO/MelinoeField_0076", Text = "I'll pass." },
	{ Cue = "/VO/MelinoeField_0077", Text = "No thank you." },
}

GlobalVoiceLines.SaluteVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeSaluteSpeech", Time = 6 },
	},
	TriggerCooldowns = { "MelinoeRoomExitVoiceLines" },
	-- formal relationships
	{
		PreLineWait = 0.15,
		RandomRemaining = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = GameData.FormalRelationships,
			},
		},

		{ Cue = "/VO/Melinoe_1698", Text = "Salutations.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", },
					HasNone = { "ConversationThisRun", "GiftedThisRun", },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1699", Text = "Salutations!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", },
					HasNone = { "ConversationThisRun", "GiftedThisRun", },
				},
			},
		},

		{ Cue = "/VO/Melinoe_1700", Text = "Death to Chronos!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "OriginalSource", "BlockDeathToChronosSalute" },
				},
				OrRequirements =
				{
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "TrueEnding01" },
						},
					},
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_1701", Text = "Moonlight guide you." },
		{ Cue = "/VO/Melinoe_1703", Text = "May moonlight guide you." },
		{ Cue = "/VO/Melinoe_1704", Text = "Moonlight guide us." },
		{ Cue = "/VO/Melinoe_1705", Text = "May moonlight guide us." },
		{ Cue = "/VO/Melinoe_1709", Text = "Moonlight guide us." },
	},
	-- informal relationships F
	{
		PreLineWait = 0.15,
		RandomRemaining = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = GameData.InformalRelationshipsF,
			},
		},

		{ Cue = "/VO/Melinoe_1700_2", Text = "Death to Chronos!",
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_2784", Text = "Salutations!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", },
					HasNone = { "ConversationThisRun", "GiftedThisRun", },
				},
			},
		},
		
		{ Cue = "/VO/Melinoe_2785", Text = "Moonlight guide you." },
		{ Cue = "/VO/Melinoe_2786", Text = "May moonlight guide you!" },
		{ Cue = "/VO/Melinoe_2787", Text = "May moonlight guide us." },
		{ Cue = "/VO/Melinoe_2788", Text = "Moonlight guide us, and all." },
	},
	-- informal relationships M
	{
		PreLineWait = 0.15,
		RandomRemaining = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = GameData.InformalRelationshipsM,
			},
		},

		{ Cue = "/VO/Melinoe_1698_2", Text = "Salutations.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", },
					HasNone = { "ConversationThisRun", "GiftedThisRun", },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1699_2", Text = "Salutations!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", },
					HasNone = { "ConversationThisRun", "GiftedThisRun", },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1700_2", Text = "Death to Chronos!",
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "TrueEnding01" },
						},
					},
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_1701_2", Text = "Moonlight guide you." },
		{ Cue = "/VO/Melinoe_1703_2", Text = "May moonlight guide you." },
		{ Cue = "/VO/Melinoe_1704_2", Text = "Moonlight guide us." },
		{ Cue = "/VO/Melinoe_1705_2", Text = "May moonlight guide us." },
		{ Cue = "/VO/Melinoe_1709_2", Text = "Moonlight guide us." },
	},
}

GlobalVoiceLines.WebDestroyedVoiceLines =
{
	{
		Queue = "Interrupt",
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.33,
		PreLineWait = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelHitWebSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_0579", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
		{ Cue = "/VO/Melinoe_0761", Text = "{#Emph}Ungh..." },
	},
}

GlobalVoiceLines.FrustratedVoiceLines =
{
	-- screen version (for laststanditem)
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens" },
				HasAny = { "WellShop", "SurfaceShop" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_1470", Text = "Oh, come on..." },
		{ Cue = "/VO/MelinoeField_1471", Text = "Blast..." },
		{ Cue = "/VO/MelinoeField_1472", Text = "Blood and..." },
		{ Cue = "/VO/MelinoeField_1473", Text = "{#Emph}Augh..." },
	},
	-- misc version
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		PreLineWait = 1.5,

		{ Cue = "/VO/MelinoeField_1470", Text = "Oh, come on..." },
		{ Cue = "/VO/MelinoeField_1471", Text = "Blast..." },
		{ Cue = "/VO/MelinoeField_1472", Text = "Blood and..." },
		{ Cue = "/VO/MelinoeField_1473", Text = "{#Emph}Augh..." },
	},
}
GlobalVoiceLines.PurchasedRandomItemVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlay = 0.75,

	-- TKTK
}

GlobalVoiceLines.PurchasedConsumableVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Story01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2", "ArtemisCombatN", "ArtemisCombatN2", "NemesisRandomEvent" },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Nemesis_01", "NPC_Heracles_01", }, Alive = false },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoePurchasedConsumableSpeech", Time = 30 },
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_1215", Text = "Should be useful." },
		{ Cue = "/VO/Melinoe_1216", Text = "I need this." },
		{ Cue = "/VO/Melinoe_1217", Text = "This should help." },
		{ Cue = "/VO/Melinoe_1222", Text = "Valuable enough." },
		{ Cue = "/VO/Melinoe_0554", Text = "I'll take it." },
		{ Cue = "/VO/Melinoe_0556", Text = "This one." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
		{ Cue = "/VO/Melinoe_1218", Text = "This one, please.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BiomesReached", "P" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1219", Text = "May I?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BiomesReached", "P" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1220", Text = "I have the Gold.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			}
		},
		{ Cue = "/VO/Melinoe_0557", Text = "Here's the Gold.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					PathFalse = { "CurrentRun", "BiomesReached", "P" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1221", Text = "Here's the Gold.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					PathFalse = { "CurrentRun", "BiomesReached", "P" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0558", Text = "Here you are.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BiomesReached", "P" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ChanceToPlay = 0.2,
		-- RequiresNullAmbientMusicId = true,
		ObjectType = "NPC_Charon_01",
		PreLineAnim = "Charon_Thanking",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		Cooldowns =
		{
			{ Name = "CharonSpokeRecently", Time = 12 },
		},

		{ Cue = "/VO/Charon_0064", Text = "{#Emph}Mmm..." },
		{ Cue = "/VO/Charon_0065", Text = "{#Emph}Rrngh..." },
		{ Cue = "/VO/Charon_0066", Text = "{#Emph}Nghh..." },
		{ Cue = "/VO/Charon_0067", Text = "{#Emph}Heehh..." },
		{ Cue = "/VO/Charon_0068", Text = "{#Emph}Grngh..." },
		{ Cue = "/VO/Charon_0069", Text = "{#Emph}Aaugh..." },
		{ Cue = "/VO/Charon_0093", Text = "{#Emph}Eehhh..." },
	},
	{ GlobalVoiceLines = "HermesPurchaseReactionVoiceLines" },
}
GlobalVoiceLines.RushWellShopItemVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 30,
		SuccessiveChanceToPlay = 0.33,

		{ Cue = "/VO/Melinoe_1360", Text = "I need this right away." },
		{ Cue = "/VO/Melinoe_1361", Text = "Express shipping, please." },
		{ Cue = "/VO/Melinoe_1362", Text = "I could use this right now." },
		{ Cue = "/VO/Melinoe_1363", Text = "Rush delivery on this." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.32,
		Source = { LineHistoryName = "NPC_Hermes_01", SubtitleColor = Color.HermesVoice },
		Cooldowns =
		{
			{ Name = "HermesSpokeRecently", Time = 2 },
			{ Name = "HermesExpeditedRecently", Time = 10 },
		},

		{ Cue = "/VO/Hermes_0103", Text = "Rush delivery!" },
		{ Cue = "/VO/Hermes_0104", Text = "Premium service!" },
		{ Cue = "/VO/Hermes_0105", Text = "Right away!" },
		{ Cue = "/VO/Hermes_0106", Text = "Consider it done!" },
		{ Cue = "/VO/Hermes_0107", Text = "Expedited!" },
		{ Cue = "/VO/Hermes_0108", Text = "And, {#Emph}done!" },
		{ Cue = "/VO/Hermes_0109", Text = "Express it is!" },
		{ Cue = "/VO/Hermes_0110", Text = "Coming right up!", PlayFirst = true },
		{ Cue = "/VO/Hermes_0111", Text = "You got it!" },
		{ Cue = "/VO/Hermes_0112", Text = "Sure thing!" },
		{ Cue = "/VO/Hermes_0113", Text = "Order received!" },
		{ Cue = "/VO/Hermes_0114", Text = "Good choice!" },
		{ Cue = "/VO/Hermes_0115", Text = "All yours!" },
	},
}
GlobalVoiceLines.StandardWellShopItemVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 30,
		SuccessiveChanceToPlay = 0.65,
		GameStateRequirements =
		{
			{
				PathTrue = { "ActiveScreens", "WellShop" },
			},
		},
		{ Cue = "/VO/Melinoe_1215", Text = "Should be useful." },
		{ Cue = "/VO/Melinoe_1216", Text = "I need this." },
		{ Cue = "/VO/Melinoe_1217", Text = "This should help." },
		{ Cue = "/VO/Melinoe_1220", Text = "I have the Gold." },
		{ Cue = "/VO/Melinoe_1222", Text = "Valuable enough." },
		{ Cue = "/VO/Melinoe_0554", Text = "I'll take it." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
		{ Cue = "/VO/MelinoeField_1451", Text = "Should come in handy." },
		{ Cue = "/VO/MelinoeField_1452", Text = "All right." },
		{ Cue = "/VO/MelinoeField_1453", Text = "Out you go." },
		{ Cue = "/VO/MelinoeField_1454", Text = "Come on out." },
		{ Cue = "/VO/MelinoeField_1455", Text = "Should help." },
		{ Cue = "/VO/MelinoeField_1456", Text = "Couldn't hurt." },
		{ Cue = "/VO/MelinoeField_1457", Text = "An even trade." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 30,
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				PathTrue = { "ActiveScreens", "SurfaceShop" },
			},
		},

		{ Cue = "/VO/Melinoe_1364", Text = "Looking forward to this." },
		{ Cue = "/VO/Melinoe_1365", Text = "Should get here soon enough." },
		{ Cue = "/VO/Melinoe_1366", Text = "Shouldn't take too long." },
		{ Cue = "/VO/Melinoe_1367", Text = "Delivery coming soon." },
	},
}
GlobalVoiceLines.PurchasedLastStandVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
			}
		},
		{ Cue = "/VO/MelinoeField_1466", Text = "Perfect." },
		{ Cue = "/VO/MelinoeField_1467", Text = "Just what I needed." },
		{ Cue = "/VO/MelinoeField_1468", Text = "Thank the Fates." },
		{ Cue = "/VO/MelinoeField_1469", Text = "Well worthwhile." },
	},
}
GlobalVoiceLines.PurchasedRandomPomVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.45,
	
	-- TKTK
}
GlobalVoiceLines.PurchasedChaosWeaponUpgradeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.33,
	
	-- TKTK
}
GlobalVoiceLines.PurchasedDamageSelfDropVoicelines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.1,
	
	{ Cue = "/VO/MelinoeField_1462", Text = "{#Emph}Ow! {#Prev}Gold." },
	{ Cue = "/VO/MelinoeField_1463", Text = "{#Emph}Ungh, {#Prev}coinage!" },
	{ Cue = "/VO/MelinoeField_1464", Text = "{#Emph}Aah, {#Prev}shiny!" },
	{ Cue = "/VO/MelinoeField_1465", Text = "{#Emph}Oof! {#Prev}Worth it!" },
}

-- hub interaction voice lines
GlobalVoiceLines.AlchemyStartVoiceLines =
{
	PreLineWait = 0.3,
	RandomRemaining = true,

	{ Cue = "/VO/Melinoe_1350", Text = "Power to create..." },
	{ Cue = "/VO/Melinoe_1351", Text = "Power to change..." },
	{ Cue = "/VO/Melinoe_5591", Text = "{#Emph}Become as new..." },
	{ Cue = "/VO/Melinoe_5592", Text = "{#Emph}Become as new...!" },
	{ Cue = "/VO/Melinoe_5593", Text = "{#Emph}Become what I seek." },
	{ Cue = "/VO/Melinoe_5594", Text = "{#Emph}Become what I seek...!" },
}

GlobalVoiceLines.CookingStartedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.95,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		
		{ Cue = "/VO/Melinoe_2329", Text = "This'll take a little while..." },
		{ Cue = "/VO/Melinoe_2330", Text = "It'll be worth the wait." },
		{ Cue = "/VO/Melinoe_5509", Text = "Covered up..." },
		{ Cue = "/VO/Melinoe_5510", Text = "Now simmer away..." },
		{ Cue = "/VO/Melinoe_5511", Text = "It's cooking..." },
		{ Cue = "/VO/Melinoe_5512", Text = "Bubble away..." },
	},
	--[[
	{
		RandomRemaining = true,
		PreLineWait = 0.95,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Hecate_01",
		
		{ Cue = "/VO/Hecate_0610", Text = "You'd use our cauldron thus?" },
		{ Cue = "/VO/Hecate_0611", Text = "An odd use of our craft." },
		{ Cue = "/VO/Hecate_0612", Text = "A foreign incantation of some sort." },
		{ Cue = "/VO/Hecate_0613", Text = "A Witch ought to eat..." },
	},
	]]--
}
GlobalVoiceLines.CookingPendingVoiceLines =
{
	{
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_2333", Text = "It's cooking still.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2334", Text = "Cooking away for now...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_2895", Text = "We've something brewing still." },
		{ Cue = "/VO/Melinoe_2896", Text = "The cauldron's still in use." },
		{ Cue = "/VO/Melinoe_2897", Text = "Still cooking isn't it." },
		{ Cue = "/VO/Melinoe_2898", Text = "Can't use the cauldron now." },
	},
}
GlobalVoiceLines.CookingCompleteVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_2331", Text = "Smells delicious!" },
		{ Cue = "/VO/Melinoe_2332", Text = "Fresh from the pot!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1352", Text = "Transmutation complete.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1353", Text = "Transmutation succeeded." },
		{ Cue = "/VO/Melinoe_5513", Text = "All done." },
		{ Cue = "/VO/Melinoe_5514", Text = "It's finished." },
		{ Cue = "/VO/Melinoe_5515", Text = "There we have it." },
		{ Cue = "/VO/Melinoe_5516", Text = "Just right." },
	},
}

GlobalVoiceLines.MelMusicChoiceVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		Cooldowns =
		{
			{ Name = "MelMusicPlayerRequestSpeech", Time = 10 },
		},
		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						PathFromArgs = true,
						PathTrue = { "PurchasingSong" },
					},
				},
				{
					-- reduced odds of playing for already-unlocked songs
					ChanceToPlay = 0.33,
				},
			},
		},

		{ Cue = "/VO/Melinoe_3832", Text = "I'd like to hear this one." },
		{ Cue = "/VO/Melinoe_3833", Text = "Would you play this one, please?" },
		{ Cue = "/VO/Melinoe_3834", Text = "Let's hear this one." },
		{ Cue = "/VO/Melinoe_3835", Text = "Play this one next, would you?" },
		{ Cue = "/VO/Melinoe_3836", Text = "Play us another song, if you don't mind!" },
		{ Cue = "/VO/Melinoe_3837", Text = "Mind playing this one next?" },
		{ Cue = "/VO/Melinoe_3838", Text = "Got a request for you.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3839", Text = "Up for another song?" },
		{ Cue = "/VO/Melinoe_4007", Text = "I like this one." },
		{ Cue = "/VO/Melinoe_4008", Text = "One of my favorites." },
		{ Cue = "/VO/Melinoe_4009", Text = "Among the best." },
		{ Cue = "/VO/Melinoe_4010", Text = "Personal pick." },
		{ Cue = "/VO/Melinoe_3841", Text = "Surprised you've heard of this one, but all right...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					SumPrevRuns = 6,
					Path = { "SpeechRecord", "/VO/Melinoe_3841" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
				{
					Path = { "GameState", "MusicPlayerSongName" },
					IsAny =
					{
						-- "Song_Scylla1a",
						"Song_Scylla1b",
						"Song_Scylla2a",
						"Song_Scylla2b",
						"Song_Scylla3a",
						"Song_Scylla3b",
						"Song_Scylla4a",
						"Song_Scylla4b",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3840", Text = "I almost hesitate to ask...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "MusicPlayerSongName" },
					IsAny =
					{
						-- "Song_Scylla1a",
						"Song_Scylla1b",
						"Song_Scylla2a",
						"Song_Scylla2b",
						"Song_Scylla3a",
						"Song_Scylla3b",
						"Song_Scylla4a",
						"Song_Scylla4b",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5756", Text = "A comrade recommended this...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "MusicPlayerSongName" },
					IsAny =
					{
						"Song_Scylla1a",
						"Song_Scylla1b",
						"Song_Scylla2a",
						"Song_Scylla2b",
						"Song_Scylla3a",
						"Song_Scylla3b",
						"Song_Scylla4a",
						"Song_Scylla4b",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5757", Text = "This ought to drive everyone mad...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "MusicPlayerSongName" },
					IsAny =
					{
						-- "Song_Scylla1a",
						"Song_Scylla1b",
						-- "Song_Scylla2a",
						"Song_Scylla2b",
						-- "Song_Scylla3a",
						"Song_Scylla3b",
						-- "Song_Scylla4a",
						"Song_Scylla4b",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5758", Text = "We should have laws against this type of song...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "MusicPlayerSongName" },
					IsAny =
					{
						-- "Song_Scylla1a",
						"Song_Scylla1b",
						-- "Song_Scylla2a",
						"Song_Scylla2b",
						-- "Song_Scylla3a",
						"Song_Scylla3b",
						-- "Song_Scylla4a",
						"Song_Scylla4b",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5759", Text = "Their past work was so much better...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "MusicPlayerSongName" },
					IsAny =
					{
						-- "Song_Scylla1a",
						-- "Song_Scylla1b",
						-- "Song_Scylla2a",
						-- "Song_Scylla2b",
						"Song_Scylla3a",
						"Song_Scylla3b",
						"Song_Scylla4a",
						"Song_Scylla4b",
					},
				},
			},
		},

	},
	{ GlobalVoiceLines = "ArtemisSongStoppedReactionVoiceLines" },
	{ GlobalVoiceLines = "OdysseusSongReactionVoiceLines" },
}

GlobalVoiceLines.WardedDoorVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		PlayOnceFromTableThisRun = true,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeExitAttemptSpeech", Time = 8 },
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
			},
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},

		{ Cue = "/VO/Melinoe_5694", Text = "Done with Typhon. Chronos next.", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "WardedDoorVO",
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_5558", Text = "Have to complete an incantation first...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeAltRunDoor" },
				},
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0561", Text = "Sealed as always...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0562", Text = "{#Emph}Ungh{#Prev}, these blasted wards...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_0561" }
				},
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2385", Text = "Can't right now." },
		{ Cue = "/VO/Melinoe_2386", Text = "Can't do it." },
		{ Cue = "/VO/Melinoe_3084", Text = "No use." },
		{ Cue = "/VO/Melinoe_3085", Text = "{#Emph}Ngh." },
		{ Cue = "/VO/Melinoe_3086", Text = "I wish.",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3087", Text = "Can't do it." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.05,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyMiscSpeech", Time = 12 },
		},

		{ Cue = "/VO/Skelly_0122", Text = "Cease messing with that thing!" },
	},
}
GlobalVoiceLines.EndTechTestVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		Cooldowns =
		{
			{ Name = "MelinoeExitAttemptSpeech", Time = 8 },
		},

		{ Cue = "/VO/Melinoe_0762", Text = "Blast..." },
		{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
		{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
		{ Cue = "/VO/Melinoe_1956", Text = "Damn it!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1957", Text = "Blood and...!" },
		{ Cue = "/VO/Melinoe_1954", Text = "What..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.66,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyAnyQuipSpeech", Time = 9 },
		},

		{ Cue = "/VO/Skelly_0388", Text = "Patience, young one!", PlayFirst = true },
		{ Cue = "/VO/Skelly_0327", Text = "Restrain yourself!" },
		{ Cue = "/VO/Skelly_0333", Text = "Please, young one!" },
		{ Cue = "/VO/Skelly_0334", Text = "Hey cut that out!" },
	},

}

-- resource interaction voice lines


GlobalVoiceLines.InsufficientMetaCurrencyVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				PathTrue = { "ActiveScreens", "MarketScreen" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeResourceInteractionSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_1857", Text = "Don't have the Bones.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1858", Text = "I'm short on Bones." },
	},
	{ GlobalVoiceLines = "InvalidResourceInteractionVoiceLines" },
}
GlobalVoiceLines.InvalidResourceInteractionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeResourceInteractionSpeech", Time = 6 },
		},

		{ Cue = "/VO/Melinoe_0386", Text = "I can't." },
		{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
		{ Cue = "/VO/Melinoe_0390", Text = "No use." },
		{ Cue = "/VO/Melinoe_0222", Text = "Can't." },
		{ Cue = "/VO/Melinoe_1847", Text = "Don't have enough for that.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1848", Text = "Don't have enough just yet.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1849", Text = "Don't have enough.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_1850", Text = "I need more than I have." },
		{ Cue = "/VO/Melinoe_1851", Text = "I'll have to get more." },
		{ Cue = "/VO/Melinoe_1852", Text = "Thought I had more..." },
		{ Cue = "/VO/Melinoe_1853", Text = "{#Emph}Hrm{#Prev}, not quite." },
		{ Cue = "/VO/Melinoe_1854", Text = "Afraid not..." },
		{ Cue = "/VO/Melinoe_1855", Text = "Denied." },
		{ Cue = "/VO/Melinoe_1856", Text = "Denied..." },
	},
}

GlobalVoiceLines.MelSighVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	UsePlayerSource = true,
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/Melinoe_2944", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_2945", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_0253", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_0432", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_1950", Text = "{#Emph}<Sigh>" },
}

GlobalVoiceLines.MiscEndVoiceLines_Hypnos =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		{ Cue = "/VO/Melinoe_1894", Text = "Rest well." },
		{ Cue = "/VO/Melinoe_1895", Text = "Be at peace, O Sleep." },
		{ Cue = "/VO/Melinoe_1896", Text = "May you have pleasant dreams.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1897", Text = "We'll sort this out..." },
	},
}
GlobalVoiceLines.MiscEndVoiceLines_Bouldy =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.75,

		-- { Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh...", PlayFirst = true },
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Charon =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.4,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,

		{ Cue = "/VO/Melinoe_1209", Text = "I shall, Lord Charon." },
		{ Cue = "/VO/Melinoe_1210", Text = "And you as well, Boatman." },
		{ Cue = "/VO/Melinoe_1211", Text = "Death to Chronos.",
			GameStateRequirements =
			{
				OrRequirements =
				{
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_1212", Text = "I know." },
		{ Cue = "/VO/Melinoe_1213", Text = "It is, indeed." },
		{ Cue = "/VO/Melinoe_1214", Text = "Oh, if only." },
	},
}

GlobalVoiceLines.BoonUsedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "ZeusUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },

		{ Cue = "/VO/Zeus_0113", Text = "I'm grateful." },
		{ Cue = "/VO/Zeus_0114", Text = "{#Emph}Ah{#Prev}, splendid!" },
		{ Cue = "/VO/Zeus_0115", Text = "Why thank you." },
		{ Cue = "/VO/Zeus_0116", Text = "How thoughtful!" },
		{ Cue = "/VO/Zeus_0117", Text = "Most excellent." },
		{ Cue = "/VO/Zeus_0118", Text = "This pleases me." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "HeraUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },

		{ Cue = "/VO/Hera_0138", Text = "Shrewdly decided." },
		{ Cue = "/VO/Hera_0139", Text = "No choice at all." },
		{ Cue = "/VO/Hera_0140", Text = "Well chosen, girl." },
		{ Cue = "/VO/Hera_0141", Text = "Bless you, my dear!" },
		{ Cue = "/VO/Hera_0142", Text = "How thoughtful." },
		{ Cue = "/VO/Hera_0143", Text = "We're a good match." },
		{ Cue = "/VO/Hera_0144", Text = "{#Emph}Excellent {#Prev}selection." },
		{ Cue = "/VO/Hera_0145", Text = "You made the right move." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "PoseidonUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },

		{ Cue = "/VO/Poseidon_0199", Text = "You made the correct choice!" },
		{ Cue = "/VO/Poseidon_0200", Text = "Your uncle's proud of you!" },
		{ Cue = "/VO/Poseidon_0201", Text = "That's my little niece!" },
		{ Cue = "/VO/Poseidon_0202", Text = "{#Emph}Hahaha{#Prev}, yes!" },
		{ Cue = "/VO/Poseidon_0203", Text = "You're wise beyond your years!" },
		{ Cue = "/VO/Poseidon_0204", Text = "Same thing I would have done!" },
		{ Cue = "/VO/Poseidon_0205", Text = "Flattery shall get you everywhere!" },
		{ Cue = "/VO/Poseidon_0241", Text = "Oh this is {#Emph}swell!" },
		{ Cue = "/VO/Poseidon_0242", Text = "Yes, {#Emph}haha!", PlayFirst = true },
		{ Cue = "/VO/Poseidon_0243", Text = "I am most pleased!" },
		{ Cue = "/VO/Poseidon_0244", Text = "That's my niece!" },
		{ Cue = "/VO/Poseidon_0245", Text = "Why, thanks!" },
		{ Cue = "/VO/Poseidon_0246", Text = "How thoughtful!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "ApolloUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },

		{ Cue = "/VO/Apollo_0125", Text = "I'm very much obliged." },
		{ Cue = "/VO/Apollo_0126", Text = "A brilliant choice." },
		{ Cue = "/VO/Apollo_0127", Text = "Why thank you kindly!" },
		{ Cue = "/VO/Apollo_0128", Text = "Music to my ears!" },
		{ Cue = "/VO/Apollo_0129", Text = "Wisely decided there." },
		{ Cue = "/VO/Apollo_0130", Text = "Discerning taste!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "DemeterUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },

		{ Cue = "/VO/Demeter_0125", Text = "Wise choice." },
		{ Cue = "/VO/Demeter_0126", Text = "Good pick." },
		{ Cue = "/VO/Demeter_0127", Text = "Like a breeze!" },
		{ Cue = "/VO/Demeter_0128", Text = "I'd not a doubt." },
		{ Cue = "/VO/Demeter_0129", Text = "Thank you, flower." },
		{ Cue = "/VO/Demeter_0130", Text = "My granddaughter..." },
		{ Cue = "/VO/Demeter_0131", Text = "We'll show them all." },
		{ Cue = "/VO/Demeter_0132", Text = "Plentiful." },
		{ Cue = "/VO/Demeter_0182", Text = "How sensible of you." },
		{ Cue = "/VO/Demeter_0183", Text = "My granddaughter." },
		{ Cue = "/VO/Demeter_0184", Text = "I'm proud of you.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "AphroditeUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },

		{ Cue = "/VO/Aphrodite_0104", Text = "You missed me, didn't you?" },
		{ Cue = "/VO/Aphrodite_0111", Text = "You're very sweet." },
		{ Cue = "/VO/Aphrodite_0112", Text = "Why, thank you!" },
		{ Cue = "/VO/Aphrodite_0113", Text = "How lovely!" },
		{ Cue = "/VO/Aphrodite_0114", Text = "I love it!" },
		{ Cue = "/VO/Aphrodite_0108", Text = "What do you desire?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "HephaestusUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Hephaestus_01", SubtitleColor = Color.HephaestusVoice },

		{ Cue = "/VO/Hephaestus_0156", Text = "Right smart of you!" },
		{ Cue = "/VO/Hephaestus_0157", Text = "Got a discerning eye." },
		{ Cue = "/VO/Hephaestus_0158", Text = "Good selection, that." },
		{ Cue = "/VO/Hephaestus_0159", Text = "What, really, {#Emph}me?", PlayFirst = true },
		{ Cue = "/VO/Hephaestus_0160", Text = "{#Emph}Oi! {#Prev}Coming right up!" },
		{ Cue = "/VO/Hephaestus_0161", Text = "Suit yourself, witchie!" },
		{ Cue = "/VO/Hephaestus_0162", Text = "Cheers!" },
		{ Cue = "/VO/Hephaestus_0163", Text = "{#Emph}Erm{#Prev}, cheers...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "HestiaUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },

		{ Cue = "/VO/Hestia_0090", Text = "Well isn't that sweet.", PlayFirst = true },
		{ Cue = "/VO/Hestia_0091", Text = "How wonderful." },
		{ Cue = "/VO/Hestia_0092", Text = "Ah thank you." },
		{ Cue = "/VO/Hestia_0093", Text = "Well now!" },
		{ Cue = "/VO/Hestia_0094", Text = "{#Emph}Oh-ho-ho!" },
		{ Cue = "/VO/Hestia_0095", Text = "Oh my." },
		{ Cue = "/VO/Hestia_0179", Text = "Smart girl!" },
		{ Cue = "/VO/Hestia_0180", Text = "Fine choice!" },
		{ Cue = "/VO/Hestia_0181", Text = "Into the fire!" },
		{ Cue = "/VO/Hestia_0182", Text = "Let's cook." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				Comparison = "==",
				Value = "AresUpgrade",
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			NamedRequirements = { "IsDevotionEncounter" },
		},
		Source = { LineHistoryName = "NPC_Ares_01", SubtitleColor = Color.AresVoice },

		{ Cue = "/VO/Ares_0114", Text = "How sensible." },
		{ Cue = "/VO/Ares_0115", Text = "Oh truly?" },
		{ Cue = "/VO/Ares_0116", Text = "{#Emph}Ah. {#Prev}Very good." },
		{ Cue = "/VO/Ares_0117", Text = "Most intriguing." },
		{ Cue = "/VO/Ares_0118", Text = "How diplomatic.", PlayFirst = true },
		{ Cue = "/VO/Ares_0119", Text = "A clever move." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = { "TrialUpgrade" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeBoonTakenSpeech", Time = 60 },
		},

		{ Cue = "/VO/MelinoeField_2045", Text = "By the will of {#Emph}Chaos...?", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/MelinoeField_2046", Text = "By the will of Chaos!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2047", Text = "Hail, Almighty Chaos...!" },
		{ Cue = "/VO/MelinoeField_2048", Text = "Chaos, I heard your call!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.15,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsNone = { "WeaponUpgrade", "StackUpgrade", "StackUpgradeBig", "StackUpgradeTriple", "SpellDrop", "TalentDrop", "MinorTalentDrop", "TalentBigDrop", "TrialUpgrade", "BlindBoxLoot" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "HermesFirstPickUp" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeBoonTakenSpeech", Time = 60 },
		},

		{ Cue = "/VO/Melinoe_0195", Text = "In the name of Hades." },
		{ Cue = "/VO/Melinoe_0196", Text = "In the name of Hades!" },
		{ Cue = "/VO/Melinoe_0197", Text = "Olympus, I accept this message." },
		{ Cue = "/VO/Melinoe_0198", Text = "Olympus, I accept this message!" },
		{ Cue = "/VO/Melinoe_0199", Text = "Hear me, on my authority!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.1,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsNone = { "WeaponUpgrade", "StackUpgrade", "StackUpgradeBig", "SpellDrop", "TalentDrop", },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_Bridge01" },
			},
		},
		ObjectType = "NPC_Echo_01",

		{ Cue = "/VO/Echo_0095", Text = "Accept this message! {#Echo1}This message! {#Prev}{#Echo2}This message!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_0197", "/VO/Melinoe_0198" },
				},
			},
		},
		{ Cue = "/VO/Echo_0096", Text = "On my authority! {#Echo1}Authority! {#Prev}{#Echo2}Authority!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_0199" },
				},
			},
		},
		{ Cue = "/VO/Echo_0097", Text = "The name of Hades! {#Echo1}Hades! {#Prev}{#Echo2}Hades!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_0195", "/VO/Melinoe_0196" },
				},
			},
		},
	},
}

GlobalVoiceLines.TalentDropUsedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeRewardPickUpSpeech", Time = 60 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	-- talentdrop: duo chosen
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		-- SuccessiveChanceToPlay = 0.5,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" },
			},
		},

		{ Cue = "/VO/Selene_0440", Text = "Zeus shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"PolymorphZeusTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0441", Text = "Your Path has led to Zeus.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"PolymorphZeusTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0442", Text = "Queen Hera shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"SummonHeraTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0443", Text = "Your Path has led to Hera.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"SummonHeraTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0444", Text = "Poseidon shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"PotionPoseidonTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0445", Text = "Your Path has led to Poseidon.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"PotionPoseidonTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0446", Text = "Demeter shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"TimeSlowDemeterTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0447", Text = "Your Path has led to Demeter.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"TimeSlowDemeterTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0448", Text = "Apollo shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"LaserApolloTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0449", Text = "Your Path has led to Apollo.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"LaserApolloTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0450", Text = "Aphrodite shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"TransformAphroditeTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0451", Text = "Your Path has led to Aphrodite.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"TransformAphroditeTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0452", Text = "Hephaestus shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"LeapHephaestusTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0453", Text = "Your Path has led to Hephaestus.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"LeapHephaestusTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0454", Text = "Hestia shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"MeteorHestiaTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0455", Text = "Your Path has led to Hestia.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"MeteorHestiaTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0456", Text = "Ares shall be notified at once.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"MoonBeamAresTalent",
					},
				},
			},
		},
		{ Cue = "/VO/Selene_0457", Text = "Your Path has led to Ares.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "AddedTraitNames", },
					HasAny =
					{
						"MoonBeamAresTalent",
					},
				},
			},
		},
	},

	-- talentdrop: max chosen
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.75,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			--[[ this doesn't get passed through CloseTalentScreenPresentation
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = { "TalentDrop", "MinorTalentDrop" },
			},
			]]--
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = GameData.AllRareTalents,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" },
			},
		},
		
		{ Cue = "/VO/Selene_0271", Text = "There at last." },
		{ Cue = "/VO/Selene_0272", Text = "The limits of my light." },
		{ Cue = "/VO/Selene_0273", Text = "Such terrifying might." },
		{ Cue = "/VO/Selene_0275", Text = "Thus you have risen." },
		{ Cue = "/VO/Selene_0276", Text = "Darkness guide you." },
		{ Cue = "/VO/Selene_0274", Text = "The Nightmare Bringer...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},
		},
	},
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		UsePlayerSource = true,
		-- SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			--[[ this doesn't get passed through CloseTalentScreenPresentation
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = { "TalentDrop", "MinorTalentDrop" },
			},
			]]--
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = GameData.AllRareTalents,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" },
			},
		},

		{ Cue = "/VO/MelinoeField_1677", Text = "I walked the Path..." },
		{ Cue = "/VO/MelinoeField_1678", Text = "The end of the Path.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1679", Text = "One with Selene..." },
		{ Cue = "/VO/MelinoeField_1680", Text = "The sheer might of the Moon..." },
	},

	-- talentdrop: other cases
	{
		RandomRemaining = true,
		PreLineWait = 0.75,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.75,
		GameStateRequirements =
		{
			--[[ this doesn't get passed through CloseTalentScreenPresentation
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = { "TalentDrop", "MinorTalentDrop" },
			},
			]]--
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" },
			},
		},

		{ Cue = "/VO/MelinoeField_1476", Text = "Selene's hidden strength..." },
		{ Cue = "/VO/MelinoeField_1478", Text = "Illumination..." },
		{ Cue = "/VO/MelinoeField_1475", Text = "The path across the sky..." },
		{ Cue = "/VO/MelinoeField_1477", Text = "With Selene's grace." },
		{ Cue = "/VO/MelinoeField_1479", Text = "The light of the Moon..." },
		{ Cue = "/VO/Melinoe_1665", Text = "With the grace of the Moon." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 1.0,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			--[[ this doesn't get passed through CloseTalentScreenPresentation
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = { "TalentDrop", "MinorTalentDrop" },
			},
			]]--
			{
				Path = { "GameState", "GamePhase", },
				Comparison = "~=",
				Value = 5,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" },
			},
		},

		{ Cue = "/VO/Selene_0263", Text = "Your path is set." },
		{ Cue = "/VO/Selene_0264", Text = "Shine ever brighter." },
		{ Cue = "/VO/Selene_0265", Text = "Together we shine." },
		{ Cue = "/VO/Selene_0266", Text = "The stars align." },
		{ Cue = "/VO/Selene_0267", Text = "By grace of Night..." },
		{ Cue = "/VO/Selene_0268", Text = "It is decided." },
		{ Cue = "/VO/Selene_0269", Text = "On to the next phase." },
		{ Cue = "/VO/Selene_0270", Text = "Into the dark..." },
	},
}
GlobalVoiceLines.CatGreetingVoiceLines =
{
	GameStateRequirements =
	{
		{
			PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	{
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "HubCatGreetingVO",
		UsePlayerSource = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		SuccessiveChanceToPlay = 0.25,
		SuccessiveChanceToPlayAll = 0.25,
		SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_4841" },
			},
		},

		{ Cue = "/VO/Melinoe_4842", Text = "Hi, kitties.", PostLineFunctionName = "AmbientCatsSmallReaction" },
		{ Cue = "/VO/Melinoe_4843", Text = "Hi, kitties...", PostLineFunctionName = "AmbientCatsSmallReaction" },
	},
	{ GlobalVoiceLines = "CritterGreetingVoiceLines" },
}
GlobalVoiceLines.CritterGreetingVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	PlayOnceContext = "HubCritterGreetingVO",
	UsePlayerSource = true,
	RandomRemaining = true,
	PreLineWait = 0.15,
	SuccessiveChanceToPlay = 0.75,
	SuccessiveChanceToPlayAll = 0.5,
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_4148", Text = "Hello, friends." },
	{ Cue = "/VO/Melinoe_4149", Text = "Hi, gang.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_4150", Text = "Hello." },
	{ Cue = "/VO/Melinoe_4151", Text = "Hi everyone." },
	{ Cue = "/VO/Melinoe_4152", Text = "Hi there." },
	{ Cue = "/VO/Melinoe_4153", Text = "Evening." },
}
GlobalVoiceLines.ThankingCharacterVoiceLines =
{
	UsePlayerSource = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_0651_B", Text = "Thank you." },
	{ Cue = "/VO/Melinoe_0764_B", Text = "Thank you!" },
	{ Cue = "/VO/Melinoe_0765_B", Text = "Thank you." },
	{ Cue = "/VO/Melinoe_0767_B", Text = "Thanks..." },
}
GlobalVoiceLines.ThankingIcarusVoiceLines =
{
	UsePlayerSource = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlay = 0.5,
	GameStateRequirements =
	{
		{
			PathFalse = { "CurrentRun", "Hero", "IsDead" }
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_0651", Text = "Thank you." },
	{ Cue = "/VO/Melinoe_0764", Text = "Thank you!" },
	{ Cue = "/VO/Melinoe_0765", Text = "Thank you." },
	{ Cue = "/VO/Melinoe_0767", Text = "Thanks..." },
	{ Cue = "/VO/MelinoeField_2579", Text = "I'm grateful, Icarus.", PlayOnceThisRun = true },
	{ Cue = "/VO/MelinoeField_2581", Text = "Cheers, Icarus...", PlayOnceThisRun = true },
}
GlobalVoiceLines.ThankingAthenaVoiceLines =
{
	{
		UsePlayerSource = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		SkipCooldownCheckIfNonePlayed = true,
		SuccessiveChanceToPlay = 0.75,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Athena_01", }, Alive = true },
			},
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsAny = { "NPC_Athena_01" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_2570", Text = "Thank you, my lady.", PlayFirst = true, },
		{ Cue = "/VO/MelinoeField_2571", Text = "I'm most grateful.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0651_B", Text = "Thank you." },
		{ Cue = "/VO/Melinoe_0764_B", Text = "Thank you!" },
		{ Cue = "/VO/Melinoe_0765_B", Text = "Thank you." },
		{ Cue = "/VO/Melinoe_0767_B", Text = "Thanks..." },
	},
}
GlobalVoiceLines.ThankingDionysusVoiceLines =
{
	{
		UsePlayerSource = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		SkipCooldownCheckIfNonePlayed = true,
		SuccessiveChanceToPlay = 0.75,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Dionysus_01", }, Alive = true },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_2574", Text = "Cheers for that.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2575", Text = "Well, have a good evening...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0651_B", Text = "Thank you." },
		{ Cue = "/VO/Melinoe_0764_B", Text = "Thank you!" },
		{ Cue = "/VO/Melinoe_0765_B", Text = "Thank you." },
		{ Cue = "/VO/Melinoe_0767_B", Text = "Thanks..." },
	},
}
GlobalVoiceLines.ThankingHadesVoiceLines =
{
	{
		UsePlayerSource = true,
		PreLineWait = 0.45,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.75,
		SuccessiveChanceToPlayAll = 0.75,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Story01" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_1529", Text = "You honor me." },
		{ Cue = "/VO/MelinoeField_1530", Text = "I shall return..." },
		{ Cue = "/VO/MelinoeField_1532", Text = "For our family." },
		{ Cue = "/VO/MelinoeField_4784", Text = "Thank you two.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Persephone_01" } },
				},
			},
		},

		{ Cue = "/VO/MelinoeField_4785", Text = "Thank you both.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Persephone_01" } },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4787", Text = "You two be well.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Persephone_01" } },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4786", Text = "See you again.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Persephone_01" } },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1525", Text = "Thank you, Father.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Persephone_01" }, Alive = false },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1526", Text = "It won't be for naught.",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1527", Text = "Hold on, Father...",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1528", Text = "Cerberus, take care of him, OK...?",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 506405 }, },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1531", Text = "You'll be avenged.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathFalse = { "GameState", "TextLinesRecord", "HadesAboutUltimateProgress03" },
				},
			},
		},
	},
}
GlobalVoiceLines.DarknessUnlockedVoiceLines =
{
	{
		UsePlayerSource = true,
		PreLineWait = 1.1,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{ Cue = "/VO/MelinoeField_1053", Text = "Pure Darkness... I'm grateful for this gift." },
	}
}
GlobalVoiceLines.ChaosSeedsUnlockedVoiceLines =
{
	{
		UsePlayerSource = true,
		PreLineWait = 1.3,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{ Cue = "/VO/MelinoeField_1054", Text = "This can grow into exactly what I need..." },
	}
}
GlobalVoiceLines.ThankingChaosVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.1,

		{ Cue = "/VO/Melinoe_0765_B", Text = "Thank you." },
		{ Cue = "/VO/MelinoeField_1012", Text = "I'm grateful." },
		{ Cue = "/VO/MelinoeField_0779", Text = "Almighty Chaos..." },
	},
}

GlobalVoiceLines.FoundRareBoonVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeFoundRareBoonSpeechPlayed", Time = 400 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineWait = 1.05,
		GameStateRequirements =
		{
			{
				--
			},
			{
				FunctionName = "RequiredRarityInRoom",
				FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
			},
		},

		{ Cue = "/VO/Melinoe_1960", Text = "{#Emph}Oh...!" },
		{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
		{ Cue = "/VO/Melinoe_1962", Text = "{#Emph}Ooh!" },
		-- { Cue = "/VO/Melinoe_1963", Text = "{#Emph}Hoh..." },
		{ Cue = "/VO/Melinoe_1964", Text = "{#Emph}Hmm!" },
		{ Cue = "/VO/Melinoe_1965", Text = "{#Emph}Whew..." },
	},
}

GlobalVoiceLines.DemeterFatalityVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },

		{ Cue = "/VO/Demeter_0147", Text = "{#Emph}Back to dust!", PlayFirst = true },
		{ Cue = "/VO/Demeter_0148", Text = "{#Emph}Cold as death!" },
		{ Cue = "/VO/Demeter_0149", Text = "{#Emph}Ripe for the harvest!" },
		{ Cue = "/VO/Demeter_0150", Text = "{#Emph}Reap what you sow!" },
		{ Cue = "/VO/Demeter_0151", Text = "{#Emph}Cut short!" },
		{ Cue = "/VO/Demeter_0152", Text = "{#Emph}Rooted out!" },
	},
}

-- Devotion Scripts
GlobalVoiceLines.DevotionChoicePresentedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,

	GameStateRequirements =
	{
		-- None
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1260", Text = "Aid from two relatives at once?", PlayFirst = true, PlayOnce = true },
	{ Cue = "/VO/Melinoe_1261", Text = "The gods and their petty squabbles..." },
	{ Cue = "/VO/Melinoe_1262", Text = "Choose one, spurn the other..." },
	{ Cue = "/VO/Melinoe_1263", Text = "Can't they form an orderly queue?" },
	{ Cue = "/VO/Melinoe_1264", Text = "Whom to upset this time?" },
}
GlobalVoiceLines.GodRejectedVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		UsePlayerSource = true,
		PlayOnce = true,
		PlayOnceContext = "FirstDevotionTest",

		{ Cue = "/VO/Melinoe_1265", Text = "Wait, what?" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "ZeusUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1266", Text = "Lord Uncle, I meant no offense." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "HeraUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1268", Text = "Forgive me, Queen Hera." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "PoseidonUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1267", Text = "I'm sorry, Uncle Poseidon." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "ApolloUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1270", Text = "Nothing personal, Cousin." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "DemeterUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1271", Text = "Please understand, Grandmother." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "HestiaUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1269", Text = "Sorry, Great-Auntie!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "AphroditeUpgrade" },
			},
		},

		{ Cue = "/VO/Melinoe_1272", Text = "Don't hate me, Aphrodite?" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "HephaestusUpgrade" },
			},
		},

		{ Cue = "/VO/MelinoeField_3038", Text = "Hephaestus, don't be mad..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.65,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
				IsAny = { "AresUpgrade" },
			},
		},

		{ Cue = "/VO/MelinoeField_3039", Text = "Is this what you want, Ares?", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3040", Text = "Care for a fight, Ares?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.65,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_1273", Text = "I mean no disrespect..." },
		{ Cue = "/VO/Melinoe_1274", Text = "We fickle gods..." },
		{ Cue = "/VO/Melinoe_1275", Text = "Had to do it..." },
		{ Cue = "/VO/MelinoeField_2366", Text = "Had to do it..." },
		{ Cue = "/VO/MelinoeField_2367", Text = "Let's take it easy now..." },
		{ Cue = "/VO/MelinoeField_2368", Text = "Sorry...!" },
		{ Cue = "/VO/MelinoeField_2369", Text = "Well here we go." },
		{ Cue = "/VO/MelinoeField_2370", Text = "Here he comes...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
					IsAny = { "ZeusUpgrade", "PoseidonUpgrade", "ApolloUpgrade", "HephaestusUpgrade" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2371", Text = "Here she comes...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
					IsAny = { "HeraUpgrade", "DemeterUpgrade", "AphroditeUpgrade", "HestiaUpgrade" },
				},
			},
		},

	},
}

GlobalVoiceLines.ForkingPathVoiceLines =
{
	Queue = "Never",
	{
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.15,
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I" },
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "MapState", "OfferedRewardPreviewTypes" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
			},

			{ Cue = "/VO/MelinoeField_1561", Text = "Could head straight for Chronos, or...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1562", Text = "He'll send more and more foes the longer I stay...", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1561" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1563", Text = "Worth taking the longer route...?" },
			{ Cue = "/VO/MelinoeField_1564", Text = "Do I risk straying from the shortest route?" },
			{ Cue = "/VO/MelinoeField_1544", Text = "Best not stay any longer than I must..." },
		},
		-- underworld route, new maps
		{
			PlayOnce = true,
			PlayOnceContext = "NewUnderworldRunAltStart",
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Opening01", "F_Opening02", "F_Opening03" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 }
			},

			{ Cue = "/VO/Melinoe_1390", Text = "Looks like a new path out...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered", "F_Opening02" },
						Comparison = "==",
						Value = 1,
					},
				},
			},
			{ Cue = "/VO/Melinoe_1392", Text = "Let's head this way this time...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered", "F_Opening03" },
						Comparison = "==",
						Value = 1,
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "F_Opening01", "F_Opening02" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1391", Text = "Other path this time...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Opening01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "F_Opening02" },
						Comparison = "==",
						Value = 1,
					},
					{
						Path = { "GameState", "RoomsEntered", "F_Opening03" },
						Comparison = "==",
						Value = 1,
					},
					{
						Path = { "GameState", "RoomsEntered" },
						HasAll = { "F_Opening02", "F_Opening03" },
					},
				},
			},
		},
		-- standard Erebus cases
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.15,
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "ArtemisCombatIntro", "ArtemisCombatF" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Opening01", "F_Opening02", "F_Opening03" },
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Opening01", "F_Opening02", "F_Opening03" },
				},
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = "<=",
					Value = 25,
				},
			},

			{ Cue = "/VO/Melinoe_0254", Text = "Where to..." },
			{ Cue = "/VO/Melinoe_0255", Text = "Split path..." },
			{ Cue = "/VO/Melinoe_0256", Text = "Which way..." },
			{ Cue = "/VO/Melinoe_0245", Text = "So..." },
			{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
			{ Cue = "/VO/Melinoe_0336", Text = "Where to go..." },
			{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
			{ Cue = "/VO/Melinoe_0338", Text = "Which way..." },
		},
	},
}
GlobalVoiceLines.RecordRunDepthVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.5,
	Cooldowns =
	{
		{ Name = "MelExitVoiceLines", Time = 20 },
		{ Name = "MelinoeAnyQuipSpeech", Time = 5 }
	},
	GameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathFalse = { "GameState", "RoomCountCache", "I_Intro" },
		},
		{
			PathFalse = { "PrevRun", "Cleared" }
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "Secrets", },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "F_PreBoss01", "F_Boss01", "F_Boss02", "F_PostBoss01", "G_Intro", "G_PreBoss01", "G_Boss01", "G_Boss02", "G_PostBoss01", "H_Intro", "H_PreBoss01", "H_Boss01", "H_Boss02", "H_PostBoss01", "I_Intro", "I_Story01", "I_PreBoss01", "I_PreBoss02", "I_Boss01", "N_Opening01", "N_PreBoss01", "N_Boss01", "N_Boss02", "N_PostBoss01", "O_Intro", "O_PreBoss01", "O_Boss01", "O_Boss02", "O_PostBoss01", "P_PreBoss01", "P_Boss01", "P_PostBoss01" },
		},
	},

	{ Cue = "/VO/Melinoe_0339", Text = "I've come this far..." },
	{ Cue = "/VO/Melinoe_0340", Text = "Farther than last time.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_0341", Text = "I'm getting farther." },
	{ Cue = "/VO/MelinoeField_1337", Text = "Farther than before..." },
	{ Cue = "/VO/MelinoeField_1338", Text = "One step closer..." },
	{ Cue = "/VO/MelinoeField_1339", Text = "Little by little..." },
}
GlobalVoiceLines.EnteredReprieveRoomVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Reprieve01" },
			},
		},

		{ Cue = "/VO/MelinoeField_0280", Text = "My incantation must have led me to this place..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Reprieve01" },
			},
		},

		{ Cue = "/VO/MelinoeField_0281", Text = "Must be the chamber that my spell revealed..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Reprieve01" },
			},
		},

		{ Cue = "/VO/MelinoeField_1533", Text = "I can access this old fountain chamber now..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Reprieve01" },
			},
		},

		{ Cue = "/VO/MelinoeField_1902", Text = "This is the hidden isle I revealed..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Reprieve01" },
			},
		},

		{ Cue = "/VO/MelinoeField_2530", Text = "Must be the mountain pass my incantation helped me find..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.85,
		SuccessiveChanceToPlay = 0.33,

		{ Cue = "/VO/Melinoe_1121", Text = "...It's quiet..." },
		{ Cue = "/VO/Melinoe_1123", Text = "Clear..." },
		{ Cue = "/VO/Melinoe_1124", Text = "No threats nearby..." },
		{ Cue = "/VO/Melinoe_1125", Text = "Fountain chamber...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G", "I", "P", "Q" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1126", Text = "This place again..." },
		{ Cue = "/VO/Melinoe_1127", Text = "Breathe, Mel..." },
		{ Cue = "/VO/Melinoe_1128", Text = "Thank the Fates..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		ChanceToPlay = 0.25,
		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
			},
			NamedRequirements = { "NoRecentInspectPointUsed" },
		},

		{ Cue = "/VO/Storyteller_0107", Text = "{#Emph}A brief respite awaits..." },
		{ Cue = "/VO/Storyteller_0108", Text = "{#Emph}Her foes are nowhere to be found..." },
		{ Cue = "/VO/Storyteller_0109", Text = "{#Emph}A moment of reprieve..." },
		{ Cue = "/VO/Storyteller_0110", Text = "{#Emph}The welcome solitude..." },
		{ Cue = "/VO/Storyteller_0392", Text = "{#Emph}Here it is safe and quiet..." },
		{ Cue = "/VO/Storyteller_0393", Text = "{#Emph}A place of momentary comfort..." },
		{ Cue = "/VO/Storyteller_0394", Text = "{#Emph}There is no danger here..." },
		{ Cue = "/VO/Storyteller_0395", Text = "{#Emph}Life-giving waters, just ahead..." },
		{ Cue = "/VO/Storyteller_0396", Text = "{#Emph}The soothing waters of a fountain..." },
		{ Cue = "/VO/Storyteller_0397", Text = "{#Emph}A fleeting sense of peace..." },
		{ Cue = "/VO/Storyteller_0398", Text = "{#Emph}Again, this moonlit grove in Erebus...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0399", Text = "{#Emph}Within these winding woods, a place of rest...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0400", Text = "{#Emph}Fresh water so deep in the sea...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "G_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0401", Text = "{#Emph}No trace of horrid lurkers of the deep...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "G_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0402", Text = "{#Emph}That ancient fountain chamber, once again...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0403", Text = "{#Emph}Her brother drank these waters many times...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0404", Text = "{#Emph}A clear spring in the Rift of Thessaly...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0405", Text = "{#Emph}This peaceful little isle in the Rift...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0406", Text = "{#Emph}The hidden spring within Olympus...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "P_Reprieve01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0407", Text = "{#Emph}These purest waters from the mountaintop...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "P_Reprieve01" },
				},
			},
		},
	},
}

GlobalVoiceLines.BoardedFlagshipVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.45,
		SuccessiveChanceToPlay = 0.5,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_1848", Text = "The Black Flagship...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1849", Text = "Lord Charon's ship..." },
		{ Cue = "/VO/MelinoeField_1850", Text = "End of the line.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_PreBoss01"},
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1851", Text = "The foremost ship...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_PreBoss01"},
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1852", Text = "The front of the fleet...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_PreBoss01"},
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1853", Text = "Solid ground ahead...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_PreBoss01"},
				},
			},
		},
	},
}

GlobalVoiceLines.MiniBossEncounterStartVoiceLines =
{
	GameStateRequirements =
	{
		-- handled in GlobalVoiceLines.CharybdisEncounterStartVoiceLines
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "MiniBossCharybdis" },
		},
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.5,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			NamedRequirements = { "MinibossCountShrineUpgradeActive" },
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/MelinoeField_2754", Text = "The Vow of Shadow took effect, I see..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.2,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossTreant" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/Melinoe_1003", Text = "A Root-Stalker...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1004", Text = "This one again..." },
		{ Cue = "/VO/MelinoeField_3717", Text = "Go back beneath the Earth." },
		{ Cue = "/VO/MelinoeField_3720", Text = "Still rooted here I see.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Treant" },
					Comparison = ">=",
					Value = 2,
				},
			}
		},
		{ Cue = "/VO/MelinoeField_3719", Text = "Grown back, have you?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Treant" },
					Comparison = ">=",
					Value = 3,
				},
			}
		},
		{ Cue = "/VO/MelinoeField_0249", Text = "You don't know who you're dealing with...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Treant" },
					Comparison = ">=",
					Value = 3,
				},
			}
		},
		{ Cue = "/VO/MelinoeField_3718", Text = "You can't stop me anymore.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastKilledByName" },
					IsNone = { "Treant", "Treant2" },
				},
				{
					Path = { "GameState", "EnemyKills", "Treant" },
					Comparison = ">=",
					Value = 6,
				},
			}
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossAssassin" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/MelinoeField_3698", Text = "...You're a long way from Ephyra.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3696", Text = "A Cutthroat came especially for me..." },
		{ Cue = "/VO/MelinoeField_3699", Text = "The Master-Slicer returns." },
		{ Cue = "/VO/MelinoeField_3700", Text = "Shall we cross blades again?" },
		{ Cue = "/VO/MelinoeField_3701", Text = "Chronos must reward you handsomely.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3696" }
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
	},

	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossFogEmitter" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/Melinoe_1635", Text = "That gloom... a Shadow-Spiller...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1636", Text = "Shadow-Spiller..." },
		{ Cue = "/VO/Melinoe_1637", Text = "The Shadow-Spiller's back..." },
		{ Cue = "/VO/Melinoe_1638", Text = "Those shadows..." },
		{ Cue = "/VO/MelinoeField_1044", Text = "Shadow-Spiller...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.2,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossWaterUnit" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/MelinoeField_0160", Text = "Now {#Emph}that's {#Prev}a Sea-Serpent.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersOccurredCache", "WaterUnitIntro" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_0161", Text = "You're in my way." },
		{ Cue = "/VO/MelinoeField_0162", Text = "This isn't your domain.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0163", Text = "Remember me, Serpent?" },
		{ Cue = "/VO/MelinoeField_0164", Text = "You ought have stayed below." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.2,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossJellyfish" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/MelinoeField_3017", Text = "A swarm of Hellifish...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3018", Text = "More of those Hellifish..." },
		{ Cue = "/VO/MelinoeField_3019", Text = "Hello, Hellifish..." },
		{ Cue = "/VO/MelinoeField_3020", Text = "Get your tentacles away from me." },
		{ Cue = "/VO/MelinoeField_3021", Text = "Go float someplace else." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossLamia" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/MelinoeField_1117", Text = "Queen Lamia herself...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1118", Text = "They think they caught a live one." },
		{ Cue = "/VO/MelinoeField_1119", Text = "All you lot against me?" },
		{ Cue = "/VO/MelinoeField_1120", Text = "Your magick against mine!" },
		{ Cue = "/VO/MelinoeField_1121", Text = "Oh don't you hiss at me!" },
		{ Cue = "/VO/MelinoeField_1122", Text = "Queen Lamia returns..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossVampire" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/MelinoeField_1128", Text = "A Phantom lair!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1129", Text = "The Phantom..." },
		{ Cue = "/VO/MelinoeField_1130", Text = "Out of the way, Phantom." },
		{ Cue = "/VO/MelinoeField_1131", Text = "Just try and take my blood!" },
		{ Cue = "/VO/MelinoeField_1132", Text = "My blood is not for you!" },
		{ Cue = "/VO/MelinoeField_1133", Text = "Thirsty for more are we?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossRatCatcher" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{ Cue = "/VO/MelinoeField_1610", Text = "That's a substantial Satyr...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1611", Text = "That massive Satyr's back...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossRatCatcher" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1612", Text = "The Verminancer..." },
		{ Cue = "/VO/MelinoeField_1613", Text = "The Verminancer's back, is he...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossRatCatcher" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1614", Text = "One of the leaders of this Satyr cult..." },
		{ Cue = "/VO/MelinoeField_1615", Text = "Best keep your rodents to yourself!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossGoldElemental" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{ Cue = "/VO/MelinoeField_1620", Text = "A Goldwrath...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1621", Text = "Are you how Chronos gets his gold?" },
		{ Cue = "/VO/MelinoeField_1622", Text = "Come on, Goldwrath!" },
		{ Cue = "/VO/MelinoeField_1623", Text = "Let's go you sack of filth!" },
		{ Cue = "/VO/MelinoeField_1624", Text = "Oh great, the treasury..." },
		{ Cue = "/VO/MelinoeField_1625", Text = "Found the treasury..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.33,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossSatyrCrossbow" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},

		{ Cue = "/VO/Melinoe_1008", Text = "Death to the servants of Chronos!",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},
		{ Cue = "/VO/MelinoeField_0249", Text = "You don't know who you're dealing with..." },
		{ Cue = "/VO/MelinoeField_0467", Text = "A champion of Chronos...!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},
		{ Cue = "/VO/MelinoeField_0468", Text = "No mercy for servants of the Titan...!",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},
		{ Cue = "/VO/MelinoeField_0469", Text = "I'll send your soul into the depths of hell." },
		{ Cue = "/VO/MelinoeField_0470", Text = "Are you the Satyr currently in charge?" },
		{ Cue = "/VO/MelinoeField_0471", Text = "This city belongs to the mortals...!" },
		{ Cue = "/VO/MelinoeField_0472", Text = "Let this be a message to your lord!",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			}
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.45,
		SuccessiveChanceToPlayAll = 0.33,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossCaptain" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{ Cue = "/VO/MelinoeField_3142", Text = "Now there's a seasoned sailor...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3143", Text = "Back for another voyage, Captain?" },
		{ Cue = "/VO/MelinoeField_3144", Text = "I'm commandeering this vessel!" },
		{ Cue = "/VO/MelinoeField_3145", Text = "Looks like you have a stowaway, Captain!" },
		{ Cue = "/VO/MelinoeField_3146", Text = "I'll run this blasted ship aground!" },
		{ Cue = "/VO/MelinoeField_3147", Text = "You'll soon sail back to hell." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossDragon" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{ Cue = "/VO/MelinoeField_2616", Text = "A Dracon of that size? And serving Chronos too...", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/MelinoeField_2617", Text = "Best use those wings to fly away, Dracon!" },
		{ Cue = "/VO/MelinoeField_2618", Text = "You Dracons ought to choose wiser alliances." },
		{ Cue = "/VO/MelinoeField_2619", Text = "Soon you shall be afraid of me, Dracon." },
		{ Cue = "/VO/MelinoeField_2620", Text = "Not had enough of me, Dracon?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossBrute" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{ Cue = "/VO/MelinoeField_2957", Text = "That's... gods...!", PlayFirst = true, PlayOnce = true, PlayOnceContext = "TyphonBruteIntroVO" },
		{ Cue = "/VO/MelinoeField_3006", Text = "One of Typhon's broodlings...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3007", Text = "You've got your father's looks...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3008", Text = "You're one of Typhon's bigger children aren't you.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3009", Text = "That broodling again...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3010", Text = "It's that broodling... or a twin?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.25,
		RecheckRequirementsPostWait = true,
		RecheckRequirementsForSubLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossStalker" },
			},
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{ Cue = "/VO/MelinoeField_3132", Text = "You two appear well-fed...", PlayFirst = true, },
		{ Cue = "/VO/MelinoeField_3133", Text = "These two again." },
		{ Cue = "/VO/MelinoeField_3134", Text = "These two again? Or two just like the rest.",
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3133" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3135", Text = "You two get along quite well for twins." },
		{ Cue = "/VO/MelinoeField_3136", Text = "I don't like either one of you." },
		{ Cue = "/VO/MelinoeField_0249", Text = "You don't know who you're dealing with..." },
	},
	{ GlobalVoiceLines = "MiniBossEncounterMiscStartLines" },
	{ GlobalVoiceLines = "CombatBeginsVoiceLines" },
}
GlobalVoiceLines.MiniBossEncounterMiscStartLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.76,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	GameStateRequirements =
	{
		{
			PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
		},
	},
	{ Cue = "/VO/MelinoeField_0682", Text = "Ah, yes." },
	{ Cue = "/VO/MelinoeField_0683", Text = "This again." },
	{ Cue = "/VO/MelinoeField_0684", Text = "Let's begin...!" },
	{ Cue = "/VO/MelinoeField_0685", Text = "Let's go, then." },
	{ Cue = "/VO/MelinoeField_0686", Text = "You and me...!" },
	{ Cue = "/VO/MelinoeField_0687", Text = "I've returned." },
	{ Cue = "/VO/MelinoeField_0688", Text = "You won't stop me." },
	{ Cue = "/VO/MelinoeField_0689", Text = "I'm back." },
}

GlobalVoiceLines.MiniBossEncounterEndVoiceLines =
{
	Cooldowns = { { Name = "LootDroppedSpeech", Time = 30 }, },
	{
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "SpawnsSkipped" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossTreant" },
				},
			},

			{ Cue = "/VO/Melinoe_1005", Text = "Foul spirit.", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_1006", Text = "Go haunt some other glade.", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_0999", Text = "Got you." },
			{ Cue = "/VO/Melinoe_1000", Text = "Done." },
			{ Cue = "/VO/Melinoe_1001", Text = "Enough." },
			{ Cue = "/VO/Melinoe_1002", Text = "{#Emph}Whew." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossFogEmitter" },
				},
			},

			{ Cue = "/VO/Melinoe_1639", Text = "Back to the dark with you.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1640", Text = "It's clear again..." },
			{ Cue = "/VO/Melinoe_1641", Text = "Such rage it must have felt..." },
			{ Cue = "/VO/Melinoe_1642", Text = "It's gone..." },
			{ Cue = "/VO/Melinoe_1643", Text = "Detest that thing..." },
			{ Cue = "/VO/Melinoe_1644", Text = "The shadows dissipate..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossAssassin" },
				},
			},

			{ Cue = "/VO/MelinoeField_3702", Text = "...And here your soul shall stay.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3703", Text = "I'll not fall to some hired thug." },
			{ Cue = "/VO/MelinoeField_3704", Text = "Whatever you were paid was not enough." },
			{ Cue = "/VO/MelinoeField_3705", Text = "Your little plan to slay me backfired." },
			{ Cue = "/VO/MelinoeField_3706", Text = "You should have stayed up top." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossWaterUnit" },
				},
			},

			{ Cue = "/VO/MelinoeField_0165", Text = "Took me for simple prey." },
			{ Cue = "/VO/MelinoeField_0167", Text = "Out with you, serpent." },
			{ Cue = "/VO/MelinoeField_0168", Text = "Stick to the seas next time.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0169", Text = "Hideous thing..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.5,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossJellyfish" },
				},
			},

			{ Cue = "/VO/MelinoeField_3022", Text = "...I can sting too.", PreLineWait = 1.5 },
			{ Cue = "/VO/MelinoeField_3023", Text = "These always grow back..." },
			{ Cue = "/VO/MelinoeField_3024", Text = "Too much squirming." },
			{ Cue = "/VO/MelinoeField_3025", Text = "Your place is out at sea.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3026", Text = "...Squish.", PreLineWait = 1.5 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.5,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossLamia" },
				},
			},

			{ Cue = "/VO/MelinoeField_1123", Text = "That's enough slithering about..." },
			{ Cue = "/VO/MelinoeField_1124", Text = "Venomous fiends.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1125", Text = "I'll cast you out each time." },
			{ Cue = "/VO/MelinoeField_1126", Text = "Crude sorcery at best." },
			{ Cue = "/VO/MelinoeField_1127", Text = "I usually like snakes..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.5,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossVampire" },
				},
			},

			{ Cue = "/VO/MelinoeField_1134", Text = "Drink {#Emph}that {#Prev}up." },
			{ Cue = "/VO/MelinoeField_1135", Text = "Phantoms, begone..." },
			{ Cue = "/VO/MelinoeField_1136", Text = "How many mortals have you tormented?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1137", Text = "They won't be gone for long..." },
			{ Cue = "/VO/MelinoeField_1138", Text = "All banished for now..." },
			{ Cue = "/VO/MelinoeField_1139", Text = "No blood where you're going." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossRatCatcher" },
				},
			},
			{ Cue = "/VO/MelinoeField_1616", Text = "Your master will fare no better.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1617", Text = "Traitorous wretch." },
			{ Cue = "/VO/MelinoeField_1618", Text = "Good riddance..." },
			{ Cue = "/VO/MelinoeField_1619", Text = "{#Emph}Eugh{#Prev}, that {#Emph}stench..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossGoldElemental" },
				},
			},
			{ Cue = "/VO/MelinoeField_1626", Text = "Where does Chronos find these things..." },
			{ Cue = "/VO/MelinoeField_1627", Text = "Melted down." },
			{ Cue = "/VO/MelinoeField_1628", Text = "I much prefer silver..." },
			{ Cue = "/VO/MelinoeField_1629", Text = "Not losing to a {#Emph}bag...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1630", Text = "Who needs Gold anyway..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossSatyrCrossbow" },
				},
			},

			{ Cue = "/VO/MelinoeField_0473", Text = "Your soul be damned, traitor.", PlayFirst = true, },
			{ Cue = "/VO/MelinoeField_0474", Text = "You chose the wrong side." },
			{ Cue = "/VO/MelinoeField_0475", Text = "Another night, another Satyr slaughtered." },
			{ Cue = "/VO/MelinoeField_0476", Text = "I look forward to meeting your replacement." },
			{ Cue = "/VO/MelinoeField_0477", Text = "For Ephyra." },
			{ Cue = "/VO/MelinoeField_0478", Text = "For Olympus." },

			{ Cue = "/VO/Melinoe_1009", Text = "One less traitor." },
			{ Cue = "/VO/Melinoe_0999", Text = "Got you." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossBoar" },
				},
			},

			{ Cue = "/VO/MelinoeField_3713", Text = "You ought to be at rest." },
			{ Cue = "/VO/MelinoeField_3714", Text = "Peace, Spirit." },
			{ Cue = "/VO/MelinoeField_3715", Text = "Now calm yourself, Spirit." },
			{ Cue = "/VO/MelinoeField_3716", Text = "Let go your rage, Spirit.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3712", Text = "If Heracles could handle it...",
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "HeraclesAboutBoar01" },
					},
					{
						PathTrue = { "GameState", "EncountersCompletedCache", "HeraclesCombatN" },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossCaptain" },
				},
			},
			{ Cue = "/VO/MelinoeField_3148", Text = "May this be your final voyage for a while." },
			{ Cue = "/VO/MelinoeField_3149", Text = "I'll take the helm from here." },
			{ Cue = "/VO/MelinoeField_3150", Text = "The sea claims another." },
			{ Cue = "/VO/MelinoeField_3151", Text = "Are all sailors as surly as that one?" },
			{ Cue = "/VO/MelinoeField_3152", Text = "Are all sailors as salty as that one?" },
			{ Cue = "/VO/MelinoeField_3153", Text = "Enjoy Poseidon's depths.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3154", Text = "You're sunk, Yargonaut." },
		},
		-- occurs via GenericBossKillPresentation
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.55,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossCharybdis" },
				},
			},
			{ Cue = "/VO/MelinoeField_1866", Text = "You'll soon be back for more, won't you?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1868", Text = "Don't get in my way." },
			{ Cue = "/VO/MelinoeField_1871", Text = "Drove it away for now..." },
			{ Cue = "/VO/MelinoeField_1870", Text = "How many ships have fallen in that maw?",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1839" },
							},
							{
								SumPrevRuns = 8,
								Path = { "SpeechRecord", "/VO/MelinoeField_1839" },
								CountPathTrue = true,
								Comparison = "<=",
								Value = 0,
							},
						},
						{
							{
								PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1839" },
							},
						},
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1869", Text = "Tell Scylla I said {#Emph}hi.",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight01" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1867", Text = "That's for Odysseus and his crew.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutCharybdis01" }
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossTalos" },
				},
			},

			{ Cue = "/VO/MelinoeField_2474", Text = "What did he take me for?" },
			{ Cue = "/VO/MelinoeField_2475", Text = "Mindless machinery and nothing more.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2476", Text = "Probably took me for a Harpy or something." },
			{ Cue = "/VO/MelinoeField_2477", Text = "Another unfortunate misunderstanding." },
			{ Cue = "/VO/MelinoeField_2478", Text = "Save it for Prometheus next time." },
			{ Cue = "/VO/MelinoeField_2479", Text = "You picked the wrong target." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossDragon" },
				},
			},

			{ Cue = "/VO/MelinoeField_2621", Text = "I much prefer Dracons that cannot fly..." },
			{ Cue = "/VO/MelinoeField_2622", Text = "This mountain's for the gods." },
			{ Cue = "/VO/MelinoeField_2623", Text = "How is Chronos controlling those..." },
			{ Cue = "/VO/MelinoeField_2624", Text = "A magnificent beast, but a threat..." },
			{ Cue = "/VO/MelinoeField_2625", Text = "Olympus is no place for such monstrosities...", PlayFirst = true },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossBrute" },
				},
			},

			{ Cue = "/VO/MelinoeField_3301", Text = "All these monstrosities... oh, no...", PlayFirst = true, PlayOnce = true, PreLineWait = 1.6 },
			{ Cue = "/VO/MelinoeField_3011", Text = "Foul creature..." },
			{ Cue = "/VO/MelinoeField_3013", Text = "{#Emph}Eugh{#Prev}, that is a {#Emph}stench..." },
			{ Cue = "/VO/MelinoeField_3014", Text = "Go cry to your father." },
			{ Cue = "/VO/MelinoeField_3015", Text = "One less of Typhon's brood." },
			{ Cue = "/VO/MelinoeField_3016", Text = "What a brute..." },
			{ Cue = "/VO/MelinoeField_3012", Text = "Children can be such a nuisance, so they say.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "MiniBossStalker" },
				},
			},

			{ Cue = "/VO/MelinoeField_3137", Text = "Not so easy to hunt down, was I?" },
			{ Cue = "/VO/MelinoeField_3138", Text = "Stay in the ground next time.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3141", Text = "Now this fortress is your grave." },
			{ Cue = "/VO/MelinoeField_3139", Text = "Your father shall be hearing about this.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3140", Text = "I'll deal with your father next.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "BossTyphonTail01" },
				},
			},

			{ Cue = "/VO/MelinoeField_3300", Text = "That monster, that was... {#Emph}Typhon...", PlayFirst = true, PlayOnce = true },
			{ Cue = "/VO/MelinoeField_3241", Text = "Retreated..." },
			{ Cue = "/VO/MelinoeField_3242", Text = "See you again shortly." },
			{ Cue = "/VO/MelinoeField_3243", Text = "It fell back..." },
			{ Cue = "/VO/MelinoeField_3244", Text = "Drove it back..." },
			{ Cue = "/VO/MelinoeField_3245", Text = "Just his tail..." },
			{ Cue = "/VO/MelinoeField_3246", Text = "Just his tail... one of them...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3245" },
					},
				}
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "BossTyphonEye01" },
				},
			},

			{ Cue = "/VO/MelinoeField_3691", Text = "It's improper to stare." },
			{ Cue = "/VO/MelinoeField_3692", Text = "...Properly disgusting." },
			{ Cue = "/VO/MelinoeField_3693", Text = "Should have stayed shut." },
			{ Cue = "/VO/MelinoeField_3694", Text = "How many more of those does Typhon have..." },
			{ Cue = "/VO/MelinoeField_3695", Text = "That was vile..." },
			{ Cue = "/VO/MelinoeField_2955", Text = "These are... eggs...", PlayOnce = true },
			{ Cue = "/VO/MelinoeField_2952", Text = "The walls are... breathing...", PlayOnce = true },
			{ Cue = "/VO/MelinoeField_2954", Text = "This is all... one being...", PlayOnce = true, PlayFirst = true },
		},
		-- misc. miniboss victories
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",

			{ Cue = "/VO/MelinoeField_0690", Text = "Out of my sight..." },
			{ Cue = "/VO/MelinoeField_0691", Text = "Out with you." },
			{ Cue = "/VO/MelinoeField_0692", Text = "Mindless wretch.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "MiniBossCrawler", "MiniBossJellyfish", "MiniBossDragon", "MiniBossStalker" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_0693", Text = "That's what you get." },
			{ Cue = "/VO/MelinoeField_0694", Text = "We're settled." },
			{ Cue = "/VO/MelinoeField_0695", Text = "Until we meet again." },
			{ Cue = "/VO/MelinoeField_0696", Text = "Remember that." },
			{ Cue = "/VO/MelinoeField_0697", Text = "We'll have to do this again." },
		},
		-- homer shout-outs
		{
			PlayOnceFromTableThisRun = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlay = 0.75,
			ThreadName = "RoomThread",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
				},
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 10,
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				NamedRequirements = { "NoRecentInspectPointUsed" },
			},
			{ Cue = "/VO/Melinoe_0861", Text = "You with me, Homer?" },
			{ Cue = "/VO/Melinoe_0862", Text = "Ready, Homer?" },
			{ Cue = "/VO/Melinoe_0863", Text = "Let's go, Homer." },
			{ Cue = "/VO/Melinoe_0864", Text = "See that, Homer?" },
			{ Cue = "/VO/Melinoe_1130", Text = "You there, Homer?" },
			{ Cue = "/VO/Melinoe_1131", Text = "What say you, Homer?" },
			{ Cue = "/VO/Melinoe_1133", Text = "Come along, Homer." },
			{ Cue = "/VO/Melinoe_1134", Text = "Say something, Homer?" },
			{ Cue = "/VO/Melinoe_1531", Text = "Keep up, Homer.",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.75, },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1129", Text = "We got them, Homer.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Kills" },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},
	},
	{ GlobalVoiceLines = "StorytellerFightReactionVoiceLines" },
}

GlobalVoiceLines.CrawlerMiniBossEncounterStartVoiceLines =
{
	{
		PreLineWait = 1.75,
		PlayOnce = true,
		PlayOnceContext = "TinyVerminIntro",
		Cooldowns =
		{
			{ Name = "CrawlerBossBurrowSpeech", Time = 20 },
		},

		{ Cue = "/VO/MelinoeField_0170", Text = "{#Emph}Erm..." },
		{ Cue = "/VO/MelinoeField_0171", Text = "Why are you glaring at me like that, little one?", PreLineWait = 0.65 },
		{ Cue = "/VO/Melinoe_1925", Text = "Uh-oh!", PreLineWait = 1.5 },
		{ Cue = "/VO/MelinoeField_0172", Text = "Have I offended in some way?!", PreLineWait = 1.4, BreakIfPlayed = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.75,
		SuccessiveChanceToPlayAll = 0.75,
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/MelinoeField_0173", Text = "Oh no.", PlayFirst = true, },
		{ Cue = "/VO/MelinoeField_0174", Text = "You again.", PlayFirst = true, },
		{ Cue = "/VO/MelinoeField_0175", Text = "The King Vermin...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "OdysseusAboutVerminMiniboss01", "OdysseusAboutVerminMiniboss01_B" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_0176", Text = "Hail, O King.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "OdysseusAboutVerminMiniboss01", "OdysseusAboutVerminMiniboss01_B" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_0177", Text = "At last, a worthy opponent." },
		{ Cue = "/VO/MelinoeField_0178", Text = "Have at you, King!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "OdysseusAboutVerminMiniboss01", "OdysseusAboutVerminMiniboss01_B" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2085", Text = "Toula, time to shine.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_2086", Text = "Toula, King Vermin.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "OdysseusAboutVerminMiniboss01", "OdysseusAboutVerminMiniboss01_B" },
				},
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},

	},	
}
GlobalVoiceLines.CharybdisEncounterStartVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.25,
		SuccessiveChanceToPlayAll = 0.75,
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/MelinoeField_1858", Text = "That maw... there's no mistaking it.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1860", Text = "You're going to let me pass!" },
		{ Cue = "/VO/MelinoeField_1863", Text = "Feast on this {#Emph}ship{#Prev}, not me!" },
		{ Cue = "/VO/MelinoeField_3721", Text = "Got some new tentacles I see!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1859", Text = "Charybdis, Devourer of Ships...!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1858" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1861", Text = "Hungry for more, Charybdis?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1862", Text = "Back from the depths, I see.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1864", Text = "How many tentacles does this thing have...?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1865", Text = "You won't be stopping {#Emph}me{#Prev}, Charybdis!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
				},
			},
		},
	},	
}
GlobalVoiceLines.TalosEncounterStartVoiceLines =
{
	{
		PreLineWait = 1.76,
		PlayOnce = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_2466", Text = "Wow, you must be Talos. Please tell me you're smarter than the other Automatons around here?" },
		{ Cue = "/VO/MelinoeField_2467", Text = "I'll have to take that as an absolutely not!", PreLineWait = 3.1, BreakIfPlayed = true },
	},
	{
		PreLineWait = 1.76,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.75,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_2468", Text = "Remember me, Talos? Or just attack me right away...", PlayFirst = true, },
		{ Cue = "/VO/MelinoeField_2470", Text = "I'd like a word with Lord Hephaestus about you." },
		{ Cue = "/VO/MelinoeField_2471", Text = "You probably can't understand a word I say." },
		{ Cue = "/VO/MelinoeField_2473", Text = "Perhaps I'll knock some sense into you yet." },
		{ Cue = "/VO/MelinoeField_2469", Text = "I'm back to put you out of commission again.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossTalos" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2472", Text = "Back in one piece, Talos?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossTalos" },
				},
			},
		},
	},
	{ GlobalVoiceLines = "MiniBossEncounterMiscStartLines" },
}

GlobalVoiceLines.FoundShopVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.2,
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Heracles_01" }, },
			},
		},
		-- RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Melinoe_1388", Text = "Heracles..." },
		{ Cue = "/VO/Melinoe_1389", Text = "Him again..." },
	},
}

-- Iris - Systems Interactions
GlobalVoiceLines.CostumeReAddedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_1413", Text = "I'm comfortable in this..." },
		{ Cue = "/VO/Melinoe_1414", Text = "Why mess with success?" },
	}
}

GlobalVoiceLines.CosmeticChangeVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	Cooldowns =
	{
		{ Name = "MelCosmeticsRemovedVO", Time = 9 },
	},

	-- { Cue = "/VO/Melinoe_1397", Text = "This sounds good." },
	-- { Cue = "/VO/Melinoe_1398", Text = "Let's do it." },
	-- { Cue = "/VO/Melinoe_1399", Text = "Let's try this on." },
	-- { Cue = "/VO/Melinoe_1400", Text = "Sure, why not." },
	
	{ Cue = "/VO/Melinoe_3660", Text = "I've changed my mind." },
	{ Cue = "/VO/Melinoe_3661", Text = "Let's try the other way." },
	{ Cue = "/VO/Melinoe_3662", Text = "Let's switch this." },
	{ Cue = "/VO/Melinoe_3663", Text = "Let's try this way again." },
	{ Cue = "/VO/Melinoe_3664", Text = "Let's go back to this." },
	{ Cue = "/VO/Melinoe_3665", Text = "A change is in order." },
	{ Cue = "/VO/Melinoe_3666", Text = "Let's try something else." },
	{ Cue = "/VO/Melinoe_3667", Text = "A different option here." },
}

GlobalVoiceLines.CosmeticRemovedVoiceLines =
{
	{ GlobalVoiceLines = "CosmeticChangeVoiceLines" },
	{ GlobalVoiceLines = "DoraDecorationRemovedLines" },	
}

GlobalVoiceLines.CosmeticReAddedVoiceLines =
{
	{ GlobalVoiceLines = "CosmeticChangeVoiceLines" },
	{ GlobalVoiceLines = "DoraRedecorationReactionVoiceLines" },
}

-- Systems & Screens
-- Pinning
GlobalVoiceLines.PinnedItemVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelPinnedItemSpeech", Time = 60 },
	},

	{ Cue = "/VO/Melinoe_0787", Text = "I'll keep this in mind.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_0788", Text = "Jotted down." },
	{ Cue = "/VO/Melinoe_0789", Text = "One to keep track of." },
	{ Cue = "/VO/Melinoe_0790", Text = "Noted." },
}

GlobalVoiceLines.FamiliarUpgradedGlobalVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "FrogFamiliar", "RavenFamiliar" },
			}
		},

		{ Cue = "/VO/Melinoe_0246", Text = "I got you something.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0247", Text = "I got you this.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0248", Text = "Got something for you.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0249", Text = "Here you go!", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0991", Text = "Little one, I have something for you.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_2355", Text = "For you!" },
		{ Cue = "/VO/Melinoe_2356", Text = "Surprise!" },
		{ Cue = "/VO/Melinoe_2357", Text = "Got you something!" },
		{ Cue = "/VO/Melinoe_2358", Text = "This is for you!" },
		{ Cue = "/VO/Melinoe_3592", Text = "You're going to like this." },
		{ Cue = "/VO/Melinoe_3593", Text = "You're getting stronger." },
		{ Cue = "/VO/Melinoe_3594", Text = "Well look at you!" },
		{ Cue = "/VO/Melinoe_3595", Text = "Our bond grows stronger." },
		{ Cue = "/VO/Melinoe_3596", Text = "Closer together." },
		{ Cue = "/VO/Melinoe_3597", Text = "We're here for each other." },

		{ Cue = "/VO/Melinoe_3788", Text = "This'll make you strong." },
		{ Cue = "/VO/Melinoe_3789", Text = "This is for you." },
		{ Cue = "/VO/Melinoe_3790", Text = "Thank you for being here." },
		{ Cue = "/VO/Melinoe_3791", Text = "Grow strong, my friend." },

		{ Cue = "/VO/Melinoe_3792", Text = "Here you go, Frinos.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "FrogFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3793" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3793", Text = "Here, Frinos.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "FrogFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3792" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3796", Text = "Here you go, Raki.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "RavenFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3797" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3797", Text = "Here, Raki.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "RavenFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3796" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
			}
		},

		{ Cue = "/VO/Melinoe_0246_B", Text = "I got you something.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0247_B", Text = "I got you this.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0248_B", Text = "Got something for you.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0249_B", Text = "Here you go!", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0991_B", Text = "Little one, I have something for you.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsNone = { "HoundFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2355_B", Text = "For you!" },
		{ Cue = "/VO/Melinoe_2356_B", Text = "Surprise!" },
		{ Cue = "/VO/Melinoe_2357_B", Text = "Got you something!" },
		{ Cue = "/VO/Melinoe_2358_B", Text = "This is for you!" },
		{ Cue = "/VO/Melinoe_3592_B", Text = "You're going to like this." },
		{ Cue = "/VO/Melinoe_3593_B", Text = "You're getting stronger." },
		{ Cue = "/VO/Melinoe_3594_B", Text = "Well look at you!" },
		{ Cue = "/VO/Melinoe_3595_B", Text = "Our bond grows stronger." },
		{ Cue = "/VO/Melinoe_3596_B", Text = "Closer together." },
		{ Cue = "/VO/Melinoe_3597_B", Text = "We're here for each other." },

		{ Cue = "/VO/Melinoe_3788_B", Text = "This'll make you strong." },
		{ Cue = "/VO/Melinoe_3789_B", Text = "This is for you." },
		{ Cue = "/VO/Melinoe_3790_B", Text = "Thank you for being here." },
		{ Cue = "/VO/Melinoe_3791_B", Text = "Grow strong, my friend." },

		{ Cue = "/VO/Melinoe_3794", Text = "Here you go, Toula.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "CatFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3795" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3795", Text = "Here, Toula.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "CatFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3794" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3798", Text = "Here you go, Hecuba.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "HoundFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3799" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3799", Text = "Here, Hecuba.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "HoundFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3798" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3961", Text = "Here you go, Gale.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "PolecatFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3961" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3962", Text = "Here, Gale.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "FamiliarName" },
					IsAny = { "PolecatFamiliar" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3962" },
				},
			},
		},
	},
}


GlobalVoiceLines.PostRevealGlobalVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.66,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0200", Text = "Greater strength." },
		{ Cue = "/VO/Melinoe_0201", Text = "I accept this gift." },
		{ Cue = "/VO/Melinoe_0203", Text = "Yes." },
		{ Cue = "/VO/Melinoe_0204", Text = "Excellent." },
		{ Cue = "/VO/Melinoe_0206", Text = "Good." },
		{ Cue = "/VO/Melinoe_0207", Text = "Adequate." },
		{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0209", Text = "There." },
		{ Cue = "/VO/Melinoe_0211", Text = "Right." },
		{ Cue = "/VO/Melinoe_0213", Text = "Greater might..." },
		{ Cue = "/VO/Melinoe_0244", Text = "Very well..." },
		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0179", Text = "All right." },
		{ Cue = "/VO/Melinoe_0180", Text = "Set." },
		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
	},
}

-- Weapon Equipping
GlobalVoiceLines.MiscWeaponEquipVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeMiscWeaponEquipSpeech", Time = 25 },
		{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
	},
	{
		PlayOnceFromTableThisRun = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTrait2" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_2408", Text = "I'll find more Bones with this." },
		{ Cue = "/VO/Melinoe_2409", Text = "Should help me gather Bones." },
		{ Cue = "/VO/Melinoe_2410", Text = "Grave Thirst activated..." },
		{ Cue = "/VO/Melinoe_2411", Text = "This has Grave Thirst this eve..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		-- { Cue = "/VO/Melinoe_0727", Text = "Descura, the Staff of Dusk. Accompany me through the dark." },
		{ Cue = "/VO/Melinoe_3030", Text = "Descura, the Witch's Staff. With me, my friend.", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/Melinoe_0728", Text = "Descura." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_0730", Text = "Lim and Oros." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_3032", Text = "Zorephet.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0732", Text = "Zorephet." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_0734", Text = "Revaal." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_0736", Text = "Ygnium." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_3617", Text = "Xinth." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.33,

		{ Cue = "/VO/Melinoe_0214", Text = "This one." },
		{ Cue = "/VO/Melinoe_0215", Text = "How about..." },
		{ Cue = "/VO/Melinoe_0216", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0217", Text = "You." },
		{ Cue = "/VO/Melinoe_0218", Text = "Why not." },
		{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
		{ Cue = "/VO/Melinoe_0220", Text = "{#Emph}Heh." },
		{ Cue = "/VO/Melinoe_0180", Text = "Set." },
	},
}
GlobalVoiceLines.SwitchedWeaponUpgradeVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeWeaponUpgradeScreenSpeech", Time = 6 },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.8,

		{ Cue = "/VO/Melinoe_2451", Text = "Circe.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffClearCastAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_2452", Text = "Circe...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffClearCastAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_2453", Text = "Momus.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffSelfHitAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2454", Text = "Momus...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffSelfHitAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2457", Text = "Anubis.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2458", Text = "Anubis...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2455", Text = "Artemis.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerBlockAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2456", Text = "Artemis...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerBlockAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2543", Text = "Pan.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerHomingThrowAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_2544", Text = "Pan...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerHomingThrowAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_3996", Text = "The Morrigan.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_3997", Text = "The Morrigan...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect"},
				},
			}
		},
		{ Cue = "/VO/Melinoe_3022", Text = "Moros.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchDetonateAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3023", Text = "Moros...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchDetonateAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3024", Text = "Eos.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3025", Text = "Eos...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_1999", Text = "Dawn.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4376", Text = "Supay.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchAutofireAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4377", Text = "Supay...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchAutofireAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3018", Text = "Charon.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeArmCastAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3019", Text = "Charon...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeArmCastAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3020", Text = "Thanatos.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3021", Text = "Thanatos...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4382", Text = "Nergal.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4383", Text = "Nergal...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3026", Text = "Medea.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobCloseAttackAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3027", Text = "Medea...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobCloseAttackAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3028", Text = "Persephone.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobImpulseAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3029", Text = "Persephone...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobImpulseAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4388", Text = "Hel.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4389", Text = "Hel...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3734", Text = "Selene.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3735", Text = "Selene...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3736", Text = "Nyx.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3737", Text = "Nyx...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4394", Text = "Shiva.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitComboAspect" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_4395", Text = "Shiva...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitComboAspect" },
				},
			}
		},
	},
	{
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "SeleneAspectEquipSpeech",
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
			},
			{
				Path = { "GameState", "GamePhase", },
				Comparison = "~=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGift03" },
			},
			-- Selene is MIA during this
			NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
		},
		Cooldowns =
		{
			{ Name = "SeleneAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/Selene_0392", Text = "Yes...?", PlayFirst = true },
		{ Cue = "/VO/Selene_0393", Text = "Little star." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.8,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "BaseStaffAspect", "DaggerBackstabAspect", "AxeRecoveryAspect", "TorchSpecialDurationAspect", "LobAmmoBoostAspect", "BaseSuitAspect" },
			},
		},

		{ Cue = "/VO/Melinoe_2459", Text = "Myself." },
		{ Cue = "/VO/Melinoe_2460", Text = "Melinoë." },
		{ Cue = "/VO/Melinoe_2461", Text = "My form." },
		{ Cue = "/VO/Melinoe_2462", Text = "Return." },
	},
}

GlobalVoiceLines.MiscToolEquipVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.33,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
		},
		{ Cue = "/VO/Melinoe_3751", Text = "Find more with this." },
		{ Cue = "/VO/Melinoe_3752", Text = "Put this to work." },
		{ Cue = "/VO/Melinoe_3753", Text = "Focused on this." },
		{ Cue = "/VO/Melinoe_3754", Text = "Prioritized." },
		{ Cue = "/VO/Melinoe_3755", Text = "Help me find more." },
		{ Cue = "/VO/Melinoe_0214", Text = "This one." },
		{ Cue = "/VO/Melinoe_0215", Text = "How about..." },
		{ Cue = "/VO/Melinoe_0216", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0218", Text = "Why not." },
		{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
	},
}

GlobalVoiceLines.FamiliarEquipVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.33,
		Cooldowns =
		{
			{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
		},

		{ Cue = "/VO/Melinoe_2771", Text = "Come along!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2772", Text = "With me!" },
		{ Cue = "/VO/Melinoe_2773", Text = "Shall we?" },
		{ Cue = "/VO/Melinoe_2774", Text = "Let's go." },
		{ Cue = "/VO/Melinoe_0845", Text = "Come join me, little one." },
		{ Cue = "/VO/Melinoe_0846", Text = "Care to accompany me, little one?" },
		{ Cue = "/VO/Melinoe_0847", Text = "Come, little one, let's go." },
		{ Cue = "/VO/Melinoe_2499", Text = "Together we'll go far." },
		{ Cue = "/VO/Melinoe_2498", Text = "It shall be my honor." },
		{ Cue = "/VO/Melinoe_5625", Text = "Your turn." },
		{ Cue = "/VO/Melinoe_5626", Text = "Join me?" },
		{ Cue = "/VO/Melinoe_5627", Text = "Come along?" },
		{ Cue = "/VO/Melinoe_5628", Text = "With me." },
		{ Cue = "/VO/Melinoe_5629", Text = "Frinos.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5631", Text = "Raki.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5630", Text = "Toula.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5632", Text = "Hecuba.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "HoundFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5633", Text = "Gale.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "PolecatFamiliar" },
				},
			},
		},
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.33,
		SuccessiveChanceToPlayAll = 0.05,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyFamiliarSpeech", Time = 10 },
		},

		{ Cue = "/VO/Skelly_0132", Text = "It seems we have a new disciple!", PlayOnce = true, PlayOnceContext = "FamiliarEquipFirst", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Skelly_0133", Text = "A new disciple joined our ranks, young one!", PlayOnce = true, PlayOnceContext = "FamiliarEquipSecond", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Skelly_0134", Text = "Whence came that tiny beast?", PlayOnce = true, PlayOnceContext = "FamiliarEquipThird", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar", "PolecatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Skelly_0135", Text = "The small amphibian is welcome here.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Skelly_0136", Text = "That feline is to be trusted then?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		 },
		{ Cue = "/VO/Skelly_0137", Text = "Move swiftly as the raven flies.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				}
			},
		},

	},
}
GlobalVoiceLines.FamiliarPostTreatVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllFrogFamiliarUpgrades,
			},
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "FrogFamiliar" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5582", Text = "Look at how strong you've grown." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllRavenFamiliarUpgrades,
			},
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "RavenFamiliar" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5583", Text = "Look at you now, little raven." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllCatFamiliarUpgrades,
			},
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "CatFamiliar" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5584", Text = "You're an impressive cat." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllHoundFamiliarUpgrades,
			},
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "HoundFamiliar" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5585", Text = "The queen of the hounds." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllPolecatFamiliarUpgrades,
			},
			{
				PathFromArgs = true,
				Path = { "FamiliarName" },
				IsAny = { "PolecatFamiliar" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5586", Text = "You've done it now, Gale." },
	},
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		UsePlayerSource = true,
		SuccessiveChanceToPlayAll = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeTreatVOPlayedRecently", Time = 30 },
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_3874", Text = "Good, wasn't it?", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3875", Text = "Familiars just love these." },
		{ Cue = "/VO/Melinoe_3876", Text = "I'm tempted to try one myself..." },
		{ Cue = "/VO/Melinoe_3877", Text = "Works every time." },
		{ Cue = "/VO/Melinoe_3878", Text = "Always does the trick." },
		{ Cue = "/VO/Melinoe_3879", Text = "Those must be tasty..." },
		{ Cue = "/VO/Melinoe_5634", Text = "Nourishing!" },
		{ Cue = "/VO/Melinoe_5635", Text = "Can't get enough of those." },
		{ Cue = "/VO/Melinoe_5636", Text = "That good, huh?" },
		{ Cue = "/VO/Melinoe_5637", Text = "Growing strong." },
	},
	{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
}

GlobalVoiceLines.CardInspectVoiceLines =
{
	PreLineWait = 0.4,
	BreakIfPlayed = true,
	SuccessiveChanceToPlay = 0.2,
	SuccessiveChanceToPlayAll = 0.2,
	GameStateRequirements =
	{
		{
			PathTrue = { "ActiveScreens", "MetaUpgradeCardUpgradeLayout" },
		},
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelCardScreenModeSpeech", Time = 20 },
	},

	{ Cue = "/VO/Melinoe_5489", Text = "Let's take a closer look...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_5490", Text = "Intricate detail...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
	{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
	{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
	{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
}

GlobalVoiceLines.ClosedWeaponUpgradeMenuVoiceLines =
{
	{
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "SeleneAspectEquipSpeech",
		PreLineWait = 0.4,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
			},
			{
				Path = { "GameState", "GamePhase", },
				Comparison = "~=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGift03" },
			},
			ChanceToPlay = 0.33,
			-- Selene is MIA during this
			NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
		},
		Cooldowns =
		{
			{ Name = "SeleneAnyQuipSpeech", Time = 6 },
		},
		
		{ Cue = "/VO/Selene_0394", Text = "{#Emph}Sky Fall." },
		{ Cue = "/VO/Selene_0395", Text = "{#Emph}Sky Fall...!" },
		{ Cue = "/VO/Selene_0389", Text = "I see..." },
		{ Cue = "/VO/Selene_0390", Text = "Well chosen.", PlayFirst = true },
		{ Cue = "/VO/Selene_0391", Text = "My Aspect..." },
	},
}

GlobalVoiceLines.OlympusAssaultReactionLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	GameStateRequirements = 
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "P" },
		},
	},
	SuccessiveChanceToPlayAll = 0.1,

	{ Cue = "/VO/MelinoeField_2459", Text = "It's under attack...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_2460", Text = "They don't let up..." },
	{ Cue = "/VO/MelinoeField_2461", Text = "That's quite enough!" },
	{ Cue = "/VO/MelinoeField_2462", Text = "That's not your property!" },
}
GlobalVoiceLines.AutomatonAttackReactionLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "AutomatonSecondAppearanceVO",
		UsePlayerSource = true,
		PreLineWait = 2.1,
		GameStateRequirements = 
		{
		},

		{ Cue = "/VO/MelinoeField_2465", Text = "The mountain's own defenses turned on me..." },
	},
}
GlobalVoiceLines.AutomatonReactionLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "AutomatonFirstAppearanceVO",
		UsePlayerSource = true,
		GameStateRequirements = 
		{
		},

		{ Cue = "/VO/MelinoeField_2463", Text = "Olympian Automatons are fighting back..." },
		{ Cue = "/VO/MelinoeField_2464", Text = "Hey wait I'm on your side!", PreLineWait = 1.6 },
	},
}

GlobalVoiceLines.ActiveStatueSpottedVoiceLines =
{
	{
		PlayOnce = true,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		},

		{ Cue = "/VO/MelinoeField_2993", Text = "Those statues should be activated now..." },
	},
}
GlobalVoiceLines.StatueActivatedVoiceLines =
{
	{
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.25,

		TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

		{ Cue = "/VO/MelinoeField_2998", Text = "{#Emph}Now!" },
		{ Cue = "/VO/MelinoeField_2999", Text = "Do it!" },
	},
	--[[
	{
		-- { Cue = "/VO/Zeus_0101", Text = "This shall come as a shock!" },
		-- { Cue = "/VO/Zeus_0102", Text = "A storm is coming..." },
		-- { Cue = "/VO/Zeus_0103", Text = "Behold my thunderbolts!" },
	},
	{
		-- { Cue = "/VO/Hestia_0078", Text = "What say we turn up the heat?!" },
		-- { Cue = "/VO/Hestia_0079", Text = "They'll burn!" },
		-- { Cue = "/VO/Hestia_0080", Text = "Flames take them all!" },
	},
	]]--
}
GlobalVoiceLines.TyphonSummonReactionVoiceLines =
{
	{
		PlayOnceFromTableThisRun = true,
		UsePlayerSource = true,
		RandomRemaining = true,
		PreLineWait = 5.0,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.33,
		RecheckRequirementsPostWait = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
		},

		{ Cue = "/VO/Melinoe_1954", Text = "What...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "TyphonFirstEggSpawnReactionVO" },
		{ Cue = "/VO/MelinoeField_3281", Text = "Eggs...!" },
		{ Cue = "/VO/MelinoeField_3282", Text = "Those eggs...!" },
		{ Cue = "/VO/MelinoeField_3283", Text = "{#Emph}Ungh{#Prev}, eggs..." },
		{ Cue = "/VO/MelinoeField_3284", Text = "More eggs?" },
		{ Cue = "/VO/MelinoeField_3285", Text = "Egg breath...!" },
		{ Cue = "/VO/MelinoeField_3286", Text = "Here we go..." },
		{ Cue = "/VO/MelinoeField_3287", Text = "Need to stop these..." },
		{ Cue = "/VO/MelinoeField_3288", Text = "More eggs to break..." },
	},
}

GlobalVoiceLines.ApproachingHouseLines =
{
	{
		PreLineWait = 2.0,
		BreakIfPlayed = true,
		PlayOnce = true,
		PlayOnceContext = "FirstIPreBoss02VisitSpeech",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
		{ Cue = "/VO/MelinoeField_4190", Text = "The House of Hades..." },
	},
	{
		PreLineWait = 1.2,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
		},

		{ Cue = "/VO/MelinoeField_1291", Text = "Down there...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1292", Text = "There it is..." },
		{ Cue = "/VO/MelinoeField_1293", Text = "The House..." },
		{ Cue = "/VO/MelinoeField_1294", Text = "Made it through..." },
		{ Cue = "/VO/MelinoeField_1295", Text = "I'm here..." },
		{ Cue = "/VO/MelinoeField_1296", Text = "This is it..." },
		{ Cue = "/VO/MelinoeField_4188", Text = "Reconstruction underway...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4190" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4191", Text = "The River Styx...",
			PlayFirst = true, PreLineWait = 2.0,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4190" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4189", Text = "It's changed so much...",
			PlayFirst = true, PreLineWait = 2.0,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4190" },
				},
				{
					Path = { "GameState", "SpeechRecord", "/VO/MelinoeField_4189" },
					Comparison = "<=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4190", Text = "The House of Hades...",
			PlayFirst = true, PreLineWait = 2.0,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					SumPrevRuns = 8,
					Path = { "SpeechRecord", "/VO/MelinoeField_4190" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
			},
		},
	},
}

GlobalVoiceLines.InfiltratingHouseLines =
{
	{
		PreLineWait = 0.5,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "I", },
			},
		},

		{ Cue = "/VO/MelinoeField_1299", Text = "One way in...!" },
		{ Cue = "/VO/MelinoeField_1300", Text = "{#Emph}<Inhale>", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1301", Text = "River, take me...!" },
		{ Cue = "/VO/MelinoeField_1302", Text = "Styx, take me...!" },
		{ Cue = "/VO/MelinoeField_1303", Text = "Quick dip...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
					Comparison = "<=",
					Value = 0,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1304", Text = "Swimtime...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
					Comparison = "<=",
					Value = 0,
				},
			},
		},
	},
}

-- Global Misc Lines
GlobalVoiceLines.FishNotCaughtReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Hecate_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "HecateFishing01", "HecateFishing02" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Hecate_0390", Text = "{#Emph}Mm, tsk-tsk-tsk." },
		{ Cue = "/VO/Hecate_0391", Text = "Alas." },
		{ Cue = "/VO/Hecate_0392", Text = "Merely a lesson learned.", PlayFirst = true },
		{ Cue = "/VO/Hecate_0393", Text = "Outmaneuvered..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Dora_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "DoraFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Dora_0095", Text = "Oof. Sorry.", PlayFirst = true },
		{ Cue = "/VO/Dora_0096", Text = "Bummer..." },
		{ Cue = "/VO/Dora_0097", Text = "Missed 'em, huh." },
		{ Cue = "/VO/Dora_0098", Text = "All that for nothing." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Odysseus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "OdysseusFishing01", "OdysseusFishing02" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Odysseus_0080", Text = "Alas..." },
		{ Cue = "/VO/Odysseus_0081", Text = "That blasted...", PlayFirst = true },
		{ Cue = "/VO/Odysseus_0082", Text = "{#Emph}Nrgh..." },
		{ Cue = "/VO/Odysseus_0083", Text = "Ah well..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "MorosFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Moros_0356", Text = "{#Emph}Ah... {#Prev}my regrets." },
		{ Cue = "/VO/Moros_0357", Text = "Outmaneuvered..." },
		{ Cue = "/VO/Moros_0358", Text = "They are quick..." },
		{ Cue = "/VO/Moros_0359", Text = "How inopportune...", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Nemesis_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "NemesisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Nemesis_0194", Text = "Could've caught it." },
		{ Cue = "/VO/Nemesis_0195", Text = "Empty-handed." },
		{ Cue = "/VO/Nemesis_0196", Text = "Caught out." },
		{ Cue = "/VO/Nemesis_0197", Text = "No fair, right?", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Eris_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "ErisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Eris_0233", Text = "{#Emph}Sorry!" },
		{ Cue = "/VO/Eris_0234", Text = "You blew it!", PlayFirst = true },
		{ Cue = "/VO/Eris_0235", Text = "You missed!" },
		{ Cue = "/VO/Eris_0236", Text = "Got away, huh?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Icarus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "CurrentRun", "TextLinesRecord", },
						HasAny = { "IcarusFishing01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
			},
		},
		
		{ Cue = "/VO/Icarus_0229", Text = "It got away..." },
		{ Cue = "/VO/Icarus_0230", Text = "Tough one..." },
		{ Cue = "/VO/Icarus_0231", Text = "{#Emph}Ah {#Prev}well..." },
		{ Cue = "/VO/Icarus_0232", Text = "{#Emph}Aah{#Prev}, sorry...", PlayFirst = true },
		{ Cue = "/VO/Icarus_0233", Text = "Not our night..." },
		{ Cue = "/VO/Icarus_0234", Text = "No good." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Arachne_01",

		{ Cue = "/VO/Arachne_0340", Text = "{#Emph}<Scoff>" },
		{ Cue = "/VO/Arachne_0347", Text = "Aw..." },
		{ Cue = "/VO/Arachne_0348", Text = "{#Emph}Ungh!" },
		{ Cue = "/VO/Arachne_0349", Text = "Shoot." },
		{ Cue = "/VO/Arachne_0350", Text = "Oh {#Emph}fiddle...", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Narcissus_01",

		{ Cue = "/VO/Narcissus_0167", Text = "Just the way it is..." },
		{ Cue = "/VO/Narcissus_0168", Text = "Just didn't like you." },
		{ Cue = "/VO/Narcissus_0169", Text = "The one that got away...", PlayFirst = true },
		{ Cue = "/VO/Narcissus_0170", Text = "Didn't work out, huh?" },
		{ Cue = "/VO/Narcissus_0171", Text = "Stop disturbing the water!" },
		{ Cue = "/VO/Narcissus_0172", Text = "Plenty of fish... {#Emph}in the sea!" },
		{ Cue = "/VO/Narcissus_0173", Text = "{#Emph}Aw{#Prev}, too bad." },
		{ Cue = "/VO/Narcissus_0174", Text = "You have to let it go..." },
		{ Cue = "/VO/Narcissus_0175", Text = "Just wasn't meant to be." },
		{ Cue = "/VO/Narcissus_0176", Text = "You'll find the one someday." },
		{ Cue = "/VO/Narcissus_0177", Text = "I'm really sad for you." },
		{ Cue = "/VO/Narcissus_0178", Text = "Just wasn't into you." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Heracles_01",

		{ Cue = "/VO/Heracles_0609", Text = "Bested..." },
		{ Cue = "/VO/Heracles_0610", Text = "Vanquished..." },
		{ Cue = "/VO/Heracles_0611", Text = "You lost.", PlayFirst = true },
		{ Cue = "/VO/Heracles_0612", Text = "{#Emph}<Scoff> Hah." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Medea_01",

		{ Cue = "/VO/Medea_0327", Text = "All for naught." },
		{ Cue = "/VO/Medea_0328", Text = "Shall I curse it...?", PlayFirst = true },
		{ Cue = "/VO/Medea_0329", Text = "Next time, perhaps." },
		{ Cue = "/VO/Medea_0330", Text = "I saw nothing." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Circe_01",

		{ Cue = "/VO/Circe_0196", Text = "How unexpected..." },
		{ Cue = "/VO/Circe_0197", Text = "Not meant to be." },
		{ Cue = "/VO/Circe_0198", Text = "Oh, no..." },
		{ Cue = "/VO/Circe_0199", Text = "What happened there?" },
		{ Cue = "/VO/Circe_0200", Text = "An effort, nonetheless!", PlayFirst = true },
		{ Cue = "/VO/Circe_0201", Text = "I thought you {#Emph}had {#Prev}that one!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Artemis_Field_01",

		{ Cue = "/VO/Artemis_0338", Text = "No good...", PlayFirst = true },
		{ Cue = "/VO/Artemis_0339", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Artemis_0340", Text = "Eluded." },
		{ Cue = "/VO/Artemis_0341", Text = "Evaded." },
		{ Cue = "/VO/Artemis_0342", Text = "Not quite." },
		{ Cue = "/VO/Artemis_0343", Text = "Missed the mark..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Athena_01",

		{ Cue = "/VO/Athena_0154", Text = "A wasted opportunity.", PlayFirst = true },
		{ Cue = "/VO/Athena_0155", Text = "Unbelievable." },
		{ Cue = "/VO/Athena_0156", Text = "Empty-handed..." },
		{ Cue = "/VO/Athena_0157", Text = "Evaded." },			
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Dionysus_01",
		PreLineAnim = "Dionysus_Surprise",

		{ Cue = "/VO/Dionysus_0201", Text = "{#Emph}Ah{#Prev}, you had us going there!" },
		{ Cue = "/VO/Dionysus_0202", Text = "Now can we {#Emph}please {#Prev}get back to it?" },
		{ Cue = "/VO/Dionysus_0203", Text = "Hey cheer up baby!" },
		{ Cue = "/VO/Dionysus_0204", Text = "That didn't seem like it'd work..." },
		{ Cue = "/VO/Dionysus_0205", Text = "Let me know if you could use a drink!" },
		{ Cue = "/VO/Dionysus_0206", Text = "Nice try, though!", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
				IsAny = { "SpellDrop" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "G", "H", "I", },
			},
			{
				Path = { "GameState", "GamePhase", },
				Comparison = "~=",
				Value = 5,
			},
		},

		{ Cue = "/VO/Selene_0304", Text = "I saw nothing at all." },
		{ Cue = "/VO/Selene_0305", Text = "No reason for despair." },
		{ Cue = "/VO/Selene_0306", Text = "Some other night perhaps." },
		{ Cue = "/VO/Selene_0307", Text = "It was too swift..." },
		{ Cue = "/VO/Selene_0308", Text = "Eluded..." },
		{ Cue = "/VO/Selene_0309", Text = "Outmaneuvered..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "UseRecord", "PoseidonUpgrade" }
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutFishing04" }
			},
		},
		{ Cue = "/VO/Poseidon_0239", Text = "I think not." },
		{ Cue = "/VO/Poseidon_0240", Text = "Done what I can." },
		{ Cue = "/VO/Poseidon_0339", Text = "Too bad, Niece!" },
		{ Cue = "/VO/Poseidon_0340", Text = "I'm keeping {#Emph}that {#Prev}one!" },
		{ Cue = "/VO/Poseidon_0341", Text = "That one's {#Emph}mine!", PlayFirst = true },
		{ Cue = "/VO/Poseidon_0342", Text = "{#Emph}Hah-hah{#Prev}, no!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.68,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Charon_01",
		PreLineAnim = "Charon_Fierce",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Charon_0126", Text = "{#Emph}Ahhh..." },
		{ Cue = "/VO/Charon_0127", Text = "{#Emph}Ehhh..." },
		{ Cue = "/VO/Charon_0128", Text = "{#Emph}Mmm..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		ChanceToPlay = 0.33,
		PreLineWait = 0.57,
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "Chaos" },
			},
		},

		{ Cue = "/VO/Chaos_0187", Text = "Your efforts were in vain." },
		{ Cue = "/VO/Chaos_0188", Text = "An acceptable loss." },
		{ Cue = "/VO/Chaos_0189", Text = "Perhaps the Fates desired this.", PlayFirst = true },
		{ Cue = "/VO/Chaos_0190", Text = "An unsuccessful attempt." },
	},
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		SuccessiveChanceToPlay = 0.1,
		SuccessiveChanceToPlayAll = 0.5,
		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "InspectPoint" },
				Comparison = ">=",
				Value = 40,
			},
			NamedRequirements = { "NoRecentInspectPointUsed" },
		},
		Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
		Cooldowns =
		{
			{ Name = "HomerSpokeRecently", Time = 420 },
		},

		{ Cue = "/VO/Storyteller_0315", Text = "{#Emph}Whatever lurks within those waters, there remains." },
		{ Cue = "/VO/Storyteller_0316", Text = "{#Emph}Her prey escapes, however narrowly..." },
		{ Cue = "/VO/Storyteller_0317", Text = "{#Emph}Well, she is not the Princess of the Sea..." },
		{ Cue = "/VO/Storyteller_0318", Text = "{#Emph}That which she sought to capture slips away..." },
	},
}
GlobalVoiceLines.FishIdentifiedReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		Queue = "Interrupt",
		ObjectType = "NPC_Hecate_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "HecateFishing01", "HecateFishing02" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Hecate_0386", Text = "And caught." },
		{ Cue = "/VO/Hecate_0575", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Hecate_0578", Text = "{#Emph}Hm." },
		{ Cue = "/VO/Hecate_0580", Text = "{#Emph}Hmm." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		Queue = "Interrupt",
		ObjectType = "NPC_Dora_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "DoraFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Dora_0091", Text = "Well there you go!" },
		{ Cue = "/VO/Dora_0092", Text = "{#Emph}Hah! {#Prev}You tricked a fish!", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		Queue = "Interrupt",
		ObjectType = "NPC_Odysseus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "OdysseusFishing01", "OdysseusFishing02" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Odysseus_0076", Text = "Hey, you got one!" },
		{ Cue = "/VO/Odysseus_0077", Text = "{#Emph}Hoh{#Prev}, nice catch!" },
		{ Cue = "/VO/Odysseus_0765", Text = "{#Emph}There {#Prev}it is!" },
		{ Cue = "/VO/Odysseus_0767", Text = "Caught!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		Queue = "Interrupt",
		ObjectType = "NPC_Nemesis_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "NemesisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		{ Cue = "/VO/Nemesis_0183", Text = "Fair catch.", PlayFirst = true },
		{ Cue = "/VO/Nemesis_0190", Text = "Big deal." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		Queue = "Interrupt",
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "MorosFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Moros_0352", Text = "Impressive catch." },
		{ Cue = "/VO/Moros_0353", Text = "Skillfully caught." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.8,
		Queue = "Interrupt",
		ObjectType = "NPC_Nemesis_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Nemesis_0182", Text = "Thank the Fates." },
		{ Cue = "/VO/Nemesis_0183", Text = "Fair catch." },
		{ Cue = "/VO/Nemesis_0184", Text = "Had it coming." },
		{ Cue = "/VO/Nemesis_0185", Text = "Tough break, fish." },
		{ Cue = "/VO/Nemesis_0186", Text = "Lucky catch." },
		{ Cue = "/VO/Nemesis_0187", Text = "Caught bigger ones than that.", PlayFirst = true },
		{ Cue = "/VO/Nemesis_0188", Text = "Lured it with magick didn't you." },
		{ Cue = "/VO/Nemesis_0189", Text = "Can we get back to work?" },
		{ Cue = "/VO/Nemesis_0190", Text = "Big deal." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		Queue = "Interrupt",
		ObjectType = "NPC_Eris_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "ErisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Eris_0230", Text = "Real {#Emph}beauty {#Prev}there!" },
		{ Cue = "/VO/Eris_0232", Text = "{#Emph}Ugly!" },
	},
	{ GlobalVoiceLines = "IcarusFishCaughtReactionVoiceLines" },
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Arachne_01",
		AllowTalkOverTextLines = true,
		Cooldowns =
		{
			{ Name = "ArachneSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Arachne_0330", Text = "Nice catch!" },
		{ Cue = "/VO/Arachne_0331", Text = "Well done." },
		{ Cue = "/VO/Arachne_0332", Text = "Got one huh." },
		{ Cue = "/VO/Arachne_0333", Text = "Did you get it?" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Narcissus_01",
		AllowTalkOverTextLines = true,
		Cooldowns =
		{
			{ Name = "NarcissusSpokeRecently", Time = 8 },
		},

		{ Cue = "/VO/Narcissus_0153", Text = "Could you, like, keep it down?" },
		{ Cue = "/VO/Narcissus_0154", Text = "Better not throw it back..." },
		{ Cue = "/VO/Narcissus_0155", Text = "What did you just do?" },
		{ Cue = "/VO/Narcissus_0156", Text = "I'm trying to concentrate!" },
		{ Cue = "/VO/Narcissus_0157", Text = "One less suitor.", PlayFirst = true },
		{ Cue = "/VO/Narcissus_0158", Text = "Caught something, huh?" },
		{ Cue = "/VO/Narcissus_0159", Text = "{#Emph}Eugh..." },
		{ Cue = "/VO/Narcissus_0160", Text = "Did you just...?" },
		{ Cue = "/VO/Narcissus_0161", Text = "Watch with the splashing." },
		{ Cue = "/VO/Narcissus_0162", Text = "Get it out of here." },
		{ Cue = "/VO/Narcissus_0163", Text = "I'm happy for you two.", PlayFirst = true },
		{ Cue = "/VO/Narcissus_0164", Text = "Is it over...?" },
		{ Cue = "/VO/Narcissus_0165", Text = "Whatever you're into." },
		{ Cue = "/VO/Narcissus_0166", Text = "Nice one, Laurel.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection01" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Queue = "Interrupt",
		ObjectType = "NPC_Heracles_01",
		Cooldowns =
		{
			{ Name = "HeraclesAnyQuipSpeech", Time = 4 },
		},

		{ Cue = "/VO/Heracles_0603", Text = "Glory." },
		{ Cue = "/VO/Heracles_0604", Text = "Astonishing." },
		{ Cue = "/VO/Heracles_0605", Text = "You're victorious.", PlayFirst = true },
		{ Cue = "/VO/Heracles_0607", Text = "Mightily impressive." },
		{ Cue = "/VO/Heracles_0608", Text = "Truly a feat." },
		{ Cue = "/VO/Heracles_0606", Text = "Fish vanquished.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Queue = "Interrupt",
		ObjectType = "NPC_Medea_01",
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 4 },
		},

		{ Cue = "/VO/Medea_0321", Text = "Well, look at that." },
		{ Cue = "/VO/Medea_0322", Text = "No magick required." },
		{ Cue = "/VO/Medea_0323", Text = "Risen from the deep." },
		{ Cue = "/VO/Medea_0324", Text = "The Acheron provides.", PlayFirst = true },
		{ Cue = "/VO/Medea_0325", Text = "Is it even alive...?" },
		{ Cue = "/VO/Medea_0326", Text = "You caught something..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Queue = "Interrupt",
		ObjectType = "NPC_Circe_01",
		Cooldowns =
		{
			{ Name = "CirceAnyQuipSpeech", Time = 4 },
		},

		{ Cue = "/VO/Circe_0190", Text = "The deed is done!" },
		{ Cue = "/VO/Circe_0191", Text = "From water to land!" },
		{ Cue = "/VO/Circe_0192", Text = "How {#Emph}marvelous!" },
		{ Cue = "/VO/Circe_0193", Text = "A rescue from the Rift!", PlayFirst = true },
		{ Cue = "/VO/Circe_0194", Text = "You have it!" },
		{ Cue = "/VO/Circe_0195", Text = "I'd not a doubt!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Artemis_Field_01",
		AllowTalkOverTextLines = true,
		Cooldowns =
		{
			{ Name = "ArtemisAnyQuipSpeech", Time = 4 },
		},
		{ Cue = "/VO/Artemis_0332", Text = "Success." },
		{ Cue = "/VO/Artemis_0333", Text = "There it is." },
		{ Cue = "/VO/Artemis_0334", Text = "Not bad!" },
		{ Cue = "/VO/Artemis_0335", Text = "{#Emph}Ooh." },
		{ Cue = "/VO/Artemis_0336", Text = "Look at that!", PlayFirst = true },
		{ Cue = "/VO/Artemis_0337", Text = "Well caught." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Dionysus_01",
		AllowTalkOverTextLines = true,
		PreLineAnim = "Dionysus_Surprise",
		Cooldowns =
		{
			{ Name = "DionysusSpokeRecently", Time = 4 },
		},
		{ Cue = "/VO/Dionysus_0134", Text = "Whoa you got one!" },
		{ Cue = "/VO/Dionysus_0135", Text = "Hey nice catch!" },
		{ Cue = "/VO/Dionysus_0139", Text = "Nice!" },
		{ Cue = "/VO/Dionysus_0140", Text = "Hey good for {#Emph}you!" },
		{ Cue = "/VO/Dionysus_0141", Text = "Right {#Emph}on!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Athena_01",
		AllowTalkOverTextLines = true,
		Cooldowns =
		{
			{ Name = "AthenaSpokeRecently", Time = 6 },
		},
		{ Cue = "/VO/Athena_0148", Text = "Are you quite done?" },
		{ Cue = "/VO/Athena_0149", Text = "A resounding success." },
		{ Cue = "/VO/Athena_0150", Text = "A brilliant strategy." },
		{ Cue = "/VO/Athena_0151", Text = "Extraordinary." },
		{ Cue = "/VO/Athena_0152", Text = "Impressive!" },
		{ Cue = "/VO/Athena_0153", Text = "Thank the Fates." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.85,
		PreLineWait = 0.5,
		Queue = "Always",
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
				IsAny = { "SpellDrop" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "G", "H", "I", "Chaos" },
			},
		},

		{ Cue = "/VO/Selene_0298", Text = "Impressively retrieved." },
		{ Cue = "/VO/Selene_0299", Text = "The shadow-huntress strikes." },
		{ Cue = "/VO/Selene_0300", Text = "The huntress strikes again." },
		{ Cue = "/VO/Selene_0301", Text = "The outcome you desired." },
		{ Cue = "/VO/Selene_0302", Text = "Is that the one you sought?" },
		{ Cue = "/VO/Selene_0303", Text = "Outsmarted easily." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "UseRecord", "PoseidonUpgrade" }
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutFishing04" }
			},
		},
		{ Cue = "/VO/Poseidon_0334", Text = "She's all yours!" },
		{ Cue = "/VO/Poseidon_0331", Text = "Successfully procured!" },
		{ Cue = "/VO/Poseidon_0329", Text = "I knew you could do it!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsNone = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0330", Text = "What a show!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsNone = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0332", Text = "{#Emph}Well {#Prev}done!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsNone = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0333", Text = "Terrific work!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsNone = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0335", Text = "You didn't use the Rod...?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0336", Text = "That little {#Emph}monster!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0337", Text = "How did that cat...?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},
		{ Cue = "/VO/Poseidon_0338", Text = "A bit unsporting...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
		},

	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		ChanceToPlay = 0.33,
		PreLineWait = 0.41,
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "Chaos" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			{ Name = "ChaosSpokeRecently", Time = 30 },
		},

		{ Cue = "/VO/Chaos_0181", Text = "An interesting specimen." },
		{ Cue = "/VO/Chaos_0182", Text = "Specimen procured.", PlayFirst = true },
		{ Cue = "/VO/Chaos_0183", Text = "You found a specimen." },
		{ Cue = "/VO/Chaos_0184", Text = "You have procured something." },
		{ Cue = "/VO/Chaos_0185", Text = "That was amusing to behold." },
		{ Cue = "/VO/Chaos_0186", Text = "A show of certain skill..." },
	},
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		SuccessiveChanceToPlay = 0.1,
		SuccessiveChanceToPlayAll = 0.5,
		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "InspectPoint" },
				Comparison = ">=",
				Value = 40,
			},
			{
				Path = { "CurrentRun", "FishingSuccessesFamiliar" },
				Comparison = "<",
				Value = 1,
			},
			NamedRequirements = { "NoRecentInspectPointUsed" },
		},
		Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
		Cooldowns =
		{
			{ Name = "HomerSpokeRecently", Time = 420 },
		},

		{ Cue = "/VO/Storyteller_0309", Text = "{#Emph}Her prize procured from water, caught with grace." },
		{ Cue = "/VO/Storyteller_0310", Text = "{#Emph}Mere mortals never could achieve such skill." },
		{ Cue = "/VO/Storyteller_0311", Text = "{#Emph}A catch achievable only by gods." },
		{ Cue = "/VO/Storyteller_0312", Text = "{#Emph}Behold, another creature from the depths." },
		{ Cue = "/VO/Storyteller_0313", Text = "{#Emph}A sudden flash, and thus the catch is made." },
		{ Cue = "/VO/Storyteller_0314", Text = "{#Emph}Is there a water denizen she cannot catch?" },
	},
}

GlobalVoiceLines.SpellReactionVoiceLines =
{
	Cooldowns =
	{
		{ Name = "SpellReactionVOPlayedRecently", Time = 90 },
	},
	-- Hecate
	{
		BreakIfPlayed = true,
		PreLineWait = 1.8,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "Hecate",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">=",
				Value = 0.2,
			},
		},
		TriggerCooldowns = { "HecateSpokeRecently", },
		{
			RandomRemaining = true,
			PreLineWait = 1.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},
			{ Cue = "/VO/HecateField_0222", Text = "{#Emph}Dark Side...", PlayFirst = true },
			{ Cue = "/VO/HecateField_0221", Text = "...Oh!" },
			{ Cue = "/VO/HecateField_0223", Text = "Melinoë..." },
			{ Cue = "/VO/HecateField_0224", Text = "You..." },
			{ Cue = "/VO/HecateField_0225", Text = "There you are..." },
			{ Cue = "/VO/HecateField_0226", Text = "{#Emph}Ah-hah..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.6,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellMeteorTrait" },
				},
			},
			{ Cue = "/VO/HecateField_0227", Text = "The {#Emph}Eclipse...!", PlayFirst = true },
			{ Cue = "/VO/HecateField_0229", Text = "Selene, don't you dare..." },
			{ Cue = "/VO/HecateField_0230", Text = "Blood and darkness...!" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTimeSlowTrait" },
				},
			},

			{ Cue = "/VO/HecateField_0374", Text = "Phase Shift..." },
			{ Cue = "/VO/HecateField_0375", Text = "Phase Shift, was it?" },
			{ Cue = "/VO/HecateField_0376", Text = "Time can bend..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.2,

			{ Cue = "/VO/HecateField_0231", Text = "The Lunar Ray...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0228", Text = "The Moon...",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/HecateField_0142" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0232", Text = "Here it comes...",
				PreLineWait = 1,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0233", Text = "There, {#Emph}yes...!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0234", Text = "Wrath of the Moon...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait" },
					},
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/HecateField_0142" },
					},
				},
			},
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.65,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellSummonTrait" },
				},
			},
			{ Cue = "/VO/HecateField_0247", Text = "You brought a {#Emph}friend..." },
			{ Cue = "/VO/HecateField_0248", Text = "An attendant..." },
			{ Cue = "/VO/HecateField_0249", Text = "I know that one...", PlayFirst = true },
			{ Cue = "/VO/HecateField_0250", Text = "A little backup..." },
		},
	},
	-- Scylla
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.5,
		ObjectType = "Scylla",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "SpellSummonTrait" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
				IsAny = { "SirenDrummer", "SirenKeytarist", "CharybdisTentacle2" },
			},
		},
		TriggerCooldowns = { "ScyllaSpokeRecently" },

		{ Cue = "/VO/Scylla_0242", Text = "Roxy, how {#Emph}dare {#Prev}you!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenDrummer" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0243", Text = "Roxy, you {#Emph}traitor!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenDrummer" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0244", Text = "Snap out of it, Rox!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenDrummer" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0245", Text = "Roxy, wake up dammit!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenDrummer" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0246", Text = "Jetty, what is {#Emph}wrong {#Prev}with you?!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenKeytarist" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0247", Text = "What's gotten into Jetty?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenKeytarist" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0248", Text = "What did you do to Jetty?!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenKeytarist" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0249", Text = "Jetty, cut it {#Emph}out!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "SirenKeytarist" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0376", Text = "Control yourself, Charybdis!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "CharybdisTentacle2" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0377", Text = "Hands {#Emph}off{#Prev}, Charybdis!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "CharybdisTentacle2" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0378", Text = "Charybdis, get a {#Emph}hold {#Prev}of yourself!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "CharybdisTentacle2" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0379", Text = "Charybdis, snap {#Emph}out {#Prev}of it!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
					IsAny = { "CharybdisTentacle2" },
				},
			},
		},		
		{ Cue = "/VO/Scylla_0250", Text = "Quit messing with my band!" },
		{ Cue = "/VO/Scylla_0251", Text = "You {#Emph}cut {#Prev}that out!" },
		{ Cue = "/VO/Scylla_0252", Text = "Not {#Emph}this {#Prev}again!" },
		{ Cue = "/VO/Scylla_0253", Text = "You're breaking up the band!" },
		{ Cue = "/VO/Scylla_0183", Text = "{#Emph}Oh{#Prev}, come {#Emph}on!" },
		{ Cue = "/VO/Scylla_0184", Text = "That's {#Emph}not {#Prev}part of the {#Emph}act!" },
		{ Cue = "/VO/Scylla_0185", Text = "What did you {#Emph}do {#Prev}to her?" },
		{ Cue = "/VO/Scylla_0186", Text = "No {#Emph}fair!!" },
	},
	-- Polyphemus
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "Polyphemus",
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		TriggerCooldowns = { "CyclopsSpokeRecently" },

		{ Cue = "/VO/Polyphemus_0337", Text = "Don't like the sound of {#Emph}that..." },
		{ Cue = "/VO/Polyphemus_0338", Text = "{#Emph}Uhh..." },
		{ Cue = "/VO/Polyphemus_0339", Text = "Was that...?" },
		{ Cue = "/VO/Polyphemus_0340", Text = "What, that's {#Emph}it?" },
	},
	-- Eris
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		ObjectType = "Eris",
		SuccessiveChanceToPlay = 0.5,
		SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
				Comparison = ">=",
				Value = 0.2,
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		Cooldowns =
		{
			{ Name = "ErisSpokeRecently", Time = 10 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},

			{ Cue = "/VO/ErisField_0303", Text = "Oh, {#Emph}scary!" },
			{ Cue = "/VO/ErisField_0304", Text = "What's gotten into you?" },
			{ Cue = "/VO/ErisField_0305", Text = "Snap out of it, babe!" },
			{ Cue = "/VO/ErisField_0306", Text = "You're a {#Emph}freak!", PlayFirst = true },
			{ Cue = "/VO/ErisField_0307", Text = "So {#Emph}angry!" },
			{ Cue = "/VO/ErisField_0308", Text = "Big deal!" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.45,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellLaserTrait" },
				},
			},

			{ Cue = "/VO/ErisField_0309", Text = "Whoa, {#Emph}watch {#Prev}it!" },
			{ Cue = "/VO/ErisField_0310", Text = "I'll do the shooting, thanks!" },
			{ Cue = "/VO/ErisField_0311", Text = "Ooh {#Emph}shiny!" },
			{ Cue = "/VO/ErisField_0314", Text = "{#Emph}Whoa {#Prev}calm down!" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.6,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellSummonTrait" },
				},
			},

			{ Cue = "/VO/ErisField_0315", Text = "Turned one against me, {#Emph}eh?" },
			{ Cue = "/VO/ErisField_0316", Text = "They always stab me in the back..." },
			{ Cue = "/VO/ErisField_0317", Text = "You got a minion of your {#Emph}own!" },
			{ Cue = "/VO/ErisField_0318", Text = "Who's your new {#Emph}friend?", PlayFirst = true },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.5,

			{ Cue = "/VO/ErisField_0291", Text = "What did you just do?" },
			{ Cue = "/VO/ErisField_0292", Text = "Like {#Emph}that'll {#Prev}work!" },
			{ Cue = "/VO/ErisField_0293", Text = "Oh be {#Emph}quiet!" },
			{ Cue = "/VO/ErisField_0294", Text = "Stay out of this, {#Emph}Moon!" },
			{ Cue = "/VO/ErisField_0295", Text = "Whatever!" },
			{ Cue = "/VO/ErisField_0296", Text = "{#Emph}Lunatic!" },
			{ Cue = "/VO/ErisField_0312", Text = "Neat trick!" },
			{ Cue = "/VO/ErisField_0313", Text = "Hey what {#Emph}gives?" },
		},
	},
	-- Prometheus
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "Prometheus",
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		TriggerCooldowns = { "PrometheusSpokeRecently" },

		{ Cue = "/VO/Prometheus_0272", Text = "Impressive trick.", PlayFirst = true },
		{ Cue = "/VO/Prometheus_0273", Text = "Remarkable..." },
		{ Cue = "/VO/Prometheus_0274", Text = "The Moon..." },
		{ Cue = "/VO/Prometheus_0275", Text = "I see..." },
		{ Cue = "/VO/Prometheus_0276", Text = "Sure enough..." },
		{ Cue = "/VO/Prometheus_0277", Text = "Witchery..." },
		{ Cue = "/VO/Prometheus_0278", Text = "Magick..." },
		{ Cue = "/VO/Prometheus_0279", Text = "The wrath of gods..." },
	},
	-- Chronos
	{
		BreakIfPlayed = true,
		PreLineWait = 1.8,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "Chronos",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = ">=",
				Value = 0.25,
			},
		},
		TriggerCooldowns = { "ChronosSpokeRecently" },
		{
			RandomRemaining = true,
			PreLineWait = 1.25,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},
			{ Cue = "/VO/Chronos_0661", Text = "Angry now, are we?" },
			{ Cue = "/VO/Chronos_0662", Text = "Oh...!", PlayFirst = true },
			{ Cue = "/VO/Chronos_0663", Text = "Consumed by Darkness..." },
			{ Cue = "/VO/Chronos_0664", Text = "A new look!" },
			{ Cue = "/VO/Chronos_0665", Text = "A mere shadow." },
			{ Cue = "/VO/Chronos_0666", Text = "If you could see yourself." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.35,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellMeteorTrait" },
				},
			},

			{ Cue = "/VO/Chronos_0667", Text = "Invoking the Moon, {#Emph}here?", PlayFirst = true },
			{ Cue = "/VO/Chronos_0668", Text = "What did you just do...?" },
			{ Cue = "/VO/Chronos_0669", Text = "This again..." },
			{ Cue = "/VO/Chronos_0670", Text = "Augh, {#Emph}blast..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.65,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellSummonTrait" },
				},
			},

			{ Cue = "/VO/Chronos_1221", Text = "That Tempus there is {#Emph}mine!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
						IsAny = { "TimeElemental2" },
					},
				},
			},
			{ Cue = "/VO/Chronos_1222", Text = "Traitorous Tempus!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
						IsAny = { "TimeElemental2" },
					},
				},
			},
			{ Cue = "/VO/Chronos_1223", Text = "You have yourself a Tempus for a pet!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
						IsAny = { "TimeElemental2" },
					},
				},
			},
			{ Cue = "/VO/Chronos_1224", Text = "What is that Tempus {#Emph}doing?!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SummonEnemyName" },
						IsAny = { "TimeElemental2" },
					},
				},
			},
			{ Cue = "/VO/Chronos_0675", Text = "A traitor in my ranks." },
			{ Cue = "/VO/Chronos_0676", Text = "My legions are susceptible..." },
			{ Cue = "/VO/Chronos_0677", Text = "That is {#Emph}my {#Prev}servant!" },
			{ Cue = "/VO/Chronos_0678", Text = "Get your {#Emph}own {#Prev}servants!" },
			{ Cue = "/VO/Chronos_0920", Text = "You twist my servant's will!", PlayFirst = true },
			{ Cue = "/VO/Chronos_0921", Text = "What lunacy is {#Emph}this?" },
			{ Cue = "/VO/Chronos_0922", Text = "A betrayal...!" },
			{ Cue = "/VO/Chronos_0923", Text = "Manipulative witch...!" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.45,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellLaserTrait" },
				},
			},

			{ Cue = "/VO/Chronos_0671", Text = "Mere moonbeams...", PlayFirst = true, },
			{ Cue = "/VO/Chronos_0672", Text = "The Moon's own light..." },
			{ Cue = "/VO/Chronos_0673", Text = "Not bad..." },
			{ Cue = "/VO/Chronos_0674", Text = "The Moon shines even here..." },
		},
		-- some handled in GlobalVoiceLines.ChronosSpellResistVoiceLines
		-- SpellPolymorphReactionVoiceLines is below
	},

	-- Nemesis
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "NPC_Nemesis_01",
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		TriggerCooldowns = { "NemesisAnyQuipSpeech" },

		{ Cue = "/VO/NemesisField_0296", Text = "{#Emph}Huh." },
		{ Cue = "/VO/NemesisField_0297", Text = "Right..." },
		{ Cue = "/VO/NemesisField_0298", Text = "No fair..." },
		{ Cue = "/VO/NemesisField_0299", Text = "Seriously?" },
		{ Cue = "/VO/NemesisField_0300", Text = "No way..." },
		{ Cue = "/VO/NemesisField_0301", Text = "How..." },
	},
	-- Artemis
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "NPC_Artemis_Field_01",
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		TriggerCooldowns = { "ArtemisAnyQuipSpeech" },

		{ Cue = "/VO/Artemis_0454", Text = "Selene's gift..." },
		{ Cue = "/VO/Artemis_0457", Text = "Cheers, Selene!" },
		{ Cue = "/VO/Artemis_0458", Text = "Teamwork!" },
		{ Cue = "/VO/Artemis_0459", Text = "Moonlight..." },
		{ Cue = "/VO/Artemis_0455", Text = "That never works for {#Emph}me...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},
		},
		{ Cue = "/VO/Artemis_0456", Text = "The Silver Sisters special!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellLaserTrait" },
				},
			},
		},
		{ Cue = "/VO/Artemis_0462", Text = "You're fast...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTimeSlowTrait" },
				},
			},
		},
		{ Cue = "/VO/Artemis_0463", Text = "Where'd you go...?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTimeSlowTrait" },
				},
			},
		},
	},
	-- Icarus
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "NPC_Icarus_01",
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		TriggerCooldowns = { "IcarusAnyQuipSpeech" },

		{ Cue = "/VO/Icarus_0495", Text = "What was {#Emph}that...?", PlayFirst = true },
		{ Cue = "/VO/Icarus_0496", Text = "Moonlight..." },
		{ Cue = "/VO/Icarus_0497", Text = "The moon...!" },
		{ Cue = "/VO/Icarus_0498", Text = "Incredible..." },
		{ Cue = "/VO/Icarus_0500", Text = "{#Emph}Hah{#Prev}, look at that!" },
		{ Cue = "/VO/Icarus_0499", Text = "Where did you go...?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTimeSlowTrait" },
				},
			},
		},
		{ Cue = "/VO/Icarus_0501", Text = "Oh, gods..." },
		{ Cue = "/VO/Icarus_0502_B", Text = "{#Emph}Whoa...!" },
		{ Cue = "/VO/Icarus_0502_C", Text = "{#Emph}Whoa..." },
	},
	-- Heracles
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "NPC_Heracles_01",
		SuccessiveChanceToPlay = 0.5,
		SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		Cooldowns =
		{
			{ Name = "HeraclesAnyQuipSpeech", Time = 12 },
		},

		{ Cue = "/VO/Heracles_0081", Text = "You and your tricks..." },
		{ Cue = "/VO/Heracles_0082", Text = "Magick...", PlayFirst = true },
		{ Cue = "/VO/Heracles_0083", Text = "Tricksy..." },
		{ Cue = "/VO/Heracles_0484", Text = "Witch..." },
		{ Cue = "/VO/Heracles_0485", Text = "You and your magick..." },
		{ Cue = "/VO/Heracles_0486", Text = "How did..." },
		{ Cue = "/VO/Heracles_0487", Text = "Uncanny..." },
		{ Cue = "/VO/Heracles_0488", Text = "Unnatural..." },
		{ Cue = "/VO/Heracles_0489", Text = "{#Emph}Eugh..." },
	},
	-- Medea
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.05,
		ObjectTypes = { "Medea", "NPC_Medea_01" },
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 16 },
		},

		{ Cue = "/VO/Medea_0419", Text = "The Eye of Night...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SpellPotionTrait", "SpellLeapTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0420", Text = "By the Moon...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SpellPotionTrait", "SpellLeapTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0421", Text = "The Lunar Ray...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellLaserTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0423", Text = "Wolf Howl...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellLeapTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0424", Text = "Total Eclipse...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellMeteorTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0425", Text = "Sky Fall...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellMoonBeamTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0426", Text = "Dark Side...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0427", Text = "Your Dark Side...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTransformTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0428", Text = "Phase Shift...?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellTimeSlowTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0429", Text = "Moon Water...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellPotionTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0430", Text = "Night Bloom...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellSummonTrait" },
				},
			},
		},
		{ Cue = "/VO/Medea_0431", Text = "We have a guest...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SpellSummonTrait" },
				},
			},
		},
	},
	-- Zagreus
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "Zagreus",
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/Zagreus_0370", Text = "Hey, {#Emph}magick!", PlayFirst = true },
		{ Cue = "/VO/Zagreus_0371", Text = "Whoa." },
		{ Cue = "/VO/Zagreus_0372", Text = "Neat trick!" },
		{ Cue = "/VO/Zagreus_0373", Text = "Fancy!" },
		{ Cue = "/VO/Zagreus_0374", Text = "How'd you do that?" },
		{ Cue = "/VO/Zagreus_0375", Text = "How nice for you!" },
		{ Cue = "/VO/Zagreus_0376", Text = "Magick..." },
		{ Cue = "/VO/Zagreus_0377", Text = "Magick tricks..." },
	},
}
GlobalVoiceLines.SpellPolymorphReactionVoiceLines =
{
	Cooldowns =
	{
		{ Name = "SpellReactionVOPlayedRecently", Time = 45 },
		{ Name = "SpellPolymorphVOPlayedRecently", Time = 75 },
	},
	-- Hecate
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "Hecate",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">=",
				Value = 0.2,
			},
		},
		TriggerCooldowns = { "HecateSpokeRecently" },
		
		{ Cue = "/VO/HecateField_0213", Text = "My favored trick...", PlayFirst = true },
		{ Cue = "/VO/HecateField_0214", Text = "The Twilight Curse..." },
		{ Cue = "/VO/HecateField_0215", Text = "More beasts to go around..." },
		{ Cue = "/VO/HecateField_0216", Text = "Apologies, Sisters...!" },
		{ Cue = "/VO/HecateField_0217", Text = "The tables turn." },
		{ Cue = "/VO/HecateField_0218", Text = "Uncalled for!" },
	},
	-- Artemis
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Artemis_Field_01",
		SuccessiveChanceToPlay = 0.5,
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "ArtemisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/Artemis_0460", Text = "Hunting livestock, sure.", PlayFirst = true },
		{ Cue = "/VO/Artemis_0461", Text = "Easy targets." },
	},
	-- Polyphemus
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "Polyphemus",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">=",
				Value = 0.2,
			},
		},
		TriggerCooldowns = { "CyclopsSpokeRecently" },

		{ Cue = "/VO/Polyphemus_0315", Text = "What do you know, more sheep!" },
		{ Cue = "/VO/Polyphemus_0316", Text = "Hey, where'd you get the sheep?" },
		{ Cue = "/VO/Polyphemus_0317", Text = "Wait, these aren't my sheep..." },
		{ Cue = "/VO/Polyphemus_0318", Text = "{#Emph}<Sniff> {#Prev}More sheep?", PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0319", Text = "More sheep out of thin air?" },
		{ Cue = "/VO/Polyphemus_0320", Text = "Hey, how'd you make more sheep?" },
	},
	-- Medea
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.05,
		ObjectTypes = { "Medea", "NPC_Medea_01" },
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 16 },
		},

		{ Cue = "/VO/Medea_0422", Text = "The Twilight Curse..." },
	},
	-- Eris
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "Eris",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
				Comparison = ">=",
				Value = 0.2,
			},
		},
		TriggerCooldowns = { "ErisSpokeRecently" },
		
		{ Cue = "/VO/ErisField_0297", Text = "{#Emph}Haha, wow!" },
		{ Cue = "/VO/ErisField_0298", Text = "You're {#Emph}mean!" },
		{ Cue = "/VO/ErisField_0299", Text = "You {#Emph}animal!" },
		{ Cue = "/VO/ErisField_0300", Text = "{#Emph}Aw, sheep!", PlayFirst = true },
	},
	-- Chronos
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "Chronos",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = ">=",
				Value = 0.25,
			},
		},
		TriggerCooldowns = { "ChronosSpokeRecently" },

		{ Cue = "/VO/Chronos_0653", Text = "My {#Emph}legions!" },
		{ Cue = "/VO/Chronos_0654", Text = "Such mockery." },
		{ Cue = "/VO/Chronos_0655", Text = "Such nonsense!" },
		{ Cue = "/VO/Chronos_0656", Text = "You are the sheep here." },
		{ Cue = "/VO/Chronos_0657", Text = "This foul trick." },
		{ Cue = "/VO/Chronos_0658", Text = "Livestock..." },
	},

}

-- Global Zeus Lines
GlobalVoiceLines.ZeusInstaKillVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
		Cooldowns =
		{
			{ Name = "ZeusInstantKillSpeech", Time = 20 },
		},

		{ Cue = "/VO/Zeus_0178", Text = "Smitten!", PlayFirst = true },
		{ Cue = "/VO/Zeus_0179", Text = "Perish.", PlayFirst = true },
		{ Cue = "/VO/Zeus_0180", Text = "Shocking!", PlayFirst = true },
		{ Cue = "/VO/Zeus_0181", Text = "{#Emph}Zap." },
		{ Cue = "/VO/Zeus_0182", Text = "Thunder!" },
		{ Cue = "/VO/Zeus_0183", Text = "Lightning!" },

		--[[
		{ Cue = "/VO/Zeus_0101", Text = "{#Emph}This {#Prev}shall come as a shock!", PlayFirst = true },
		{ Cue = "/VO/Zeus_0102", Text = "A storm is coming..." },
		{ Cue = "/VO/Zeus_0103", Text = "Behold my thunderbolts!" },
		]]--
	},
}

-- Global Hestia Lines
GlobalVoiceLines.HestiaSacrificeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },
		GameStateRequirements =
		{
			--
		},
		{ Cue = "/VO/Hestia_0093", Text = "Well now!" },
		{ Cue = "/VO/Hestia_0094", Text = "Oh-ho-{#Emph}ho!", PlayFirst = true },
		{ Cue = "/VO/Hestia_0095", Text = "Oh my." },
		{ Cue = "/VO/Hestia_0179", Text = "Smart girl!" },
	},
}


-- Global Dionysus Lines
GlobalVoiceLines.SkippedEncounterVoiceLines =
{
	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 0.85 },
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		Source = { LineHistoryName = "NPC_Dionysus_01", SubtitleColor = Color.DionysusVoice },

		{ Cue = "/VO/Dionysus_0268", Text = "{#Emph}Yeah, hahahaha!" },
		{ Cue = "/VO/Dionysus_0269", Text = "{#Emph}Niiice!" },
		{ Cue = "/VO/Dionysus_0270", Text = "{#Emph}Relaaax!" },
		{ Cue = "/VO/Dionysus_0271", Text = "{#Emph}Take it easy!" },
		{ Cue = "/VO/Dionysus_0273", Text = "{#Emph}All you, Mel baby!" },
		{ Cue = "/VO/Dionysus_0274", Text = "{#Emph}It's your lucky night!", PlayFirst = true },
		{ Cue = "/VO/Dionysus_0275", Text = "{#Emph}Take a load off!" },
		{ Cue = "/VO/Dionysus_0272", Text = "{#Emph}Where'd everybody go...?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					CountOf =
					{
						"/VO/Dionysus_0268", "/VO/Dionysus_0269", "/VO/Dionysus_0270", "/VO/Dionysus_0271", "/VO/Dionysus_0272", "/VO/Dionysus_0273", "/VO/Dionysus_0274", "/VO/Dionysus_0275"
					},
					Comparison = ">=",
					Value = 6,
				},
			}
		},
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.1,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.1,
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
		},

		{ Cue = "/VO/MelinoeField_2812", Text = "A moment of peace..." },
		{ Cue = "/VO/MelinoeField_2814", Text = "The Fig Leaf took effect.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2815", Text = "Cheers, Dionysus sir." },
		{ Cue = "/VO/MelinoeField_2813", Text = "No foes in sight...",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Dionysus_0274" }
				},
			},
		},
	},
	{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
}

-- Global Hypnos Lines
GlobalVoiceLines.HypnosAwakenedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.15,
	ObjectType = "NPC_Hypnos_01",
	SkipAnim = true,

	-- Removed Hypnos VO
}
GlobalVoiceLines.HypnosDozingOffVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.15,
	SkipAnim = true,
	Actor = "SleepyBoyOcclusion",
	ObjectType = "NPC_Hypnos_01",

	-- Removed Hypnos VO
}

GlobalVoiceLines.HypnosDreamSaluteVoiceLines =
{
	{
		PreLineWait = 0.3,
		RandomRemaining = true,
		UsePlayerSource = true,
		-- RandomRemaining = true,
		Cooldowns =
		{
			{ Name = "MelinoeSaluteSpeech", Time = 4 },
		},
		{ Cue = "/VO/Melinoe_1883", Text = "Rest easy, Son of Nyx.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3575", Text = "You look comfortable." },
		{ Cue = "/VO/Melinoe_3576", Text = "Not a care in the world." },
		{ Cue = "/VO/Melinoe_3577", Text = "You're safe here..." },
		{ Cue = "/VO/Melinoe_3578", Text = "Moonlight guide you." },
	},
}

-- Global Skelly Lines
GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.6,
	SuccessiveChanceToPlay = 0.15,
	ObjectType = "NPC_Skelly_01",
	Cooldowns =
	{
		{ Name = "SkellyAnyQuipSpeech", Time = 35 },
	},

	{ Cue = "/VO/Skelly_0016", Text = "A fine choice." },
	{ Cue = "/VO/Skelly_0017", Text = "Care to try it out?" },
	{ Cue = "/VO/Skelly_0032", Text = "A wise selection." },
	{ Cue = "/VO/Skelly_0216", Text = "{#Emph}Ahh{#Prev}, yes!" },
	{ Cue = "/VO/Skelly_0035", Text = "Use caution with that thing." },
	{ Cue = "/VO/Skelly_0415", Text = "Feel like that one, huh?" },
	{ Cue = "/VO/Skelly_0416", Text = "Back to basics, huh?",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0033", Text = "That's no mere walking stick you got there!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0417", Text = "Cut 'em up, kiddo.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0034", Text = "Those blades cut to the bone!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0210", Text = "Stick it to 'em for me!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0211", Text = "Always up for some slicing.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger", "WeaponAxe" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0418", Text = "Hack 'em all to bits!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger", "WeaponAxe" },
			},
		},
	},
	{ Cue = "/VO/Skelly_0036", Text = "The time has come for some slicing huh?",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger", "WeaponAxe" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0208", Text = "Go light 'em up, kiddo.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0209", Text = "Shine on with those!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0419", Text = "Burn bright, young one.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" }
			},
		},
	},
	{ Cue = "/VO/Skelly_0212", Text = "Lay into 'em with that!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0213", Text = "Oh that's my favorite one.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0214", Text = "Taking Momma for a spin!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0215", Text = "Show Momma a good time.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0204", Text = "The second-finest skull!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0205", Text = "Now you're thinking.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0206", Text = "Give 'em a blast for me.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob", "WeaponSuit" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0207", Text = "The mystic cranium!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0420", Text = "Dressed for success!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0421", Text = "All suited up?",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0422", Text = "Hey nice Coat!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
			}
		},
	},
	{ Cue = "/VO/Skelly_0423", Text = "Sock it to 'em for me.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
			}
		},
	},
}
GlobalVoiceLines.SkellyRootReactionVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentHubRoom", "Name" },
			IsAny = { "Hub_PreRun"},
		},
	},
	Cooldowns =
	{
		{ Name = "SkellyOnHitSpeech", Time = 8 },
		{ Name = "SkellyRootedSpeech", Time = 60 },
	},
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.33,
		ObjectType = "NPC_Skelly_01",

		{ Cue = "/VO/Skelly_0378", Text = "I am {#Emph}ensnared!", PlayFirst = true },
		{ Cue = "/VO/Skelly_0379", Text = "I can't {#Emph}move!" },
		{ Cue = "/VO/Skelly_0380", Text = "I'm {#Emph}stuck!" },
		{ Cue = "/VO/Skelly_0381", Text = "Immobilized!" },
		{ Cue = "/VO/Skelly_0382", Text = "I'm {#Emph}trapped!" },
		{ Cue = "/VO/Skelly_0383", Text = "I am held fast!" },
	}
}
GlobalVoiceLines.SkellyManaFountainReactionVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentHubRoom", "Name" },
			IsAny = { "Hub_PreRun"},
		},
	},
	Cooldowns =
	{
		{ Name = "SkellyAnyQuipSpeech", Time = 9 },
		{ Name = "SkellyManaFullSpeech", Time = 30 },
	},
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Skelly_01",

		{ Cue = "/VO/Skelly_0356", Text = "Got all your magick back.", PlayFirst = true },
		{ Cue = "/VO/Skelly_0357", Text = "Magick's back to full!" },
	}
}

GlobalVoiceLines.InventoryOpenedVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "SkellyInventoryObjectiveVO",
		PreLineWait = 0.65,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ActiveObjectiveSet" },
				IsAny = { "SkellyInventoryQuest" },
			},
		},

		{ Cue = "/VO/Skelly_0366", Text = "{#Emph}Yeah{#Prev}, that's what I'm talkin' about." },
	}
}

-- Global Athena Lines
GlobalVoiceLines.AthenaGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Athena_01",
	Cooldowns =
	{
		{ Name = "AthenaSpokeRecently", Time = 6 },
	},

	{ Cue = "/VO/Athena_0135", Text = "Something of value?" },
	{ Cue = "/VO/Athena_0136", Text = "If that is of use." },
	{ Cue = "/VO/Athena_0137", Text = "Keen eye." },
	{ Cue = "/VO/Athena_0138", Text = "Take what you require." },
	{ Cue = "/VO/Athena_0140", Text = "Help yourself.",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "P" },
			},
		},
	},
	{ Cue = "/VO/Athena_0139", Text = "Come on, Cousin.",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
			},
		},
	},
	{ Cue = "/VO/Athena_0141", Text = "I'm waiting...",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
			},
		},
	},
}

-- Global Storyteller Lines
GlobalVoiceLines.StorytellerRunStartVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 2.0,
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "InspectPoint" },
			Comparison = ">=",
			Value = 10,
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
		},
		ChanceToPlay = 0.1,
	},

	Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
	StatusAnimation = "StatusIconStorytellerSpeaking",
	StatusAnimSourceIsHero = true,

	{ Cue = "/VO/Storyteller_0103", Text = "{#Emph}Again sets forth the Princess of the Dead..." },
	{ Cue = "/VO/Storyteller_0104", Text = "{#Emph}Once more the Princess sets upon her task." },
	{ Cue = "/VO/Storyteller_0105", Text = "{#Emph}Thus the relentless Princess starts again." },
	{ Cue = "/VO/Storyteller_0106", Text = "{#Emph}She steps into the fetid surface air...", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},
	},
}

GlobalVoiceLines.StorytellerFightReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		RecheckRequirementsPostWait = true,
		-- always play if Mel prompts it, max. once per run
		-- SuccessiveChanceToPlay = 0.75,
		-- SuccessiveChanceToPlayAll = 0.1,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_0861", "/VO/Melinoe_0862", "/VO/Melinoe_0863", "/VO/Melinoe_0864", "/VO/Melinoe_1129", "/VO/Melinoe_1130", "/VO/Melinoe_1131", "/VO/Melinoe_1379" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
			},
			{
				Path = { "ActiveScreens" },
				HasNone = { "Dialog", "UpgradeChoice" },
			},
		},

		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
		ThreadName = "RoomThread",

		{ Cue = "/VO/Storyteller_0060", Text = "{#Emph}Splendid was the Princess in her fight." },
		{ Cue = "/VO/Storyteller_0061", Text = "{#Emph}Fearless Melinoë continues undeterred." },
		{ Cue = "/VO/Storyteller_0062", Text = "{#Emph}Her foes, all vanquished to the last." },
		{ Cue = "/VO/Storyteller_0065", Text = "{#Emph}The Princess brings her many foes to heel." },
		{ Cue = "/VO/Storyteller_0071", Text = "{#Emph}Though Time cannot be stopped, neither can she." },
		{ Cue = "/VO/Storyteller_0073", Text = "{#Emph}A victory, yet Time our foe remains!" },
		{ Cue = "/VO/Storyteller_0074", Text = "{#Emph}Sing, O Muse." },
		{ Cue = "/VO/Storyteller_0076", Text = "{#Emph}Such wondrous spectacle." },
		{ Cue = "/VO/Storyteller_0363", Text = "{#Emph}After the fury of that battle, calm." },
		{ Cue = "/VO/Storyteller_0364", Text = "{#Emph}Again her foes are utterly destroyed." },
		{ Cue = "/VO/Storyteller_0366", Text = "{#Emph}Her victory achieved, she presses on." },
		{ Cue = "/VO/Storyteller_0368", Text = "{#Emph}Few traces of her cruel foes remain." },
		{ Cue = "/VO/Storyteller_0370", Text = "{#Emph}Another battle fought with skill and grace." },
		{ Cue = "/VO/Storyteller_0362", Text = "{#Emph}The Titan's forces, shattered at her feet.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "I", "O" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0369", Text = "{#Emph}She stands alone, unless you count her pet.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EquippedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0371", Text = "{#Emph}Her foes did not so much as touch her in that bout.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 1.0, },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0374", Text = "{#Emph}The worst of Erebus, fallen like leaves.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_MiniBoss01", "F_MiniBoss02" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0375", Text = "{#Emph}The deadliest of Oceanus, gone.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_MiniBoss01", "O_MiniBoss02", "O_MiniBoss03" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0376", Text = "{#Emph}The Daemons of the Mourning Fields, dispersed.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "H_MiniBoss01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0377", Text = "{#Emph}Even the Titan's strongest Satyrs were no match.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_MiniBoss01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0378", Text = "{#Emph}A captain of the Titan's guard, vanquished.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_MiniBoss01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0379", Text = "{#Emph}That fearsome maw retreats into the depths.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_MiniBoss01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0380", Text = "{#Emph}That dreaded sailor, driven to the depths.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_MiniBoss02" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0381", Text = "{#Emph}One fewer countless dangers on the mountaintop.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "P_MiniBoss01", "P_MiniBoss02" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0382", Text = "{#Emph}The greatest of Automatons, destroyed.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "P_MiniBoss01" },
				},
			},
		},
		{ Cue = "/VO/Storyteller_0383", Text = "{#Emph}Monstrous Typhon's hateful brood, repelled.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_MiniBoss02", "Q_MiniBoss05" },
				},
			},
		},		
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_0861", "/VO/Melinoe_0862", "/VO/Melinoe_0863", "/VO/Melinoe_1129", "/VO/Melinoe_1133", "/VO/Melinoe_1134", "/VO/Melinoe_1531" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
			},
		},
		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
		ThreadName = "RoomThread",

		{ Cue = "/VO/Storyteller_0058", Text = "{#Emph}Whither goes the Princess, so shall I." },
		{ Cue = "/VO/Storyteller_0072", Text = "{#Emph}The Princess calls into the dark, to no avail." },
		{ Cue = "/VO/Storyteller_0075", Text = "{#Emph}Hail Princess, light of the Moon." },
		{ Cue = "/VO/Storyteller_0365", Text = "{#Emph}None can escape the Princess of the Dead." },
		{ Cue = "/VO/Storyteller_0367", Text = "{#Emph}Shades of the dead, her only witnesses." },
		{ Cue = "/VO/Storyteller_0372", Text = "{#Emph}All is quiet once again, for now." },
		{ Cue = "/VO/Storyteller_0373", Text = "{#Emph}Now only death and the Princess remain." },
	},
}
GlobalVoiceLines.StorytellerReturnToHubVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.1,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_0861", "/VO/Melinoe_0862", "/VO/Melinoe_0863", "/VO/Melinoe_0864", "/VO/Melinoe_1129", "/VO/Melinoe_1379" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "N", },
			},
			NamedRequirements = { "NoRecentInspectPointUsed" },
		},
		Cooldowns =
		{
			{ Name = "HomerSpokeRecently", Time = 420 },
		},

		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
		ThreadName = "RoomThread",

		{ Cue = "/VO/Storyteller_0408", Text = "{#Emph}Thus she returns to the Ephyra square." },
		{ Cue = "/VO/Storyteller_0409", Text = "{#Emph}Steadily, she retraces her steps." },
		{ Cue = "/VO/Storyteller_0410", Text = "{#Emph}Her work here for the night is done." },
		{ Cue = "/VO/Storyteller_0411", Text = "{#Emph}Back to the heart of the necropolis." },
	},
}

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
	{ Cue = "/VO/Melinoe_1749", Text = "This will be over soon." },
	{ Cue = "/VO/Melinoe_1748", Text = "This does not belong to you.",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "BiomesReached", "P" },
			},
		},
	},
}
GlobalVoiceLines.ChallengeEncounterClearedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.33,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
	},

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
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "EncounterType" },
			IsNone = { "EliteChallenge", "PerfectClear" },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
	},

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
GlobalVoiceLines.EliteEncounterInitiatedLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.33,

		{ Cue = "/VO/MelinoeField_2756", Text = "Reveal yourself, whoever haunts this shrine." },
		{ Cue = "/VO/MelinoeField_2757", Text = "You cannot hide from us." },
		{ Cue = "/VO/MelinoeField_2758", Text = "Show yourself by the light of the Moon.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2759", Text = "What haunts this place, come forth!" },
		{ Cue = "/VO/MelinoeField_2760", Text = "Selene, show my foe to me." },
		{ Cue = "/VO/MelinoeField_2761", Text = "Who dares disturb this Monument?" },
	},
}
GlobalVoiceLines.EliteEncounterClearedLines =
{
	RandomRemaining = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.33,
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/MelinoeField_2762", Text = "Monument cleansed." },
	{ Cue = "/VO/MelinoeField_2763", Text = "Washed in moonlight." },
	{ Cue = "/VO/MelinoeField_2764", Text = "Thank you, Selene." },
	{ Cue = "/VO/MelinoeField_2765", Text = "For Sister Selene." },
	{ Cue = "/VO/MelinoeField_2766", Text = "This is our Monument." },
	{ Cue = "/VO/MelinoeField_2767", Text = "I saw clear through my prey." },
}

GlobalVoiceLines.PerfectClearEncounterInitiatedLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.33,

		{ Cue = "/VO/MelinoeField_2769", Text = "{#Emph}To be Unseen is to be unscathed." },
		{ Cue = "/VO/MelinoeField_2770", Text = "{#Emph}To be Unseen is to become as mist." },
		{ Cue = "/VO/MelinoeField_2771", Text = "I'll slay you all without a scratch.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2772", Text = "Come catch me if you can..." },
		{ Cue = "/VO/MelinoeField_2773", Text = "Think you can catch me?" },
		{ Cue = "/VO/MelinoeField_2774", Text = "I should be able to avoid this lot." },
	},
}
GlobalVoiceLines.PerfectClearGotHitVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.2,
	Queue = "Interrupt",
	TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
	Cooldowns =
	{
		{ Name = "MelPerfectClearGotHitSpeech", Time = 300 },
	},

	{ Cue = "/VO/MelinoeField_2775", Text = "{#Emph}Ah{#Prev}, blast...!" },
	{ Cue = "/VO/MelinoeField_2776", Text = "{#Emph}Augh{#Prev}, well there goes that...", PlayFirst = true },
	{ Cue = "/VO/MelinoeField_2777", Text = "{#Emph}Ngh{#Prev}, I'm hit...!" },
	{ Cue = "/VO/MelinoeField_2778", Text = "{#Emph}Ungh{#Prev}, come on..." },
	{ Cue = "/VO/MelinoeField_2779", Text = "{#Emph}Guh{#Prev}, they got me there..." },
	{ Cue = "/VO/MelinoeField_2780", Text = "{#Emph}Augh{#Prev}, embarrassing..." },
}
GlobalVoiceLines.PerfectClearEncounterConcludedLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.33,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "ChallengeEncounter", "PlayerTookDamage" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_2781", Text = "Could have gone better..." },
		{ Cue = "/VO/MelinoeField_2782", Text = "Not as Unseen as I would like..." },
		{ Cue = "/VO/MelinoeField_2783", Text = "At least I saw it through...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2784", Text = "A consolation prize..." },
		{ Cue = "/VO/MelinoeField_2785", Text = "A learning experience." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "ChallengeEncounter", "PlayerTookDamage" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_2787", Text = "{#Emph}In shadow, I serve." },
		{ Cue = "/VO/MelinoeField_2788", Text = "For the Underworld." },
		{ Cue = "/VO/MelinoeField_2789", Text = "We are as shadows." },
		{ Cue = "/VO/MelinoeField_2790", Text = "I proved myself this time..." },
		{ Cue = "/VO/MelinoeField_2791", Text = "From the King and Queen..." },
		{ Cue = "/VO/MelinoeField_2792", Text = "As the shadows dance." },
	},
}
GlobalVoiceLines.PerfectClearEncounterClearedLines =
{
}
GlobalVoiceLines.MetaRewardStandUsedVoiceLines =
{
	PlayOnce = true,
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.45,
	-- SuccessiveChanceToPlayAll = 0.5,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
	},

	{ Cue = "/VO/MelinoeField_3568", Text = "For having come this far on such a night..." },
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

-- Summit
GlobalVoiceLines.PalaceEntranceUsedVoiceLines =
{
	Queue = "Interrupt",
	{
		PlayOnce = true,
		PreLineWait = 0.35,
		RandomRemaining = true,

		{ Cue = "/VO/MelinoeField_3457", Text = "{#Emph}To all my family on the mountain, let me pass...?" },
	},
	{
		PreLineWait = 0.35,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3457" }
			},
		},

		{ Cue = "/VO/MelinoeField_3457", Text = "{#Emph}To all my family on the mountain, let me pass...?", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3458", Text = "{#Emph}To all my family on the mountain, let me pass." },
		{ Cue = "/VO/MelinoeField_3459", Text = "{#Emph}To all my family on the mountain, let me pass!" },
	},
	{
		PreLineWait = 4.25,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
		{ Cue = "/VO/MelinoeField_1275", Text = "It worked..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 2.25,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},

		{ Cue = "/VO/MelinoeField_3460", Text = "{#Emph}Aah...!" },
		{ Cue = "/VO/MelinoeField_3461", Text = "{#Emph}<Gasp>" },
		{ Cue = "/VO/MelinoeField_3462", Text = "{#Emph}So... bright...", PlayFirst = true, PreLineWait = 3.25 },
	},
}

GlobalVoiceLines.PalaceObservationVoiceLines =
{
	UsePlayerSource = true,
	RandomRemaining = true,
	BreakIfPlayed = true,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.33,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
		{ Name = "MelinoePalaceObservationSpeech", Time = 30 },
	},

	{ Cue = "/VO/MelinoeField_4246", Text = "I think I know everyone here..." },
	{ Cue = "/VO/MelinoeField_4247", Text = "The family..." },
	{ Cue = "/VO/MelinoeField_4248", Text = "This is only the courtyard..." },
	{ Cue = "/VO/MelinoeField_4249", Text = "Where are the others...?" },
	{ Cue = "/VO/MelinoeField_4250", Text = "Such a place..." },
	{ Cue = "/VO/MelinoeField_4251", Text = "It's warmer than I thought..." },
}

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
		{ Cue = "/VO/MelinoeField_1271", Text = "On my authority as Princess of the Underworld: {#Emph}Unseal...!", PreLineWait = 0.5, BreakIfPlayed = true },
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
	Queue = "Interrupt",
	{
		PreLineWait = 0.35,

		{ Cue = "/VO/MelinoeField_1270", Text = "Please work..." },
		{ Cue = "/VO/MelinoeField_1272", Text = "On my authority as Princess of the Underworld: {#Emph}Unseal.", PreLineWait = 1.0 },

		{ Cue = "/VO/MelinoeField_1472", Text = "Blood and...", PreLineWait = 2.33, PreLineAnim = "MelTalkBroodingFull01" },
		{ Cue = "/VO/Melinoe_0224", Text = "Won't open.", PreLineWait = 1.1 },
		{ Cue = "/VO/Melinoe_0215", Text = "How about...", PreLineWait = 1.25 },
	},
}

