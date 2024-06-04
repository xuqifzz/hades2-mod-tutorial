MusicTrackData =
{
	F =
	{
		{ Name = "/Music/IrisMusicExploration2_MC" },
		{ Name = "/Music/IrisMusicExploration1_MC" },
		{ Name = "/Music/IrisMusicErebus2_MC" },
	},
	G =
	{
		{
			Name = "/Music/IrisMusicScylla1_MC",
			TrackStartEvents =
			{
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "BiomeMusicPlayCounts", "G" },
							Modulo = 4,
							Comparison = "==",
							Value = 2,
						},
					},
					FunctionName = "MusicSetTrackOffset",
					Args =
					{
						TrackOffset = 34.194,
					},
					FailedFunctionName = "SetPathValue",
					FailedFunctionArgs =
					{
						TablePath = { "SessionMapState", },
						Key = "Humming",
						Value = true
					},
				},
			},
		},
		{
			Name = "/Music/IrisMusicScylla2_MC",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "G_PostBoss01" },
				},
			},
			TrackStartEvents =
			{
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "BiomeMusicPlayCounts", "G" },
							Modulo = 4,
							Comparison = "==",
							Value = 3,
						},
					},
					FunctionName = "MusicSetTrackOffset",
					Args =
					{
						TrackOffset = 28.168,
					},
					FailedFunctionName = "SetPathValue",
					FailedFunctionArgs =
					{
						TablePath = { "SessionMapState", },
						Key = "Humming",
						Value = true
					},
				},
			},
		},
	},
	H =
	{
		{ Name = "/Music/IrisMusicMourningFields1_MC" },
		{ Name = "/Music/IrisMusicMourningFields2_MC" },
	},
	I =
	{
		{ Name = "/Music/IrisMusicClockworkTartarus_MC" },
	},
	N =
	{
		{ Name = "/Music/IrisMusicFilthyArp_MC" },
		{ Name = "/Music/IrisMusicEphyra2_MC" },
		{ Name = "/Music/IrisMusicEphyra3_MC" },
	},
	O =
	{
		{ Name = "/Music/IrisMusicShips1_MC" },
		{ Name = "/Music/IrisMusicShips2_MC" },
	},
}

RoomStartMusicEvents =
{
	-- Underworld Run
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "RunDepthCache" },
				Comparison = "==",
				Value = 2,
			},
			{
				-- Actually started in Erebus, not faked from a Bounty
				Path = { "CurrentRun", "RoomsEntered" },
				HasAny = { "F_Opening01", "F_Opening02", "F_Opening03", },
			},
		},
		MusicSection = 2,
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "RunDepthCache" },
				Comparison = "==",
				Value = 3,
			},
			{
				-- Actually started in Erebus, not faked from a Bounty
				Path = { "CurrentRun", "RoomsEntered" },
				HasAny = { "F_Opening01", "F_Opening02", "F_Opening03", },
			},
		},
		MusicSection = 3,
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "RunDepthCache" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "Styx", "G", },
			},
			RequiredMusicSection = 0,
			RequiredMusicSectionRoomDuration = 2,
		},
		MusicSection = 1,
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				PathFalse = { "AudioState", "MusicId" },
			},
			{
				PathFalse = { "AudioState", "SecretMusicId" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Intro", "H_Intro", "I_Intro", "G_Reprieve01", "H_Reprieve01", "I_Reprieve01", "I_Boss01" },
			},
		},
		PlayBiomeMusic = true,
		MusicSection = 0,
		UseRoomMusicSection = true,
	},
	-- Oceanus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Story01", },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		MusicActiveStems = { "Vocals" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
			},
		},
		MusicSection = 0,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "GameState", "BiomeMusicPlayCounts", "G" },
				Modulo = 4,
				Comparison = "<=",
				Value = 1,
			},
			RequiredMusicSection = 0,
			-- RequiredMusicSectionRoomDuration = 2,
		},
		MusicSection = 1,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "GameState", "BiomeMusicPlayCounts", "G" },
				Modulo = 4,
				Comparison = ">=",
				Value = 2,
			},
			RequiredMusicSection = 0,
			-- RequiredMusicSectionRoomDuration = 2,
		},
		MusicSection = 3,
	},
	-- Fields
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "H" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "==",
				Value = 2,
			},
			{
				Path = { "AudioState", "MusicSection" },
				Comparison = "==",
				Value = 0,
			},
		},
		MusicSection = 1,
	},
	-- Tartarus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss01", "I_MiniBoss02" },
			},
		},
		FunctionName = "GenericPresentation",
		FunctionArgs =
		{
			SetSoundCueValues =
			{
				{
					Name = "Miniboss",
					Value = 1.0,
					AudioStateId = "MusicId",
					Duration = 0.75,
				}
			},
		},
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "I", },
			},
			{
				Path = { "CurrentRun", "RemainingClockworkGoals", },
				Comparison = "<=",
				Value = 1,
			},
		},
		MusicActiveStems = { "Guitar", "Drums", "Bass", },
	},

	-- Surface Run
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				PathFalse = { "AudioState", "MusicId" },
			},
			{
				PathFalse = { "AudioState", "SecretMusicId" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Intro", },
			},
		},
		PlayBiomeMusic = true,
		MusicSection = 0,
		UseRoomMusicSection = true,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Hub" },
			},
			RequiredMusicSection = 0,
		},
		MusicSection = 1,
		UseRoomMusicSection = true,
	},	
}

CombatOverMusicEvents =
{
	{
		GameStateRequirements =
		{
			RequiredMinDepth = 3,
			RequiredMusicName = "/Music/MusicRunstart_MC",
		},
		EndMusic = true,
	},
	{
		GameStateRequirements =
		{
			-- None
		},
		MusicMutedStems = { "Drums", },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss01", "I_MiniBoss02" },
			},
		},
		FunctionName = "GenericPresentation",
		FunctionArgs =
		{
			SetSoundCueValues =
			{
				{
					Name = "Miniboss",
					Value = 0.0,
					AudioStateId = "MusicId",
					Duration = 0.75,
				}
			},
		},
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
			RequiredMinHealthFraction = 1.0,
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
		},

		{ Cue = "/VO/Melinoe_0250", Text = "{#Emph}Whew." },
		{ Cue = "/VO/Melinoe_0251", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_0252", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0253", Text = "{#Emph}<Sigh>" },
		{ Cue = "/VO/Melinoe_1122", Text = "Pure water...", PreLineWait = 0.9 },
		{ Cue = "/VO/Melinoe_1841", Text = "Needed that..." },
		{ Cue = "/VO/Melinoe_1842", Text = "Clean..." },
		{ Cue = "/VO/Melinoe_1843", Text = "OK..." },
		{ Cue = "/VO/Melinoe_1844", Text = "That's good..." },
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
		ObjectType = "NPC_Chronos_01",
		Cooldowns =
		{
			{ Name = "ChronosAnyQuipSpeech", Time = 8 },
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
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	{ Cue = "/VO/MelinoeField_0610", Text = "Let's have a look around..." },
	{ Cue = "/VO/MelinoeField_0611", Text = "Let's see..." },
	{ Cue = "/VO/MelinoeField_0612", Text = "What else is here..." },
	{ Cue = "/VO/MelinoeField_0613", Text = "Let's get the lay of the land..." },
	{ Cue = "/VO/MelinoeField_0614", Text = "Show me the surroundings." },
	{ Cue = "/VO/MelinoeField_0615", Text = "Where else can we go." },
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

GlobalVoiceLines.StartPackagedBountyRunVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.66,
		SuccessiveChanceToPlayAll = 0.5,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "F", "N" },
			},
		},

		{ Cue = "/VO/Melinoe_2630", Text = "The Pitch-Black Stone transported me..." },
		{ Cue = "/VO/Melinoe_2631", Text = "Already come this far..." },
		{ Cue = "/VO/MelinoeField_2108", Text = "Here already..." },
		{ Cue = "/VO/MelinoeField_2109", Text = "Skipped me ahead..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.66,
		SuccessiveChanceToPlayAll = 0.5,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "ActiveBounty" },
				IsNone = { "PackageBountyChaosIntro" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
		},

		{ Cue = "/VO/Melinoe_1427", Text = "My loadout's changed." },
		{ Cue = "/VO/Melinoe_1428", Text = "Feels different somehow.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2103", Text = "What happened to me..." },
		{ Cue = "/VO/MelinoeField_2104", Text = "Chaos..." },
		{ Cue = "/VO/MelinoeField_2105", Text = "Something's happened..." },
		{ Cue = "/VO/MelinoeField_2106", Text = "I feel... {#Emph}ungh..." },
		{ Cue = "/VO/MelinoeField_2107", Text = "Only temporary..." },
	},
	{
		PreLineWait = 0.66,
		SuccessiveChanceToPlayAll = 0.2,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBounty" },
				IsAny = { "PackageBountyChaosIntro" },
			},
		},

		{ Cue = "/VO/MelinoeField_2044", Text = "I feel... unstoppable..." },
	},
	-- 4+ losses
	{
		NoTarget = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.942,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 5,
			},
		},
		{ Cue = "/VO/Chaos_0248", Text = "Perhaps you should cease attempting this Trial for now." },
		{ Cue = "/VO/Chaos_0249", Text = "Perhaps if your weapon was stronger? Or perhaps not.", PlayFirst = true },
		{ Cue = "/VO/Chaos_0250", Text = "I have eternity for these attempts; do you?" },
		{ Cue = "/VO/Chaos_0251", Text = "Only continue with this Trial if that is your wish." },
	},
	-- 2 - 3 losses
	{
		NoTarget = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.942,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 3,
			},
		},
		{ Cue = "/VO/Chaos_0237", Text = "Repeated failure is acceptable to me, for it is amusing." },
		{ Cue = "/VO/Chaos_0239", Text = "Your prior failure in this Trial was quite interesting to observe." },
		{ Cue = "/VO/Chaos_0242", Text = "This Trial has been difficult, and yet you reattempt." },
		{ Cue = "/VO/Chaos_0243", Text = "I think this Trial may be far too difficult for you." },
		{ Cue = "/VO/Chaos_0244", Text = "Try all you like; your repeat attempts are interesting." },
		{ Cue = "/VO/Chaos_0247", Text = "We have been through this before, and shall do it again." },
	},
	-- 1 - 2 loss
	{
		NoTarget = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.942,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 2,
			},
		},
		{ Cue = "/VO/Chaos_0233", Text = "Repetition sometimes is required for success." },
		{ Cue = "/VO/Chaos_0236", Text = "I am curious to see if you shall fail this Trial once again." },
		{ Cue = "/VO/Chaos_0238", Text = "Shall this Trial prove too much for you again?" },
		{ Cue = "/VO/Chaos_0232", Text = "You are the variable in this Trial, Spawn of Hades." },
		{ Cue = "/VO/Chaos_0234", Text = "A Trial may require multiple attempts.", PlayFirst = true },
		{ Cue = "/VO/Chaos_0235", Text = "I have affected this night much like you experienced before." },
		{ Cue = "/VO/Chaos_0240", Text = "Perhaps you have a better sense of what to expect this time." },
		{ Cue = "/VO/Chaos_0241", Text = "I appreciate your willingness to reattempt this Trial." },
		{ Cue = "/VO/Chaos_0245", Text = "This is a Trial that you know; yet the outcome may change." },
		{ Cue = "/VO/Chaos_0246", Text = "I shall be interested to see what you do differently this time." },
	},
	-- initial attempts & general
	{
		NoTarget = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.66,
		PreLineWait = 0.876,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
		},
		{ Cue = "/VO/Chaos_0217", Text = "Our Trial thus begins, O Spawn of Hades.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyChaosIntro" },
				},
			},
		},

		{ Cue = "/VO/Chaos_0262", Text = "Vengeance is an impulse I would better understand.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRevenge" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0265", Text = "Gold flows freely throughout my domain; claim it.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyGold" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0268", Text = "Let us see the so-called Earthshaker live up to his title.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyOceanus" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0277", Text = "This is a Trial of strength, so please use it with care.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHellChop" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0275", Text = "This is a Trial of destruction, so please see what you can do.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHazard" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0269", Text = "I have no wish to see the god of light, only his strength.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHealer", "PackageBountyHazard" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0270", Text = "The cold brought on by the goddess of seasons, I know well.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyOneTouch" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0272", Text = "The goddess of love is well accustomed to being observed.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyAphrodite" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0273", Text = "The goddess of the hearth, and the potential of her flames...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHestia" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0276", Text = "This is a Trial of haste, so please do not hesitate.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountySpeed" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0224", Text = "You lack the power you accumulated; but not the knowledge.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyStarter" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0225", Text = "I can take away your strength, but not your experience.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyStarter" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0264", Text = "You have a strong connection to the Moon; show it to me.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountySpellCast" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0278", Text = "I believe your magick shall be of little use in this Trial.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyLowMana" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0263", Text = "Do the Fates determine what transpires, or do you?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyCriticalHealth" },
				},
			},
		},

		{ Cue = "/VO/Chaos_0219", Text = "You have arrived here rather quickly, Spawn of Hades.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0220", Text = "Let us begin our current Trial from this point.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0221", Text = "Commence this Trial from this point, beginning now.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0222", Text = "I have an interest in evaluating this domain.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0223", Text = "You may proceed immediately, Spawn of Hades.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasNone = { "F", "N" },
				},
			},
		},

		{ Cue = "/VO/Chaos_0226", Text = "This Trial shall attempt to break you, Spawn of Hades.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyCriticalHealth",
						"PackageBountyOneTouch",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0227", Text = "It is possible that this Trial is impossible, Spawn of Hades.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyCriticalHealth",
						"PackageBountyOneTouch",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0228", Text = "I do not think you shall complete this Trial, though please try.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyCriticalHealth",
						"PackageBountyOneTouch",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0229", Text = "The Fates themselves determine the details of this Trial.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld10Shrine" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0230", Text = "I cede control of the details of this Trial to the Fates.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld10Shrine" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0231", Text = "In choosing this Trial, all other choices shall be made for you.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld10Shrine" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0105", Text = "This shall be interesting..." },
		{ Cue = "/VO/Chaos_0106", Text = "I have made some adjustments to reality..." },
		{ Cue = "/VO/Chaos_0107", Text = "Minor changes may have profound effects..." },
		{ Cue = "/VO/Chaos_0108", Text = "Some alterations to the fabric of reality..." },
		{ Cue = "/VO/Chaos_0109", Text = "Is all this in accordance with the Fates' design?" },
		{ Cue = "/VO/Chaos_0110", Text = "Of infinite possibilities, this was your choice." },
		{ Cue = "/VO/Chaos_0111", Text = "From my infinite depths rises an opportunity." },
		{ Cue = "/VO/Chaos_0112", Text = "I do appreciate your willingness..." },
		{ Cue = "/VO/Chaos_0113", Text = "So many minor details to adjust..." },
		{ Cue = "/VO/Chaos_0114", Text = "Another possibility to be explored..." },
		{ Cue = "/VO/Chaos_0218", Text = "All that you see is my domain, and I am everywhere." },
	},

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
	-- surface route
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.5,
		SuccessiveChanceToPlayAll = 0.1,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "N" },
			},
		},
		
		{ Cue = "/VO/Melinoe_0569", Text = "{#Emph}<Inhale>", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0121", Text = "Hold on, everyone." },
		{ Cue = "/VO/Melinoe_0122", Text = "Cold up here..." },
	},
	-- underworld route
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.5,
		SuccessiveChanceToPlayAll = 0.15,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "F" },
			},
		},
		{ Cue = "/VO/Melinoe_1670", Text = "To the House of Hades.",
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "UseRecord", "NPC_Chronos_01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0004_V3", Text = "Death to Chronos.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 7,
				},
			},
		},
		{ Cue = "/VO/Melinoe_0380", Text = "I'll get you, Chronos." },
	},
	-- general
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.25,

		{ Cue = "/VO/Melinoe_0003_V3", Text = "It's now or never." },
		{ Cue = "/VO/Melinoe_0114", Text = "Time to shine." },
		{ Cue = "/VO/Melinoe_0115", Text = "For my family." },
		{ Cue = "/VO/Melinoe_0116", Text = "Moonlight guide me." },
		{ Cue = "/VO/Melinoe_0117", Text = "Beginning assignment." },
		{ Cue = "/VO/Melinoe_0118", Text = "All right." },
		{ Cue = "/VO/Melinoe_0119", Text = "I was born for this." },
		{ Cue = "/VO/Melinoe_0120", Text = "No pressure." },
		{ Cue = "/VO/Melinoe_0381", Text = "This is my path.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_0377" },
				}
			},
		},
		{ Cue = "/VO/Melinoe_0382", Text = "No holding back." },
		{ Cue = "/VO/Melinoe_0383", Text = "I will not fail." },
		{ Cue = "/VO/Melinoe_0384", Text = "Headmistress guide me." },
		{ Cue = "/VO/Melinoe_0385", Text = "For the Silver Sisters." },
		{ Cue = "/VO/Melinoe_1666", Text = "Strength; knowledge; patience." },
	},
}

