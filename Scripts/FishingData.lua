GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.FishCaughtVoiceLines =
{
	{
		BreakIfPlayed = true,
		BreakIfPlayed = true,
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

		{ Cue = "/VO/Melinoe_0757", Text = "Got you!" },
		{ Cue = "/VO/Melinoe_0758", Text = "Caught out." },
		{ Cue = "/VO/Melinoe_0759", Text = "That's a bite!" },
		{ Cue = "/VO/Melinoe_0760", Text = "Mine!" },
		{ Cue = "/VO/MelinoeField_1351", Text = "And, caught!" },
		{ Cue = "/VO/MelinoeField_1352", Text = "Come on out!" },
		{ Cue = "/VO/MelinoeField_1353", Text = "It's over!" },
		{ Cue = "/VO/MelinoeField_1354", Text = "Victory!" },
		{ Cue = "/VO/MelinoeField_1355", Text = "To me!" },
		{ Cue = "/VO/MelinoeField_1356", Text = "No escape!" },
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
		PreLineWait = 0.35,
		UsePlayerSource = true,
		Queue = "Interrupt",
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Melinoe_0350", Text = "{#Emph}<Laugh>" },
		{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
	},
}
GlobalVoiceLines.FishIdentifiedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
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

		{ Cue = "/VO/Hecate_0386", Text = "And caught." },
		{ Cue = "/VO/Hecate_0387", Text = "Ensnared!" },
	},
	{
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
		{ Cue = "/VO/Dora_0092", Text = "Hah, you tricked a fish!", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
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

		{ Cue = "/VO/Odysseus_0076", Text = "Hey, you got one!" },
		{ Cue = "/VO/Odysseus_0077", Text = "Hoh, nice catch!" },
	},
	{
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

		{ Cue = "/VO/Nemesis_0182", Text = "Thank the Fates." },
		{ Cue = "/VO/Nemesis_0183", Text = "Fair catch.", PlayFirst = true },
		{ Cue = "/VO/Nemesis_0184", Text = "Had it coming." },
		{ Cue = "/VO/Nemesis_0185", Text = "Tough break, fish." },
		{ Cue = "/VO/Nemesis_0186", Text = "Lucky catch." },
		{ Cue = "/VO/Nemesis_0187", Text = "Caught bigger ones than that." },
		{ Cue = "/VO/Nemesis_0188", Text = "Lured it with magick didn't you." },
		{ Cue = "/VO/Nemesis_0189", Text = "Can we get back to work?" },
		{ Cue = "/VO/Nemesis_0190", Text = "Big deal." },
	},
	{
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
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Melinoe_3542", Text = "I prevailed...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3543", Text = "It's something!" },
		{ Cue = "/VO/Melinoe_3544", Text = "It's something all right!" },
		{ Cue = "/VO/Melinoe_3545", Text = "Freshly caught." },
		{ Cue = "/VO/Melinoe_3546", Text = "Now come along." },
		{ Cue = "/VO/Melinoe_3547", Text = "Victory is mine." },
		{ Cue = "/VO/Melinoe_3548", Text = "Sweet victory..." },
		{ Cue = "/VO/Melinoe_3549", Text = "Glad you could join me." },
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
				IsNone = { "G", "H", "I", },
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

}

FishingData =
{
	DefaultSpawnChance = 0.25,
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
				Weight = 9,
				Name = "FishFCommon",
			},
			{
				Weight = 3, Name = "FishFRare",
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
				Weight = 2, Name = "FishFRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishFLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishFLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishGCommon",
			},
			{
				Weight = 3, Name = "FishGRare",
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
				Weight = 2, Name = "FishGRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishGLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishGLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishHCommon",
			},
			{
				Weight = 3, Name = "FishHRare",
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
				Weight = 2, Name = "FishHRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishHLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishHLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishICommon",
			},
			{
				Weight = 3, Name = "FishIRare",
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
				Weight = 2, Name = "FishIRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishICommon" },
						Comparison = ">=",
						Value = 3,
					},
				},
			},
			{
				Weight = 1, Name = "FishILegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishIRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishILegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishNCommon",
			},
			{
				Weight = 3, Name = "FishNRare",
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
				Weight = 2, Name = "FishNRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishNLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishNLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishOCommon",
			},
			{
				Weight = 3, Name = "FishORare",
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
				Weight = 2, Name = "FishORare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishOCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishOLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishORare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishOLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishPCommon",
			},
			{
				Weight = 3, Name = "FishPRare",
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
				Weight = 2, Name = "FishPRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishPLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishPLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishBCommon",
			},
			{
				Weight = 3, Name = "FishBRare",
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
				Weight = 2, Name = "FishBRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishBCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishBLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishBRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishBLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				Weight = 9,
				Name = "FishChaosCommon",
			},
			{
				Weight = 3, Name = "FishChaosRare",
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
				Weight = 2, Name = "FishChaosRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosCommon" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishChaosLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{
				Weight = 1, Name = "FishChaosLegendary",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", }
					},
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
				[1] = GlobalVoiceLines.FishCaughtVoiceLines,
			},
			FishIdentifiedVoiceLines =
			{
				[1] = GlobalVoiceLines.FishIdentifiedVoiceLines,
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
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/Melinoe_3527", Text = "I caught a Moper...!", PlayFirst = true },
					{ Cue = "/VO/Melinoe_3528", Text = "Another Moper." },
					{ Cue = "/VO/Melinoe_3529", Text = "That's a Moper." },
					{ Cue = "/VO/Melinoe_3530", Text = "A Moper." },
					{ Cue = "/VO/Melinoe_3531", Text = "Cheer up, Moper." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishFRare =
		{
			InheritFrom = { "DefaultRare" },
			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/Melinoe_3532", Text = "I caught a Figment...!", PlayFirst = true },
					{ Cue = "/VO/Melinoe_3533", Text = "It's a Figment!" },
					{ Cue = "/VO/Melinoe_3534", Text = "That's a Figment." },
					{ Cue = "/VO/Melinoe_3535", Text = "Looks like a Figment." },
					{ Cue = "/VO/Melinoe_3536", Text = "Another Figment." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishFLegendary=
		{
			InheritFrom = { "DefaultLegendary" },
			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/Melinoe_3537", Text = "I caught a Soulbelly?", PlayFirst = true },
					{ Cue = "/VO/Melinoe_3538", Text = "{#Emph}Ooh{#Prev}, a Soulbelly!" },
					{ Cue = "/VO/Melinoe_3539", Text = "It's a Soulbelly...!" },
					{ Cue = "/VO/Melinoe_3540", Text = "This is a Soulbelly!" },
					{ Cue = "/VO/Melinoe_3541", Text = "Soulbelly, I'm honored!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Oceanus
		FishGCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2266", Text = "I caught a Chiton!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2267", Text = "It's a Chiton." },
					{ Cue = "/VO/MelinoeField_2268", Text = "Looks like a Chiton." },
					{ Cue = "/VO/MelinoeField_2269", Text = "Another Chiton." },
					{ Cue = "/VO/MelinoeField_2270", Text = "Hey, a Chiton!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishGRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2271", Text = "I caught a Gutternose!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2272", Text = "It's a Gutternose." },
					{ Cue = "/VO/MelinoeField_2273", Text = "That's a Gutternose." },
					{ Cue = "/VO/MelinoeField_2274", Text = "A Gutternose." },
					{ Cue = "/VO/MelinoeField_2275", Text = "Hello, Gutternose." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishGLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2276", Text = "This is a Stalkfin...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2277", Text = "{#Emph}Ooh{#Prev}, a Stalkfin..." },
					{ Cue = "/VO/MelinoeField_2278", Text = "Another Stalkfin...?" },
					{ Cue = "/VO/MelinoeField_2279", Text = "It's a Stalkfin!" },
					{ Cue = "/VO/MelinoeField_2280", Text = "Found you, Stalkfin!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Fields
		FishHCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2281", Text = "I caught a Soby.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2282", Text = "It's a Soby..." },
					{ Cue = "/VO/MelinoeField_2283", Text = "It's a little Soby..." },
					{ Cue = "/VO/MelinoeField_2284", Text = "Cheer up, Soby." },
					{ Cue = "/VO/MelinoeField_2285", Text = "Poor Soby..." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishHRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2286", Text = "I caught an Anguish!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2287", Text = "This is an Anguish." },
					{ Cue = "/VO/MelinoeField_2288", Text = "It's an Anguish." },
					{ Cue = "/VO/MelinoeField_2289", Text = "It'll be OK, Anguish..." },
					{ Cue = "/VO/MelinoeField_2290", Text = "Come on, Anguish..." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishHLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2291", Text = "I caught a Tearjerker!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2292", Text = "It's a Tearjerker...!" },
					{ Cue = "/VO/MelinoeField_2293", Text = "{#Emph}Ah{#Prev}, a Tearjerker!" },
					{ Cue = "/VO/MelinoeField_2294", Text = "{#Emph}<Sniff> {#Prev}A Tearjerker...!" },
					{ Cue = "/VO/MelinoeField_2295", Text = "{#Emph}<Sniff> {#Prev} Hi, Tearjerker...!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Clockwork Tartarus
		FishICommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2296", Text = "I caught a Jiffy!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2297", Text = "It's a Jiffy." },
					{ Cue = "/VO/MelinoeField_2298", Text = "That's a Jiffy." },
					{ Cue = "/VO/MelinoeField_2299", Text = "Caught another Jiffy." },
					{ Cue = "/VO/MelinoeField_2300", Text = "Count me in, Jiffy." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishIRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2301", Text = "I caught a Goldfish!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2302", Text = "It's a Goldfish." },
					{ Cue = "/VO/MelinoeField_2303", Text = "Chronos must love these." },
					{ Cue = "/VO/MelinoeField_2304", Text = "Caught me a Goldfish!" },
					{ Cue = "/VO/MelinoeField_2305", Text = "Come along, Goldfish!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishILegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2306", Text = "I caught a Styxeon!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2307", Text = "This is a Styxeon...!" },
					{ Cue = "/VO/MelinoeField_2308", Text = "Another Styxeon...?" },
					{ Cue = "/VO/MelinoeField_2309", Text = "{#Emph}Ah{#Prev}, a Styxeon!" },
					{ Cue = "/VO/MelinoeField_2310", Text = "Got you, Styxeon...!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Ephyra
		FishNCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2311", Text = "I caught a Roach.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2312", Text = "It's a Roach." },
					{ Cue = "/VO/MelinoeField_2313", Text = "Another Roach." },
					{ Cue = "/VO/MelinoeField_2314", Text = "One more Roach." },
					{ Cue = "/VO/MelinoeField_2315", Text = "That's a Roach." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishNRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2316", Text = "I caught a Spike...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2317", Text = "It's a Spike." },
					{ Cue = "/VO/MelinoeField_2318", Text = "Hey, a Spike!" },
					{ Cue = "/VO/MelinoeField_2319", Text = "Got me a Spike." },
					{ Cue = "/VO/MelinoeField_2320", Text = "Another Spike." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishNLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2321", Text = "I caught a Zeel...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2322", Text = "Another Zeel!" },
					{ Cue = "/VO/MelinoeField_2323", Text = "{#Emph}Whoa{#Prev}, a Zeel...!" },
					{ Cue = "/VO/MelinoeField_2324", Text = "This is a Zeel!" },
					{ Cue = "/VO/MelinoeField_2325", Text = "It's a Zeel...!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Ships
		FishOCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2326", Text = "I caught a Squid!" },
					{ Cue = "/VO/MelinoeField_2327", Text = "It's a Squid..." },
					{ Cue = "/VO/MelinoeField_2328", Text = "Looks like a Squid." },
					{ Cue = "/VO/MelinoeField_2329", Text = "Hello, Squid." },
					{ Cue = "/VO/MelinoeField_2330", Text = "Another Squid." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishORare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2331", Text = "Is this a Chrab?", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2332", Text = "It's a Chrab...!" },
					{ Cue = "/VO/MelinoeField_2333", Text = "Looks like a Chrab." },
					{ Cue = "/VO/MelinoeField_2334", Text = "Don't pinch me, you." },
					{ Cue = "/VO/MelinoeField_2335", Text = "Come on, Chrab." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishOLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2336", Text = "I caught a Tuna...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2337", Text = "It's a Tuna!" },
					{ Cue = "/VO/MelinoeField_2338", Text = "Another Tuna?" },
					{ Cue = "/VO/MelinoeField_2339", Text = "Wow, a Tuna...!" },
					{ Cue = "/VO/MelinoeField_2340", Text = "Hey, a Tuna!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Olympus
		FishPCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					-- TriggerCooldowns = { "MelGlobalFishCaughtVoiceLinesPlayed" },

					-- TKTK
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishPRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					-- TriggerCooldowns = { "MelGlobalFishCaughtVoiceLinesPlayed" },

					-- TKTK
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishPLegendary=
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					-- TriggerCooldowns = { "MelGlobalFishCaughtVoiceLinesPlayed" },

					-- TKTK
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Asphodel
		FishBCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					-- TriggerCooldowns = { "MelGlobalFishCaughtVoiceLinesPlayed" },

					-- TKTK
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishBRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					-- TriggerCooldowns = { "MelGlobalFishCaughtVoiceLinesPlayed" },

					-- TKTK
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishBLegendary =
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "MelGlobalFishCaughtVoiceLinesPlayed" },

					-- TKTK
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		-- Chaos 
		FishChaosCommon =
		{
			InheritFrom = { "DefaultCommon" },

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2341", Text = "I caught a Mati...", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2342", Text = "This is a Mati..." },
					{ Cue = "/VO/MelinoeField_2343", Text = "Another Mati." },
					{ Cue = "/VO/MelinoeField_2344", Text = "Looks like a Mati." },
					{ Cue = "/VO/MelinoeField_2345", Text = "In you go, Mati." },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishChaosRare =
		{
			InheritFrom = { "DefaultRare" },

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2346", Text = "I caught a Projelly!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2347", Text = "This is a Projelly...!" },
					{ Cue = "/VO/MelinoeField_2348", Text = "It's a Projelly!" },
					{ Cue = "/VO/MelinoeField_2349", Text = "Another Projelly!" },
					{ Cue = "/VO/MelinoeField_2350", Text = "Hey, a Projelly!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		FishChaosLegendary =
		{
			InheritFrom = { "DefaultLegendary" },

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,

					{ Cue = "/VO/MelinoeField_2351", Text = "I caught a Voidskate...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2352", Text = "This is a Voidskate...!" },
					{ Cue = "/VO/MelinoeField_2353", Text = "Another Voidskate!" },
					{ Cue = "/VO/MelinoeField_2354", Text = "A Voidskate, of all things..." },
					{ Cue = "/VO/MelinoeField_2355", Text = "Incredible, a Voidskate!" },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

	},
}