GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.FishCaughtVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		UsePlayerSource = true,
		Queue = "Interrupt",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/MelinoeField_1351", Text = "And, caught!" },
		{ Cue = "/VO/MelinoeField_1352", Text = "Come on out!" },
		{ Cue = "/VO/MelinoeField_1353", Text = "It's over!" },
		{ Cue = "/VO/MelinoeField_1354", Text = "Victory!" },
		{ Cue = "/VO/MelinoeField_1356", Text = "No escape!" },
		{ Cue = "/VO/Melinoe_0760", Text = "Mine!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1355", Text = "To me!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Hecate_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "HecateFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Hecate_0388", Text = "Got you!", PlayFirst = true },
		{ Cue = "/VO/Hecate_0389", Text = "Out with you!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
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

		{ Cue = "/VO/Dora_0093", Text = "Now! I think?" },
		{ Cue = "/VO/Dora_0094", Text = "Swimtime's over!", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Odysseus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "OdysseusFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Odysseus_0078", Text = "Hah, caught out!" },
		{ Cue = "/VO/Odysseus_0079", Text = "Got you, you little...!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
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

		{ Cue = "/VO/Nemesis_0191", Text = "Got you." },
		{ Cue = "/VO/Nemesis_0192", Text = "You're mine." },
		{ Cue = "/VO/Nemesis_0193", Text = "Caught one...", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
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

		{ Cue = "/VO/Moros_0354", Text = "Come meet your fate!" },
		{ Cue = "/VO/Moros_0355", Text = "Your fate is sealed!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		UsePlayerSource = true,
		Queue = "Interrupt",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			}
		},

		{ Cue = "/VO/Melinoe_0350", Text = "{#Emph}<Laugh>" },
		{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
	},
}
GlobalVoiceLines.FishIdentifiedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		Cooldowns =
		{
			{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
		},

		{ Cue = "/VO/Melinoe_3542", Text = "I prevailed...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3543", Text = "It's something!" },
		{ Cue = "/VO/Melinoe_3544", Text = "It's something all right!" },
		{ Cue = "/VO/Melinoe_3545", Text = "Freshly caught." },
		{ Cue = "/VO/Melinoe_3546", Text = "Now come along." },
		{ Cue = "/VO/Melinoe_3547", Text = "Victory is mine." },
		{ Cue = "/VO/Melinoe_3548", Text = "Sweet victory..." },
		{ Cue = "/VO/Melinoe_3549", Text = "Glad you could join me.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1359", Text = "Hello.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1360", Text = "Figures.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1361", Text = "Come with me.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1362", Text = "A fine catch.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
	},
	[2] = { GlobalVoiceLines = "FishIdentifiedReactionLines" },
}
GlobalVoiceLines.FishCaughtByCatVoiceLines =
{
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "FishingSuccessesFamiliar" },
		},
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.25,
		Cooldowns =
		{
			{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
		},

		{ Cue = "/VO/MelinoeField_2671", Text = "Fine work, Toula." },
		{ Cue = "/VO/MelinoeField_2672", Text = "Excellent catch, Toula." },
		{ Cue = "/VO/MelinoeField_2673", Text = "Look what we got, Toula!" },
		{ Cue = "/VO/MelinoeField_2674", Text = "Easy catch for Toula." },
		{ Cue = "/VO/MelinoeField_2675", Text = "You did it, Toula!" },
		{ Cue = "/VO/MelinoeField_2676", Text = "Toula never fails." },
		{ Cue = "/VO/MelinoeField_2677", Text = "She makes it look easy." },
		{ Cue = "/VO/MelinoeField_2678", Text = "Cheers for that, Toula." },
	},
	[2] = { GlobalVoiceLines = "FishIdentifiedReactionLines" },
}