-- RunStartVoiceLines
GlobalVoiceLines.StartNewRunVoiceLines =
{
	-- underworld route
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		UsePlayerSource = true,
		ThreadName = "RoomThread",
		SuccessiveChanceToPlayAll = 0.9,
		GameStateRequirements =
		{
			{
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
		{ Cue = "/VO/Melinoe_0376", Text = "Into Erebus." },
		{ Cue = "/VO/Melinoe_1608", Text = "Find the Titan, slay the Titan.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0107", Text = "I'm off." },
		{ Cue = "/VO/Melinoe_0108", Text = "I go.", },
		{ Cue = "/VO/Melinoe_0109", Text = "Heading out.", },
		{ Cue = "/VO/Melinoe_0110", Text = "Commencing.", },
		{ Cue = "/VO/Melinoe_0111", Text = "Once more.", },
		{ Cue = "/VO/Melinoe_2482", Text = "Once more, then." },
		{ Cue = "/VO/Melinoe_0029", Text = "I'd best be off...", },
		{ Cue = "/VO/Melinoe_0375", Text = "Farewell, Commander.", },
		{ Cue = "/VO/Melinoe_0377", Text = "This is my path.", },
		{ Cue = "/VO/Melinoe_0378", Text = "I'll make this count." },
		{ Cue = "/VO/Melinoe_0379", Text = "My path is set.", },
		{ Cue = "/VO/Melinoe_1668", Text = "I was born for this." },
		{ Cue = "/VO/Melinoe_3058_B", Text = "Here we go." },
	},
	--[[
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.5,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
			},
		},

		{ Cue = "/VO/Melinoe_0861", Text = "You with me, Homer?" },
		{ Cue = "/VO/Melinoe_0862", Text = "Ready, Homer?" },
		{ Cue = "/VO/Melinoe_0863", Text = "Let's go, Homer.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1133", Text = "Come along, Homer." },
	},
	]]--
}
GlobalVoiceLines.StartSurfaceRunVoiceLines =
{
	-- surface route
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlayAll = 0.8,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/Melinoe_0113", Text = "To the surface.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2480", Text = "Heading up." },
		{ Cue = "/VO/Melinoe_2483", Text = "Break the siege..." },
		{ Cue = "/VO/Melinoe_2488", Text = "Unfinished business here..." },
		{ Cue = "/VO/Melinoe_2489", Text = "More to be done up here." },
		{ Cue = "/VO/Melinoe_1665", Text = "With the grace of the Moon." },
		{ Cue = "/VO/Melinoe_3568", Text = "Toward the gods..." },
		{ Cue = "/VO/Melinoe_3569", Text = "Going up..." },
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
					PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
				},
				{
					PathFalse = { "CurrentRun", "RoomsEntered", "P_Intro" },
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
					PathTrue = { "PrevRun", "BiomesReached", "F" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_2487", Text = "New night, new path.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2485" },
				},
				{
					PathTrue = { "PrevRun", "BiomesReached", "F" },
				},
			}
		},
	},
	--[[
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnce = true,
		PlayOnceContext = "SkellySurfaceRunReaction",
		ObjectType = "NPC_Skelly_01",
		ThreadName = "RoomThread",
		Cooldowns =
		{
			-- { Name = "SkellyKeepsakeSpeech", Time = 10 },
		},

		-- { Cue = "/VO/Skelly_0123", Text = "Wait how did you--" ,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
				},
			},
		},
		-- { Cue = "/VO/Skelly_0124", Text = "Such youthful vigor..." ,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
				},
			},
		},
	},
	]]--
}
GlobalVoiceLines.StartNewPackagedBountyVoiceLines =
{
	-- starting packaged bounties
	{
		--[[
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.21,
			SuccessiveChanceToPlay = 0.2,
			NoTarget = true,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift01" },
				},
			},
			Cooldowns =
			{
				{ Name = "ChaosSpokeRecently", Time = 15 },
			},

			{ Cue = "/VO/Chaos_0115", Text = "Let us explore this facet of reality again." },
			{ Cue = "/VO/Chaos_0116", Text = "Here there is even more to be observed." },
			{ Cue = "/VO/Chaos_0117", Text = "Repetition is the key to certainty." },
			{ Cue = "/VO/Chaos_0118", Text = "Infinite possibility, even in a single facet.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0119", Text = "A familiar choice, but perhaps a different result." },
			{ Cue = "/VO/Chaos_0120", Text = "You choose a path familiar to you." },
		},
		]]--
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
			GameStateRequirements =
			{
				{
					-- PathFromArgs = true,
					-- PathTrue = { "ActiveBounty" },
				},
			},

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
		},
	},
	[2] = GlobalVoiceLines.StartNewRunVoiceLines,
}

GlobalVoiceLines.CombatBeginsVoiceLines =
{
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
				IsAny = { "GeneratedNSubRoom", "GeneratedNSubRoom_Bigger" },
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
				IsNone = { "FIntroFight", "BossHecate01", "BossScylla01", "BossPolyphemus01", "MiniBossTreant", "MiniBossFogEmitter", "MiniBossWaterUnit", "MiniBossCrawler" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Story01", "G_Story01", "I_Story01", "N_Opening01", "N_Story01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "GeneratedAnomalyB" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		Cooldowns =
		{
			{ Name = "CombatBeginsLinesPlayedRecently", Time = 500 },
		},

		{ Cue = "/VO/Melinoe_0257", Text = "Traitors!",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", "N" },
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
			}
		},
		{ Cue = "/VO/Melinoe_0261", Text = "Begone...!" },
		{ Cue = "/VO/Melinoe_0263", Text = "For my father!" },
		{ Cue = "/VO/Melinoe_0265", Text = "I'll slay you all!",
			GameStateRequirements = 
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 3,
				},
			}
		},
		{ Cue = "/VO/Melinoe_0267", Text = "You'll regret this!" },
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
		{ Cue = "/VO/Melinoe_0271", Text = "Come on!" },
		{ Cue = "/VO/Melinoe_0273", Text = "Face me!" },
		{ Cue = "/VO/Melinoe_0275", Text = "Come!" },
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
			},
		},
		{ Cue = "/VO/Melinoe_1774", Text = "This is the Titan's fault." },
		{ Cue = "/VO/Melinoe_1776", Text = "Let's begin." },
		{ Cue = "/VO/Melinoe_1778", Text = "You dare?" },
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
		{ Cue = "/VO/Melinoe_1784", Text = "Come." },
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
					HasAny = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
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
					HasAny = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
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
				Comparison = "<=",
				Value = 2,
			},
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
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
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
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
					"HeraclesCombatN",
					"HeraclesCombatN2",
					"HeraclesCombatO",
					"HeraclesCombatO2",
					"NemesisCombatF",
					"NemesisCombatG",
					"NemesisCombatH",
					"IcarusCombatO",
					"IcarusCombatO2",
					"BossHecate01",
					"BossScylla01",
					"BossInfestedCerberus01",
					"BossChronos01",
					"BossPolyphemus01",
					"BossEris01",
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
			RequiredMinHealthFraction = 0.2,
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.35,
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
				HasAny = { "/VO/Artemis_0036", "/VO/Artemis_0037", "/VO/Artemis_0038", "/VO/Artemis_0039", "/VO/Artemis_0040", "/VO/Artemis_0041", "/VO/Artemis_0042", "/VO/Artemis_0043", "/VO/Artemis_0044", "/VO/Artemis_0045", "/VO/Artemis_0046", "/VO/Artemis_0047", "/VO/Artemis_0048", "/VO/Artemis_0049" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
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
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
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
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.1,
		ObjectType = "NPC_Nemesis_01",
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
				IsAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
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
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
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
				IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Boss01", "N_Opening01", "H_Boss01", "I_Boss01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone =
				{
					"ArtemisCombatIntro",
					"ArtemisCombatF",
					"ArtemisCombatG",
					"ArtemisCombatN",
					"HeraclesCombatN",
					"BossHecate01",
					"BossPolyphemus01",
					"BossScylla01",
					"BossChronos01",
					"SiegeVineIntro",
					"RadiatorIntro",
					"ScreamerIntro",
					"FishmanIntro",
					"FishSwarmerIntro",
					"TurtleIntro",
					"LamiaIntro",
					"LovesickIntro",
					"VampireIntro",
					"LycanthropeIntro",
					"MournerIntro",
					"MudmanIntro",
					"ZombieAssassinIntro",
					"ZombieHeavyRangedIntro",
					"ZombieSpawnerIntro",
				},
			},
			ChanceToPlay = 0.045,
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
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
			}
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
		{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm!" },
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
	PreLineWait = 0.45,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01", "N_Boss01", "O_Boss01", "P_Boss01", "Q_Boss01" },
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


GlobalVoiceLines.SatyrsSightedVoiceLines =
{
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
	},
	SuccessiveChanceToPlay = 0.1,

	{ Cue = "/VO/MelinoeField_1635", Text = "Satyrs...!" },
	{ Cue = "/VO/MelinoeField_1636", Text = "Satyrs..." },
	{ Cue = "/VO/MelinoeField_1637", Text = "More Satyrs." },
	{ Cue = "/VO/MelinoeField_1638", Text = "Come, Satyrs...!" },
}

GlobalVoiceLines.CombatResolvedVoiceLines =
{
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
			RequiredMinHealthFraction = 0.75,
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
	
	Cooldowns =
	{
		{ Name = "MelCombatResolvedSpeech", Time = 300 },
		{ Name = "MelinoeAnyQuipSpeech" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
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
			RequiredMinHealthFraction = 0.2,
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
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "I" },
				},
			}
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
				IsNone = { "FIntroFight", "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatH", "ArtemisCombatN", "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "HeraclesCombatN" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		ThreadName = "RoomThread",

		{ Cue = "/VO/MelinoeField_2063", Text = "We did it, Frinos.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				}
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
		{ Cue = "/VO/Melinoe_0279", Text = "Rest now, all of you.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "H", "N" },
				}
			},
		},
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
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	ChanceToPlay = 0.75,
	PreLineWait = 1.0,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "HeraclesCombatIntro", "HeraclesCombatN" },
		},
	},

	{ Cue = "/VO/Melinoe_0283", Text = "Lost too much blood..." },
	{ Cue = "/VO/Melinoe_0284", Text = "That was careless." },
	{ Cue = "/VO/Melinoe_0285", Text = "{#Emph}Ungh..." },
	{ Cue = "/VO/Melinoe_0286", Text = "Not good enough." },
	{ Cue = "/VO/Melinoe_0287", Text = "Spilled half my blood back there..." },
	{ Cue = "/VO/Melinoe_0288", Text = "Mistakes were made..." },
	{ Cue = "/VO/Melinoe_0289", Text = "One more chamber...",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G", "I", "P", "Q" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_0290", Text = "Keep going..." },
	{ Cue = "/VO/Melinoe_0291", Text = "I can still fight." },
	{ Cue = "/VO/Melinoe_0292", Text = "{#Emph}Ungh{#Prev}, that hurt." },
}
GlobalVoiceLines.BarelySurvivedBossFightVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 7.1,
	SuccessiveChanceToPlayAll = 0.33,
	UsePlayerSource = true,
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
		RequiredMaxHealthFraction = 0.25,
	},

	{ Cue = "/VO/MelinoeField_0548", Text = "...Survived all that..." },
	{ Cue = "/VO/MelinoeField_0549", Text = "...A bit too close..." },
	{ Cue = "/VO/MelinoeField_0550", Text = "...Pulled through, somehow..." },
	{ Cue = "/VO/MelinoeField_0551", Text = "...Oh, thank the gods..." },
	{ Cue = "/VO/MelinoeField_0552", Text = "...A narrow victory, but still..." },
	{ Cue = "/VO/MelinoeField_0553", Text = "...Somehow managed that..." },
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
					HasAny = { "SpellMeteorTrait", "SpellLeapTrait" },
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
		-- RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
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
	[1] =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		-- RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
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
	[2] = GlobalVoiceLines.ClaimedRewardVoiceLines,
}
GlobalVoiceLines.UsedShieldDropVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlay = 0.5,
		-- RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			RequiredUnitsNotAlive = { "NPC_Nemesis_01" },
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
GlobalVoiceLines.PickedMoonSpellVoiceLines =
{
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.33,

		{ Cue = "/VO/Melinoe_0025", Text = "Together we shine.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0573", Text = "Together we shine..." },
		{ Cue = "/VO/Melinoe_0574", Text = "Together we shine...!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.5,
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
GlobalVoiceLines.CostumeChangedVoiceLines =
{
	{
		PreLineWait = 0.35,
		RandomRemaining = true,
		ObjectType = "NPC_Arachne_01",
		-- SuccessiveChanceToPlayAll = 0.75,
		-- also see additional Arachne lines below
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = GameData.ArachneUpsetEvents,
			},
		},

		{ Cue = "/VO/Arachne_0171", Text = "Certainly!" },
		{ Cue = "/VO/Arachne_0172", Text = "Of course!" },
		{ Cue = "/VO/Arachne_0173", Text = "Of course." },
		{ Cue = "/VO/Arachne_0174", Text = "Right away." },
		{ Cue = "/VO/Arachne_0175", Text = "Coming right up!" },
		{ Cue = "/VO/Arachne_0176", Text = "Oh, yes." },
		{ Cue = "/VO/Arachne_0177", Text = "I hear that!" },
		{ Cue = "/VO/Arachne_0178", Text = "Wonderful." },
		{ Cue = "/VO/Arachne_0179", Text = "You bet." },
		{ Cue = "/VO/Arachne_0180", Text = "Why, sure!" },
		{ Cue = "/VO/Arachne_0184", Text = "Do you like it?", PlayFirst = true, PreLineWait = 1.0 },
		{ Cue = "/VO/Arachne_0185", Text = "Well, what do you think?", PreLineWait = 1.0 },
		{ Cue = "/VO/Arachne_0186", Text = "How does that feel?", PreLineWait = 1.0 },
	},
	{
		RandomRemaining = true,
		-- SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		-- { Cue = "/VO/Melinoe_1409", Text = "It's certainly a change..." },
		{ Cue = "/VO/Melinoe_1410", Text = "How do I look?",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Arachne_0184", "/VO/Arachne_0185", "/VO/Arachne_0186" },
				},
			},
		},
		-- { Cue = "/VO/Melinoe_1411", Text = "Seems like a decent fit..." },
		{ Cue = "/VO/Melinoe_1412", Text = "I think I like it...",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Arachne_0184" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1413", Text = "I'm comfortable in this..." },
		{ Cue = "/VO/Melinoe_1731", Text = "Why this is beautiful, thank you...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2378", Text = "Thanks, Arachne." },
		{ Cue = "/VO/Melinoe_0350", Text = "{#Emph}<Laugh>" },
		{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.25,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Arachne_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = GameData.ArachneUpsetEvents,
			},
		},

		{ Cue = "/VO/Arachne_0181", Text = "A {#Emph}perfect {#Prev}fit!" },
		{ Cue = "/VO/Arachne_0182", Text = "There!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_1410", "/VO/Melinoe_1411", "/VO/Melinoe_1412", "/VO/Melinoe_1413", "/VO/Melinoe_1731" },
				},
			},
		},
		{ Cue = "/VO/Arachne_0183", Text = "Oh, you look {#Emph}wonderful!" },
		{ Cue = "/VO/Arachne_0187", Text = "Made this one just for you." },
		{ Cue = "/VO/Arachne_0188", Text = "I knew you'd pick this one!" },
		{ Cue = "/VO/Arachne_0189", Text = "You truly look lovely." },
		{ Cue = "/VO/Arachne_0190", Text = "I hope you like it.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_1412" },
				},
			},
		},
		{ Cue = "/VO/Arachne_0191", Text = "Now you enjoy, all right?" },
		{ Cue = "/VO/Arachne_0192", Text = "{#Emph}Whew! {#Prev}Enjoy it while it lasts..." },
		{ Cue = "/VO/Arachne_0193", Text = "All in an evening's work!" },
		{ Cue = "/VO/Arachne_0194", Text = "Woven with care." },
		{ Cue = "/VO/Arachne_0195", Text = "It's all yours." },
		{ Cue = "/VO/Arachne_0196", Text = "Like a warm embrace..." },
		{ Cue = "/VO/Arachne_0197", Text = "May it keep you safe." },
		{ Cue = "/VO/Arachne_0198", Text = "Absolutely stunning...!" },
		{ Cue = "/VO/Arachne_0199", Text = "It matches your eye.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "VitalityCostume", "CastDamageCostume" },
				}
			},
		},
		{ Cue = "/VO/Arachne_0200", Text = "What a sight you are." },
	}
}
GlobalVoiceLines.CostumeDestroyedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.25,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "LastRemovedTraitName" },
				IsAny = { "AgilityCostume", "ManaCostume", "VitalityCostume", "CastDamageCostume", "IncomeCostume", "HighArmorCostume" },
			},
		},
		{ Cue = "/VO/Melinoe_1916", Text = "My outfit!" },
		{ Cue = "/VO/Melinoe_1917", Text = "So much for silken armor..." },
		{ Cue = "/VO/Melinoe_1918", Text = "There goes Arachne's suit..." },
		{ Cue = "/VO/Melinoe_1919", Text = "They broke my suit...",
			PlayOnce = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
		{ Cue = "/VO/Melinoe_0579", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
		{ Cue = "/VO/MelinoeField_2374", Text = "Blast..." },
		{ Cue = "/VO/MelinoeField_2375", Text = "{#Emph}Augh..." },
		{ Cue = "/VO/MelinoeField_2376", Text = "My silk...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2377", Text = "My dress.." },
		{ Cue = "/VO/MelinoeField_2379", Text = "{#Emph}Tsk..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Arachne_01",

		{ Cue = "/VO/Arachne_0268", Text = "Limit one per evening, I'm afraid...", PlayFirst = true },
		{ Cue = "/VO/Arachne_0269", Text = "Hey, I'm not made of those you know!" },
		{ Cue = "/VO/Arachne_0270", Text = "Oh, now that's a shame..." },
		{ Cue = "/VO/Arachne_0271", Text = "Oh, dear..." },
		{ Cue = "/VO/Arachne_0272", Text = "Aw..." },
		{ Cue = "/VO/Arachne_0273", Text = "{#Emph}<Gasp>" },
		{ Cue = "/VO/Arachne_0274", Text = "Ooh!" },
	}
}

GlobalVoiceLines.FieldsRewardClaimedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.25,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "H" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "H_Bridge01", "H_MiniBoss01", "H_MiniBoss02", "H_PreBoss01", "H_Boss01" },
		},
		{
			PathNotEmpty = { "MapState", "RoomRequiredObjects" },
		},
		{
			PathEmpty = { "MapState", "AggroedUnits" },
		},
	},
	TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
	ThreadName = "RoomThread",

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
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1083", Text = "Another two remain.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1084", Text = "Two left.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1085", Text = "Two more.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1086", Text = "Two more to go.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1087", Text = "Now two remain.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1088", Text = "Should be two more.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1089", Text = "Where are the other two...",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1091", Text = "Two to go?",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
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
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1093", Text = "One more left.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1094", Text = "One more.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1095", Text = "One left.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1096", Text = "One to go.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1097", Text = "One remains.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1098", Text = "Should be one left.",
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
			},
		}
	},
	{ Cue = "/VO/MelinoeField_1101", Text = "Where's the last one?", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "MapState", "RoomRequiredObjects" },
				UseLength = true,
				Comparison = "==",
				Value = 1,
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
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN" },
			},
		},
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,

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
		PreLineWait = 0.85,
		SuccessiveChanceToPlay = 0.33,

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
				IsNone = { "Shop", "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTextN", "DevotionTestO", "DevotionTestP" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "TestAllThings", "F_Story01", "G_Story01", "N_Story01", "I_Story01" },
			},
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.33,

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
					"DespairElementalLarge",
					"DespairElementalLarge_Elite",
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
		SuccessiveChanceToPlayAll = 0.66,
		PreLineWait = 0.75,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
			},
			{
				PathFalse = { "CurrentRun", "BiomesReached", "G" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Story01", "N_Story01", "O_Story01" },
			},
			IsObjectTypeNotAlive = "NPC_Nemesis_01",
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
				IsNone = { "F_Story01", "G_Story01" },
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
				IsNone = { "TestAllThings" },
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
				IsNone = { "Story_Chronos01", "Story_Narcissus_01", "Story_Hades_01", "NemesisCombatIntro", "NemesisCombatF", 
				"NemesisCombatG", "NemesisCombatH" },
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
	{
		PlayOnce = true,
		PlayOnceContext = "HarvestBountyVO",
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "TestAllThings" },
			},
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_2360", Text = "Gaia's Secrets..." },
		{ Cue = "/VO/MelinoeField_2361", Text = "Gaia's Bounty..." },
	},
	[2] = GlobalVoiceLines.PositiveReactionVoiceLines,
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
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 2 },
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

	{ Cue = "/VO/Melinoe_1952", Text = "{#Emph}Huh?" },
	{ Cue = "/VO/Melinoe_1958", Text = "Oh?" },
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

	{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}Khh." },
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
	PreLineWait = 0.5,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_2143", Text = "...I said I don't need your aid. Watch yourself, Nem.",
		PlayOnce = true, PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "NemesisGift03" },
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
		PreLineWait = 0.25,
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

		{ Cue = "/VO/Melinoe_1700", Text = "Death to Chronos!" },
		{ Cue = "/VO/Melinoe_1701", Text = "Moonlight guide you." },
		{ Cue = "/VO/Melinoe_1703", Text = "May moonlight guide you." },
		{ Cue = "/VO/Melinoe_1704", Text = "Moonlight guide us." },
		{ Cue = "/VO/Melinoe_1705", Text = "May moonlight guide us." },
		{ Cue = "/VO/Melinoe_1709", Text = "Moonlight guide us." },
	},
	-- informal relationships F
	{
		PreLineWait = 0.25,
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

		{ Cue = "/VO/Melinoe_1700_2", Text = "Death to Chronos!" },
		
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
		PreLineWait = 0.25,
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
		{ Cue = "/VO/Melinoe_1700_2", Text = "Death to Chronos!" },
		{ Cue = "/VO/Melinoe_1701_2", Text = "Moonlight guide you." },
		{ Cue = "/VO/Melinoe_1703_2", Text = "May moonlight guide you." },
		{ Cue = "/VO/Melinoe_1704_2", Text = "Moonlight guide us." },
		{ Cue = "/VO/Melinoe_1705_2", Text = "May moonlight guide us." },
		{ Cue = "/VO/Melinoe_1709_2", Text = "Moonlight guide us." },
	},
}
GlobalVoiceLines.SaluteFrinosVoiceLines =
{
	[1] =
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.1,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "Familiar_Frog_01" },
				Comparison = ">=",
				Value = 5,
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeSaluteSpeech", Time = 8 },
		},
		{ Cue = "/VO/Melinoe_1678", Text = "You're safe here, little one." },
	},
	[2] = GlobalVoiceLines.SaluteVoiceLines
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

		{ Cue = "/VO/Melinoe_0579", Text = "Hm!" },
		{ Cue = "/VO/Melinoe_0580", Text = "Ugh..." },
		{ Cue = "/VO/Melinoe_0761", Text = "Ungh..." },
	},
}


