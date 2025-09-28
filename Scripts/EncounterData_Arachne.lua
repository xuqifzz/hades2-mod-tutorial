OverwriteTableKeys( EncounterData,
{
	-- Arache F Encounters
	BaseArachneCombat =
	{
		EncounterType = "ArachneCombat",
		SkipExitReadyCheckpoint = true,
		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "TalentDrop" },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ArachneCombatF" },
			},
			{
				Path = { "CurrentRun", "EncountersOccurredBiomeCache" },
				HasNone = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN" },
			},
			NamedRequirements = { "NoRecentArachneEncounter" },
		},

		UnthreadedEvents = EncounterSets.EncounterEventsArachneCombat,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SetupArachneCombatEncounter", Args = { CocoonCountMin = 8, CocoonCountMax = 14,
					CocoonOptions = { "ArachneCocoon", "ArachneCocoon", "ArachneCocoon",
						  "ArachneCocoonMedium", "ArachneCocoonMedium",
						  "ArachneCocoonLarge", }, } }
		},

		RequireCompletedIntro = true,
		PreSpawnEnemies = false,

		BlockAthenaEncounterKeepsake = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		BlockRandomStems = true,
		MusicActiveStems = { "Guitar", "Bass", },

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",
		SpeakerName = "Arachne",
		Using =
		{
			"CocoonOptions",
			Sounds =
			{
				"/SFX/Menu Sounds/Lounge_GlassWithIce",
				"/SFX/Menu Sounds/Lounge_BottleCork",
				"/SFX/Menu Sounds/Lounge_BottlePour",
				"/Leftovers/World Sounds/Caravan Interior/SwallowDrink",
				"/SFX/Menu Sounds/Lounge_GlassesClinking",
			},
		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				PlayOnce = true,
				PlayOnceContext = "CocoonsInLaterBiomesIntro",

				{ Cue = "/VO/MelinoeField_0186", Text = "Those spiders get around...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "G", "H" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.33,

				{ Cue = "/VO/Melinoe_1717", Text = "Silk cocoons...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "F", },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1718", Text = "Arachne was here...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "F", },
						},
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1719", Text = "Let's see what we can find..." },
				{ Cue = "/VO/Melinoe_1720", Text = "More cocoons..." },
				{ Cue = "/VO/MelinoeField_0185", Text = "The spiders got here first..." },
				{ Cue = "/VO/MelinoeField_0186", Text = "Those spiders get around...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "G", "H" },
						},
						{
							PathFalse = { "PrevRun", "SpeechRecord", "/VO/MelinoeField_0186" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0187", Text = "Arachne's handiwork...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "F", },
						},
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0188", Text = "Thank you, hidden spiderlings...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
			},
			{
				PreLineWait = 1.23,
				RandomRemaining = true,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.5,
				Source = { LineHistoryName = "NPC_Arachne_01", SubtitleColor = Color.ArachneVoice },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
				},

				{ Cue = "/VO/Arachne_0362", Text = "{#Emph}<Laughter>", PlayFirst = true },
				{ Cue = "/VO/Arachne_0363", Text = "{#Emph}<Laughter>" },
				{ Cue = "/VO/Arachne_0364", Text = "{#Emph}<Laughter>" },
				{ Cue = "/VO/Arachne_0365", Text = "{#Emph}<Laughter>" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ArachneLaughResponseVO",
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Arachne_0362", "/VO/Arachne_0363", "/VO/Arachne_0364", "/VO/Arachne_0365" },
					},
				},

				{ Cue = "/VO/Melinoe_1936", Text = "Who's there...?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1937", Text = "What was that...?" },
				{ Cue = "/VO/Melinoe_1938", Text = "Arachne...?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1939", Text = "That you, Arachne?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3037", Text = "Arachne, is that you?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
			}
		},
	},

	ArachneCombatF =
	{
		InheritFrom = { "BaseArachneCombat" },
		
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAny = { "MiniBossTreant", "MiniBossFogEmitter", "BossHecate01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 8,
			},
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			}, 
			{
				Path = { "CurrentRun", "EncountersOccurredBiomeCache" },
				HasNone = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN" },
			},
		},
	},

	ArachneCombatG =
	{
		InheritFrom = { "BaseArachneCombat" },

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SetupArachneCombatEncounter", Args = { CocoonCountMin = 8, CocoonCountMax = 14,
					CocoonOptions = { "ArachneCocoon_G", "ArachneCocoon_G", "ArachneCocoon_G",
						  "ArachneCocoonMedium_G", "ArachneCocoonMedium_G",
						  "ArachneCocoonLarge_G", },
						  RequiredSpawnPointType = "EnemyPoint" } }
		},
	},

	ArachneCombatN =
	{
		InheritFrom = { "BaseArachneCombat" },
	},
})