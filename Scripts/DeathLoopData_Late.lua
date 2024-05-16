OverwriteTableKeys( HubRoomData, {
	-- Flashback02 / Hades Flashback
	Flashback_DeathAreaBedroomHades =
	{
		HeroUnitName = "PlayerHadesFlashback",
		HeroOverwrites =
		{
			AttachedAnimationName = "nil",
		},

		OnDeathLoadRequirements =
		{
			{
				NamedRequirements =  { "Flashback02Unlocked" },
			},
		},
		ZoomFraction = 1.0,
		SoftClamp = 0.75,
		EntranceFunctionName = "EnterHubRoomPresentation",

		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/RunstartIntroAmbience",

		-- NextRoomEntranceFunctionName = "LeavingBedroomHadesPresentation",

		IgnoreStemMixer = true,
		IntroSequenceDuration = 0.2,
		DebugOnly = true,
		NoAutoEquip = true,
		FullscreenEffectGroup = "Foreground_01",
		RichPresence = "#RichPresence_House",
		BlockCombatUI = true,

		LegalEncounters = { "Empty", },

		ReverbValue = 2.0,

		CheckObjectives = { "MetaPrompt", "BedPrompt" },

		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/MusicExploration4Ambience",

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					
				},
				Args =
				{
					Types =
					{
						"NPC_Hecate_01",
					},
				},
			},
			{
				FunctionName = "SetupFlashback02",
				Args = { NightmareMessage = "NightmareMessage", NightmareMessageSubtitle = "NightmareMessage_Subtitle", SecretMusic = "/Music/MusicHadesReset2_MC" },
			},
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosNightmare01", },
					},
				},
				Args =
				{
					Ids = { 560340 },
				},
			},
			{
				FunctionName = "SurpriseNPCPresentation",
				Args =
				{
					SourceId = 560340,
					SkipPan = true,
					VoiceLines =
					{
						Queue = "Interrupt",
						{
							{
								PreLineWait = 2.75,
								ObjectType = "NPC_Hecate_01",

								{ Cue = "/VO/Hecate_0207", Text = "...But, Lord Hades, I..." },
							},
						},
					},
					TextLineSet =
					{
						HadesWithHecate01 =
						{
							{ Cue = "/VO/Hades_0048", Speaker = "NPC_LordHades_01", 
								Portrait = "Portrait_Hades_Past_01",
								PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
								PreLineWait = 0.35,
								Text = "...You have your orders. Now return to shadow. And, take care of her. For all of us." },
							{ Cue = "/VO/Hecate_0208", Speaker = "NPC_Hecate_01", 
								Portrait = "Portrait_Hec_Default_01",
								PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
								PostLineThreadedFunctionName = "HecateFlashback02Exit",
								Text = "No harm shall come to young Melinoë, my lord. In this, at least, I shall not fail you." },
							EndVoiceLines = 
							{
								{
									PreLineWait = 1.2,
									ObjectType = "NPC_Hecate_01",

									{ Cue = "/VO/Hecate_0209", Text = "Farewell..." },
								},
								{
									PreLineWait = 0.4,
									UsePlayerSource = true,

									{ Cue = "/VO/Hades_0017", Text = "Goodbye, Daughter..." },
								},
							},										
						},
					}
				},
			},

		},

		ThreadedEvents =
		{
			{
				FunctionName = "Flashback02Objective",
				Args = { Delay = 13.0 },
			},
		},

		UnthreadedEvents =
		{

		},
		ObstacleData =
		{
			-- room exit
			[488298] =
			{
				OnUsedGameStateRequirements =
				{
					--
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "Flashback_DeathArea", HeroStartPoint = 555684, HeroEndPoint = 555685 },
				InteractDistance = 140,
				AutoActivate = true,
			},

		},
		EnterVoiceLines =
		{
			--
		},

		InspectPoints =
		{
			--
		},
	},
	-- Flashback02 -- Hub
	Flashback_DeathArea =
	{
		HeroUnitName = "PlayerHadesFlashback",

		ZoomFraction = 0.9,
		ZoomLerpTime = 2.0,
		CameraZoomWeights =
		{
			[40001] = 1.0,
			[210380] = 1.2,
			[50002] = 1.3,
			[555424] = 1.0,
		},
		SoftClamp = 0.75,
		CameraClamps = { 422043, 422045, 422046, 555683 },
		-- CameraClamps = { 422050, 422043, 422045, 422046, 422047 },
		FullscreenEffectGroup = "LoungeHider_01",
		RichPresence = "#RichPresence_House",

		EntranceFunctionName = "EnterHubRoomPresentation",

		IgnoreStemMixer = true,
		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/MusicExploration4Ambience",
		RemoveDashFireFx = true,

		StartUnthreadedEvents =
		{

		},

		ThreadedEvents =
		{
			{
				FunctionName = "SetupFlashback02_DeathArea",
				Args = { NightmareMessage = "NightmareMessage", SecretMusic = "/Music/MusicHadesReset2_MC" },
				GameStateRequirements =
				{
				}
			},

		},

		UnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					-- RequiredMinCompletedRuns = 0,
				},
				Args =
				{
					Types =
					{
						"NPC_Nyx_01",
						"NPC_Chronos_Story_01",
					},
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
		},

		RushMaxRangeOverride = 200,

		InspectPoints =
		{

		},

		ObstacleData =
		{

		},
	},
})