GlobalVoiceLines.UsedMoneyDropVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Story01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "NemesisRandomEvent" },
			},
			RequiredUnitsNotAlive = { "NPC_Nemesis_01", "NPC_Heracles_01" },
		},
		Cooldowns =
		{
			{ Name = "MelinoePurchasedConsumableSpeech", Time = 30 },
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_1215", Text = "Should be useful." },
		{ Cue = "/VO/Melinoe_1216", Text = "I need this." },
		{ Cue = "/VO/Melinoe_1217", Text = "This should help." },
		{ Cue = "/VO/Melinoe_1218", Text = "This one, please.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1219", Text = "May I?" },
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
			}
		},
		{ Cue = "/VO/Melinoe_1221", Text = "Here's the Gold.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			}
		},
		{ Cue = "/VO/Melinoe_1222", Text = "Valuable enough." },
		{ Cue = "/VO/Melinoe_0554", Text = "I'll take it." },
		{ Cue = "/VO/Melinoe_0556", Text = "This one." },
		{ Cue = "/VO/Melinoe_0558", Text = "Here you are." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
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
	}
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
	},
}
GlobalVoiceLines.WardedDoorVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "WardedDoorVO",
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0562", Text = "{#Emph}Ungh{#Prev}, these blasted wards...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0561", Text = "Sealed as always...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_0562" }
				},
			},
		},
		{ Cue = "/VO/Melinoe_2385", Text = "Can't right now." },
		{ Cue = "/VO/Melinoe_2386", Text = "Can't do it." },
		{ Cue = "/VO/Melinoe_3084", Text = "No use." },
		{ Cue = "/VO/Melinoe_3085", Text = "{#Emph}Ngh." },
		{ Cue = "/VO/Melinoe_3086", Text = "I wish." },
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
			{ Name = "SkellyQuipAnySpeech", Time = 9 },
		},

		{ Cue = "/VO/Skelly_0388", Text = "Patience, young one!", PlayFirst = true },
		{ Cue = "/VO/Skelly_0327", Text = "Restrain yourself!" },
		{ Cue = "/VO/Skelly_0333", Text = "Please, young one!" },
		{ Cue = "/VO/Skelly_0334", Text = "Hey cut that out!" },
	},

}

-- resource interaction voice lines


-- MINOS RESOURCES
GlobalVoiceLines.SpentMetaPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedMetaPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.66,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientMetaPointsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.66,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}

GlobalVoiceLines.SpentGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientGiftPointsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}
GlobalVoiceLines.SpentGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientGemsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}
GlobalVoiceLines.SpentSuperGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.4,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedSuperGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientSuperGemsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentSuperLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.4,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedSuperLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.NotEnoughSuperLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientSuperLockKeysVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}
GlobalVoiceLines.SpentSuperGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.PurchasedSuperGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},
}
GlobalVoiceLines.InsufficientSuperGiftPointsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			--{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}
-- END MINOS RESOURCES


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
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
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
		{ Cue = "/VO/Melinoe_1211", Text = "Death to Chronos." },
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
		{ Cue = "/VO/MelinoeField_2047", Text = "Hail, almighty Chaos...!" },
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
				IsNone = { "WeaponUpgrade", "StackUpgrade", "StackUpgradeBig", "SpellDrop", "TalentDrop", "MinorTalentDrop", "TrialUpgrade" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" },
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
	--[[
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
	]]--
}

GlobalVoiceLines.ManaDropUsedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.15,
	SuccessiveChanceToPlay = 0.75,
	GameStateRequirements =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp", },
		},
	},

	{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
	{ Cue = "/VO/Melinoe_0179", Text = "All right." },
	{ Cue = "/VO/Melinoe_0541", Text = "Focus." },
}
GlobalVoiceLines.TalentDropUsedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeRewardPickUpSpeech", Time = 60 },
	},
	-- talentdrop: max chosen
	{
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
		{ Cue = "/VO/MelinoeField_1474", Text = "The Path of Stars...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
					HasNone = { "/VO/MelinoeField_1474", "/VO/MelinoeField_2380" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2380", Text = "The Path of Stars...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
					HasNone = { "/VO/MelinoeField_1474", "/VO/MelinoeField_2380" },
				},
			},
		},
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
GlobalVoiceLines.ThankingCharacterVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_0651", Text = "Thank you." },
	{ Cue = "/VO/Melinoe_0764", Text = "Thank you!" },
	{ Cue = "/VO/Melinoe_0765", Text = "Thank you." },
	{ Cue = "/VO/Melinoe_0767", Text = "Thanks..." },
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
		PreLineWait = 1.1,
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

		{ Cue = "/VO/Melinoe_0765", Text = "Thank you." },
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
			ValuableUpgradeInRoom =
			{
				AllAtLeastRarity = "Rare",
				HasAtLeastRarity = "Epic",
			},
		},

		{ Cue = "/VO/Melinoe_1960", Text = "{#Emph}Oh...!" },
		{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
		{ Cue = "/VO/Melinoe_1962", Text = "{#Emph}Ooh!" },
		{ Cue = "/VO/Melinoe_1963", Text = "{#Emph}Hoh..." },
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

		{ Cue = "/VO/Melinoe_1269", Text = "Sorry, Auntie Hestia." },
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
	Queue = "NeverQueue",
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
			IsNone = { "F_PreBoss01", "F_Boss01", "F_PostBoss01", "G_Intro", "G_PreBoss01", "G_Boss01", "G_PostBoss01", "H_Intro", "H_PreBoss01", "H_Boss01", "H_PostBoss01", "I_Intro", "I_Story01", "I_PreBoss01", "I_Boss01", "N_Opening01", "N_PreBoss01", "N_Boss01", "N_PostBoss01", "O_Intro", "O_PreBoss01", "O_Boss01", "O_PostBoss01", },
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
		Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },

		{ Cue = "/VO/Storyteller_0107", Text = "{#Emph}A brief respite awaits..." },
		{ Cue = "/VO/Storyteller_0108", Text = "{#Emph}Her foes are nowhere to be found..." },
		{ Cue = "/VO/Storyteller_0109", Text = "{#Emph}A moment of reprieve..." },
		{ Cue = "/VO/Storyteller_0110", Text = "{#Emph}The welcome solitude..." },
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
	[1] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.33,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossTreant" },
			},
		},

		{ Cue = "/VO/Melinoe_1003", Text = "A Root-Stalker...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1004", Text = "This one again..." },
	},
	[2] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossFogEmitter" },
			},
		},

		{ Cue = "/VO/Melinoe_1635", Text = "That gloom... a Shadow-Spiller...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1636", Text = "Shadow-Spiller..." },
		{ Cue = "/VO/Melinoe_1637", Text = "The Shadow-Spiller's back..." },
		{ Cue = "/VO/Melinoe_1638", Text = "Those shadows..." },
		{ Cue = "/VO/MelinoeField_1044", Text = "Shadow-Spiller...!" },
	},
	[3] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.2,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossWaterUnit" },
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
		{ Cue = "/VO/MelinoeField_0162", Text = "This isn't your domain." },
		{ Cue = "/VO/MelinoeField_0163", Text = "Remember me, Serpent?" },
		{ Cue = "/VO/MelinoeField_0164", Text = "You ought have stayed below.", PlayFirst = true },
	},
	[4] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossLamia" },
			},
		},

		{ Cue = "/VO/MelinoeField_1117", Text = "Queen Lamia herself...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1118", Text = "They think they caught a live one." },
		{ Cue = "/VO/MelinoeField_1119", Text = "All you lot against me?" },
		{ Cue = "/VO/MelinoeField_1120", Text = "Your magick against mine!" },
		{ Cue = "/VO/MelinoeField_1121", Text = "Oh don't you hiss at me!" },
		{ Cue = "/VO/MelinoeField_1122", Text = "Queen Lamia returns..." },
	},
	[5] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossVampire" },
			},
		},

		{ Cue = "/VO/MelinoeField_1128", Text = "A Phantom lair!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1129", Text = "The Phantom..." },
		{ Cue = "/VO/MelinoeField_1130", Text = "Out of the way, Phantom." },
		{ Cue = "/VO/MelinoeField_1131", Text = "Just try and take my blood!" },
		{ Cue = "/VO/MelinoeField_1132", Text = "My blood is not for you!" },
		{ Cue = "/VO/MelinoeField_1133", Text = "Thirsty for more are we?" },
	},
	[6] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossRatCatcher" },
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
	[7] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.88,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossGoldElemental" },
			},
		},
		{ Cue = "/VO/MelinoeField_1620", Text = "A Goldwrath...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1621", Text = "Are you how Chronos gets his gold?" },
		{ Cue = "/VO/MelinoeField_1622", Text = "Come on, Goldwrath!" },
		{ Cue = "/VO/MelinoeField_1623", Text = "Let's go you sack of filth!" },
		{ Cue = "/VO/MelinoeField_1624", Text = "Oh great, the treasury..." },
		{ Cue = "/VO/MelinoeField_1625", Text = "Found the treasury..." },
	},
	[8] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlayAll = 0.33,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "MiniBossSatyrCrossbow" },
			},
		},

		{ Cue = "/VO/Melinoe_1008", Text = "Death to the servants of Chronos!" },
		{ Cue = "/VO/MelinoeField_0249", Text = "You don't know who you're dealing with..." },
		{ Cue = "/VO/MelinoeField_0467", Text = "A champion of Chronos...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0468", Text = "No mercy for servants of the Titan...!" },
		{ Cue = "/VO/MelinoeField_0469", Text = "I'll send your soul into the depths of hell." },
		{ Cue = "/VO/MelinoeField_0470", Text = "Are you the Satyr currently in charge?" },
		{ Cue = "/VO/MelinoeField_0471", Text = "This city belongs to the mortals...!" },
		{ Cue = "/VO/MelinoeField_0472", Text = "Let this be a message to your lord!" },
	},
	[9] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.76,
		SuccessiveChanceToPlay = 0.5,

		{ Cue = "/VO/MelinoeField_0682", Text = "Ah, yes." },
		{ Cue = "/VO/MelinoeField_0683", Text = "This again." },
		{ Cue = "/VO/MelinoeField_0684", Text = "Let's begin...!" },
		{ Cue = "/VO/MelinoeField_0685", Text = "Let's go, then." },
		{ Cue = "/VO/MelinoeField_0686", Text = "You and me...!" },
		{ Cue = "/VO/MelinoeField_0687", Text = "I've returned." },
		{ Cue = "/VO/MelinoeField_0688", Text = "You won't stop me." },
		{ Cue = "/VO/MelinoeField_0689", Text = "I'm back." },
	},
	[10] = GlobalVoiceLines.CombatBeginsVoiceLines,
}
GlobalVoiceLines.MiniBossEncounterEndVoiceLines =
{
	Cooldowns = { { Name = "LootDroppedSpeech", Time = 30 }, },
	{
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
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.66,
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
			SuccessiveChanceToPlayAll = 0.66,
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
			SuccessiveChanceToPlayAll = 0.66,
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
			SuccessiveChanceToPlayAll = 0.66,
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
			SuccessiveChanceToPlayAll = 0.66,
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
			SuccessiveChanceToPlayAll = 0.66,
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
					IsAny = { "MiniBossCharybdis" },
				},
			},
			{ Cue = "/VO/MelinoeField_1866", Text = "You'll soon be back for more, won't you?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1868", Text = "Don't get in my way." },
			{ Cue = "/VO/MelinoeField_1870", Text = "How many ships have fallen in that maw?" },
			{ Cue = "/VO/MelinoeField_1871", Text = "Drove it away for now..." },
			{ Cue = "/VO/MelinoeField_1869", Text = "Tell Scylla I said {#Emph}hi.",
				GameStateRequirements = 
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "G_Boss01" },
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
		-- misc. miniboss victories
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",

			{ Cue = "/VO/MelinoeField_0690", Text = "Out of my sight..." },
			{ Cue = "/VO/MelinoeField_0691", Text = "Out with you." },
			{ Cue = "/VO/MelinoeField_0692", Text = "Mindless wretch.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "MiniBossCrawler" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_0693", Text = "That's what you get." },
			{ Cue = "/VO/MelinoeField_0694", Text = "We're settled." },
			{ Cue = "/VO/MelinoeField_0695", Text = "Until we meet again." },
			{ Cue = "/VO/MelinoeField_0696", Text = "Remember that." },
			{ Cue = "/VO/MelinoeField_0697", Text = "We'll have to do this again." },
			{ Cue = "/VO/Melinoe_0861", Text = "You with me, Homer?",
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
				},
			},
			{ Cue = "/VO/Melinoe_0862", Text = "Ready, Homer?",
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
				},
			},
			{ Cue = "/VO/Melinoe_0863", Text = "Let's go, Homer.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_0864", Text = "See that, Homer?", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1129", Text = "We got them, Homer.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
		},
	},
	[2] = GlobalVoiceLines.StorytellerFightReactionVoiceLines,
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
					PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0176", Text = "Hail, O King.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0177", Text = "At last, a worthy opponent." },
		{ Cue = "/VO/MelinoeField_0178", Text = "Have at you, King!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" },
				}
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
		PreLineWait = 1.75,
		SuccessiveChanceToPlayAll = 0.75,
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/MelinoeField_1858", Text = "That maw... there's no mistaking it.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1860", Text = "You're going to let me pass!" },
		{ Cue = "/VO/MelinoeField_1863", Text = "Feast on this ship, not me!" },
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
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1865", Text = "You won't be stopping me, Charybdis!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossCharybdis" },
				},
			},
		},
	},	
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
			RequiredUnitAlive = "NPC_Heracles_01",
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