FishingData =
{
	DefaultSpawnCap = 1,
	DefaultSpawnChance = 0.01,
	HasToolSpawnChance = 0.25,
	ToolName = "ToolFishingRod",
	DefaultGameStateRequirements =
	{
		{
			SumPrevRooms = 5,
			Path = { "NumFishingPoints" },
			Comparison = "<=",
			Value = 0,
		},
	},

	FidgetInterval = { Min = 3, Max = 9 },

	Difficulty =
	{
		Default =
		{
			NumFakeDunks = { Min = 0, Max = 3 },
			FakeDunkInterval = { Min = 2, Max = 5 },
			WarnInterval = { Min = 1, Max = 2 },
			SuccessInterval = 0.68,
			WayLateInterval = 1,
			GiveUpInterval = 3,
		},

		Gifting =
		{
			NumFakeDunks = { Min = 2, Max = 7 },
			FakeDunkInterval = { Min = 1, Max = 6 },
			WarnInterval = { Min = 1, Max = 3 },
			SuccessInterval = 0.68,
			WayLateInterval = 1,
			GiveUpInterval = 3,
		},
	},

	BiomeFish =
	{
		Defaults =
		{

			{
				Weight = 1,
				Name = "FishFCommon",
			},
		},

		F =
		{
			{
				Weight = 3,
				Name = "FishFCommon",
			},
			{
				Weight = 2,
				Name = "FishFRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishFLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},

		G =
		{

			{
				Weight = 3,
				Name = "FishGCommon",
			},
			{
				Weight = 2,
				Name = "FishGRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishGLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},


		H =
		{

			{
				Weight = 3,
				Name = "FishHCommon",
			},
			{
				Weight = 2,
				Name = "FishHRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishHLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},


		I =
		{

			{
				Weight = 3,
				Name = "FishICommon",
			},
			{
				Weight = 2,
				Name = "FishIRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishICommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishILegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishIRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},


		N =
		{

			{
				Weight = 3,
				Name = "FishNCommon",
			},
			{
				Weight = 2,
				Name = "FishNRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishNLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},


		O =
		{

			{
				Weight = 3,
				Name = "FishOCommon",
			},
			{
				Weight = 2,
				Name = "FishORare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishOCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishOLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishORare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},


		P =
		{

			{
				Weight = 3,
				Name = "FishPCommon",
			},
			{
				Weight = 2,
				Name = "FishPRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishPLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},

		Anomaly =
		{

			{
				Weight = 3,
				Name = "FishBCommon",
			},
			{
				Weight = 2,
				Name = "FishBRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishBCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishBLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishBRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},


		Chaos =
		{

			{
				Weight = 3,
				Name = "FishChaosCommon",
			},
			{
				Weight = 2,
				Name = "FishChaosRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishChaosLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},
	},

	FishValues =
	{
		DefaultCommon =
		{
			FishCaughtVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtVoiceLines" },
			},
			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		DefaultRare =
		{
			FishCaughtVoiceLines =
			{
				[1] = GlobalVoiceLines.FishCaughtVoiceLines
			},
			FishIdentifiedVoiceLines =
			{
				[1] = GlobalVoiceLines.FishIdentifiedVoiceLines
			},

			ReelTime = 12.0,
			ReelMissTimePenalty = 1.0,
			ReelCooldown = 1.0,
			MoveRadius = 60,
			MoveSpeedMin = 30,
			MoveSpeedMax = 70,
			DirectionChangeTimeMin = 0.5,
			DirectionChangeTimeMax = 1.5,
			ReturnToCatchZoneChance = 0.1,
			ReturnToCatchZoneChanceIncrement = 0.45,
			ReturnToCatchZoneVariance = 15,
			CatchZoneRadius = 35,
			CatchZoneHits = 3,
		},

		DefaultLegendary =
		{
			FishCaughtVoiceLines =
			{
				[1] = GlobalVoiceLines.FishCaughtVoiceLines
			},
			FishIdentifiedVoiceLines =
			{
				[1] = GlobalVoiceLines.FishIdentifiedVoiceLines
			},

			ReelTime = 18.0,
			ReelMissTimePenalty = 1.0,
			ReelCooldown = 1.0,
			MoveRadius = 60,
			MoveSpeedMin = 70,
			MoveSpeedMax = 200,
			DirectionChangeTimeMin = 0.3,
			DirectionChangeTimeMax = 0.9,
			ReturnToCatchZoneChance = 0.1,
			ReturnToCatchZoneChanceIncrement = 0.3,
			ReturnToCatchZoneVariance = 15,
			CatchZoneRadius = 20,
			CatchZoneHits = 5,
		},

		-- Erebus
		FishFCommon =
		{
			InheritFrom = { "DefaultCommon" },
			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/Melinoe_3527", Text = "I caught a Moper...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3528", Text = "Another Moper.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishFCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/Melinoe_3529", Text = "That's a Moper." },
					{ Cue = "/VO/Melinoe_3530", Text = "A Moper." },
					{ Cue = "/VO/Melinoe_3531", Text = "Cheer up, Moper." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishFRare =
		{
			InheritFrom = { "DefaultRare" },
			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/Melinoe_3532", Text = "I caught a Figment...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3533", Text = "It's a Figment!" },
					{ Cue = "/VO/Melinoe_3534", Text = "That's a Figment." },
					{ Cue = "/VO/Melinoe_3535", Text = "Looks like a Figment." },
					{ Cue = "/VO/Melinoe_3536", Text = "Another Figment.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishFRare" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishFLegendary=
		{
			InheritFrom = { "DefaultLegendary" },
			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/Melinoe_3537", Text = "I caught a Soulbelly?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3538", Text = "{#Emph}Ooh{#Prev}, a Soulbelly!" },
					{ Cue = "/VO/Melinoe_3539", Text = "It's a Soulbelly...!" },
					{ Cue = "/VO/Melinoe_3540", Text = "This is a Soulbelly!" },
					{ Cue = "/VO/Melinoe_3541", Text = "Soulbelly, I'm honored!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Oceanus
		FishGCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2266", Text = "I caught a Chiton!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2267", Text = "It's a Chiton." },
					{ Cue = "/VO/MelinoeField_2268", Text = "Looks like a Chiton." },
					{ Cue = "/VO/MelinoeField_2269", Text = "Another Chiton.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishGCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2270", Text = "Hey, a Chiton!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishGRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2641", Text = "I caught a Gutterpop...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2642", Text = "It's a Gutterpop." },
					{ Cue = "/VO/MelinoeField_2643", Text = "That's a Gutterpop." },
					{ Cue = "/VO/MelinoeField_2644", Text = "A Gutterpop." },
					{ Cue = "/VO/MelinoeField_2645", Text = "Hello, Gutterpop." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishGLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2276", Text = "This is a Stalkfin...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2277", Text = "{#Emph}Ooh{#Prev}, a Stalkfin..." },
					{ Cue = "/VO/MelinoeField_2278", Text = "Another Stalkfin...?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishGLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2279", Text = "It's a Stalkfin!" },
					{ Cue = "/VO/MelinoeField_2280", Text = "Found you, Stalkfin!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Fields
		FishHCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2281", Text = "I caught a Soby.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2282", Text = "It's a Soby...", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2283", Text = "It's a little Soby..." },
					{ Cue = "/VO/MelinoeField_2284", Text = "Cheer up, Soby." },
					{ Cue = "/VO/MelinoeField_2285", Text = "Poor Soby..." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishHRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2286", Text = "I caught an Anguish!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2287", Text = "This is an Anguish." },
					{ Cue = "/VO/MelinoeField_2288", Text = "It's an Anguish." },
					{ Cue = "/VO/MelinoeField_2289", Text = "It'll be OK, Anguish..." },
					{ Cue = "/VO/MelinoeField_2290", Text = "Come on, Anguish..." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishHLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2291", Text = "I caught a Tearjerker!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2292", Text = "It's a Tearjerker...!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2293", Text = "{#Emph}Ah{#Prev}, a Tearjerker!" },
					{ Cue = "/VO/MelinoeField_2294", Text = "{#Emph}<Sniff> {#Prev}A Tearjerker...!" },
					{ Cue = "/VO/MelinoeField_2295", Text = "{#Emph}<Sniff> {#Prev}Hi, Tearjerker...!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Clockwork Tartarus
		FishICommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2296", Text = "I caught a Jiffy!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2297", Text = "It's a Jiffy.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2298", Text = "That's a Jiffy." },
					{ Cue = "/VO/MelinoeField_2299", Text = "Caught another Jiffy.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishICommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2300", Text = "Count me in, Jiffy." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishIRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2301", Text = "I caught a Goldfish!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2302", Text = "It's a Goldfish.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2303", Text = "Chronos must love these." },
					{ Cue = "/VO/MelinoeField_2304", Text = "Caught me a Goldfish!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2305", Text = "Come along, Goldfish!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishILegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2306", Text = "I caught a Styxeon!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2307", Text = "This is a Styxeon...!" },
					{ Cue = "/VO/MelinoeField_2308", Text = "Another Styxeon...?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishILegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2309", Text = "{#Emph}Ah{#Prev}, a Styxeon!" },
					{ Cue = "/VO/MelinoeField_2310", Text = "Got you, Styxeon...!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Ephyra
		FishNCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2626", Text = "I caught a Ribeye.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2627", Text = "It's a Ribeye...", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2628", Text = "Another Ribeye..." },
					{ Cue = "/VO/MelinoeField_2629", Text = "One more Ribeye..." },
					{ Cue = "/VO/MelinoeField_2630", Text = "That's a Ribeye." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishNRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2631", Text = "I caught a Zeel...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2632", Text = "It's a Zeel.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2633", Text = "Hey, a Zeel!" },
					{ Cue = "/VO/MelinoeField_2634", Text = "Got me a Zeel." },
					{ Cue = "/VO/MelinoeField_2635", Text = "Another Zeel." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishNLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2636", Text = "I caught a Neckbiter...!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2637", Text = "Another Neckbiter...?" },
					{ Cue = "/VO/MelinoeField_2638", Text = "Whoa, a Neckbiter...!" },
					{ Cue = "/VO/MelinoeField_2639", Text = "This is a Neckbiter...!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2640", Text = "It's a Neckbiter...!" },

				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Ships
		FishOCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2646", Text = "I caught a Shrimp...!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2647", Text = "It's a Shrimp.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2648", Text = "Looks like a Shrimp." },
					{ Cue = "/VO/MelinoeField_2649", Text = "Hello, Shrimp." },
					{ Cue = "/VO/MelinoeField_2650", Text = "Another Shrimp." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishORare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2331", Text = "Is this a Chrab?", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2332", Text = "It's a Chrab...!" },
					{ Cue = "/VO/MelinoeField_2333", Text = "Looks like a Chrab." },
					{ Cue = "/VO/MelinoeField_2334", Text = "Don't pinch me, you." },
					{ Cue = "/VO/MelinoeField_2335", Text = "Come on, Chrab." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishOLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2651", Text = "I caught a Squid...!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2652", Text = "It's a Squid!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2653", Text = "Another Squid?" },
					{ Cue = "/VO/MelinoeField_2654", Text = "Wow, a Squid..." },
					{ Cue = "/VO/MelinoeField_2655", Text = "Hey, a Squid!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Olympus
		FishPCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2656", Text = "I caught a Pillartop!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2657", Text = "Hey, a Pillartop!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2658", Text = "It's a Pillartop." },
					{ Cue = "/VO/MelinoeField_2659", Text = "Another Pillartop." },
					{ Cue = "/VO/MelinoeField_2660", Text = "Looks like a Pillartop." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishPRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2661", Text = "I caught a Chrestle!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2662", Text = "This is a Chrestle!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2663", Text = "It's a Chrestle." },
					{ Cue = "/VO/MelinoeField_2664", Text = "Another Chrestle." },
					{ Cue = "/VO/MelinoeField_2665", Text = "With me, Chrestle." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishPLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2666", Text = "I caught a Starsailor...!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2667", Text = "Wow, a Starsailor!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2668", Text = "This is a Starsailor!" },
					{ Cue = "/VO/MelinoeField_2669", Text = "A Starsailor, what an honor!" },
					{ Cue = "/VO/MelinoeField_2670", Text = "<Gasp> A Starsailor...!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Asphodel
		FishBCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					-- TKTK
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishBRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					-- TKTK
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishBLegendary =
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					-- TKTK
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Chaos 
		FishChaosCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2341", Text = "I caught a Mati...", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2342", Text = "This is a Mati..." },
					{ Cue = "/VO/MelinoeField_2343", Text = "Another Mati." },
					{ Cue = "/VO/MelinoeField_2344", Text = "Looks like a Mati." },
					{ Cue = "/VO/MelinoeField_2345", Text = "In you go, Mati." },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishChaosRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2346", Text = "I caught a Projelly!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2347", Text = "This is a Projelly...!" },
					{ Cue = "/VO/MelinoeField_2348", Text = "It's a Projelly!" },
					{ Cue = "/VO/MelinoeField_2349", Text = "Another Projelly!" },
					{ Cue = "/VO/MelinoeField_2350", Text = "Hey, a Projelly!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishChaosLegendary =
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				[1] = { GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				[2] =
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2351", Text = "I caught a Voidskate...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "FishingSuccessesFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2352", Text = "This is a Voidskate...!" },
					{ Cue = "/VO/MelinoeField_2353", Text = "Another Voidskate!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishChaosLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2354", Text = "A Voidskate, of all things..." },
					{ Cue = "/VO/MelinoeField_2355", Text = "Incredible, a Voidskate!" },
				},
				[3] = { GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

	},
}