local temp = GlobalVoiceLines.DeathReturnVoiceLines
GlobalVoiceLines.DeathReturnVoiceLines =
{
	[2] =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Scylla_01", SubtitleColor = Color.ScyllaVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "BossScylla01" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Scylla_0134", Text = "We're {#Emph}Scylla and the Sirens{#Prev}, everybody!!" },
		{ Cue = "/VO/Scylla_0135", Text = "Thank you, everybody! Good night!" },
		{ Cue = "/VO/Scylla_0136", Text = "{#Emph}Thank you, Oceanus!!", PlayFirst = true },
		{ Cue = "/VO/Scylla_0137", Text = "Hey, {#Emph}thanks {#Prev}for coming to our show!" },
	},
	[3] = 
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Chronos_0197", Text = "An inevitable outcome, nothing more.", PlayFirst = true },
		{ Cue = "/VO/Chronos_0198", Text = "We must do this again some other time." },
		{ Cue = "/VO/Chronos_0199", Text = "No good shall come to those who swear allegiance to the gods." },
		{ Cue = "/VO/Chronos_0200", Text = "I had expected somewhat more from my own kin." },
		{ Cue = "/VO/Chronos_0201", Text = "What did you hope you would accomplish here?" },
		{ Cue = "/VO/Chronos_0202", Text = "Time may heal all wounds, or may inflict them just as readily." },
		{ Cue = "/VO/Chronos_0468", Text = "I alone shall not forget your meaningless efforts." },
		{ Cue = "/VO/Chronos_0469", Text = "As you can see, I am quite spry despite my age." },
		{ Cue = "/VO/Chronos_0470", Text = "Attack me all you like; I have all the time in the world." },
		{ Cue = "/VO/Chronos_0471", Text = "The youth of this age grow soft in body and in mind." },

		{ Cue = "/VO/Chronos_0257", Text = "The same predictable result, yet you persist.",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveDeathsInRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0258", Text = "What did you expect would change this time?",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveDeathsInRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0259", Text = "Once more you slip through my grasp, but I shall catch you yet.",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveDeathsInRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0260", Text = "Again you have risked everything, only to fail ignobly.",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveDeathsInRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0467", Text = "Thus history repeats as it is wont to do.",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveDeathsInRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0472", Text = "You ought not have anticipated any other outcome.",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveDeathsInRoom = { Name = "I_Boss01", Count = 1 },
			},
		},

		{ Cue = "/VO/Chronos_0261", Text = "That is what you get for all the inconvenience you caused!",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveClearsOfRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0262", Text = "Our previous engagement likewise ought have ended thus!",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveClearsOfRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0263", Text = "Did you truly think you would prevail against me once more?",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveClearsOfRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/Chronos_0264", Text = "Ah, a bitter defeat! Now, that is more like it.",
			PlayFirst = true,
			GameStateRequirements =
			{
				ConsecutiveClearsOfRoom = { Name = "I_Boss01", Count = 1 },
			},
		},
	},
	[4] =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Polyphemus_0089", Text = "Get your hindquarters out of my town." },
		{ Cue = "/VO/Polyphemus_0090", Text = "That ought to teach you." },
		{ Cue = "/VO/Polyphemus_0091", Text = "You mess with my sheep, I mess with {#Emph}you." },
		{ Cue = "/VO/Polyphemus_0092", Text = "Chow time... wait, where'd you go?", PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0093", Text = "{#Emph}Urgh {#Prev}where'd she go that time?" },
		{ Cue = "/VO/Polyphemus_0094", Text = "Worked up a real appetite back there." },
		{ Cue = "/VO/Polyphemus_0095", Text = "Nobody messes with my sheep." },
		{ Cue = "/VO/Polyphemus_0096", Text = "So much for my meal ticket huh." },
		{ Cue = "/VO/Polyphemus_0097", Text = "Get back here, you little..." },
		{ Cue = "/VO/Polyphemus_0098", Text = "Sounds like we're done here, huh." },
	},
	[5] =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
				Comparison = ">",
				Value = 0,
			},
		},
		{ Cue = "/VO/ErisField_0122", Text = "{#Emph}Return to shadow, now!" },
		{ Cue = "/VO/ErisField_0123", Text = "{#Emph}Return to shadow, now...!" },
		{ Cue = "/VO/ErisField_0124", Text = "That's right, Miss Perfect, go on home and {#Emph}cry." },
		{ Cue = "/VO/ErisField_0125", Text = "{#Emph}Aha, haha! {#Prev}Got so far, only to trip and fall!", PlayFirst = true },
		{ Cue = "/VO/ErisField_0126", Text = "Sorry, babe, but that's the way it goes!" },
		{ Cue = "/VO/ErisField_0127", Text = "Same time, same place tomorrow night, Trouble?" },
		{ Cue = "/VO/ErisField_0128", Text = "Don't hate me, babe! I'm just being {#Emph}me!" },
		{ Cue = "/VO/ErisField_0129", Text = "We have {#Emph}got {#Prev}to do this again sometime, OK?" },
	},
}
OverwriteTableKeys( temp, GlobalVoiceLines.DeathReturnVoiceLines )
GlobalVoiceLines.DeathReturnVoiceLines = temp