GlobalVoiceLines.CosmeticRemovedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldown = 60,

		{ Cue = "/VO/Melinoe_1397", Text = "This sounds good." },
		{ Cue = "/VO/Melinoe_1398", Text = "Let's do it." },
		{ Cue = "/VO/Melinoe_1399", Text = "Let's try this on." },
		{ Cue = "/VO/Melinoe_1400", Text = "Sure, why not." },
	},
	[2] = GlobalVoiceLines.DoraRedecorationReactionVoiceLines,	
}

GlobalVoiceLines.CosmeticReAddedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldown = 60,

		{ Cue = "/VO/Melinoe_1397", Text = "This sounds good." },
		{ Cue = "/VO/Melinoe_1398", Text = "Let's do it." },
		{ Cue = "/VO/Melinoe_1399", Text = "Let's try this on." },
		{ Cue = "/VO/Melinoe_1400", Text = "Sure, why not." },
	},
	[2] = GlobalVoiceLines.DoraRedecorationReactionVoiceLines,
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

-- Cauldron -- Crossroads Cauldron
GlobalVoiceLines.AboutToCastSpell =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.15,
	SuccessiveChanceToPlay = 0.75,

	{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
	{ Cue = "/VO/Melinoe_0179", Text = "All right." },
}

-- Cauldron Alchemy
GlobalVoiceLines.ResourceTransmutationVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		Queue = "Always",
		Cooldowns =
		{
			-- { "MelinoeAnyQuipSpeech" },
		},
	
		{ Cue = "/VO/Melinoe_1352", Text = "Transmutation complete.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1353", Text = "Transmutation succeeded." },
		{ Cue = "/VO/Melinoe_1354", Text = "My will is manifest." },
		{ Cue = "/VO/Melinoe_1355", Text = "Re-shaped by Chaos..." },
	}
}

-- Aspects Screen
GlobalVoiceLines.OpenedWeaponUpgradeMenuVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.75,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_2541", Text = "The Aspects of the Nocturnal Arms..." },
		{ Cue = "/VO/Melinoe_0728", Text = "Descura.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponStaffSwing" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3428", Text = "Descura.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponStaffSwing" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3429", Text = "Descura.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponStaffSwing" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"StaffClearCastAspect",
						"StaffSelfHitAspect",
					},
				},
			},
		},		
		{ Cue = "/VO/Melinoe_0730", Text = "Lim and Oros.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3430", Text = "Lim and Oros.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3431", Text = "Lim. Oros.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"DaggerBlockAspect",
						"DaggerHomingThrowAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_0736", Text = "Ygnium.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3432", Text = "Ygnium.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3433", Text = "Ygnium.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponTorch" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"TorchDetonateAspect",
						"TorchSprintRecallAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3032", Text = "Zorephet.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3434", Text = "Zorephet.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3435", Text = "Zorephet.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponAxe" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"AxeArmCastAspect",
						"AxePerfectCriticalAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_0734", Text = "Revaal.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3436", Text = "Revaal.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3437", Text = "Revaal.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponLob" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"LobCloseAttackAspect",
						"LobImpulseAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3416", Text = "I have returned." },
		{ Cue = "/VO/Melinoe_3417", Text = "Such intricate work..." },
		{ Cue = "/VO/Melinoe_3418", Text = "Still not even a scratch..." },
		-- single-weapon lines
		{ Cue = "/VO/Melinoe_3415", Text = "Show me what you can do.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3420", Text = "I'm honored as your bearer.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3422", Text = "Show me your past.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3423", Text = "Show me our future.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3425", Text = "In service to the realm.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3426", Text = "Can hear me, can't you...?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		-- dual-weapon lines
		{ Cue = "/VO/Melinoe_3421", Text = "Who else shall wield you?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3419", Text = "What secrets do you keep...?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3424", Text = "Forged by the Fates...",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3427", Text = "What form suits you tonight?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
	},
}

GlobalVoiceLines.AspectMaxedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.35,
	UsePlayerSource = true,
	TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },

	{ Cue = "/VO/Melinoe_2619", Text = "My bond with this Aspect is complete." },
	{ Cue = "/VO/Melinoe_2620", Text = "Our bond is now complete." },
	{ Cue = "/VO/Melinoe_2621", Text = "We are inseparable now." },
}

-- Market / Broker / Wretched Broker
GlobalVoiceLines.OpenedMarketVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "BrokerSellShop",
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeSellShop" },
			},
		},

		-- { Cue = "/VO/Melinoe_0553", Text = "Broker, you've expanded your shop!" },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "MelMarketIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_3579", Text = "Moon Dust now in stock...",
			PlayFirst = true,
			PlayOnce = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" }
				},
				{
					PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" }
				},
			},
		},
		{ Cue = "/VO/Melinoe_0552", Text = "Hail, Broker.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2345", Text = "Good evening, Broker." },
		{ Cue = "/VO/Melinoe_2346", Text = "Broker." },
		{ Cue = "/VO/Melinoe_2347", Text = "Just checking up on you." },
		{ Cue = "/VO/Melinoe_2348", Text = "What do I need..." },
	},
}
GlobalVoiceLines.TradedMarketItemVoiceLines =
{
	-- selling
	{
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "==",
				Value = 3,
			}
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SkipAnim = true,
		SuccessiveChanceToPlay = 0.75,
		Cooldowns =
		{
			{ Name = "MelMarketInteraction", Time = 8 },
		},

		{ Cue = "/VO/Melinoe_0558", Text = "Here you are." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
	},
	-- buying
	{
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "!=",
				Value = 3,
			}
		},

		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SkipAnim = true,
		SuccessiveChanceToPlay = 0.75,
		Cooldowns =
		{
			{ Name = "MelMarketInteraction", Time = 8 },
		},

		{ Cue = "/VO/Melinoe_0554", Text = "I'll take it." },
		{ Cue = "/VO/Melinoe_0555", Text = "One, please." },
		{ Cue = "/VO/Melinoe_0556", Text = "This one." },
		{ Cue = "/VO/Melinoe_0558", Text = "Here you are." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
		{ Cue = "/VO/Melinoe_2349", Text = "Here are the Bones." },
		{ Cue = "/VO/Melinoe_2350", Text = "Trade you." },
		{ Cue = "/VO/Melinoe_2351", Text = "I've need of that." },
		{ Cue = "/VO/Melinoe_2352", Text = "Should be of use." },
	},
}
GlobalVoiceLines.ClosedMarketVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.1,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.45,

		{ Cue = "/VO/Melinoe_0560", Text = "Farewell." },
		{ Cue = "/VO/Melinoe_2353", Text = "Be well." },
		{ Cue = "/VO/Melinoe_2354", Text = "Take care, then." },
	},
}


-- RunHistory Screen
GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "MelRunHistoryIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_2981", Text = "What does my history reveal?", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2982", Text = "Let's see how fares my task." },
	},
}

-- GameStats Screen
GlobalVoiceLines.OpenedGameStatsScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "MelRunHistoryIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_2979", Text = "Let's have the latest numbers." },
		{ Cue = "/VO/Melinoe_2980", Text = "Best to keep track of each detail...", PlayFirst = true },
	},
}

-- Altar
GlobalVoiceLines.OpenedCardScreenVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.33,
	GameStateRequirements =
	{
		{
			PathTrue = { "ActiveScreens", "MetaUpgradeCardLayout" },
		},
	},
	Cooldowns =
	{
		{ Name = "MelCardScreenOpenedSpeech", Time = 20 },
	},


	{ Cue = "/VO/Melinoe_2403", Text = "The Altar of Ashes.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1609" },
			},
		},
	},
	{ Cue = "/VO/Melinoe_2404", Text = "The ashes remember." },
	{ Cue = "/VO/Melinoe_2405", Text = "Ashes of the past..." },
	{ Cue = "/VO/Melinoe_2406", Text = "What say the ashes...?" },
	{ Cue = "/VO/Melinoe_0538", Text = "My Altar...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 12,
			},
		}
	},
	{ Cue = "/VO/Melinoe_0539", Text = "The Arcana..." },
	{ Cue = "/VO/Melinoe_0540", Text = "Strength and wisdom of my predecessors." },
	{ Cue = "/VO/Melinoe_0541", Text = "Focus..." },
	{ Cue = "/VO/Melinoe_1135", Text = "What say the Cards this eve?" },
	{ Cue = "/VO/Melinoe_1136", Text = "Which Cards reflect my path...?" },
	{ Cue = "/VO/Melinoe_1137", Text = "Know the past, know the future..." },
	{ Cue = "/VO/Melinoe_1138", Text = "What say the Arcana...?" },
	{ Cue = "/VO/Melinoe_1139", Text = "I have this..." },
	{ Cue = "/VO/Melinoe_1609", Text = "Headmistress lent me the Arcana...", PlayFirst = true, PlayOnce = true },
	{ Cue = "/VO/Melinoe_1867", Text = "Wisdom of the ages..." },
	{ Cue = "/VO/Melinoe_1868", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_1869", Text = "What is my path...?" },
	{ Cue = "/VO/Melinoe_1870", Text = "Just breathe..." },
}
GlobalVoiceLines.UnlockedCardVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.33,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelCardUnlockSpeech", Time = 10 },
	},

	{ Cue = "/VO/Melinoe_0544", Text = "New Arcana..." },
	{ Cue = "/VO/Melinoe_0545", Text = "Another Card..." },
	{ Cue = "/VO/Melinoe_0546", Text = "This strength is mine.", PlayFirst = true },
}
GlobalVoiceLines.UpgradedMemLimitVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.35,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.1,
	UsePlayerSource = true,
	SkipAnim = true,

	{ Cue = "/VO/Melinoe_0547", Text = "I can do this...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_0548", Text = "Concentrate..." },
	{ Cue = "/VO/Melinoe_2602", Text = "All in the mind..." },
	{ Cue = "/VO/Melinoe_2603", Text = "Remnants of the past..." },
	{ Cue = "/VO/Melinoe_2604", Text = "So that's it..." },
	{ Cue = "/VO/Melinoe_2605", Text = "I see it now..." },
	{ Cue = "/VO/Melinoe_2606", Text = "I never realized..." },
	{ Cue = "/VO/Melinoe_2607", Text = "Just as I thought..." },
}
GlobalVoiceLines.CannotAffordMemUpgradeVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.1,
	UsePlayerSource = true,
	SkipAnim = true,

	{ Cue = "/VO/Melinoe_0779", Text = "I need more Psyche..." },
	{ Cue = "/VO/Melinoe_0780", Text = "Don't have enough Psyche..." },
}

GlobalVoiceLines.ReachedMemLimitVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	UsePlayerSource = true,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelMemLimitSpeech", Time = 30 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/Melinoe_2325", Text = "I lack the Grasp for this.", PlayFirst = true, },
	{ Cue = "/VO/Melinoe_2326", Text = "I can't quite grasp this one..." },
	{ Cue = "/VO/Melinoe_2327", Text = "This is beyond my Grasp." },
	{ Cue = "/VO/Melinoe_2328", Text = "Don't think I can do this..." },
	{ Cue = "/VO/Melinoe_0777", Text = "I'm at my limit." },
	{ Cue = "/VO/Melinoe_0778", Text = "I've reached my limit." },
}
GlobalVoiceLines.ReachedMaxMemLimitVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	UsePlayerSource = true,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelMemLimitSpeech", Time = 30 },
	},

	{ Cue = "/VO/Melinoe_0777", Text = "I'm at my limit." },
	{ Cue = "/VO/Melinoe_0778", Text = "I've reached my limit." },
}
GlobalVoiceLines.ClosedCardScreenVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.75,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.33,
	UsePlayerSource = true,
	GameStateRequirements =
	{
		{
			PathTrue = { "SessionState", "MetaUpgradeChanges", "HasChanged" },
		},
	},

	{ Cue = "/VO/Melinoe_1140", Text = "Ready for more." },
	{ Cue = "/VO/Melinoe_1141", Text = "The Cards know." },
	{ Cue = "/VO/Melinoe_1142", Text = "Better prepared." },
	{ Cue = "/VO/Melinoe_1143", Text = "That'll do.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_0549", Text = "Very well." },
	{ Cue = "/VO/Melinoe_0550", Text = "Ready." },
}
GlobalVoiceLines.SwitchToUpgradeCardModeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "MelCardScreenModeSpeech", Time = 20 },
	},

	{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
	{ Cue = "/VO/Melinoe_0548", Text = "Concentrate..." },
}
GlobalVoiceLines.SwitchFromUpgradeCardModeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "MelCardScreenModeSpeech", Time = 20 },
	},

	{ Cue = "/VO/Melinoe_0282", Text = "{#Emph}Whew." },
	{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
}
GlobalVoiceLines.UpgradeCardVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelCardUpgradeSpeech", Time = 2 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.75,

		{ Cue = "/VO/Melinoe_2973", Text = "I see it now...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2976", Text = "I never realized...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2978", Text = "This potential...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2974", Text = "Now I see..." },
		{ Cue = "/VO/Melinoe_2975", Text = "I understand..." },
		{ Cue = "/VO/Melinoe_2977", Text = "So that's it..." },
		{ Cue = "/VO/Melinoe_0993", Text = "I see it now." },
		{ Cue = "/VO/Melinoe_0994", Text = "I see..." },
		{ Cue = "/VO/Melinoe_0995", Text = "So that's it..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,

		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0179", Text = "All right." },
		{ Cue = "/VO/Melinoe_0185", Text = "There." },
		{ Cue = "/VO/Melinoe_0205", Text = "Better." },
		{ Cue = "/VO/Melinoe_0203", Text = "Yes." },
		{ Cue = "/VO/Melinoe_0209", Text = "There." },
		{ Cue = "/VO/Melinoe_0206", Text = "Good." },
	},
}
GlobalVoiceLines.UnlockedUpgradeModeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.45,
	Cooldowns =
	{
		{ Name = "MelCardScreenOpenedSpeech", Time = 20 },
	},

	{ Cue = "/VO/Melinoe_0992", Text = "What's this...?" },
	-- { Cue = "/VO/Melinoe_0827", Text = "Something there." },
}

