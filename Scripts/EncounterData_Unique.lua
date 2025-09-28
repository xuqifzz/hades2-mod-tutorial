OverwriteTableKeys( EncounterData,
{
	-- Unique Encounters
	HealthRestore =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivateObjects", Args = { ObjectTypes = { "HealthFountain", "HealthFountainF", "HealthFountainG", "HealthFountainH", "HealthFountainI", "HealthFountainN", "HealthFountainO" } } },
			{ FunctionName = "SpawnRoomReward" },
		},
	},

	Shop =
	{
		InheritFrom = { "NonCombat" },
		SpeakerNames = { "Selene", },
		LoadPackages = { "Selene", },
		TimerBlock = "ShopEncounter",
		TimerBlockRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "StoreDataName" },
			}
		},
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SpawnRoomReward" },
			{
				FunctionName = "CheckHeraclesShoppingEvent",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", "O", "P" },
					},
					{
						PathFalse = { "CurrentRun", "ShoppingEvent" },
					},
					{
						PathFalse = { "PrevRun", "HeraclesShopped" },
					},
					NamedRequirements = { "NoRecentFieldNPCEncounter", },
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
					ChanceToPlay = 0.125, 
				},
			},
			{
				FunctionName = "CheckNemesisShoppingEvent",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "G", "H", "I" },
					},
					{
						PathFalse = { "CurrentRun", "ShoppingEvent" },
					},
					{
						PathFalse = { "PrevRun", "NemesisShopped" },
					},
					NamedRequirements = { "NoRecentNemesisEncounter", },
					NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing" },
					ChanceToPlay = 0.125, 
				},
				Args =
				{
					NPCVariantData = "NemesisShopping",
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Charon_01", WithinDistance = 1600,
				FunctionName = "FieldsBridgeCharonMusic",
				GameStateRequirements = 
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01", "H_PreBoss01" },
					},
				},
			},
		},

		ExitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeRoomExitVoiceLines", Time = 25 },
			},
			{
				PreLineWait = 0.5,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "G_PreBoss01" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "G_Boss01", "G_Boss02" },
						Comparison = ">=",
						Value = 4,
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_0981", Text = "All right, Scylla...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0979", Text = "To the stage..." },
				{ Cue = "/VO/MelinoeField_0978", Text = "Showtime...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "Scylla" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0980", Text = "On with the show...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "Scylla" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0977", Text = "Almost out of here...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "Scylla" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0982", Text = "The old song-and-dance...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomCountCache" },
							SumOf = { "G_Boss01", "G_Boss02" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
			},
			{
				PreLineWait = 0.25,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.4,
				SuccessiveChanceToPlayAll = 0.2,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_PreBoss01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "F_Boss01" },
					},
					-- @ ending
					NamedRequirementsFalse = { "HecateMissing" },
				},

				{ Cue = "/VO/MelinoeField_2356", Text = "{#Emph}<Sigh> {#Prev}Here goes...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2357", Text = "Headmistress awaits..." },
				{ Cue = "/VO/MelinoeField_0103", Text = "Mustn't keep her waiting..." },
				{ Cue = "/VO/MelinoeField_0104", Text = "Now for the test..." },
				{ Cue = "/VO/MelinoeField_0105", Text = "She awaits..." },
				{ Cue = "/VO/MelinoeField_0106", Text = "Here goes..." },
				{ Cue = "/VO/MelinoeField_0107", Text = "The clearing isn't far..." },
				{ Cue = "/VO/MelinoeField_0108", Text = "I can do this...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.5,
						},
						{
							Path = { "GameState", "EnemyKills", "Hecate" },
							Comparison = "<=",
							Value = 9,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2358", Text = "I can beat her.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.5,
						},
						{
							Path = { "GameState", "EnemyKills", "Hecate" },
							Comparison = "<=",
							Value = 9,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2359", Text = "I can take her.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.5,
						},
						{
							Path = { "GameState", "EnemyKills", "Hecate" },
							Comparison = "<=",
							Value = 9,
						},
					},
				},
			},
			{
				PreLineWait = 0.25,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "DoAnomalies" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "G_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},

				{ Cue = "/VO/Melinoe_1234", Text = "Farewell, Lord Charon." },
				{ Cue = "/VO/Melinoe_1236", Text = "Thank you for your service." },
				{ Cue = "/VO/Melinoe_1237", Text = "Until we meet again." },
				{ Cue = "/VO/Melinoe_1235", Text = "Be safe, Lord Charon.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1235", },
						},
					},
				},
			},
		},
	},

	BridgeShop =
	{
		InheritFrom = { "Shop" },

		RequireRoomReward = "Shop",
	},

	TyphonShop =
	{
		InheritFrom = { "Shop" },
		SpeakerNames = { "Hermes", "Selene", },
	},

})