temp = GlobalVoiceLines.EnteredDeathAreaVoiceLines
GlobalVoiceLines.EnteredDeathAreaVoiceLines =
{
	-- post-flashback02
	[5] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosNightmare01" },
			},
		},
		PlayOnce = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
	
		{ Cue = "/VO/Melinoe_0373", Text = "{#Emph}<Gasp> {#Prev}...Father..." },
	},

	-- packaged bounty cleared
	[7] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BountyCleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_2703", Text = "{#Emph}Mm... {#Prev}Chaos got their way." },
		{ Cue = "/VO/Melinoe_2704", Text = "{#Emph}Whew... {#Prev}mission complete..." },
		{ Cue = "/VO/Melinoe_2705", Text = "{#Emph}Mmph... {#Prev}thank you, Chaos..." },
		{ Cue = "/VO/Melinoe_2760", Text = "{#Emph}Nngh... {#Prev}Chaos shall be pleased." },
		{ Cue = "/VO/Melinoe_2761", Text = "{#Emph}Ungh... {#Prev}did what I had to do." },
		{ Cue = "/VO/Melinoe_3042", Text = "{#Emph}Whew... {#Prev}Chaos Trial, check.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3043", Text = "{#Emph}Mhm... {#Prev}another Chaos Trial down." },
		{ Cue = "/VO/Melinoe_3044", Text = "{#Emph}Nngh... {#Prev}Chaos Trial done..." },
		{ Cue = "/VO/Melinoe_3045", Text = "{#Emph}Whew... {#Prev}Trial complete..." },
		{ Cue = "/VO/Melinoe_3046", Text = "{#Emph}Mph... {#Prev}Trial finished." },
		{ Cue = "/VO/Melinoe_3047", Text = "{#Emph}Hm... {#Prev}Trial, done." },
		{ Cue = "/VO/Melinoe_3048", Text = "{#Emph}Nngh... {#Prev}cheers, Chaos." },
	},
	-- nightmare occurred
	[8] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "NightmareOccurred" },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" },
			},			
		},
		-- RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlayAll = 0.1,
		PreLineWait = 1.0,
	
		{ Cue = "/VO/Melinoe_2131", Text = "{#Emph}Augh... {#Prev}get out of my head...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2635", Text = "{#Emph}Eugh... {#Prev}just another nightmare..." },
	},

	-- minibosses
	-- lost to Oceanus minibosses
	[11] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2265", Text = "{#Emph}Ungh... {#Prev}that Sea-Serpent...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2266", Text = "{#Emph}Mmph... {#Prev}Sea-Serpents, I swear..." },
	},
	
	[12] = 
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2263", Text = "{#Emph}Ugh... {#Prev}that thing was evil...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2264", Text = "{#Emph}Urgh... {#Prev}that was terrifying..." },
	},
	-- lost to Fields minibosses
	[13] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2754", Text = "{#Emph}Rngh... {#Prev}that blood-sucking..." },
		{ Cue = "/VO/Melinoe_2755", Text = "{#Emph}Eugh... {#Prev}I don't like Phantom lairs...", PlayFirst = true },
	},
	[14] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2756", Text = "{#Emph}Ugh... {#Prev}blasted Lamia...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2757", Text = "{#Emph}Augh... {#Prev}all those snakes..." },
	},
	-- lost to Tartarus minibosses
	[15] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3038", Text = "{#Emph}Urgh... {#Prev}Satyrs..." },
		{ Cue = "/VO/Melinoe_3039", Text = "{#Emph}Augh... {#Prev}cheers to the Verminancer then..." },
	},
	[16] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3040", Text = "{#Emph}Eugh... {#Prev}I'll make that Goldwrath pay..." },
		{ Cue = "/VO/Melinoe_3041", Text = "{#Emph}Ngh... {#Prev}so close to Chronos there..." },
	},
	-- lost to Ephyra minibosses
	[17] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_MiniBoss01", "I_MiniBoss01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2573", Text = "{#Emph}Eugh... {#Prev}that wretched Satyr...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3038", Text = "{#Emph}Urgh... {#Prev}Satyrs..." },
	},
	-- lost to Thessaly minibosses
	[18] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_MiniBoss01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3167", Text = "{#Emph}Guh... {#Prev}Charybdis claims another sailor, then..." },
		{ Cue = "/VO/Melinoe_3168", Text = "{#Emph}Eugh... {#Prev}to think such things are living in the sea..." },
	},

	-- bosses
	-- lost to scylla
	[20] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "BossScylla01" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2259", Text = "{#Emph}Nrgh... {#Prev}blast those Sirens.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2260", Text = "{#Emph}Ungh... {#Prev}I'm not a fan." },
		{ Cue = "/VO/Melinoe_2261", Text = "{#Emph}Ngh... {#Prev}what is her problem?" },
		{ Cue = "/VO/Melinoe_2262", Text = "{#Emph}Augh... {#Prev}beaten by Scylla?" },
	},
	-- lost to cerberus
	[21] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "InfestedCerberus" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2750", Text = "{#Emph}Augh... {#Prev}we'll fix this, Cerberus...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2751", Text = "{#Emph}Ungh... {#Prev}Cerberus just doing his job..." },
		{ Cue = "/VO/Melinoe_2694", Text = "{#Emph}Augh... {#Prev}blasted beast..."	},
		{ Cue = "/VO/Melinoe_2695", Text = "{#Emph}Ungh... {#Prev}bad dog..." },
		{ Cue = "/VO/Melinoe_2696", Text = "{#Emph}Urgh... {#Prev}bad boy...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
				}
			},
		},
		{ Cue = "/VO/Melinoe_2697", Text = "{#Emph}Urgh... {#Prev}bad boy... boys...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2696" }
				}
			}
		},
	},

	-- lost to chronos
	[22] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2805", Text = "{#Emph}Augh... {#Prev}I could have had him...!" },
		{ Cue = "/VO/Melinoe_2806", Text = "{#Emph}Ungh... {#Prev}I had him in my grasp!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2807", Text = "{#Emph}Ngh... {#Prev}no, I could have beaten him!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = "<",
					Value = 0.4,
				},
			}
		},
		{ Cue = "/VO/Melinoe_2808", Text = "{#Emph}Gah...! {#Prev}Again!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = ">=",
					Value = 3,
				},
			}
		},
	},

	-- lost to polyphemus
	[23] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_0371", Text = "{#Emph}Augh{#Prev}, beaten by a Cyclops, then?" },
		{ Cue = "/VO/Melinoe_0372", Text = "{#Emph}Eugh{#Prev}, ate me alive back there..." },
		{ Cue = "/VO/Melinoe_2571", Text = "{#Emph}Augh... {#Prev}he hits hard..." },
		{ Cue = "/VO/Melinoe_2752", Text = "{#Emph}Urgh... {#Prev}he had me figured out..." },
		{ Cue = "/VO/Melinoe_2753", Text = "{#Emph}Ungh... {#Prev}barely escaped from him..." },
	},
	-- lost to eris
	[24] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3163", Text = "{#Emph}Ungh... {#Prev}damn it, Eris...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3164", Text = "{#Emph}Augh... {#Prev}Eris and her blasted Rail..." },
		{ Cue = "/VO/Melinoe_3165", Text = "{#Emph}Ngh... {#Prev}to be beaten by {#Emph}her...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3166", Text = "{#Emph}Tsch... {#Prev}she had a blast at my expense again..." },
	},

	-- other encounters
	-- lost in devotion encounter
	[26] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_1876", Text = "...The gods don't like me very much I guess." },
	},
	-- lost in nemesis encounter
	[28] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2267", Text = "{#Emph}Eugh... {#Prev}damn it, Nemesis..." },
	},
	-- lost in anomaly encounter
	[29] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "GeneratedAnomalyB" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2268", Text = "{#Emph}<Gasp> {#Prev}...that was too real..." },
	},
	-- packaged bounties not cleared / failed chaos trial / lost to chaos trial
	-- multiple losses
	[30] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 4,
			},
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathFalse = { "CurrentRun", "BountyCleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3489", Text = "{#Emph}Ungh... {#Prev}perhaps that Trial and I need a break..." },
		{ Cue = "/VO/Melinoe_3490", Text = "{#Emph}Ngh... {#Prev}why keep bashing my head against that one...?" },
	},
	[31] = 
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathFalse = { "CurrentRun", "BountyCleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2706", Text = "{#Emph}Ungh... {#Prev}have to try that one again..." },
		{ Cue = "/VO/Melinoe_2707", Text = "{#Emph}Augh... {#Prev}was not an easy mission..." },
		{ Cue = "/VO/Melinoe_2708", Text = "{#Emph}Eugh... {#Prev}apologies, Chaos..." },
		{ Cue = "/VO/Melinoe_2709", Text = "{#Emph}<Gasp>... {#Prev}what happened there..." },
		{ Cue = "/VO/Melinoe_2632", Text = "{#Emph}Mm... {#Prev}no mere vision, was it?" },
		{ Cue = "/VO/Melinoe_2633", Text = "{#Emph}Augh... {#Prev}my head still aches..." },
		{ Cue = "/VO/Melinoe_2634", Text = "{#Emph}Ungh... {#Prev}was like a vivid dream..." },
		{ Cue = "/VO/Melinoe_3049", Text = "{#Emph}Augh... {#Prev}was not an easy Trial..." },
		{ Cue = "/VO/Melinoe_3050", Text = "{#Emph}Eugh... {#Prev}not a successful Trial..." },
		{ Cue = "/VO/Melinoe_3051", Text = "{#Emph}Ungh... {#Prev}Trial incomplete...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3052", Text = "{#Emph}Ngh... {#Prev}apologies, almighty Chaos." },
	},
	-- lost due to BiomeTimer
	[32] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "KilledByName", },
				IsAny = { "BiomeTimer" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3053", Text = "{#Emph}Ungh... {#Prev}Time got the best of me for sure...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3054", Text = "{#Emph}Ngh... {#Prev}just wasn't swift enough..." },
		{ Cue = "/VO/Melinoe_3055", Text = "{#Emph}Augh... {#Prev}need to be faster still." },
		{ Cue = "/VO/Melinoe_3056", Text = "{#Emph}Urgh... {#Prev}I blame the Oath... or me." },
		{ Cue = "/VO/Melinoe_3057", Text = "{#Emph}Rngh... {#Prev}I brought that on myself." },
	},
	-- lost (partly) due to Chaos Curse
	[33] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "TookChaosCurseDamage" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2700", Text = "{#Emph}Urgh... {#Prev}the mark of Chaos..." },
		{ Cue = "/VO/Melinoe_2701", Text = "{#Emph}Oof... {#Prev}careless with Chaos..." },
	},
	-- failed on surface (cursed, etc.)
	[34] =
	{
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.33,

		-- { Cue = "/VO/Melinoe_0567", Text = "Rngh... the surface... I..." },
		{ Cue = "/VO/Melinoe_2423", Text = "{#Emph}<Gasp> {#Prev}...I couldn't breathe...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2424", Text = "Has to be a way I can survive up there...",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2572", Text = "{#Emph}Augh... {#Prev}so that's the surface, then...", PlayOnce = true },
	},
	-- lost in Thessaly
	[35] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_Boss01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_3169", Text = "{#Emph}Oof... {#Prev}still feel a bit sea-sick from that..." },
	},	
	-- lost in Fields
	[36] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "H" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2698", Text = "{#Emph}Eugh... {#Prev}come so far..." },
		{ Cue = "/VO/Melinoe_2699", Text = "{#Emph}Mmph... {#Prev}not happy...", PlayFirst = true },
	},
	-- lost in Tartarus
	[37] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "I_Story01" },
			},
			{
				PathFalse = { "CurrentRun", "Cleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_2930", Text = "{#Emph}Ungh... {#Prev}wait for me, Father..." },
	},
}
OverwriteTableKeys( temp, GlobalVoiceLines.EnteredDeathAreaVoiceLines )
GlobalVoiceLines.EnteredDeathAreaVoiceLines = temp