-- Weapon Shop / Weapons
-- Silver Pool
GlobalVoiceLines.WeaponShopOpenedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelWeaponShopInteractSpeech", Time = 30 },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_1611", Text = "The Arms of Night are now at my disposal..." },
		{ Cue = "/VO/Melinoe_1898", Text = "...or shall be, soon enough.",
			PreLineWait = 0.8, BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1611" },
				},
			},
		},
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},

		{ Cue = "/VO/Melinoe_3392", Text = "So much to choose from now..." },
		{ Cue = "/VO/Melinoe_3393", Text = "Where to even begin...?",
			PreLineWait = 0.8, BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_3392" },
				},
			},
		},
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = { "WeaponDagger", "WeaponTorch", "WeaponAxe" },
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasNone = { "WeaponLob" },
			},
		},
		{ Cue = "/VO/Melinoe_3394", Text = "Another artifact of Night within the Pool..." },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "ToolsShopIntro",
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeToolsShop" },
			},
		},
		{ Cue = "/VO/Melinoe_0571", Text = "There's something new here..." },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "AspectsShopIntro",
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		{ Cue = "/VO/Melinoe_2541", Text = "The Aspects of the Nocturnal Arms..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.1,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0570", Text = "The Silver Pool...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3395", Text = "The Arms of Night..." },
		{ Cue = "/VO/Melinoe_3396", Text = "What secrets lie within?" },
		{ Cue = "/VO/Melinoe_3397", Text = "Much deeper than it looks..." },
	},
}
GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Skelly_01",
		TriggerCooldowns = { "SkellyQuipAnySpeech" },

		{ Cue = "/VO/Skelly_0014", Text = "Requisition authorized!" },
		{ Cue = "/VO/Skelly_0015", Text = "A fitting armament.", PlayFirst = true },
		{ Cue = "/VO/Skelly_0026", Text = "Bear it with honor!" },
		{ Cue = "/VO/Skelly_0027", Text = "Would that I could see behind me now..." },
		{ Cue = "/VO/Skelly_0028", Text = "That creepy artifact is yours, kiddo." },
	},
}
GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Skelly_01",
		TriggerCooldowns = { "SkellyQuipAnySpeech" },
		Cooldowns =
		{
			{ Name = "SkellyUpgradeReactionSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0198", Text = "Whoa, what was that?" },
		{ Cue = "/VO/Skelly_0199", Text = "Hey, what just happened?" },
		{ Cue = "/VO/Skelly_0200", Text = "Oh dang!" },
		{ Cue = "/VO/Skelly_0201", Text = "Oh something's going on back there..." },
		{ Cue = "/VO/Skelly_0202", Text = "Oh, something's up!" },
		{ Cue = "/VO/Skelly_0203", Text = "I know that sound all right!" },
	},
}
GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		CooldownTime = 5,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Skelly_01",
		TriggerCooldowns = { "SkellyQuipAnySpeech" },

		{ Cue = "/VO/Skelly_0029", Text = "Do make good use of that." },
		{ Cue = "/VO/Skelly_0030", Text = "It shall serve you well." },
		{ Cue = "/VO/Skelly_0031", Text = "A trusty tool indeed." },
		{ Cue = "/VO/Skelly_0118", Text = "The path to perfection...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					HasAll = { "/VO/Skelly_0029", "/VO/Skelly_0030", "/VO/Skelly_0031" },
				},
			},
		},
	},
}
GlobalVoiceLines.WeaponUnlockGlobalVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0572", Text = "Awaken, Arms of Night, and join with me!", PlayFirst = true },
		-- { Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0214", Text = "This one." },
		{ Cue = "/VO/Melinoe_0215", Text = "How about..." },
		-- { Cue = "/VO/Melinoe_0216", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0217", Text = "You." },
		{ Cue = "/VO/Melinoe_0218", Text = "Why not." },
		{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
		{ Cue = "/VO/Melinoe_0220", Text = "{#Emph}Heh." },
		-- { Cue = "/VO/Melinoe_0234", Text = "Open." },
		{ Cue = "/VO/Melinoe_0236", Text = "This one." },
		-- { Cue = "/VO/Melinoe_0237", Text = "You're mine." },
		{ Cue = "/VO/Melinoe_0238", Text = "Sure." },
		{ Cue = "/VO/Melinoe_0239", Text = "Join with me." },
		-- { Cue = "/VO/Melinoe_0240", Text = "You are mine now." },
	},
	[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
}
GlobalVoiceLines.FamiliarUpgradedGlobalVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
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
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsAny = { "CatFamiliar" },
			}
		},

		{ Cue = "/VO/Melinoe_0246_B", Text = "I got you something.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0247_B", Text = "I got you this.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0248_B", Text = "Got something for you.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0249_B", Text = "Here you go!", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_0991_B", Text = "Little one, I have something for you.", PlayFirst = true, },
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
	},
}

GlobalVoiceLines.AnyAspectUpgradedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.2,
	-- SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
	},
	TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

	{ Cue = "/VO/Melinoe_2549", Text = "Awaken, hidden power." },
	{ Cue = "/VO/Melinoe_2550", Text = "There's more to this Aspect." },
	{ Cue = "/VO/Melinoe_2551", Text = "Let our bond grow strong." },
	{ Cue = "/VO/Melinoe_2552", Text = "Become even stronger." },
	{ Cue = "/VO/Melinoe_2553", Text = "Such power hides within." },
	{ Cue = "/VO/Melinoe_2554", Text = "Show me your true strength." },
	{ Cue = "/VO/Melinoe_2555", Text = "You are bound to me, and I am your bearer." },
	{ Cue = "/VO/Melinoe_2556", Text = "Draw greater power from the Silver Pool." },
}

GlobalVoiceLines.StaffAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2545", Text = "Descura: Awaken!" },
		{ Cue = "/VO/Melinoe_2546", Text = "Descura, reveal your secrets!" },

	},
	[2] = GlobalVoiceLines.AnyAspectUpgradedVoiceLines,
	[3] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
}
GlobalVoiceLines.DaggerAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2547", Text = "Lim and Oros: Awaken!" },
		{ Cue = "/VO/Melinoe_2548", Text = "Lim and Oros, reveal your secrets!" },
	},
	[2] = GlobalVoiceLines.AnyAspectUpgradedVoiceLines,
	[3] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
}

GlobalVoiceLines.ToolUnlockGlobalVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
		},

		{ Cue = "/VO/Melinoe_0235", Text = "Open up." },
		{ Cue = "/VO/Melinoe_0216", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0237", Text = "You're mine." },
		{ Cue = "/VO/Melinoe_0240", Text = "You are mine now." },
	},
	[2] = GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines,
}
GlobalVoiceLines.AnyToolUpgradedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.2,
	-- SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
	},
	TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

	{ Cue = "/VO/Melinoe_2561", Text = "May you shine like the Moon." },
	{ Cue = "/VO/Melinoe_2562", Text = "Bathe now in the light of the Moon." },
}
GlobalVoiceLines.ToolPickaxeUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2557", Text = "The Crescent Pick achieves a greater form..." },
	},
	[2] = GlobalVoiceLines.AnyToolUpgradedVoiceLines,
	[3] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
}
GlobalVoiceLines.ToolExorcismBookUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2559", Text = "New life for the Tablet of Peace." },
	},
	[2] = GlobalVoiceLines.AnyToolUpgradedVoiceLines,
	[3] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
}
GlobalVoiceLines.ToolShovelUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2558", Text = "The Silver Spade shines even brighter now." },
	},
	[2] = GlobalVoiceLines.AnyToolUpgradedVoiceLines,
	[3] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
}
GlobalVoiceLines.ToolFishingRodUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2560", Text = "The Rod of Fishing should be stronger now." },
	},
	[2] = GlobalVoiceLines.AnyToolUpgradedVoiceLines,
	[3] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
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
GlobalVoiceLines.WeaponShopClosedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.8,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasNone = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
			},
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "==",
				Value = 0,
			},
		},

		{ Cue = "/VO/Melinoe_1899", Text = "Much more than just this staff bathing in there." },
	},
}

-- Weapon Equipping
GlobalVoiceLines.MiscWeaponEquipVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeMiscWeaponEquipSpeech", Time = 25 },
	},
	{
		PlayOnceFromTableThisRun = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "UnusedWeaponBonusTrait" },
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
		{ Name = "MelinoeWeaponUpgradeScreenSpeech", Time = 3 },
	},
	{
		BreakIfPlayed = true,
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
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.8,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "BaseStaffAspect", "DaggerBackstabAspect" },
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
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
		},
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
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.33,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyFamiliarSpeech", Time = 10 },
		},

		{ Cue = "/VO/Skelly_0132", Text = "It seems we have a new disciple!", PlayOnce = true, PlayOnceContext = "FirstFamiliarEquip", PlayFirst = true, },
		{ Cue = "/VO/Skelly_0133", Text = "A new disciple joined our ranks, young one!" },
		{ Cue = "/VO/Skelly_0134", Text = "Whence came that tiny beast?" },
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

-- Keepsakes Lines
GlobalVoiceLines.OpenedAwardMenuVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	Cooldowns =
	{
		{ Name = "KeepsakesMentionedRecently", Time = 200 },
		{ Name = "MelinoeRemainsSilent", Time = 8 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.33,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},

		{ Cue = "/VO/MelinoeField_0721", Text = "Should I change things up?" },
		{ Cue = "/VO/MelinoeField_0722", Text = "Maybe I should switch." },
		{ Cue = "/VO/MelinoeField_0723", Text = "Try another one maybe..." },
		{ Cue = "/VO/MelinoeField_0724", Text = "Could try a different one..." },
		{ Cue = "/VO/MelinoeField_0725", Text = "Which one would help..." },
		{ Cue = "/VO/MelinoeField_0726", Text = "Which Keepsake now..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.2,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		{ Cue = "/VO/Melinoe_0834", Text = "My Keepsakes...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2642", Text = "Which one..." },
		{ Cue = "/VO/Melinoe_2643", Text = "I'm in the mood for..." },
		{ Cue = "/VO/Melinoe_2644", Text = "Faith of my comrades..." },
		{ Cue = "/VO/Melinoe_2645", Text = "Another Keepsake perhaps...?" },
		{ Cue = "/VO/Melinoe_3174", Text = "This night calls for..." },
		{ Cue = "/VO/Melinoe_3177", Text = "Which shall it be..." },
		{ Cue = "/VO/Melinoe_3175", Text = "Which Keepsake for tonight...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3176", Text = "Everything's in order...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3178", Text = "Which to use first...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3179", Text = "Which to start with...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
	},
}
GlobalVoiceLines.AwardMenuNewAvailableVoiceLines =
{
	Cooldowns =
	{
		{ Name = "KeepsakesMentionedRecently", Time = 200 },
	},
	{
		{
			SkipAnim = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlayAll = 0.1,
			GameStateRequirements =
			{
				{
					PathTrue = { "ActiveScreens", "KeepsakeRack" },
				},
				IsObjectTypeNotAlive = "NPC_Chronos_01",
			},

			-- ~8 variants?
			{ Cue = "/VO/Melinoe_0834", Text = "My Keepsakes...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3207", Text = "What's that one do?" },
			{ Cue = "/VO/Melinoe_3208", Text = "A new Keepsake..." },
			{ Cue = "/VO/Melinoe_3209", Text = "My collection grows..." },
			{ Cue = "/VO/Melinoe_3210", Text = "New Keepsake there..." },
			{ Cue = "/VO/Melinoe_0836", Text = "Something new there?" },
			{ Cue = "/VO/Melinoe_0837", Text = "Expanded my collection..." },
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			ObjectType = "NPC_Skelly_01",

			{ Cue = "/VO/Skelly_0082", Text = "Behold that heirloom storage case over there!" },
		},
	},
}
GlobalVoiceLines.AwardMenuEmptyVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		PreLineWait = 0.4,

		{ Cue = "/VO/Melinoe_0835", Text = "I'd store my Keepsakes here, if I had any..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		ObjectType = "NPC_Skelly_01",

		{ Cue = "/VO/Skelly_0082", Text = "Behold that heirloom storage case over there!" },
	},
}
GlobalVoiceLines.AwardSelectedVoiceLines =
{
	{
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			IsObjectTypeNotAlive = "NPC_Chronos_01",
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0838", Text = "This one." },
		{ Cue = "/VO/Melinoe_0839", Text = "That one." },
		{ Cue = "/VO/Melinoe_0840", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0841", Text = "Should keep me company." },
		{ Cue = "/VO/Melinoe_2646", Text = "Ought to help." },
		{ Cue = "/VO/Melinoe_2647", Text = "Very well." },
		{ Cue = "/VO/Melinoe_2648", Text = "Sure." },
		{ Cue = "/VO/Melinoe_3204", Text = "All right." },
		{ Cue = "/VO/Melinoe_3205", Text = "This, then." },
		{ Cue = "/VO/Melinoe_3206", Text = "Might as well." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.15,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyKeepsakeSpeech", Time = 60 },
		},

		{ Cue = "/VO/Skelly_0128", Text = "May it serve you well." },
		{ Cue = "/VO/Skelly_0129", Text = "A fine selection!" },
		{ Cue = "/VO/Skelly_0130", Text = "A fine selection." },
		{ Cue = "/VO/Skelly_0131", Text = "That's no mere trinket, huh?" },
	},
}
GlobalVoiceLines.AwardMenuClosedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Chronos_01",
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			{ Name = "ChronosAnyQuipSpeech", Time = 8 },
		},

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
	},	
	{
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0204", Text = "Excellent." },
		{ Cue = "/VO/Melinoe_0206", Text = "Good." },
		{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0244", Text = "Very well..." },
		{ Cue = "/VO/Melinoe_0179", Text = "All right." },
		{ Cue = "/VO/Melinoe_0180", Text = "Set." },
	},
}

-- Global Misc Lines
GlobalVoiceLines.SpellReactionVoiceLines =
{
	Cooldowns =
	{
		{ Name = "SpellReactionVOPlayedRecently", Time = 30 },
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
						HasAny = { "SpellLaserTrait", "SpellLeapTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0232", Text = "Here it comes...",
				PreLineWait = 1.5,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait", "SpellLeapTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0233", Text = "There, {#Emph}yes...!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait", "SpellLeapTrait" },
					},
				},
			},
			{ Cue = "/VO/HecateField_0234", Text = "Wrath of the Moon...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellLaserTrait", "SpellLeapTrait" },
					},
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/HecateField_0142" },
					},
				},
			},
		},
		{
			RandomRemaining = true,
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
		PreLineWait = 1.8,
		ObjectType = "Scylla",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "SpellSummonTrait" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Kills" },
				HasNone = { "FishSwarmer", "FishSwarmer_Elite" },
			},
		},
		{ Cue = "/VO/Scylla_0180", Text = "Roxy!!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasAll = { "SirenDrummer" },
				},
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasNone = { "SirenKeytarist" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0181", Text = "{#Emph}Ngh, dammit{#Prev}, Roxy!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasAll = { "SirenDrummer" },
				},
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasNone = { "SirenKeytarist" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0089", Text = "Jetty?!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasAll = { "SirenKeytarist" },
				},
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasNone = { "SirenDrummer" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0132", Text = "What happened to Jetty?!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasAll = { "SirenKeytarist" },
				},
				{
					Path = { "CurrentRun", "EnemyKills" },
					HasNone = { "SirenDrummer" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0183", Text = "{#Emph}Oh{#Prev}, come {#Emph}on!" },
		{ Cue = "/VO/Scylla_0184", Text = "That's {#Emph}not {#Prev}part of the {#Emph}act!" },
		{ Cue = "/VO/Scylla_0185", Text = "What did you {#Emph}do {#Prev}to her?" },
		{ Cue = "/VO/Scylla_0186", Text = "No {#Emph}fair!!" },
	},

	-- Chronos
	-- handled in GlobalVoiceLines.ChronosSpellResistVoiceLines

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
	-- Nemesis
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "NPC_Nemesis_01",
		SuccessiveChanceToPlay = 0.5,
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
	-- Heracles
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.8,
		ObjectType = "NPC_Heracles_01",
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SpellPotionTrait" },
			},
		},
		TriggerCooldowns = { "HeraclesAnyQuipSpeech" },

		{ Cue = "/VO/Heracles_0081", Text = "You and your tricks..." },
		{ Cue = "/VO/Heracles_0082", Text = "Magick...", PlayFirst = true },
		{ Cue = "/VO/Heracles_0083", Text = "Tricksy..." },
	},
}
GlobalVoiceLines.SpellPolymorphReactionVoiceLines =
{
	Cooldowns =
	{
		{ Name = "SpellReactionVOPlayedRecently", Time = 30 },
	},
	-- Hecate
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
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
	-- Polyphemus
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
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

}

-- Global Hades Lines
GlobalVoiceLines.HadesCurseVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice },

	{ Cue = "/VO/Hades_0085", Text = "{#Emph}Curse you..." },
	{ Cue = "/VO/Hades_0086", Text = "{#Emph}Curse you, Father..." },
	{ Cue = "/VO/Hades_0087", Text = "{#Emph}Blast you, Father!" },
	{ Cue = "/VO/Hades_0088", Text = "{#Emph}You stay away from her...!" },
	{ Cue = "/VO/Hades_0089", Text = "{#Emph}Wretched Titan..." },
	{ Cue = "/VO/Hades_0090", Text = "{#Emph}Wretched excuse for a father!" },
	{ Cue = "/VO/Hades_0091", Text = "{#Emph}There is no escape." },
	{ Cue = "/VO/Hades_0092", Text = "{#Emph}Get from my House!" },
	{ Cue = "/VO/Hades_0093", Text = "{#Emph}Death is your only family." },
	{ Cue = "/VO/Hades_0094", Text = "{#Emph}For what you did to me!" },
	{ Cue = "/VO/Hades_0095", Text = "{#Emph}<Laughter>", PlayFirst = true },
}
GlobalVoiceLines.HadesHarvestReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.33,
	ObjectType = "NPC_Hades_Field_01",
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
			Comparison = ">=",
			Value = 2,
		},
	},
	Cooldowns =
	{
		{ Name = "HadesSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Hades_0152", Text = "Why pick the refuse from this place?" },
	{ Cue = "/VO/Hades_0153", Text = "There's nothing here of use." },
}
GlobalVoiceLines.HadesExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.33,
	ObjectType = "NPC_Hades_Field_01",
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
			Comparison = ">=",
			Value = 2,
		},
	},
	Cooldowns =
	{
		{ Name = "HadesSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Hades_0154", Text = "I thought that one would never leave." },
	{ Cue = "/VO/Hades_0155", Text = "A Shade that has a spine." },
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

-- Global Poseidon Lines
GlobalVoiceLines.PoseidonCheerVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
		GameStateRequirements =
		{
			--
		},
		{ Cue = "/VO/Poseidon_0202", Text = "{#Emph}Hahaha{#Prev}, yes!" },
		{ Cue = "/VO/Poseidon_0242", Text = "Yes, {#Emph}haha!", PlayFirst = true },
	},
	[2] = GlobalVoiceLines.PositiveReactionVoiceLines,
}

