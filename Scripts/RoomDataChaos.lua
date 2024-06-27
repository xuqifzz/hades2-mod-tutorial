RoomSetData.Chaos =
{
	BaseChaos =
	{
		DebugOnly = true,

		ValidateSecretData = false,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = false,

		AnomalyDoorChance = 0.0,
		AnomalyDoorChanceFirstInstance = 0.0,

		--[[
		HarvestPointChances =
		{
			0.9,
			0.5,
			0.1,
		},
		ShovelPointChance = 0.5,
		PickaxePointChance = 0.5,
		]]--

		SpawnRewardOnId = 561960,

		RushMaxRangeOverride = 475,

		IgnoreExitDirection = true,
		EntranceFunctionName = "RoomEntrancePortal",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",
		EntranceAnimation = "MelinoeSpellFire",
		EntranceVfx = "SecretDoorDiveFx",
		ExitAnimation = "MelinoeSpellFire",
		ExitVfx = "SecretDoorDiveFx",
		ExitDoorOpenAnimation = "ExitDoorLinesSpecial",
		ExitDoorCloseAnimation = "ExitDoorLinesSpecial",
		SkipLastKillPresentation = true,
		UsePromptOffsetY = 120,

		LocationText = "Location_Secret",
		SaveProfileLocationText = "Location_Secret",
		LocationTextColor = { 20, 0, 255, 255 },

		ResultText = "RunHistoryScreenResult_Secret",
		RichPresence = "#RichPresence_Chaos",
		BiomeName = "Secrets",
		PauseBiomeState = true,

		Ambience = "/Leftovers/Ambience/MountainAmbience",
		SecretMusic = "/Music/ChaosTheme_MC",
		SkipLeavePrevRoomSFX = true,
		UsePreviousRoomSet = true,
		BlockHeroLight = true,
		ForcedRewardStore = "Secrets",
		LegalEncounters = { "Empty" },

		ZoomFraction = 0.75,
		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		SoftClamp = 0.75,
		FishingPointChance = 0.30,
		FishingPointRequirements =
		{
		},

		ShovelPointChance = 1.0,
		ShovelPointRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurface01" },
			},
		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.34,
				SuccessiveChanceToPlay = 0.2,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				PlayOnceFromTableThisRun = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "ChaosSpokeRecently", Time = 15 },
				},

				{ Cue = "/VO/Chaos_0067", Text = "You have returned." },
				{ Cue = "/VO/Chaos_0068", Text = "You are here." },
				{ Cue = "/VO/Chaos_0069", Text = "You have arrived.", PlayFirst = true },
				{ Cue = "/VO/Chaos_0070", Text = "I anticipated your return." },
				{ Cue = "/VO/Chaos_0071", Text = "I see you once again." },
				{ Cue = "/VO/Chaos_0072", Text = "It is you." },
				{ Cue = "/VO/Chaos_0073", Text = "Greetings to you." },
				{ Cue = "/VO/Chaos_0074", Text = "Welcome..." },
				{ Cue = "/VO/Chaos_0075", Text = "Come forth." },
				{ Cue = "/VO/Chaos_0076", Text = "We meet again." },
				{ Cue = "/VO/Chaos_0077", Text = "You found your way." },
				{ Cue = "/VO/Chaos_0078", Text = "A guest in my domain." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.4,
				ChanceToPlay = 0.75,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "EnteredSecretRoomSpeech", Time = 20 },
				},

				{ Cue = "/VO/MelinoeField_0776", Text = "Where in the...?", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/MelinoeField_0798", Text = "So quiet..." },
				{ Cue = "/VO/MelinoeField_0799", Text = "Beautiful..." },
				{ Cue = "/VO/MelinoeField_0800", Text = "{#Emph}Augh..." },
				{ Cue = "/VO/MelinoeField_0801", Text = "Made it through..." },
				{ Cue = "/VO/MelinoeField_0802", Text = "It's warm..." },
				{ Cue = "/VO/MelinoeField_0803", Text = "Chaos..." },
				{ Cue = "/VO/MelinoeField_0804", Text = "This old place..." },
				{ Cue = "/VO/MelinoeField_0805", Text = "Good to be back..." },
				{ Cue = "/VO/MelinoeField_0806", Text = "So serene..." },
				{ Cue = "/VO/MelinoeField_0807", Text = "Still intact..." },
				{ Cue = "/VO/MelinoeField_0808", Text = "Almighty Chaos...?" },
				{ Cue = "/VO/MelinoeField_0809", Text = "Hail, Chaos!" },
				{ Cue = "/VO/MelinoeField_0810", Text = "Just me...!" },
				{ Cue = "/VO/MelinoeField_0811", Text = "You called...?" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.93,
				SuccessiveChanceToPlay = 0.2,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				PlayOnceFromTableThisRun = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift01" },
					},
				},
				{ Cue = "/VO/Chaos_0073", Text = "Greetings to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0809" },
						},
					},
				},
				{ Cue = "/VO/Chaos_0074", Text = "Welcome...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0808", "/VO/MelinoeField_0809" },
						},
					},
				},
			},

		},
		ExitVoiceLines =
		{
			NoTarget = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.15,
			PreLineWait = 0.86,
			ThreadName = "RoomThread",
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift01" },
				},
			},
			Cooldowns =
			{
				{ Name = "ChaosSpokeRecently", Time = 45 },
			},

			{ Cue = "/VO/Chaos_0103", Text = "Return now whence you came.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0104", Text = "You now are changed accordingly." },

		},

	},

	Chaos_01 =
	{
		InheritFrom = { "BaseChaos" },

		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

		InspectPoints =
		{
			[621957] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				InteractTextLineSets =
				{
					Inspect_Chaos_01_01 =
					{
						{ Cue = "/VO/Storyteller_0177",
							Text = "{#Emph}From nothingness sprang all creation, light, and darkness, and the world itself; yet all that nothingness remains, carefully tucked away where none can find it, save for those invited in." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_0823", Text = "Best keep our voices down...!" },
						},
					},
				},
			},
		},

	},
	Chaos_02 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

		InspectPoints =
		{
			[622001] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Chaos_02_01 =
					{
						{ Cue = "/VO/Storyteller_0178",
							Text = "{#Emph}Within the silence of the infinite abyss lies infinite possibility; the limitless and unseen building-blocks of all that has ever been conceived, and all that shall ever be." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_0824", Text = "It's really quite a lot..." },
						},
					},
				},
			},
		},

	},
	Chaos_03 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
		},

		InspectPoints =
		{
			[622002] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Chaos_03_01 =
					{
						{ Cue = "/VO/Storyteller_0179",
							Text = "{#Emph}The ancient and obscure originator of creation yet remains, observing from within such black impenetrable depths the endless toil of the living and the dead." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_0825", Text = "Chaos is witness to all..." },
						},
					},
				},
			},
		},

	},
	Chaos_04 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

	},
	Chaos_05 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

	},
	Chaos_06 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
		},

	},	
}
AddTableKeysCheckDupes( RoomData, RoomSetData.Chaos )