GlobalVoiceLines.PoseidonWelcomeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	SuccessiveChanceToPlay = 0.5,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 240 },
	},

	{ Cue = "/VO/Ships_0090", Text = "Welcome to my waters!", PlayFirst = true },
	{ Cue = "/VO/Ships_0091", Text = "Welcome back!" },
	{ Cue = "/VO/Ships_0092", Text = "My niece, you made it here!" },
	{ Cue = "/VO/Ships_0093", Text = "Your voyage begins anew!" },
	{ Cue = "/VO/Ships_0094", Text = "Prepare to embark!" },
	{ Cue = "/VO/Ships_0095", Text = "Let's get you through this channel!" },
}
GlobalVoiceLines.PoseidonSetSailVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 240 },
	},
	PostLineFunctionName = "HadesSpeakingPresentation",
	PostLineFunctionArgs = { PlaySpeechFirst = true, OverlayAnim = "PoseidonOverlay" },

	{ Cue = "/VO/Ships_0096", Text = "Smooth sailing, my niece!" },
	{ Cue = "/VO/Ships_0097", Text = "May you sail swift and true!" },
	{ Cue = "/VO/Ships_0098", Text = "These are contested waters I'm afraid!" },
	{ Cue = "/VO/Ships_0099", Text = "Sail on and have no fear!" },
	{ Cue = "/VO/Ships_0100", Text = "Steady as she goes!" },
	{ Cue = "/VO/Ships_0101", Text = "Sail forth!" },
}
GlobalVoiceLines.PoseidonCombatBeginsVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 180 },
	},
	PostLineFunctionName = "HadesSpeakingPresentation",
	PostLineFunctionArgs = { PlaySpeechFirst = true, OverlayAnim = "PoseidonOverlay" },

	{ Cue = "/VO/Ships_0102", Text = "Unwelcome company!" },
	{ Cue = "/VO/Ships_0103", Text = "Contaminated waters!" },
	{ Cue = "/VO/Ships_0104", Text = "Servants of Chronos!" },
	{ Cue = "/VO/Ships_0105", Text = "Enemies, upon my waters!" },
	{ Cue = "/VO/Ships_0106", Text = "Upon my waters!" },
	{ Cue = "/VO/Ships_0107", Text = "Our enemies abound!" },
	{ Cue = "/VO/Ships_0108", Text = "Rough waters coming up..." },
	{ Cue = "/VO/Ships_0109", Text = "Pirates!" },
}
GlobalVoiceLines.PoseidonEliteCombatBeginsVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 360 },
	},

	{ Cue = "/VO/Ships_0110", Text = "Beware this one!" },
	{ Cue = "/VO/Ships_0111", Text = "Don't let your guard down now!" },
	{ Cue = "/VO/Ships_0112", Text = "Go give it everything you've got!" },
	{ Cue = "/VO/Ships_0113", Text = "Brace yourself, Niece!" },
	{ Cue = "/VO/Ships_0114", Text = "All right, Niece, here we go!" },
}
GlobalVoiceLines.PoseidonKillingEnemyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 360 },
	},

	{ Cue = "/VO/Ships_0115", Text = "{#Emph}Haha{#Prev}, good one, my niece!" },
	{ Cue = "/VO/Ships_0116", Text = "Another down, {#Emph}haha!" },
	{ Cue = "/VO/Ships_0117", Text = "That ought to teach them!" },
	{ Cue = "/VO/Ships_0118", Text = "Yes, that's it!" },
	{ Cue = "/VO/Ships_0119", Text = "No mercy shown!" },
	{ Cue = "/VO/Ships_0120", Text = "Nice catch!" },
	{ Cue = "/VO/Ships_0121", Text = "That's my niece!" },
	{ Cue = "/VO/Ships_0122", Text = "Showed that one!" },
}
GlobalVoiceLines.PoseidonPlayerInjuredVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0123", Text = "Be careful, Niece!" },
	{ Cue = "/VO/Ships_0124", Text = "Now just hang on!" },
	{ Cue = "/VO/Ships_0125", Text = "You can do this!" },
	{ Cue = "/VO/Ships_0126", Text = "Steady yourself!" },
	{ Cue = "/VO/Ships_0127", Text = "Keep fighting!" },
	{ Cue = "/VO/Ships_0128", Text = "Don't you back down!" },
}
GlobalVoiceLines.PoseidonNextWaveVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0129", Text = "{#Emph}Augh{#Prev}, no..." },
	{ Cue = "/VO/Ships_0130", Text = "{#Emph}Erm{#Prev}, don't look now..." },
	{ Cue = "/VO/Ships_0131", Text = "More trouble for you, Niece!" },
	{ Cue = "/VO/Ships_0132", Text = "More incoming!" },
	{ Cue = "/VO/Ships_0133", Text = "Look what they're doing to my seas!" },
	{ Cue = "/VO/Ships_0134", Text = "This storm's not over yet!" },
	{ Cue = "/VO/Ships_0135", Text = "Watch out!" },
	{ Cue = "/VO/Ships_0136", Text = "Reinforcements!" },
}
GlobalVoiceLines.PoseidonCombatResolvedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0137", Text = "The coast is clear for now." },
	{ Cue = "/VO/Ships_0138", Text = "You showed them all!" },
	{ Cue = "/VO/Ships_0139", Text = "That's my niece!" },
	{ Cue = "/VO/Ships_0140", Text = "You did it!" },
	{ Cue = "/VO/Ships_0141", Text = "Excellent work." },
	{ Cue = "/VO/Ships_0142", Text = "Well done back there!" },
	{ Cue = "/VO/Ships_0143", Text = "That's what they get." },
	{ Cue = "/VO/Ships_0144", Text = "Enough of them!" },
}
GlobalVoiceLines.PoseidonCombatResolvedLowHealthVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0145", Text = "Rough patch of water there..." },
	{ Cue = "/VO/Ships_0146", Text = "Still in one piece are you?" },
	{ Cue = "/VO/Ships_0147", Text = "Thought you were good as gone!" },
	{ Cue = "/VO/Ships_0148", Text = "You made it out of that?!" },
}
GlobalVoiceLines.PoseidonDeathResponseVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "O_Boss01" },
		},
	},
	Cooldowns =
	{
		-- { Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0149", Text = "My niece? Where did you go?!", PlayFirst = true },
	{ Cue = "/VO/Ships_0150", Text = "Those blasted pirates, {#Emph}augh..." },
	{ Cue = "/VO/Ships_0151", Text = "Ill tidings once again..." },
	{ Cue = "/VO/Ships_0152", Text = "What happened, little Niece?!" },
	{ Cue = "/VO/Ships_0153", Text = "The voyage wasn't meant to be..." },
	{ Cue = "/VO/Ships_0154", Text = "I'm sorry, little Niece!" },
}
GlobalVoiceLines.PoseidonBoonChoiceVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	SuccessiveChanceToPlay = 0.25,
	PreLineWait = 7.55,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
		{
			{
				PathTrue = { "ActiveScreens", "UpgradeChoice" },
			},
		},
	},
	Cooldowns =
	{
		-- { Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0155", Text = "This ought to help I think!" },
	{ Cue = "/VO/Ships_0156", Text = "A little gift!" },
	{ Cue = "/VO/Ships_0157", Text = "A bounty from the sea!" },
	{ Cue = "/VO/Ships_0158", Text = "For you, my niece!" },
	{ Cue = "/VO/Ships_0159", Text = "Got something for you!" },
	{ Cue = "/VO/Ships_0160", Text = "Here's a fresh catch for you!" },
}
GlobalVoiceLines.PoseidonForkingPathsVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0161", Text = "Where to?" },
	{ Cue = "/VO/Ships_0162", Text = "There's many currents in the sea..." },
	{ Cue = "/VO/Ships_0163", Text = "The helm is yours!" },
	{ Cue = "/VO/Ships_0164", Text = "Which way to navigate?" },
}
GlobalVoiceLines.PoseidonExitRoomVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "O" },
		},
	},
	Cooldowns =
	{
		{ Name = "PoseidonAnyQuipSpeech", Time = 120 },
	},

	{ Cue = "/VO/Ships_0165", Text = "Onward!" },
	{ Cue = "/VO/Ships_0166", Text = "Smooth sailing!" },
	{ Cue = "/VO/Ships_0167", Text = "Off you go!" },
	{ Cue = "/VO/Ships_0168", Text = "Press on!" },
	{ Cue = "/VO/Ships_0169", Text = "You're getting there!" },
	{ Cue = "/VO/Ships_0170", Text = "Keep it up!" },
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

-- Global Hecate Lines
GlobalVoiceLines.HecateCauldronAssistanceLines =
{
	{
		PreLineWait = 1.0,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Hecate_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpeechRecord" },
				CountOf = {
					"/VO/Melinoe_2465",
					"/VO/Melinoe_2466",
					"/VO/Melinoe_2467",
					"/VO/Melinoe_2468",
					"/VO/Melinoe_2469",
					"/VO/Melinoe_2470",
					"/VO/Melinoe_2471",
					"/VO/Melinoe_2472",

					"/VO/Melinoe_2577",
					"/VO/Melinoe_2578",
					"/VO/Melinoe_2579",
					"/VO/Melinoe_2580",
					"/VO/Melinoe_2581",
					"/VO/Melinoe_2582",
					"/VO/Melinoe_2583",
					"/VO/Melinoe_2584",
				},
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasAny = { "/VO/Melinoe_2472" },
			},
		},
		{ Cue = "/VO/Hecate_0604", Text = "Appreciate your strength." },
		{ Cue = "/VO/Hecate_0605", Text = "Our wards are that much stronger thanks to you.", PlayFirst = true },
		{ Cue = "/VO/Hecate_0606", Text = "Thus we remain concealed." },
		{ Cue = "/VO/Hecate_0607", Text = "Thank you for that, Melinoë." },
		{ Cue = "/VO/Hecate_0608", Text = "The wards about this place are back at strength." },
		{ Cue = "/VO/Hecate_0609", Text = "Our voices joined, thus we remain unseen." },
	},
}
GlobalVoiceLines.AddingReagentVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.05,
		SuccessiveChanceToPlay = 0.66,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0518", Text = "I'm ready.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0519", Text = "Let's begin.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0520", Text = "This should help.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0521", Text = "Headmistress, if I may?", PlayFirst = true,
			GameStateRequirements =
			{
				AreIdsAlive = { 556921 },
			},
		},
		{ Cue = "/VO/Melinoe_0522", Text = "Should have everything here." },
		{ Cue = "/VO/Melinoe_0523", Text = "Into the pot..." },
		{ Cue = "/VO/Melinoe_0524", Text = "In you go." },
		-- { Cue = "/VO/Melinoe_0525", Text = "One at a time..." },
		{ Cue = "/VO/Melinoe_0526", Text = "Temperature looks good..." },
		{ Cue = "/VO/Melinoe_0527", Text = "Should be everything." },				
	},
	{
		PreLineWait = 0.45,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Hecate_01",
		-- RequiredSourceValueFalse = "InPartnerConversation",
		GameStateRequirements =
		{
			{
				PathTrue = { "MapState", "AddingReagents" },
			},
		},

		{ Cue = "/VO/Hecate_0174", Text = "You may proceed.", PlayFirst = true },
		{ Cue = "/VO/Hecate_0175", Text = "Ah, I see." ,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_0521" },
				},
			},
		},
		{ Cue = "/VO/Hecate_0176", Text = "Begin." },
		{ Cue = "/VO/Hecate_0177", Text = "Go on." },
		{ Cue = "/VO/Hecate_0178", Text = "Go on." },
		{ Cue = "/VO/Hecate_0179", Text = "Now say the words.", BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_0521" },
				},
			},
		},
		{ Cue = "/VO/Hecate_0180", Text = "Now, say the words.", BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_0521" },
				},
			},
		},
		{ Cue = "/VO/Hecate_0181", Text = "Carefully..." },
		{ Cue = "/VO/Hecate_0182", Text = "What else?" },
		{ Cue = "/VO/Hecate_0183", Text = "And...?" },
		{ Cue = "/VO/Hecate_0184", Text = "Any more?" },
		{ Cue = "/VO/Hecate_0185", Text = "{#Emph}Ah." },
	},
}
GlobalVoiceLines.CauldronReactionVoiceLines =
{
	{
		GameStateRequirements =
		{
			AreIdsNotAlive = { 556921 },
		},
		{
			PreLineWait = 1.95,
			RandomRemaining = true,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_0535", Text = "So mote it be..." },
			{ Cue = "/VO/Melinoe_0536", Text = "...So mote it be." },
			{ Cue = "/VO/Melinoe_0537", Text = "...It is done." },
		},
	},
	{
		GameStateRequirements =
		{
			AreIdsAlive = { 556921 },
		},
		{
			PreLineWait = 0.95,
			RandomRemaining = true,
			ObjectType = "NPC_Hecate_01",
			PreLineThreadedFunctionName = "LightRangedSalute",
			-- RequiredSourceValueFalse = "InPartnerConversation",

			{ Cue = "/VO/Hecate_0065", Text = "So mote it be.", PlayFirst = true },
			{ Cue = "/VO/Hecate_0186", Text = "So mote it be..." },
			{ Cue = "/VO/Hecate_0187", Text = "So mote it be...!" },
			{ Cue = "/VO/Hecate_0188", Text = "So mote it be!" },
			{ Cue = "/VO/Hecate_0189", Text = "'Tis done." },
			{ Cue = "/VO/Hecate_0329", Text = "'Tis done..." },
			{ Cue = "/VO/Hecate_0190", Text = "{#Emph}Hmm{#Prev}, yes..." },
			{ Cue = "/VO/Hecate_0191", Text = "There." },
			{ Cue = "/VO/Hecate_0330", Text = "Interesting..." },
			{ Cue = "/VO/Hecate_0331", Text = "You've done it..." },
			{ Cue = "/VO/Hecate_0480", Text = "So it shall be." },
			{ Cue = "/VO/Hecate_0481", Text = "Your will is done." },
			{ Cue = "/VO/Hecate_0482", Text = "You have it." },
			{ Cue = "/VO/Hecate_0687", Text = "Your intent was true." },
			{ Cue = "/VO/Hecate_0688", Text = "Carefully said." },
			{ Cue = "/VO/Hecate_0689", Text = "I felt your words." },
			{ Cue = "/VO/Hecate_0690", Text = "Aught else?" },
			{ Cue = "/VO/Hecate_0686", Text = "Hear that, Selene?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift02", "SeleneGift02" },
					},
				}
			},
			{ Cue = "/VO/Hecate_0691", Text = "See that, Sisters?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 10,
					},
				}
			},
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.45,
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},

			{ Cue = "/VO/Melinoe_0853", Text = "Let's try the surface one more time..." },
		},
		{
			PreLineWait = 0.45,
			SuccessiveChanceToPlay = 0.5,
			RandomRemaining = true,
			UsePlayerSource = true,
			Cooldowns =
			{
				{ Name = "CauldronRevealQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/Melinoe_0535", Text = "So mote it be..." },
			{ Cue = "/VO/Melinoe_0536", Text = "...So mote it be." },
			{ Cue = "/VO/Melinoe_0537", Text = "...It is done." },
		},
	},
}

GlobalVoiceLines.HecatePolymorphVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	ObjectType = "Hecate",
	Cooldowns =
	{
		{ Name = "HecatePolymorphedRecently", Time = 60 },
	},
	TriggerCooldowns = { "HecateSpokeRecently" },

	{ Cue = "/VO/Hecate_0148", Text = "{#Emph}Ah{#Prev}, to be a beast!", },
	{ Cue = "/VO/Hecate_0149", Text = "Caught you!", },
	{ Cue = "/VO/Hecate_0150", Text = "A hex upon you!", PlayFirst = true },
	{ Cue = "/VO/Hecate_0151", Text = "Enjoy your newfound form.", },
	{ Cue = "/VO/Hecate_0152", Text = "If you could see yourself.", },
	{ Cue = "/VO/Hecate_0153", Text = "I know you hate this trick." },
	{ Cue = "/VO/Hecate_0356", Text = "What's wrong, Melinoë?" },
	{ Cue = "/VO/Hecate_0357", Text = "The curse of Night!" },
	{ Cue = "/VO/Hecate_0358", Text = "Unpleasant, isn't it?" },
	{ Cue = "/VO/Hecate_0359", Text = "Caught out again." },
	{ Cue = "/VO/HecateField_0060", Text = "All you can do is run." },
	{ Cue = "/VO/HecateField_0061", Text = "Now run, Melinoë." },
	{ Cue = "/VO/HecateField_0062", Text = "I suggest you run." },
	{ Cue = "/VO/HecateField_0063", Text = "The tables have turned..." },
	{ Cue = "/VO/HecateField_0064", Text = "Not simple to evade that one." },
	{ Cue = "/VO/HecateField_0065", Text = "You look adorable." },
	{ Cue = "/VO/HecateField_0149", Text = "Take on a lesser form!" },
	{ Cue = "/VO/HecateField_0150", Text = "Time for a {#Emph}change." },
	{ Cue = "/VO/HecateField_0193", Text = "Pardon the interruption." },
	{ Cue = "/VO/HecateField_0191", Text = "No you don't." },
	{ Cue = "/VO/HecateField_0192", Text = "No, you don't!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/HecateField_0191" }
			},
		},
	},
	{ Cue = "/VO/HecateField_0194", Text = "Your {#Emph}favorite!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "F_Boss01" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
}
GlobalVoiceLines.HecateHexVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Hecate",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
			Comparison = ">",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "HecateHexedRecently", Time = 45 },
		{ Name = "HecateSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Hecate_0353", Text = "Now beware..." },
	{ Cue = "/VO/Hecate_0145", Text = "Behold!" },
	{ Cue = "/VO/Hecate_0352", Text = "How about this?" },
	{ Cue = "/VO/Hecate_0493", Text = "{#Emph}Kataskion aski!" },
	{ Cue = "/VO/Hecate_0496", Text = "{#Emph}Askion kataski...!" },
	{ Cue = "/VO/HecateField_0205", Text = "{#Emph}Damname aision!" },
	-- { Cue = "/VO/Hecate_0494", Text = "{#Emph}Kataskion aski...!" },
	-- { Cue = "/VO/Hecate_0495", Text = "{#Emph}Askion kataski!" },
	-- { Cue = "/VO/HecateField_0206", Text = "{#Emph}Damname aision...!" },
	-- { Cue = "/VO/HecateField_0207", Text = "{#Emph}Damnaski traxon!" },
	-- { Cue = "/VO/HecateField_0208", Text = "{#Emph}Damnaski traxon!" },
	{ Cue = "/VO/HecateField_0151", Text = "Behold the Moon!" },
	{ Cue = "/VO/HecateField_0153", Text = "Tremble beneath the Moon!" },
	{ Cue = "/VO/HecateField_0154", Text = "I have more hexes up my sleeve!" },
	{ Cue = "/VO/HecateField_0155", Text = "Let's see you evade {#Emph}this!", PlayFirst = true },
}
GlobalVoiceLines.HecatePhaseChangeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">=",
				Value = 0.65,
			},
		},
		TriggerCooldowns = { "HecateSpokeRecently", "HecateLaseredRecently", "HecateMeteoredRecently", "HecateHexedRecently" },

		{ Cue = "/VO/Hecate_0104", Text = "Good." },
		{ Cue = "/VO/Hecate_0107", Text = "Well done!" },
		{ Cue = "/VO/Hecate_0111", Text = "Good form." },
		{ Cue = "/VO/Hecate_0117", Text = "Well struck." },
		{ Cue = "/VO/HecateField_0038", Text = "Do not overextend." },
		{ Cue = "/VO/HecateField_0039", Text = "{#Emph}That {#Prev}I felt." },
		{ Cue = "/VO/HecateField_0042", Text = "Careful now." },
		{ Cue = "/VO/HecateField_0043", Text = "That's it." },
		{ Cue = "/VO/HecateField_0044", Text = "Like that." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = "<=",
				Value = 0.35,
			},
		},
		TriggerCooldowns = { "HecateSpokeRecently", "HecateLaseredRecently", "HecateMeteoredRecently" },

		{ Cue = "/VO/Hecate_0103", Text = "Good!" },
		{ Cue = "/VO/Hecate_0106", Text = "Well done." },
		{ Cue = "/VO/Hecate_0105", Text = "{#Emph}Rngh{#Prev}, good!" },
		{ Cue = "/VO/Hecate_0365", Text = "{#Emph}Heh..." },
		{ Cue = "/VO/HecateField_0048", Text = "Like that...!" },
	},

}

GlobalVoiceLines.HecateBossSpawnWaveVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Hecate",
	Cooldowns =
	{
		{ Name = "HecateSummonedRecently", Time = 200 },
	},
	TriggerCooldowns = { "HecateSpokeRecently" },

	{ Cue = "/VO/Hecate_0154", Text = "To me, my Sisters!" },
	{ Cue = "/VO/Hecate_0155", Text = "Join me, Sisters!" },
	{ Cue = "/VO/Hecate_0508", Text = "Into the fray, Sisters!" },
	{ Cue = "/VO/Hecate_0509", Text = "Once more with me, Sisters!" },
	{ Cue = "/VO/Hecate_0510", Text = "Return to me, Sisters!" },
	{ Cue = "/VO/Hecate_0511", Text = "Return to fight, Sisters!" },
	{ Cue = "/VO/Hecate_0512", Text = "Arise, Sisters!", PlayFirst = true },
	{ Cue = "/VO/Hecate_0513", Text = "Arise again, Sisters!" },	
	{ Cue = "/VO/HecateField_0050", Text = "So..." },
	{ Cue = "/VO/HecateField_0195", Text = "{#Emph}Night Bloom!" },
	{ Cue = "/VO/HecateField_0196", Text = "{#Emph}Night Bloom...!", PlayFirst = true },
	{ Cue = "/VO/HecateField_0197", Text = "Sisters, to {#Emph}me!" },
	{ Cue = "/VO/HecateField_0198", Text = "Come, Sisters of the Dead!" },
	{ Cue = "/VO/HecateField_0199", Text = "Oh, Sisters?",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EnemyKills", "Chronos" },
			},
			{
				Path = { "GameState", "RoomsEntered", "F_Boss01" },
				Comparison = ">=",
				Value = 8,
			},
		},
	},
	{ Cue = "/VO/HecateField_0200", Text = "Sisters, {#Emph}now!" },
}
GlobalVoiceLines.HecateGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Hecate",
	Cooldowns =
	{
		{ Name = "HecateSpokeRecently", Time = 25 },
	},

	{ Cue = "/VO/Hecate_0360", Text = "Don't you think that can wait?" },
	{ Cue = "/VO/Hecate_0361", Text = "A valuable!" },
	{ Cue = "/VO/Hecate_0362", Text = "Find anything good?", PlayFirst = true },
	{ Cue = "/VO/Hecate_0363", Text = "Hello, this is a {#Emph}fight!" },
	{ Cue = "/VO/HecateField_0070", Text = "Aren't you a cheeky one." },
	{ Cue = "/VO/HecateField_0071", Text = "You'll soon get more than that." },
	{ Cue = "/VO/HecateField_0072", Text = "How nice for you." },
	{ Cue = "/VO/HecateField_0073", Text = "{#Emph}Ooh {#Prev}let me see!" },
}
GlobalVoiceLines.HecateAddsDeadVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.25,
		Cooldowns =
		{
			{ Name = "HecateSpokeRecently", Time = 25 },
		},

		{ Cue = "/VO/Hecate_0103", Text = "Good!" },
		{ Cue = "/VO/Hecate_0104", Text = "Good." },
		{ Cue = "/VO/Hecate_0106", Text = "Well done." },
		{ Cue = "/VO/Hecate_0107", Text = "Well done!" },
		{ Cue = "/VO/Hecate_0111", Text = "Good form." },
		{ Cue = "/VO/Hecate_0117", Text = "Well struck." },
		{ Cue = "/VO/HecateField_0038", Text = "Do not overextend." },
		{ Cue = "/VO/HecateField_0043", Text = "That's it." },
		{ Cue = "/VO/HecateField_0044", Text = "Like that." },
	},
}

GlobalVoiceLines.HecateReturnVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	SuccessiveChanceToPlay = 0.33,
	PreLineWait = 0.4,
	GameStateRequirements =
	{
		{
			Path = { "GameState", "EnemyKills", "Hecate" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = 
			{
				"HecateBossMiscOutro15",
				"HecateBossOutro01",
				"HecateBossGrantsCodex01",
				"HecateBossGrantsCardUpgradeSystem01",
				"HecateBossGrantsFamiliarSystem01",
				"HecateBossGrantsWeaponUpgradeSystem01",
			},
		},
	},

	{ Cue = "/VO/HecateField_0251", Text = "Return to shadow, now!" },
	{ Cue = "/VO/HecateField_0252", Text = "Return to shadow, now..." },
	{ Cue = "/VO/HecateField_0253", Text = "Return to shadow, now.", PlayFirst = true, },
	{ Cue = "/VO/HecateField_0254", Text = "Return to shadow, now." },
}

-- Global Odysseus Lines
GlobalVoiceLines.OdysseusLaughVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Odysseus_01", SubtitleColor = Color.OdysseusVoice },

	{ Cue = "/VO/Odysseus_0106", Text = "{#Emph}<Chuckle>" },
	{ Cue = "/VO/Odysseus_0107", Text = "{#Emph}<Chuckle>" },
	{ Cue = "/VO/Odysseus_0108", Text = "{#Emph}<Laugh>" },
	{ Cue = "/VO/Odysseus_0109", Text = "{#Emph}<Laugh>" },
}

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

GlobalVoiceLines.DoraSummonedVoiceLines =
{
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "DoraGreetedRecently", Time = 240 },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
			},
			RequiredAnyQueuedTextLines = { "DoraFirstMeeting" },
		},
		{ Cue = "/VO/Dora_0129", Text = "{#Emph}Boo!!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
			},
			RequiredAnyQueuedTextLines = { "DoraRunProgress01", "DoraAboutHaunting02" },
		},

		{ Cue = "/VO/Dora_0133", Text = "{#Emph}Who dares?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
		{ Cue = "/VO/Dora_0228", Text = "{#Emph}Kneel before me!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
			},
			RequiredAnyQueuedTextLines = { "DoraListless01", "DoraListless02", "DoraListless03","DoraAboutExisting01", "DoraAboutChronosBossW01" },
		},

		{ Cue = "/VO/Dora_0125", Text = "Hey.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0126", Text = "Hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0224", Text = "Oh hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0220", Text = "How's it going?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
			},
			RequiredAnyQueuedTextLines = { "DoraAboutShades04" },
		},
		{ Cue = "/VO/Dora_0224", Text = "Oh hey!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.15,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" }
			},
		},

		{ Cue = "/VO/Dora_0229", Text = "Took you long enough.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0230", Text = "You know how late it is?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0231", Text = "Out late again huh.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0232", Text = "Oh, finally!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.15,
		ObjectType = "NPC_Dora_01",

		{ Cue = "/VO/Dora_0125", Text = "Hey.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0126", Text = "Hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0127", Text = "Heya.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0128", Text = "Boo.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0135", Text = "Well look at you!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0136", Text = "Whoa, hey!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0137", Text = "There you are!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0220", Text = "How's it going?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0221", Text = "Where'd you come from?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0222", Text = "So what's up?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0223", Text = "What's goin' on?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0224", Text = "Oh hey!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		-- SGV
		{ Cue = "/VO/Dora_0129", Text = "{#Emph}Boo!!",
			PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
			GameStateRequirements =
			{
				MinRunsSinceAnyTextLines = { TextLines = { "DoraFirstMeeting" }, Count = 8 },
			},
		},
		{ Cue = "/VO/Dora_0130", Text = "{#Emph}OoooOooo...!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0131", Text = "{#Emph}OoooOooo!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0132", Text = "{#Emph}OoooOooo...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0133", Text = "{#Emph}Who dares?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0134", Text = "{#Emph}Hail, witch!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0145", Text = "{#Emph}Come forth!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0225", Text = "{#Emph}I rise again!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0226", Text = "{#Emph}You have returned.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0227", Text = "{#Emph}Fear me!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0228", Text = "{#Emph}Kneel before me!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
	}
}
GlobalVoiceLines.DoraHidingVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.15,
	SuccessiveChanceToPlay = 0.75,
	SkipAnim = true,
	Actor = "Dora",
	ObjectType = "NPC_Dora_01",
	SubtitleMinDistance = 1200,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "DoraFirstMeeting", },
		},
		{
			PathFromSource = true,
			Path = { "DefaultCategoryIndex" },
			Comparison = "==",
			Value = 1,
		},
	},
	Cooldowns =
	{
		{ Name = "DoraVanishedVO", Time = 180 },
	},

	{ Cue = "/VO/Dora_0138", Text = "See ya." },
	{ Cue = "/VO/Dora_0139", Text = "Later." },
	{ Cue = "/VO/Dora_0140", Text = "So long." },
	{ Cue = "/VO/Dora_0141", Text = "'K bye." },
	{ Cue = "/VO/Dora_0233", Text = "Got to go." },
	{ Cue = "/VO/Dora_0234", Text = "Bye now." },
	{ Cue = "/VO/Dora_0235", Text = "Take it easy." },
	-- SGV
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs =
		{
			SetModel = "ScaryDora_Mesh",
			SetAnimation = "DoraScary_Idle",
			CreateAnimation = "EnemyDeathFx_Dora",
		},
		{ Cue = "/VO/Dora_0142", Text = "{#Emph}I shall returnnn!" },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs =
		{
			SetModel = "ScaryDora_Mesh",
			SetAnimation = "DoraScary_Idle",
			CreateAnimation = "EnemyDeathFx_Dora",
		},
		{ Cue = "/VO/Dora_0143", Text = "{#Emph}I shall return!" },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs =
		{
			SetModel = "ScaryDora_Mesh",
			SetAnimation = "DoraScary_Idle",
			CreateAnimation = "EnemyDeathFx_Dora",
		},
		{ Cue = "/VO/Dora_0236", Text = "{#Emph}Farewell..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs =
		{
			SetModel = "ScaryDora_Mesh",
			SetAnimation = "DoraScary_Idle",
			CreateAnimation = "EnemyDeathFx_Dora",
		},
		{ Cue = "/VO/Dora_0237", Text = "{#Emph}Back to the abyss..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs =
		{
			SetModel = "ScaryDora_Mesh",
			SetAnimation = "DoraScary_Idle",
			CreateAnimation = "EnemyDeathFx_Dora",
		},
		{ Cue = "/VO/Dora_0238", Text = "{#Emph}I gooo..." },
	},
}
GlobalVoiceLines.DoraRedecorationReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Dora_01",
	GameStateRequirements = 
	{

		RequiredSourceValueFalse = "InPartnerConversation",
	},
	Cooldowns =
	{
		{ Name = "DoraCosmeticsReactionVO", Time = 60 },
	},

	{ Cue = "/VO/Dora_0251", Text = "Whatever!" },
	{ Cue = "/VO/Dora_0252", Text = "It's your stuff." },
	{ Cue = "/VO/Dora_0253", Text = "All right hold on." },
	{ Cue = "/VO/Dora_0277", Text = "Changed your mind?" },
	{ Cue = "/VO/Dora_0278", Text = "All righty." },
	{ Cue = "/VO/Dora_0279", Text = "OK let's bring it in." },
	{ Cue = "/VO/Dora_0280", Text = "Sure, whatever." },

	-- SGV
	{ Cue = "/VO/Dora_0254", Text = "{#Emph}Why not, indeed...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_1400" },
			},
		},
	},
	{ Cue = "/VO/Dora_0255", Text = "{#Emph}It shall be done...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
	{ Cue = "/VO/Dora_0256", Text = "{#Emph}If that is your will...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
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
		{ Name = "SkellyQuipAnySpeech", Time = 35 },
	},

	{ Cue = "/VO/Skelly_0016", Text = "A fine choice." },
	{ Cue = "/VO/Skelly_0017", Text = "Care to try it out?" },
	{ Cue = "/VO/Skelly_0032", Text = "A wise selection." },
	{ Cue = "/VO/Skelly_0216", Text = "{#Emph}Ahh{#Prev}, yes!" },
	{ Cue = "/VO/Skelly_0035", Text = "Use caution with that thing." },
	{ Cue = "/VO/Skelly_0033", Text = "That's no mere walking stick you got there!",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
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
				HasAny = { "WeaponLob" },
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
		{ Name = "SkellyQuipAnySpeech", Time = 9 },
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

GlobalVoiceLines.SkellyLockedReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "SkellyLockedSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0125", Text = "Please step away from that." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "SkellyLockedSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0126", Text = "Don't make me come over there." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Skelly_01",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
				Comparison = ">=",
				Value = 1,
			},
		},
		Cooldowns =
		{
			{ Name = "SkellyLockedSpeech", Time = 5 },
		},

		{ Cue = "/VO/Skelly_0127", Text = "{#Emph}Eh{#Prev}, the incorrigible youth of today..." },
	},	
}

GlobalVoiceLines.TrophyAttackReactionVoiceLines =
{
	Cooldowns =
	{
		{ Name = "SkellyQuipAnySpeech", Time = 8 },
	},
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "SourceProjectile", },
			IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
		},
	},
	{
		PreLineWait = 0.3,
		RandomRemaining = true,
		BreakIfPlayed = true,
		ChanceToPlay = 0.25,
		ObjectType = "NPC_Skelly_01",

		{ Cue = "/VO/Skelly_0327", Text = "Restrain yourself!" },
		{ Cue = "/VO/Skelly_0330", Text = "Watch out with those, will ya?", PlayFirst = true },
		{ Cue = "/VO/Skelly_0333", Text = "{#Emph}Please{#Prev}, young one!" },
		{ Cue = "/VO/Skelly_0334", Text = "Hey cut that out!" },
		{ Cue = "/VO/Skelly_0335", Text = "You mustn't hit those!" },
		{ Cue = "/VO/Skelly_0336", Text = "Night's gonna be so mad!" },
		{ Cue = "/VO/Skelly_0328", Text = "Don't chip the paint!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
				},
			}
		},
		{ Cue = "/VO/Skelly_0329", Text = "Do not defile the artistry!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
				},
			}
		},

		{ Cue = "/VO/Skelly_0331", Text = "Watch the statues!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
				},
			}
		},
		{ Cue = "/VO/Skelly_0332", Text = "No, the statues!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
				},
			}
		},
	},

}

-- Global Artemis Lines
GlobalVoiceLines.ArtemisDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },

	{ Cue = "/VO/Artemis_0101", Text = "Sister, wait, don't go!" },
	{ Cue = "/VO/Artemis_0102", Text = "Next time, we'll make them pay..." },
	{ Cue = "/VO/Artemis_0103", Text = "I'm sorry, Sister..." },
	{ Cue = "/VO/Artemis_0104", Text = "No... I swore to protect you...", PlayFirst = true },
}

-- Global Arachne Lines -- Arachne
GlobalVoiceLines.ArachneGreetingLines =
{
	Queue = "Interrupt",
	RandomRemaining = true,
	BreakIfPlayed = true,
	ObjectType = "NPC_Arachne_01",

	{ Cue = "/VO/Arachne_0133", Text = "Oh!" },
	{ Cue = "/VO/Arachne_0134", Text = "Ah, it's you!" },
	{ Cue = "/VO/Arachne_0135", Text = "Oh, welcome!" },
	{ Cue = "/VO/Arachne_0136", Text = "You've come back!" },
	{ Cue = "/VO/Arachne_0137", Text = "Do my eyes deceive?" },
	{ Cue = "/VO/Arachne_0138", Text = "My friend!" },
	{ Cue = "/VO/Arachne_0139", Text = "Is it truly you?" },
	{ Cue = "/VO/Arachne_0140", Text = "{#Emph}<Gasp>" },
	{ Cue = "/VO/Arachne_0141", Text = "A customer!" },
	{ Cue = "/VO/Arachne_0142", Text = "My finest customer!" },
	{ Cue = "/VO/Arachne_0143", Text = "Why hello there!" },
	{ Cue = "/VO/Arachne_0144", Text = "Good evening!" },
	{ Cue = "/VO/Arachne_0145", Text = "Welcome back!" },
	{ Cue = "/VO/Arachne_0146", Text = "Ah, {#Emph}haha!" },
	{ Cue = "/VO/Arachne_0147", Text = "Hello again!" },
	{ Cue = "/VO/Arachne_0148", Text = "Oh, it's been too long!" },
	{ Cue = "/VO/Arachne_0149", Text = "Got some cocoons for you!" },
	{ Cue = "/VO/Arachne_0150", Text = "Some new cocoons there!" },
	{ Cue = "/VO/Arachne_0356", Text = "Oh...!", PlayFirst = true },
	{ Cue = "/VO/Arachne_0357", Text = "{#Emph}Huh...!" },
}
GlobalVoiceLines.ArachneMutteringLines =
{
	RandomRemaining = true,
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0201", Text = "{#Emph}Dye the silk and loooad it," },
		{ Cue = "/VO/Arachne_0202", Text = "{#Emph}Spinning, spinning goes the thread," },
		{ Cue = "/VO/Arachne_0203", Text = "{#Emph}Warp and weft, warp and weft," },
		{ Cue = "/VO/Arachne_0204", Text = "{#Emph}Cut it up and fooold it." },
		{ Cue = "/VO/Arachne_0205", Text = "And again...!" },
		{ Cue = "/VO/Arachne_0201", Text = "{#Emph}Dye the silk and loooad it,", PreLineWait = 1.2 },
		{ Cue = "/VO/Arachne_0202", Text = "{#Emph}Spinning, spinning goes the thread," },
		{ Cue = "/VO/Arachne_0203", Text = "{#Emph}Warp and weft, warp and weft," },
		{ Cue = "/VO/Arachne_0204", Text = "{#Emph}Cut it up and fooold it.", BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0206", Text = "{#Emph}Silken finery, so soft, divine..." },
		{ Cue = "/VO/Arachne_0207", Text = "{#Emph}I spin my threads and catch whatever comes my way..." },
		{ Cue = "/VO/Arachne_0208", Text = "{#Emph}A pleasant memory that lingers on my mind..." },
		{ Cue = "/VO/Arachne_0209", Text = "{#Emph}From lonely dark of night until the break of day..." },
		{ Cue = "/VO/Arachne_0210", Text = "One more time..." },
		{ Cue = "/VO/Arachne_0206", Text = "{#Emph}Silken finery, so soft, divine...", PreLineWait = 1.2 },
		{ Cue = "/VO/Arachne_0207", Text = "{#Emph}I spin my threads and catch whatever comes my way..." },
		{ Cue = "/VO/Arachne_0208", Text = "{#Emph}A pleasant memory that lingers on my mind..." },
		{ Cue = "/VO/Arachne_0209", Text = "{#Emph}From lonely dark of night until the break of day...", BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0211", Text = "{#Emph}Oh, little fly, come sit and rest your wings..." },
		{ Cue = "/VO/Arachne_0212", Text = "{#Emph}You've grown so tired flying to and fro..." },
		{ Cue = "/VO/Arachne_0213", Text = "{#Emph}I'll wrap you up and sing you soon to sleep..." },
		{ Cue = "/VO/Arachne_0214", Text = "{#Emph}I'll drink of you and leave a little heap..." },
		{ Cue = "/VO/Arachne_0215", Text = "{#Emph}Ha ha ha... {#Prev}again...", PreLineWait = 1.2 },
		{ Cue = "/VO/Arachne_0211", Text = "{#Emph}Oh, little fly, come sit and rest your wings..." },
		{ Cue = "/VO/Arachne_0212", Text = "{#Emph}You've grown so tired flying to and fro..." },
		{ Cue = "/VO/Arachne_0213", Text = "{#Emph}I'll wrap you up and sing you soon to sleep..." },
		{ Cue = "/VO/Arachne_0214", Text = "{#Emph}I'll drink of you and leave a little heap...", BreakIfPlayed = true },
	},
}
GlobalVoiceLines.ArachneGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = GameData.ArachneUpsetEvents,
		},
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0326", Text = "Good eye!" },
	{ Cue = "/VO/Arachne_0327", Text = "Finders keepers." },
	{ Cue = "/VO/Arachne_0328", Text = "{#Emph}Ooh {#Prev}what's that?", PlayFirst = true },
	{ Cue = "/VO/Arachne_0329", Text = "Found it!" },
	{ Cue = "/VO/Arachne_0357", Text = "{#Emph}Huh..." },
	{ Cue = "/VO/Arachne_0360", Text = "{#Emph}Hm..." },
}
GlobalVoiceLines.ArachnePickaxeReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = GameData.ArachneUpsetEvents,
		},
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0317", Text = "Oh you got something!" },
	{ Cue = "/VO/Arachne_0318", Text = "Nice find." },
	{ Cue = "/VO/Arachne_0319", Text = "Fine work there!" },
	{ Cue = "/VO/Arachne_0320", Text = "Help yourself!" },
	{ Cue = "/VO/Arachne_0321", Text = "Help yourself." },
}
GlobalVoiceLines.ArachneExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = GameData.ArachneUpsetEvents,
		},
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0322", Text = "You got one!" },
	{ Cue = "/VO/Arachne_0323", Text = "Nicely done." },
	{ Cue = "/VO/Arachne_0324", Text = "You saved them." },
	{ Cue = "/VO/Arachne_0325", Text = "You did it." },
}
GlobalVoiceLines.ArachneMineReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.25,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Arachne_01",
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0232", Text = "Watch out!" },
	{ Cue = "/VO/Arachne_0233", Text = "Look out!" },
	{ Cue = "/VO/Arachne_0234", Text = "Careful!" },
	{ Cue = "/VO/Arachne_0235", Text = "Sorry!" },
	{ Cue = "/VO/Arachne_0236", Text = "Oops!" },
	{ Cue = "/VO/Arachne_0237", Text = "Yikes!" },
}
GlobalVoiceLines.ArachneCocoonPositiveReactionLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.66,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsAny = { "F_Story01" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = GameData.ArachneUpsetEvents,
		},
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0279", Text = "That's on the house!" },
	{ Cue = "/VO/Arachne_0280", Text = "Enjoy!" },
	{ Cue = "/VO/Arachne_0281", Text = "For you!" },
	{ Cue = "/VO/Arachne_0282", Text = "Oh you found it!" },
	{ Cue = "/VO/Arachne_0283", Text = "Surprise!" },
	{ Cue = "/VO/Arachne_0284", Text = "Hope it helps!" },
	{ Cue = "/VO/Arachne_0285", Text = "All yours." },
	{ Cue = "/VO/Arachne_0286", Text = "Oh good!" },
	{ Cue = "/VO/Arachne_0287", Text = "Keep it!" },
	{ Cue = "/VO/Arachne_0288", Text = "Just for you!" },
}
GlobalVoiceLines.ArachneCocoonNegativeReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.2,
		PlayOnceFromTableThisRun = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01" },
			},
			{
				PathEmpty = { "MapState", "RoomRequiredObjects" },
			},
		},

		{ Cue = "/VO/Melinoe_1920", Text = "Got to make way for more." },
		{ Cue = "/VO/Melinoe_1921", Text = "She says this is OK..." },
		{ Cue = "/VO/Melinoe_1922", Text = "So many of these..." },
		{ Cue = "/VO/Melinoe_1923", Text = "No spiderlings in sight." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.2,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			{
				PathEmpty = { "MapState", "RoomRequiredObjects" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeFleeCocoonSpeech", Time = 240 },
		},

		{ Cue = "/VO/Melinoe_1930", Text = "Could make a run for it...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1931", Text = "Don't have to stand and fight..." },
		{ Cue = "/VO/Melinoe_1932", Text = "The exits are right there..." },
		{ Cue = "/VO/Melinoe_1933", Text = "Perhaps I'd better go..." },
	},
	{
		ThreadName = "RoomThread",
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Arachne_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01" },
			},
		},
		Cooldowns =
		{
			{ Name = "ArachneSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Arachne_0216", Text = "Oh, sorry about that!" },
		{ Cue = "/VO/Arachne_0217", Text = "Oh, {#Emph}shoo! {#Prev}Get out of here!" },
		{ Cue = "/VO/Arachne_0218", Text = "Oh not another one of those." },
		{ Cue = "/VO/Arachne_0219", Text = "Oh do be careful!" },
		{ Cue = "/VO/Arachne_0220", Text = "Oh no!" },
		{ Cue = "/VO/Arachne_0221", Text = "How'd that one get in here?" },
		{ Cue = "/VO/Arachne_0222", Text = "Sorry for the mess!" },
		{ Cue = "/VO/Arachne_0223", Text = "One of those again." },
		{ Cue = "/VO/Arachne_0224", Text = "Forgot I snagged that one." },
		{ Cue = "/VO/Arachne_0225", Text = "Pop at your own risk..." },
	},
}

-- Global Selene Lines
GlobalVoiceLines.SeleneExorcismReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	SuccessiveChanceToPlay = 0.5,
	PreLineWait = 0.7,
	Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "SeleneGift02" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "G", "H", "I", },
		},
	},

	{ Cue = "/VO/Selene_0310", Text = "A possible ally." },
	{ Cue = "/VO/Selene_0311", Text = "Another joins our ranks." },
	{ Cue = "/VO/Selene_0312", Text = "Well done." },
	{ Cue = "/VO/Selene_0313", Text = "A soul no longer lost." },
	{ Cue = "/VO/Selene_0314", Text = "Peace for the dead..." },
	{ Cue = "/VO/Selene_0315", Text = "Everlasting peace..." },
	{ Cue = "/VO/Selene_0316", Text = "To our abode..." },
	{ Cue = "/VO/Selene_0317", Text = "Freedom in death." },
}

-- Global Nemesis Lines
GlobalVoiceLines.NemesisDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Nemesis_01", SubtitleColor = Color.NemesisVoice },

	{ Cue = "/VO/NemesisField_0326", Text = "Go home to Hecate, I'll handle it from here." },
	{ Cue = "/VO/NemesisField_0327", Text = "Always said you don't have what it takes." },
	{ Cue = "/VO/NemesisField_0328", Text = "Don't let me hear you blame the Fates for this." },
	{ Cue = "/VO/NemesisField_0329", Text = "Thought you'd take more punishment than that." },
	{ Cue = "/VO/NemesisField_0330", Text = "Got what was coming to you; I should know." },
	{ Cue = "/VO/NemesisField_0331", Text = "Was all a bit too much for you, poor thing." },
	{ Cue = "/VO/NemesisField_0332", Text = "We're all supposed to be counting on you?" },
	{ Cue = "/VO/NemesisField_0333", Text = "Come on, you could have done better than that." },
	{ Cue = "/VO/NemesisField_0334", Text = "Go, get your scrawny ass out of here." },
	{ Cue = "/VO/NemesisField_0335", Text = "You never could handle the pressure you know." },
}
GlobalVoiceLines.NemesisGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
		},		
		Cooldowns =
		{
			{ Name = "NemesisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/NemesisField_0402", Text = "Good for you." },
		{ Cue = "/VO/NemesisField_0403", Text = "Thank the Fates." },
		{ Cue = "/VO/NemesisField_0404", Text = "How fortunate for you." },
		{ Cue = "/VO/NemesisField_0405", Text = "Well deserved." },
		{ Cue = "/VO/NemesisField_0406", Text = "So what." },
		{ Cue = "/VO/NemesisField_0407", Text = "What you need that for?" },
		{ Cue = "/VO/NemesisField_0418", Text = "Lucky you." },
		{ Cue = "/VO/NemesisField_0419", Text = "Great." },
		{ Cue = "/VO/NemesisField_0420", Text = "Wow." },
		{ Cue = "/VO/NemesisField_0421", Text = "So what." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
		},		
		Cooldowns =
		{
			{ Name = "NemesisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/NemesisField_0414", Text = "Kidding me?" },
		{ Cue = "/VO/NemesisField_0415", Text = "Get in the fight!" },
		{ Cue = "/VO/NemesisField_0416", Text = "What are you doing?" },
		{ Cue = "/VO/NemesisField_0417", Text = "Fight back!" },
	},	
}
GlobalVoiceLines.NemesisExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Nemesis_01",
	Cooldowns =
	{
		{ Name = "NemesisAnyQuipSpeech", Time = 10 },
	},

	{ Cue = "/VO/NemesisField_0408", Text = "Why bother." },
	{ Cue = "/VO/NemesisField_0409", Text = "Another Shade to watch." },
	{ Cue = "/VO/NemesisField_0410", Text = "What did you do." },
	{ Cue = "/VO/NemesisField_0411", Text = "How touching." },
	{ Cue = "/VO/NemesisField_0412", Text = "What's the use." },
	{ Cue = "/VO/NemesisField_0413", Text = "Dead weight." },
}
GlobalVoiceLines.NemesisScoffingVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Nemesis_01",
	PreLineAnim = "Nemesis_Hub_Greet",

	{ Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
	{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Hmph." },
}

-- Global Storyteller Lines
GlobalVoiceLines.StorytellerRunStartVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 2.0,
	ChanceToPlay = 0.1,
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "InspectPoint" },
			Comparison = ">=",
			Value = 10,
		},
	},

	Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
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
		PreLineWait = 0.5,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_0861", "/VO/Melinoe_0862", "/VO/Melinoe_0863", "/VO/Melinoe_0864", "/VO/Melinoe_1129", "/VO/Melinoe_1379" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
		ThreadName = "RoomThread",

		{ Cue = "/VO/Storyteller_0060", Text = "{#Emph}Splendid was the Princess in her fight." },
		{ Cue = "/VO/Storyteller_0061", Text = "{#Emph}Fearless Melinoë continues undeterred." },
		{ Cue = "/VO/Storyteller_0062", Text = "{#Emph}Her foes, all vanquished to the last." },
		{ Cue = "/VO/Storyteller_0065", Text = "{#Emph}The Princess brings her many foes to heel." },
		{ Cue = "/VO/Storyteller_0071", Text = "{#Emph}Though Time cannot be stopped, neither can she." },
		{ Cue = "/VO/Storyteller_0073", Text = "{#Emph}A victory, yet Time our foe remains!" },
		{ Cue = "/VO/Storyteller_0074", Text = "{#Emph}Sing, O Muse." },
		{ Cue = "/VO/Storyteller_0076", Text = "{#Emph}Such wondrous spectacle." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_0861", "/VO/Melinoe_0862", "/VO/Melinoe_0863", "/VO/Melinoe_1531" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		StatusAnimation = "StatusIconStorytellerSpeaking",
		StatusAnimSourceIsHero = true,
		Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
		ThreadName = "RoomThread",

		{ Cue = "/VO/Storyteller_0058", Text = "{#Emph}Whither goes the Princess, so shall I." },
		{ Cue = "/VO/Storyteller_0072", Text = "{#Emph}The Princess calls into the dark, to no avail." },
		{ Cue = "/VO/Storyteller_0075", Text = "{#Emph}Hail Princess, light of the Moon." },
	},
}

-- Reactive Gossip
GossipSubtitlesMinDistance = 1200

GlobalVoiceLines.InvasionEncounterStartVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		NoTarget = true,

		{ Cue = "/VO/Chronos_0007", Text = "A word, if you please?" },
		{ Cue = "/VO/Intercom_0036", Text = "You cannot stop Time." },
		{ Cue = "/VO/Intercom_0044", Text = "You are beginning to annoy me, girl." },
	},
}

-- Old from Minos
MusicPlayerTrackData =
{
	BaseMusicTrack =
	{
		DebugOnly = true,
		ResourceName = "SuperGems",
		-- ResourceCost = 1,
		Icon = "Cosmetic_MusicTrack",
		DeathAreaFocusId = 424035,
		PanDuration = 2.5,
		PreActivationHoldDuration = 2,
		PostActivationHoldDuration = 1.3,
		UsePanSound = true,
		SkipFade = true,
		UseItemActivationVfx = true,
		--RevealGlobalVoiceLines = "MusicPurchaseResponseVoiceLines",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
		},
	},
	["/Music/MusicPlayer/MainThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		-- ResourceCost = 1,
	},
}

MusicPlayerTrackOrderData =
{
	"/Music/MusicPlayer/MainThemeMusicPlayer",
}

MusicMarkerData =
{
	HummingStart =
	{
		FunctionName = "SetPathValue",
		FunctionArgs =
		{
			TablePath = { "SessionMapState", },
			Key = "Humming",
			Value = true
		},
	},

	HummingStop =
	{
		FunctionName = "SetPathValue",
		FunctionArgs =
		{
			TablePath = { "SessionMapState", },
			Key = "Humming",
			Value = false,
		},
	},
}